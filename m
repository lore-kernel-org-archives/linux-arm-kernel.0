From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  7 Jun 2011 12:45:46 +0200
Subject: [PATCH 1/5] DRM: add i.MX IPUv3 base driver
In-Reply-To: <1307443550-25549-1-git-send-email-s.hauer@pengutronix.de>
References: <1307443550-25549-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1307443550-25549-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IPU is the Image Processing Unit found on i.MX51/53 SoCs. It
features several units for image processing, this patch adds support
for the units needed for Framebuffer support, namely:

- Display Controller (dc)
- Display Interface (di)
- Display Multi Fifo Controller (dmfc)
- Display Processor (dp)
- Image DMA Controller (idmac)

This patch is based on the Freescale driver, but follows a different
approach. The Freescale code implements logical idmac channels and
the handling of the subunits is hidden in common idmac code pathes
in big switch/case statements. This patch instead just provides code
and resource management for the different subunits. The user, in this
case the framebuffer driver, decides how the different units play
together.

The IPU has other units missing in this patch:

- CMOS Sensor Interface (csi)
- Video Deinterlacer (vdi)
- Sensor Multi FIFO Controler (smfc)
- Image Converter (ic)
- Image Rotator (irt)

So expect more files to come in this directory.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/ipu-v3.h |   22 +
 drivers/gpu/drm/Kconfig                 |    6 +
 drivers/gpu/drm/Makefile                |    1 +
 drivers/gpu/drm/imx/Makefile            |    1 +
 drivers/gpu/drm/imx/ipu-v3/Makefile     |    3 +
 drivers/gpu/drm/imx/ipu-v3/ipu-common.c |  799 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-prv.h    |  218 +++++++++
 include/drm/imx-ipu-v3.h                |  308 ++++++++++++
 8 files changed, 1358 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/ipu-v3.h
 create mode 100644 drivers/gpu/drm/imx/Makefile
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/Makefile
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-common.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-prv.h
 create mode 100644 include/drm/imx-ipu-v3.h

diff --git a/arch/arm/plat-mxc/include/mach/ipu-v3.h b/arch/arm/plat-mxc/include/mach/ipu-v3.h
new file mode 100644
index 0000000..1dd7232
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/ipu-v3.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (c) 2010 Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ */
+
+#ifndef __MACH_IPU_V3_H_
+#define __MACH_IPU_V3_H_
+
+struct imx_ipuv3_platform_data {
+	int rev;
+};
+
+#endif /* __MACH_IPU_V3_H_ */
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index b493663..969dc38 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -158,3 +158,9 @@ config DRM_SAVAGE
 	help
 	  Choose this option if you have a Savage3D/4/SuperSavage/Pro/Twister
 	  chipset. If M is selected the module will be called savage.
+
+config DRM_IMX_IPUV3
+	tristate "i.MX IPUv3"
+	depends on DRM && ARCH_MXC
+	help
+	  Choose this if you have a i.MX51/53 processor.
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 89cf05a..97c35eb 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -35,4 +35,5 @@ obj-$(CONFIG_DRM_SAVAGE)+= savage/
 obj-$(CONFIG_DRM_VMWGFX)+= vmwgfx/
 obj-$(CONFIG_DRM_VIA)	+=via/
 obj-$(CONFIG_DRM_NOUVEAU) +=nouveau/
+obj-$(CONFIG_DRM_IMX_IPUV3) +=imx/
 obj-y			+= i2c/
diff --git a/drivers/gpu/drm/imx/Makefile b/drivers/gpu/drm/imx/Makefile
new file mode 100644
index 0000000..776e6b4
--- /dev/null
+++ b/drivers/gpu/drm/imx/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_DRM_IMX_IPUV3) += ipu-v3/
diff --git a/drivers/gpu/drm/imx/ipu-v3/Makefile b/drivers/gpu/drm/imx/ipu-v3/Makefile
new file mode 100644
index 0000000..b073fd3
--- /dev/null
+++ b/drivers/gpu/drm/imx/ipu-v3/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_DRM_IMX_IPUV3) += imx-ipu-v3.o
+
+imx-ipu-v3-objs := ipu-common.o
diff --git a/drivers/gpu/drm/imx/ipu-v3/ipu-common.c b/drivers/gpu/drm/imx/ipu-v3/ipu-common.c
new file mode 100644
index 0000000..7d8be76
--- /dev/null
+++ b/drivers/gpu/drm/imx/ipu-v3/ipu-common.c
@@ -0,0 +1,799 @@
+/*
+ * Copyright (c) 2010 Sascha Hauer <s.hauer@pengutronix.de>
+ * Copyright (C) 2005-2009 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/list.h>
+#include <linux/irq.h>
+#include <mach/common.h>
+#include <mach/ipu-v3.h>
+#include <drm/imx-ipu-v3.h>
+
+#include "ipu-prv.h"
+
+static inline u32 ipu_cm_read(struct ipu_soc *ipu, unsigned offset)
+{
+	return readl(ipu->cm_reg + offset);
+}
+
+static inline void ipu_cm_write(struct ipu_soc *ipu, u32 value, unsigned offset)
+{
+	writel(value, ipu->cm_reg + offset);
+}
+
+static inline u32 ipu_idmac_read(struct ipu_soc *ipu, unsigned offset)
+{
+	return readl(ipu->idmac_reg + offset);
+}
+
+static inline void ipu_idmac_write(struct ipu_soc *ipu, u32 value, unsigned offset)
+{
+	writel(value, ipu->idmac_reg + offset);
+}
+
+void ipu_srm_dp_sync_update(struct ipu_soc *ipu)
+{
+	u32 val;
+
+	val = ipu_cm_read(ipu, IPU_SRM_PRI2);
+	val |= 0x8;
+	ipu_cm_write(ipu, val, IPU_SRM_PRI2);
+}
+EXPORT_SYMBOL_GPL(ipu_srm_dp_sync_update);
+
+struct ipu_ch_param *ipu_get_cpmem(struct ipu_channel *channel)
+{
+	struct ipu_soc *ipu = channel->ipu;
+
+	return ipu->cpmem_base + channel->num;
+}
+EXPORT_SYMBOL_GPL(ipu_get_cpmem);
+
+void ipu_ch_param_set_field(struct ipu_ch_param *base, u32 wbs, u32 v)
+{
+	u32 bit = (wbs >> 8) % 160;
+	u32 size = wbs & 0xff;
+	u32 word = (wbs >> 8) / 160;
+	u32 i = bit / 32;
+	u32 ofs = bit % 32;
+	u32 mask = (1 << size) - 1;
+
+	pr_debug("%s %d %d %d\n", __func__, word, bit , size);
+
+	base->word[word].data[i] &= ~(mask << ofs);
+	base->word[word].data[i] |= v << ofs;
+
+	if ((bit + size - 1) / 32 > i) {
+		base->word[word].data[i + 1] &= ~(v >> (mask ? (32 - ofs) : 0));
+		base->word[word].data[i + 1] |= v >> (ofs ? (32 - ofs) : 0);
+	}
+}
+EXPORT_SYMBOL_GPL(ipu_ch_param_set_field);
+
+u32 ipu_ch_param_read_field(struct ipu_ch_param *base, u32 wbs)
+{
+	u32 bit = (wbs >> 8) % 160;
+	u32 size = wbs & 0xff;
+	u32 word = (wbs >> 8) / 160;
+	u32 i = bit / 32;
+	u32 ofs = bit % 32;
+	u32 mask = (1 << size) - 1;
+	u32 val = 0;
+
+	pr_debug("%s %d %d %d\n", __func__, word, bit , size);
+
+	val = (base->word[word].data[i] >> ofs) & mask;
+
+	if ((bit + size - 1) / 32 > i) {
+		u32 tmp;
+		tmp = base->word[word].data[i + 1];
+		tmp &= mask >> (ofs ? (32 - ofs) : 0);
+		val |= tmp << (ofs ? (32 - ofs) : 0);
+	}
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(ipu_ch_param_read_field);
+
+void ipu_cpmem_set_format_rgb(struct ipu_ch_param *p, struct ipu_rgb *rgb)
+{
+	int bpp = 0, npb = 0, ro, go, bo, to;
+
+	ro = rgb->bits_per_pixel - rgb->red.length - rgb->red.offset;
+	go = rgb->bits_per_pixel - rgb->green.length - rgb->green.offset;
+	bo = rgb->bits_per_pixel - rgb->blue.length - rgb->blue.offset;
+	to = rgb->bits_per_pixel - rgb->transp.length - rgb->transp.offset;
+
+	ipu_ch_param_set_field(p, IPU_FIELD_WID0, rgb->red.length - 1);
+	ipu_ch_param_set_field(p, IPU_FIELD_OFS0, ro);
+	ipu_ch_param_set_field(p, IPU_FIELD_WID1, rgb->green.length - 1);
+	ipu_ch_param_set_field(p, IPU_FIELD_OFS1, go);
+	ipu_ch_param_set_field(p, IPU_FIELD_WID2, rgb->blue.length - 1);
+	ipu_ch_param_set_field(p, IPU_FIELD_OFS2, bo);
+
+	if (rgb->transp.length) {
+		ipu_ch_param_set_field(p, IPU_FIELD_WID3, rgb->transp.length - 1);
+		ipu_ch_param_set_field(p, IPU_FIELD_OFS3, to);
+	} else {
+		ipu_ch_param_set_field(p, IPU_FIELD_WID3, 7);
+		ipu_ch_param_set_field(p, IPU_FIELD_OFS3, rgb->bits_per_pixel);
+	}
+
+	switch (rgb->bits_per_pixel) {
+	case 32:
+		bpp = 0;
+		npb = 15;
+		break;
+	case 24:
+		bpp = 1;
+		npb = 19;
+		break;
+	case 16:
+		bpp = 3;
+		npb = 31;
+		break;
+	case 8:
+		bpp = 5;
+		npb = 63;
+		break;
+	}
+	ipu_ch_param_set_field(p, IPU_FIELD_BPP, bpp);
+	ipu_ch_param_set_field(p, IPU_FIELD_NPB, npb);
+	ipu_ch_param_set_field(p, IPU_FIELD_PFS, 7); /* rgb mode */
+}
+EXPORT_SYMBOL_GPL(ipu_cpmem_set_format_rgb);
+
+void ipu_cpmem_set_yuv_interleaved(struct ipu_ch_param *p, u32 pixel_format)
+{
+	switch (pixel_format) {
+	case IPU_PIX_FMT_UYVY:
+		ipu_ch_param_set_field(p, IPU_FIELD_BPP, 3);	/* bits/pixel */
+		ipu_ch_param_set_field(p, IPU_FIELD_PFS, 0xA);	/* pix format */
+		ipu_ch_param_set_field(p, IPU_FIELD_NPB, 15);	/* burst size */
+		break;
+	case IPU_PIX_FMT_YUYV:
+		ipu_ch_param_set_field(p, IPU_FIELD_BPP, 3);	/* bits/pixel */
+		ipu_ch_param_set_field(p, IPU_FIELD_PFS, 0x8);	/* pix format */
+		ipu_ch_param_set_field(p, IPU_FIELD_NPB, 31);	/* burst size */
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(ipu_cpmem_set_yuv_interleaved);
+
+struct ipu_channel *ipu_idmac_get(struct ipu_soc *ipu, unsigned num)
+{
+	struct ipu_channel *channel;
+
+	dev_dbg(ipu->dev, "%s %d\n", __func__, num);
+
+	if (num > 63)
+		return ERR_PTR(-ENODEV);
+
+	mutex_lock(&ipu->channel_lock);
+
+	channel = &ipu->channel[num];
+
+	if (channel->busy) {
+		channel = ERR_PTR(-EBUSY);
+		goto out;
+	}
+
+	channel->busy = 1;
+	channel->num = num;
+
+out:
+	mutex_unlock(&ipu->channel_lock);
+
+	return channel;
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_get);
+
+void ipu_idmac_put(struct ipu_channel *channel)
+{
+	struct ipu_soc *ipu = channel->ipu;
+
+	dev_dbg(ipu->dev, "%s %d\n", __func__, channel->num);
+
+	mutex_lock(&ipu->channel_lock);
+
+	channel->busy = 0;
+
+	mutex_unlock(&ipu->channel_lock);
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_put);
+
+#define idma_mask(ch)			(1 << (ch & 0x1f))
+
+void ipu_idmac_set_double_buffer(struct ipu_channel *channel, bool doublebuffer)
+{
+	struct ipu_soc *ipu = channel->ipu;
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&ipu->lock, flags);
+
+	reg = ipu_cm_read(ipu, IPU_CHA_DB_MODE_SEL(channel->num));
+	if (doublebuffer)
+		reg |= idma_mask(channel->num);
+	else
+		reg &= ~idma_mask(channel->num);
+	ipu_cm_write(ipu, reg, IPU_CHA_DB_MODE_SEL(channel->num));
+
+	spin_unlock_irqrestore(&ipu->lock, flags);
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_set_double_buffer);
+
+int ipu_module_enable(struct ipu_soc *ipu, u32 mask)
+{
+	unsigned long lock_flags;
+	u32 val;
+
+	spin_lock_irqsave(&ipu->lock, lock_flags);
+
+	val = ipu_cm_read(ipu, IPU_DISP_GEN);
+
+	if (mask & IPU_CONF_DI0_EN)
+		val |= IPU_DI0_COUNTER_RELEASE;
+	if (mask & IPU_CONF_DI1_EN)
+		val |= IPU_DI1_COUNTER_RELEASE;
+
+	ipu_cm_write(ipu, val, IPU_DISP_GEN);
+
+	val = ipu_cm_read(ipu, IPU_CONF);
+	val |= mask;
+	ipu_cm_write(ipu, val, IPU_CONF);
+
+	spin_unlock_irqrestore(&ipu->lock, lock_flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_module_enable);
+
+int ipu_module_disable(struct ipu_soc *ipu, u32 mask)
+{
+	unsigned long lock_flags;
+	u32 val;
+
+	spin_lock_irqsave(&ipu->lock, lock_flags);
+
+	val = ipu_cm_read(ipu, IPU_CONF);
+	val &= ~mask;
+	ipu_cm_write(ipu, val, IPU_CONF);
+
+	val = ipu_cm_read(ipu, IPU_DISP_GEN);
+
+	if (mask & IPU_CONF_DI0_EN)
+		val &= ~IPU_DI0_COUNTER_RELEASE;
+	if (mask & IPU_CONF_DI1_EN)
+		val &= ~IPU_DI1_COUNTER_RELEASE;
+
+	ipu_cm_write(ipu, val, IPU_DISP_GEN);
+
+	spin_unlock_irqrestore(&ipu->lock, lock_flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_module_disable);
+
+void ipu_idmac_select_buffer(struct ipu_channel *channel, u32 buf_num)
+{
+	struct ipu_soc *ipu = channel->ipu;
+	unsigned int chno = channel->num;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ipu->lock, flags);
+
+	/* Mark buffer as ready. */
+	if (buf_num == 0)
+		ipu_cm_write(ipu, idma_mask(chno), IPU_CHA_BUF0_RDY(chno));
+	else
+		ipu_cm_write(ipu, idma_mask(chno), IPU_CHA_BUF1_RDY(chno));
+
+	spin_unlock_irqrestore(&ipu->lock, flags);
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_select_buffer);
+
+int ipu_idmac_enable_channel(struct ipu_channel *channel)
+{
+	struct ipu_soc *ipu = channel->ipu;
+	u32 val;
+	unsigned long flags;
+
+	ipu_get(ipu);
+
+	spin_lock_irqsave(&ipu->lock, flags);
+
+	val = ipu_idmac_read(ipu, IDMAC_CHA_EN(channel->num));
+	val |= idma_mask(channel->num);
+	ipu_idmac_write(ipu, val, IDMAC_CHA_EN(channel->num));
+
+	spin_unlock_irqrestore(&ipu->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_enable_channel);
+
+int ipu_idmac_disable_channel(struct ipu_channel *channel)
+{
+	struct ipu_soc *ipu = channel->ipu;
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ipu->lock, flags);
+
+	/* Disable DMA channel(s) */
+	val = ipu_idmac_read(ipu, IDMAC_CHA_EN(channel->num));
+	val &= ~idma_mask(channel->num);
+	ipu_idmac_write(ipu, val, IDMAC_CHA_EN(channel->num));
+
+	/* Set channel buffers NOT to be ready */
+	ipu_cm_write(ipu, 0xf0000000, IPU_GPR); /* write one to clear */
+
+	if (ipu_cm_read(ipu, IPU_CHA_BUF0_RDY(channel->num)) & idma_mask(channel->num)) {
+		ipu_cm_write(ipu, idma_mask(channel->num),
+			     IPU_CHA_BUF0_RDY(channel->num));
+	}
+	if (ipu_cm_read(ipu, IPU_CHA_BUF1_RDY(channel->num)) & idma_mask(channel->num)) {
+		ipu_cm_write(ipu, idma_mask(channel->num),
+			     IPU_CHA_BUF1_RDY(channel->num));
+	}
+
+	ipu_cm_write(ipu, 0x0, IPU_GPR); /* write one to set */
+
+	/* Reset the double buffer */
+	val = ipu_cm_read(ipu, IPU_CHA_DB_MODE_SEL(channel->num));
+	val &= ~idma_mask(channel->num);
+	ipu_cm_write(ipu, val, IPU_CHA_DB_MODE_SEL(channel->num));
+
+	spin_unlock_irqrestore(&ipu->lock, flags);
+
+	ipu_put(ipu);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_disable_channel);
+
+static int ipu_reset(struct ipu_soc *ipu)
+{
+	int timeout = 10000;
+	u32 val;
+
+	/* hard reset the IPU */
+	val = readl(MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
+	val |= 1 << 3;
+	writel(val, MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
+
+	mdelay(300); /* FIXME: such a big delay needed? */
+
+	ipu_cm_write(ipu, 0x807FFFFF, IPU_MEM_RST);
+
+	while (ipu_cm_read(ipu, IPU_MEM_RST) & 0x80000000) {
+		if (!timeout--)
+			return -ETIME;
+		udelay(100);
+	}
+
+	return 0;
+}
+
+static int ipu_submodules_init(struct ipu_soc *ipu, struct platform_device *pdev,
+		unsigned long ipu_base, struct clk *ipu_clk)
+{
+	char *unit;
+	int ret;
+	struct device *dev = &pdev->dev;
+
+	ret = ipu_di_init(ipu, dev, 0, ipu_base + IPU_DI0_REG_BASE,
+			IPU_CONF_DI0_EN, ipu_clk);
+	if (ret) {
+		unit = "di0";
+		goto err_di_0;
+	}
+
+	ret = ipu_di_init(ipu, dev, 1, ipu_base + IPU_DI1_REG_BASE,
+			IPU_CONF_DI1_EN, ipu_clk);
+	if (ret) {
+		unit = "di1";
+		goto err_di_1;
+	}
+
+	ret = ipu_dc_init(ipu, dev, ipu_base + IPU_DC_REG_BASE,
+			ipu_base + IPU_DC_TMPL_REG_BASE);
+	if (ret) {
+		unit = "dc_template";
+		goto err_dc;
+	}
+
+	ret = ipu_dmfc_init(ipu, dev, ipu_base + IPU_DMFC_REG_BASE, ipu_clk);
+	if (ret) {
+		unit = "dmfc";
+		goto err_dmfc;
+	}
+
+	ret = ipu_dp_init(ipu, dev, ipu_base + IPU_SRM_REG_BASE);
+	if (ret) {
+		unit = "dp";
+		goto err_dp;
+	}
+
+	ret = ipu_capture_init(ipu, dev, ipu_base + IPU_CSI0_REG_BASE,
+		ipu_base + IPU_CSI1_REG_BASE, ipu_base + IPU_SMFC_REG_BASE);
+	if (ret) {
+		unit = "capture";
+		goto err_capture;
+	}
+
+	return 0;
+
+err_capture:
+	ipu_dp_exit(ipu);
+err_dp:
+	ipu_dmfc_exit(ipu);
+err_dmfc:
+	ipu_dc_exit(ipu);
+err_dc:
+	ipu_di_exit(ipu, 1);
+err_di_1:
+	ipu_di_exit(ipu, 0);
+err_di_0:
+	dev_err(&pdev->dev, "init %s failed with %d\n", unit, ret);
+	return ret;
+}
+
+void ipu_get(struct ipu_soc *ipu)
+{
+	mutex_lock(&ipu->channel_lock);
+
+	ipu->usecount++;
+
+	if (ipu->usecount == 1)
+		clk_enable(ipu->clk);
+
+	mutex_unlock(&ipu->channel_lock);
+}
+EXPORT_SYMBOL_GPL(ipu_get);
+
+void ipu_put(struct ipu_soc *ipu)
+{
+	mutex_lock(&ipu->channel_lock);
+
+	ipu->usecount--;
+
+	if (ipu->usecount == 0)
+		clk_disable(ipu->clk);
+
+	WARN_ON(ipu->usecount < 0);
+
+	mutex_unlock(&ipu->channel_lock);
+}
+EXPORT_SYMBOL_GPL(ipu_put);
+
+static void ipu_irq_handle(struct ipu_soc *ipu, const int *regs, int num_regs)
+{
+	unsigned long status;
+	int i, bit, irq_base;
+
+	for (i = 0; i < num_regs; i++) {
+
+		status = ipu_cm_read(ipu, IPU_INT_STAT(regs[i]));
+		status &= ipu_cm_read(ipu, IPU_INT_CTRL(regs[i]));
+
+		irq_base = ipu->irq_start + regs[i] * 32;
+		for_each_set_bit(bit, &status, 32)
+			generic_handle_irq(irq_base + bit);
+	}
+}
+
+static void ipu_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
+	const int int_reg[] = { 0, 1, 2, 3, 10, 11, 12, 13, 14};
+
+	ipu_irq_handle(ipu, int_reg, ARRAY_SIZE(int_reg));
+}
+
+static void ipu_err_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
+	const int int_reg[] = { 4, 5, 8, 9};
+
+	ipu_irq_handle(ipu, int_reg, ARRAY_SIZE(int_reg));
+}
+
+static void ipu_ack_irq(struct irq_data *d)
+{
+	struct ipu_soc *ipu = irq_data_get_irq_chip_data(d);
+	unsigned int irq = d->irq - ipu->irq_start;
+
+	ipu_cm_write(ipu, 1 << (irq % 32), IPU_INT_STAT(irq / 32));
+}
+
+static void ipu_unmask_irq(struct irq_data *d)
+{
+	struct ipu_soc *ipu = irq_data_get_irq_chip_data(d);
+	unsigned int irq = d->irq - ipu->irq_start;
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&ipu->lock, flags);
+	reg = ipu_cm_read(ipu, IPU_INT_CTRL(irq / 32));
+	reg |= 1 << (irq % 32);
+	ipu_cm_write(ipu, reg, IPU_INT_CTRL(irq / 32));
+	spin_unlock_irqrestore(&ipu->lock, flags);
+}
+
+static void ipu_mask_irq(struct irq_data *d)
+{
+	struct ipu_soc *ipu = irq_data_get_irq_chip_data(d);
+	unsigned int irq = d->irq - ipu->irq_start;
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&ipu->lock, flags);
+	reg = ipu_cm_read(ipu, IPU_INT_CTRL(irq / 32));
+	reg &= ~(1 << (irq % 32));
+	ipu_cm_write(ipu, reg, IPU_INT_CTRL(irq / 32));
+	spin_unlock_irqrestore(&ipu->lock, flags);
+}
+
+static struct irq_chip ipu_irq_chip = {
+	.name = "IPU",
+	.irq_ack = ipu_ack_irq,
+	.irq_mask = ipu_mask_irq,
+	.irq_unmask = ipu_unmask_irq,
+};
+
+static void ipu_submodules_exit(struct ipu_soc *ipu)
+{
+	ipu_dp_exit(ipu);
+	ipu_dmfc_exit(ipu);
+	ipu_dc_exit(ipu);
+	ipu_di_exit(ipu, 1);
+	ipu_di_exit(ipu, 0);
+	ipu_capture_exit(ipu);
+}
+
+static int platform_remove_devices_fn(struct device *dev, void *unused)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
+static void platform_device_unregister_children(struct platform_device *pdev)
+{
+	device_for_each_child(&pdev->dev, NULL, platform_remove_devices_fn);
+}
+
+static int ipu_add_subdevice_pdata(struct device *dev,
+		const char *name, int id, void *pdata, int irq)
+{
+	struct platform_device *pdev;
+	struct resource res[] = {
+		{
+			.flags = IORESOURCE_IRQ,
+			.start = irq,
+			.end = irq,
+		},
+	};
+
+	pdev = platform_device_register_resndata(dev, name, id, res,
+			ARRAY_SIZE(res), NULL, 0);
+	return pdev ? 0 : -EINVAL;
+}
+
+static int ipu_add_client_devices(struct ipu_soc *ipu)
+{
+	int ret;
+
+	ret = ipu_add_subdevice_pdata(ipu->dev, "imx-ipuv3-ovl", 0, NULL,
+			ipu->irq_start +
+			IPU_IRQ_EOF(IPUV3_CHANNEL_MEM_FG_SYNC));
+	ret |= ipu_add_subdevice_pdata(ipu->dev, "imx-ipuv3-camera", 0, NULL,
+			ipu->irq_start +
+			IPU_IRQ_EOF(IPUV3_CHANNEL_CSI0));
+	ret |= ipu_add_subdevice_pdata(ipu->dev, "imx-drm", 0, NULL,
+			ipu->irq_start +
+			IPU_IRQ_EOF(IPUV3_CHANNEL_MEM_FG_SYNC));
+
+	if (ret)
+		platform_device_unregister_children(to_platform_device(ipu->dev));
+
+	return ret;
+}
+
+static int ipu_irq_init(struct ipu_soc *ipu)
+{
+	int i;
+
+	ipu->irq_start = irq_alloc_descs(-1, 0, IPU_NUM_IRQS, 0);
+	if (ipu->irq_start < 0)
+		return ipu->irq_start;
+
+	for (i = ipu->irq_start; i < ipu->irq_start + IPU_NUM_IRQS; i++) {
+		irq_set_chip_and_handler(i, &ipu_irq_chip, handle_level_irq);
+		set_irq_flags(i, IRQF_VALID);
+		irq_set_chip_data(i, ipu);
+	}
+
+	irq_set_chained_handler(ipu->irq_sync, ipu_irq_handler);
+	irq_set_handler_data(ipu->irq_sync, ipu);
+	irq_set_chained_handler(ipu->irq_err, ipu_err_irq_handler);
+	irq_set_handler_data(ipu->irq_err, ipu);
+
+	return 0;
+}
+
+static void ipu_irq_exit(struct ipu_soc *ipu)
+{
+	int i;
+
+	irq_set_chained_handler(ipu->irq_err, NULL);
+	irq_set_handler_data(ipu->irq_err, NULL);
+	irq_set_chained_handler(ipu->irq_sync, NULL);
+	irq_set_handler_data(ipu->irq_sync, NULL);
+
+	for (i = ipu->irq_start; i < ipu->irq_start + IPU_NUM_IRQS; i++) {
+		set_irq_flags(i, 0);
+		irq_set_chip(i, NULL);
+		irq_set_chip_data(i, NULL);
+	}
+
+	irq_free_descs(ipu->irq_start, IPU_NUM_IRQS);
+}
+
+static int __devinit ipu_probe(struct platform_device *pdev)
+{
+	struct ipu_soc *ipu;
+	struct resource *res;
+	unsigned long ipu_base;
+	int i, ret, irq_sync, irq_err;
+
+	irq_sync = platform_get_irq(pdev, 0);
+	irq_err = platform_get_irq(pdev, 1);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res || irq_sync < 0 || irq_err < 0)
+		return -ENODEV;
+
+	ipu_base = res->start;
+
+	ipu = devm_kzalloc(&pdev->dev, sizeof(*ipu), GFP_KERNEL);
+	if (!ipu)
+		return -ENODEV;
+
+	for (i = 0; i < 64; i++)
+		ipu->channel[i].ipu = ipu;
+
+	spin_lock_init(&ipu->lock);
+	mutex_init(&ipu->channel_lock);
+
+	ipu->cm_reg = devm_ioremap(&pdev->dev, ipu_base + IPU_CM_REG_BASE, PAGE_SIZE);
+	ipu->idmac_reg = devm_ioremap(&pdev->dev, ipu_base + IPU_IDMAC_REG_BASE, PAGE_SIZE);
+	ipu->cpmem_base = devm_ioremap(&pdev->dev, ipu_base + IPU_CPMEM_REG_BASE, PAGE_SIZE);
+	if (!ipu->cm_reg || !ipu->idmac_reg || !ipu->cpmem_base) {
+		ret = -ENOMEM;
+		goto failed_ioremap;
+	}
+
+	ipu->clk = clk_get(&pdev->dev, "ipu");
+	if (IS_ERR(ipu->clk)) {
+		ret = PTR_ERR(ipu->clk);
+		dev_err(&pdev->dev, "clk_get failed with %d", ret);
+		goto failed_clk_get;
+	}
+
+	platform_set_drvdata(pdev, ipu);
+
+	ipu_get(ipu);
+
+	ipu->dev = &pdev->dev;
+	ipu->irq_sync = irq_sync;
+	ipu->irq_err = irq_err;
+
+	ret = ipu_irq_init(ipu);
+	if (ret)
+		goto out_failed_irq;
+
+	ipu_reset(ipu);
+
+	ret = ipu_submodules_init(ipu, pdev, ipu_base, ipu->clk);
+	if (ret)
+		goto failed_submodules_init;
+
+	/* Set sync refresh channels as high priority */
+	ipu_idmac_write(ipu, 0x18800000, IDMAC_CHA_PRI(0));
+
+	/* Set MCU_T to divide MCU access window into 2 */
+	ipu_cm_write(ipu, 0x00400000L | (IPU_MCU_T_DEFAULT << 18), IPU_DISP_GEN);
+
+	ret = ipu_add_client_devices(ipu);
+	if (ret) {
+		dev_err(&pdev->dev, "adding client devices failed with %d\n", ret);
+		goto failed_add_clients;
+	}
+
+	ipu_put(ipu);
+
+	return 0;
+
+failed_add_clients:
+	ipu_submodules_exit(ipu);
+failed_submodules_init:
+	ipu_irq_exit(ipu);
+out_failed_irq:
+	ipu_put(ipu);
+	clk_put(ipu->clk);
+failed_clk_get:
+failed_ioremap:
+	return ret;
+}
+
+static int __devexit ipu_remove(struct platform_device *pdev)
+{
+	struct ipu_soc *ipu = platform_get_drvdata(pdev);
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	platform_device_unregister_children(pdev);
+	ipu_submodules_exit(ipu);
+	ipu_irq_exit(ipu);
+
+	if (ipu->usecount != 0) {
+		dev_err(ipu->dev, "unbalanced use count: %d\n", ipu->usecount);
+		clk_disable(ipu->clk);
+	}
+
+	clk_put(ipu->clk);
+
+	return 0;
+}
+
+static struct platform_driver imx_ipu_driver = {
+	.driver = {
+		.name = "imx-ipuv3",
+	},
+	.probe = ipu_probe,
+	.remove = __devexit_p(ipu_remove),
+};
+
+static int __init imx_ipu_init(void)
+{
+	int32_t ret;
+
+	ret = platform_driver_register(&imx_ipu_driver);
+	return 0;
+}
+subsys_initcall(imx_ipu_init);
+
+static void __exit imx_ipu_exit(void)
+{
+	platform_driver_unregister(&imx_ipu_driver);
+}
+module_exit(imx_ipu_exit);
+
+MODULE_DESCRIPTION("i.MX IPU v3 driver");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/imx/ipu-v3/ipu-prv.h b/drivers/gpu/drm/imx/ipu-v3/ipu-prv.h
new file mode 100644
index 0000000..d0fc55b
--- /dev/null
+++ b/drivers/gpu/drm/imx/ipu-v3/ipu-prv.h
@@ -0,0 +1,218 @@
+/*
+ * Copyright (c) 2010 Sascha Hauer <s.hauer@pengutronix.de>
+ * Copyright (C) 2005-2009 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ */
+#ifndef __IPU_PRV_H__
+#define __IPU_PRV_H__
+
+struct ipu_soc;
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <mach/hardware.h>
+
+#define IPUV3_CHANNEL_CSI0			 0
+#define IPUV3_CHANNEL_CSI1			 1
+#define IPUV3_CHANNEL_CSI2			 2
+#define IPUV3_CHANNEL_CSI3			 3
+#define IPUV3_CHANNEL_MEM_BG_SYNC		23
+#define IPUV3_CHANNEL_MEM_FG_SYNC		27
+#define IPUV3_CHANNEL_MEM_DC_SYNC		28
+#define IPUV3_CHANNEL_MEM_FG_SYNC_ALPHA	31
+#define IPUV3_CHANNEL_MEM_DC_ASYNC		41
+#define IPUV3_CHANNEL_ROT_ENC_MEM		45
+#define IPUV3_CHANNEL_ROT_VF_MEM		46
+#define IPUV3_CHANNEL_ROT_PP_MEM		47
+#define IPUV3_CHANNEL_ROT_ENC_MEM_OUT	48
+#define IPUV3_CHANNEL_ROT_VF_MEM_OUT		49
+#define IPUV3_CHANNEL_ROT_PP_MEM_OUT		50
+#define IPUV3_CHANNEL_MEM_BG_SYNC_ALPHA	51
+
+#define IPU_CM_REG_BASE		0
+#define IPU_MCU_T_DEFAULT	8
+#define IPU_IDMAC_REG_BASE	(IPU_CM_REG_BASE + 0x00008000)
+#define IPU_ISP_REG_BASE	(IPU_CM_REG_BASE + 0x00010000)
+#define IPU_DP_REG_BASE		(IPU_CM_REG_BASE + 0x00018000)
+#define IPU_IC_REG_BASE		(IPU_CM_REG_BASE + 0x00020000)
+#define IPU_IRT_REG_BASE	(IPU_CM_REG_BASE + 0x00028000)
+#define IPU_CSI0_REG_BASE	(IPU_CM_REG_BASE + 0x00030000)
+#define IPU_CSI1_REG_BASE	(IPU_CM_REG_BASE + 0x00038000)
+#define IPU_DI0_REG_BASE	(IPU_CM_REG_BASE + 0x00040000)
+#define IPU_DI1_REG_BASE	(IPU_CM_REG_BASE + 0x00048000)
+#define IPU_SMFC_REG_BASE	(IPU_CM_REG_BASE + 0x00050000)
+#define IPU_DC_REG_BASE		(IPU_CM_REG_BASE + 0x00058000)
+#define IPU_DMFC_REG_BASE	(IPU_CM_REG_BASE + 0x00060000)
+#define IPU_CPMEM_REG_BASE	(IPU_CM_REG_BASE + 0x01000000)
+#define IPU_LUT_REG_BASE	(IPU_CM_REG_BASE + 0x01020000)
+#define IPU_SRM_REG_BASE	(IPU_CM_REG_BASE + 0x01040000)
+#define IPU_TPM_REG_BASE	(IPU_CM_REG_BASE + 0x01060000)
+#define IPU_DC_TMPL_REG_BASE	(IPU_CM_REG_BASE + 0x01080000)
+#define IPU_ISP_TBPR_REG_BASE	(IPU_CM_REG_BASE + 0x010c0000)
+#define IPU_VDI_REG_BASE	(IPU_CM_REG_BASE + 0x00068000)
+
+/* Register addresses */
+/* IPU Common registers */
+#define IPU_CM_REG(offset)	(offset)
+
+#define IPU_CONF			IPU_CM_REG(0)
+
+#define IPU_SRM_PRI1			IPU_CM_REG(0x00a0)
+#define IPU_SRM_PRI2			IPU_CM_REG(0x00a4)
+#define IPU_FS_PROC_FLOW1		IPU_CM_REG(0x00a8)
+#define IPU_FS_PROC_FLOW2		IPU_CM_REG(0x00ac)
+#define IPU_FS_PROC_FLOW3		IPU_CM_REG(0x00b0)
+#define IPU_FS_DISP_FLOW1		IPU_CM_REG(0x00b4)
+#define IPU_FS_DISP_FLOW2		IPU_CM_REG(0x00b8)
+#define IPU_SKIP			IPU_CM_REG(0x00bc)
+#define IPU_DISP_ALT_CONF		IPU_CM_REG(0x00c0)
+#define IPU_DISP_GEN			IPU_CM_REG(0x00c4)
+#define IPU_DISP_ALT1			IPU_CM_REG(0x00c8)
+#define IPU_DISP_ALT2			IPU_CM_REG(0x00cc)
+#define IPU_DISP_ALT3			IPU_CM_REG(0x00d0)
+#define IPU_DISP_ALT4			IPU_CM_REG(0x00d4)
+#define IPU_SNOOP			IPU_CM_REG(0x00d8)
+#define IPU_MEM_RST			IPU_CM_REG(0x00dc)
+#define IPU_PM				IPU_CM_REG(0x00e0)
+#define IPU_GPR				IPU_CM_REG(0x00e4)
+#define IPU_CHA_DB_MODE_SEL(ch)		IPU_CM_REG(0x0150 + 4 * ((ch) / 32))
+#define IPU_ALT_CHA_DB_MODE_SEL(ch)	IPU_CM_REG(0x0168 + 4 * ((ch) / 32))
+#define IPU_CHA_CUR_BUF(ch)		IPU_CM_REG(0x023C + 4 * ((ch) / 32))
+#define IPU_ALT_CUR_BUF0		IPU_CM_REG(0x0244)
+#define IPU_ALT_CUR_BUF1		IPU_CM_REG(0x0248)
+#define IPU_SRM_STAT			IPU_CM_REG(0x024C)
+#define IPU_PROC_TASK_STAT		IPU_CM_REG(0x0250)
+#define IPU_DISP_TASK_STAT		IPU_CM_REG(0x0254)
+#define IPU_CHA_BUF0_RDY(ch)		IPU_CM_REG(0x0268 + 4 * ((ch) / 32))
+#define IPU_CHA_BUF1_RDY(ch)		IPU_CM_REG(0x0270 + 4 * ((ch) / 32))
+#define IPU_ALT_CHA_BUF0_RDY(ch)	IPU_CM_REG(0x0278 + 4 * ((ch) / 32))
+#define IPU_ALT_CHA_BUF1_RDY(ch)	IPU_CM_REG(0x0280 + 4 * ((ch) / 32))
+
+#define IPU_INT_CTRL(n)		IPU_CM_REG(0x003C + 4 * (n))
+#define IPU_INT_STAT(n)		IPU_CM_REG(0x0200 + 4 * (n))
+
+#define IPU_DI0_COUNTER_RELEASE			(1 << 24)
+#define IPU_DI1_COUNTER_RELEASE			(1 << 25)
+
+#define IPU_IDMAC_REG(offset)	(offset)
+
+#define IDMAC_CONF			IPU_IDMAC_REG(0x0000)
+#define IDMAC_CHA_EN(ch)		IPU_IDMAC_REG(0x0004 + 4 * ((ch) / 32))
+#define IDMAC_SEP_ALPHA			IPU_IDMAC_REG(0x000c)
+#define IDMAC_ALT_SEP_ALPHA		IPU_IDMAC_REG(0x0010)
+#define IDMAC_CHA_PRI(ch)		IPU_IDMAC_REG(0x0014 + 4 * ((ch) / 32))
+#define IDMAC_WM_EN(ch)			IPU_IDMAC_REG(0x001c + 4 * ((ch) / 32))
+#define IDMAC_CH_LOCK_EN_1		IPU_IDMAC_REG(0x0024)
+#define IDMAC_CH_LOCK_EN_2		IPU_IDMAC_REG(0x0028)
+#define IDMAC_SUB_ADDR_0		IPU_IDMAC_REG(0x002c)
+#define IDMAC_SUB_ADDR_1		IPU_IDMAC_REG(0x0030)
+#define IDMAC_SUB_ADDR_2		IPU_IDMAC_REG(0x0034)
+#define IDMAC_BAND_EN(ch)		IPU_IDMAC_REG(0x0040 + 4 * ((ch) / 32))
+#define IDMAC_CHA_BUSY(ch)		IPU_IDMAC_REG(0x0100 + 4 * ((ch) / 32))
+
+#define IPU_NUM_IRQS	(32 * 5)
+
+enum ipu_modules {
+	IPU_CONF_CSI0_EN		= (1 << 0),
+	IPU_CONF_CSI1_EN		= (1 << 1),
+	IPU_CONF_IC_EN			= (1 << 2),
+	IPU_CONF_ROT_EN			= (1 << 3),
+	IPU_CONF_ISP_EN			= (1 << 4),
+	IPU_CONF_DP_EN			= (1 << 5),
+	IPU_CONF_DI0_EN			= (1 << 6),
+	IPU_CONF_DI1_EN			= (1 << 7),
+	IPU_CONF_SMFC_EN		= (1 << 8),
+	IPU_CONF_DC_EN			= (1 << 9),
+	IPU_CONF_DMFC_EN		= (1 << 10),
+
+	IPU_CONF_VDI_EN			= (1 << 12),
+
+	IPU_CONF_IDMAC_DIS		= (1 << 22),
+
+	IPU_CONF_IC_DMFC_SEL		= (1 << 25),
+	IPU_CONF_IC_DMFC_SYNC		= (1 << 26),
+	IPU_CONF_VDI_DMFC_SYNC		= (1 << 27),
+
+	IPU_CONF_CSI0_DATA_SOURCE	= (1 << 28),
+	IPU_CONF_CSI1_DATA_SOURCE	= (1 << 29),
+	IPU_CONF_IC_INPUT		= (1 << 30),
+	IPU_CONF_CSI_SEL		= (1 << 31),
+};
+
+struct ipu_channel {
+	unsigned int num;
+
+	bool enabled;
+	bool busy;
+
+	struct ipu_soc *ipu;
+};
+
+struct ipu_dc_priv;
+struct ipu_dmfc_priv;
+
+struct ipu_soc {
+	struct device		*dev;
+	spinlock_t		lock;
+	struct mutex		channel_lock;
+
+	void __iomem		*cm_reg;
+	void __iomem		*idmac_reg;
+	struct ipu_ch_param	*cpmem_base;
+
+	int			usecount;
+
+	struct clk		*clk;
+	struct ipu_channel	channel[64];
+
+	int			irq_start;
+	int			irq_sync;
+	int			irq_err;
+
+	struct ipu_dc_priv	*dc_priv;
+	struct ipu_dp_priv	*dp_priv;
+	struct ipu_dmfc_priv	*dmfc_priv;
+};
+
+void ipu_srm_dp_sync_update(struct ipu_soc *ipu);
+
+int ipu_module_enable(struct ipu_soc *ipu, u32 mask);
+int ipu_module_disable(struct ipu_soc *ipu, u32 mask);
+
+int ipu_di_init(struct ipu_soc *ipu, struct device *dev, int id, unsigned long base,
+		u32 module, struct clk *ipu_clk);
+void ipu_di_exit(struct ipu_soc *ipu, int id);
+
+int ipu_dmfc_init(struct ipu_soc *ipu, struct device *dev, unsigned long base,
+		struct clk *ipu_clk);
+void ipu_dmfc_exit(struct ipu_soc *ipu);
+
+int ipu_dp_init(struct ipu_soc *ipu, struct device *dev, unsigned long base);
+void ipu_dp_exit(struct ipu_soc *ipu);
+
+int ipu_dc_init(struct ipu_soc *ipu, struct device *dev, unsigned long base,
+		unsigned long template_base);
+void ipu_dc_exit(struct ipu_soc *ipu);
+
+int ipu_cpmem_init(struct ipu_soc *ipu, struct device *dev, unsigned long base);
+void ipu_cpmem_exit(struct ipu_soc *ipu);
+
+int ipu_capture_init(struct ipu_soc *ipu, struct device *dev, unsigned long csi1_base,
+		unsigned long csi2_base, unsigned long smfc_base);
+void ipu_capture_exit(struct ipu_soc *ipu);
+
+void ipu_get(struct ipu_soc *ipu);
+void ipu_put(struct ipu_soc *ipu);
+
+#endif				/* __IPU_PRV_H__ */
diff --git a/include/drm/imx-ipu-v3.h b/include/drm/imx-ipu-v3.h
new file mode 100644
index 0000000..f506408
--- /dev/null
+++ b/include/drm/imx-ipu-v3.h
@@ -0,0 +1,308 @@
+/*
+ * Copyright 2005-2009 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU Lesser General
+ * Public License.  You may obtain a copy of the GNU Lesser General
+ * Public License Version 2.1 or later@the following locations:
+ *
+ * http://www.opensource.org/licenses/lgpl-license.html
+ * http://www.gnu.org/copyleft/lgpl.html
+ */
+
+#ifndef __ASM_ARCH_IPU_H__
+#define __ASM_ARCH_IPU_H__
+
+#include <linux/types.h>
+#include <linux/videodev2.h>
+#include <linux/bitmap.h>
+#include <linux/fb.h>
+
+struct ipu_soc;
+
+/*
+ * IPU Pixel Formats
+ *
+ * Pixel formats are defined with ASCII FOURCC code. The pixel format codes are
+ * the same used by V4L2 API.
+ */
+
+/* Generic or Raw Data Formats */
+#define IPU_PIX_FMT_GENERIC v4l2_fourcc('I', 'P', 'U', '0')	/* IPU Generic Data */
+#define IPU_PIX_FMT_GENERIC_32 v4l2_fourcc('I', 'P', 'U', '1')	/* IPU Generic Data */
+#define IPU_PIX_FMT_LVDS666 v4l2_fourcc('L', 'V', 'D', '6')	/* IPU Generic Data */
+#define IPU_PIX_FMT_LVDS888 v4l2_fourcc('L', 'V', 'D', '8')	/* IPU Generic Data */
+/* RGB Formats */
+#define IPU_PIX_FMT_RGB332  V4L2_PIX_FMT_RGB332			/*  8  RGB-3-3-2    */
+#define IPU_PIX_FMT_RGB555  V4L2_PIX_FMT_RGB555			/* 16  RGB-5-5-5    */
+#define IPU_PIX_FMT_RGB565  V4L2_PIX_FMT_RGB565			/* 1 6  RGB-5-6-5   */
+#define IPU_PIX_FMT_RGB666  v4l2_fourcc('R', 'G', 'B', '6')	/* 18  RGB-6-6-6    */
+#define IPU_PIX_FMT_BGR666  v4l2_fourcc('B', 'G', 'R', '6')	/* 18  BGR-6-6-6    */
+#define IPU_PIX_FMT_BGR24   V4L2_PIX_FMT_BGR24			/* 24  BGR-8-8-8    */
+#define IPU_PIX_FMT_RGB24   V4L2_PIX_FMT_RGB24			/* 24  RGB-8-8-8    */
+#define IPU_PIX_FMT_GBR24   v4l2_fourcc('G', 'B', 'R', '3')	/* 24  GBR-8-8-8    */
+#define IPU_PIX_FMT_BGR32   V4L2_PIX_FMT_BGR32			/* 32  BGR-8-8-8-8  */
+#define IPU_PIX_FMT_BGRA32  v4l2_fourcc('B', 'G', 'R', 'A')	/* 32  BGR-8-8-8-8  */
+#define IPU_PIX_FMT_RGB32   V4L2_PIX_FMT_RGB32			/* 32  RGB-8-8-8-8  */
+#define IPU_PIX_FMT_RGBA32  v4l2_fourcc('R', 'G', 'B', 'A')	/* 32  RGB-8-8-8-8  */
+#define IPU_PIX_FMT_ABGR32  v4l2_fourcc('A', 'B', 'G', 'R')	/* 32  ABGR-8-8-8-8 */
+/* YUV Interleaved Formats */
+#define IPU_PIX_FMT_YUYV    V4L2_PIX_FMT_YUYV			/* 16 YUV 4:2:2 */
+#define IPU_PIX_FMT_UYVY    V4L2_PIX_FMT_UYVY			/* 16 YUV 4:2:2 */
+#define IPU_PIX_FMT_Y41P    V4L2_PIX_FMT_Y41P			/* 12 YUV 4:1:1 */
+#define IPU_PIX_FMT_YUV444  V4L2_PIX_FMT_YUV444			/* 24 YUV 4:4:4 */
+/* two planes -- one Y, one Cb + Cr interleaved  */
+#define IPU_PIX_FMT_NV12    V4L2_PIX_FMT_NV12			/* 12  Y/CbCr 4:2:0  */
+/* YUV Planar Formats */
+#define IPU_PIX_FMT_GREY    V4L2_PIX_FMT_GREY			/* 8  Greyscale */
+#define IPU_PIX_FMT_YVU410P V4L2_PIX_FMT_YVU410P		/* 9  YVU 4:1:0 */
+#define IPU_PIX_FMT_YUV410P V4L2_PIX_FMT_YUV410P		/* 9  YUV 4:1:0 */
+#define IPU_PIX_FMT_YVU420P v4l2_fourcc('Y', 'V', '1', '2')	/* 12 YVU 4:2:0 */
+#define IPU_PIX_FMT_YUV420P v4l2_fourcc('I', '4', '2', '0')	/* 12 YUV 4:2:0 */
+#define IPU_PIX_FMT_YUV420P2 v4l2_fourcc('Y', 'U', '1', '2')	/* 12 YUV 4:2:0 */
+#define IPU_PIX_FMT_YVU422P v4l2_fourcc('Y', 'V', '1', '6')	/* 16 YVU 4:2:2 */
+#define IPU_PIX_FMT_YUV422P V4L2_PIX_FMT_YUV422P		/* 16 YUV 4:2:2 */
+
+/*
+ * Bitfield of Display Interface signal polarities.
+ */
+struct ipu_di_signal_cfg {
+	unsigned datamask_en:1;
+	unsigned ext_clk:1;
+	unsigned interlaced:1;
+	unsigned odd_field_first:1;
+	unsigned clksel_en:1;
+	unsigned clkidle_en:1;
+	unsigned data_pol:1;	/* true = inverted */
+	unsigned clk_pol:1;	/* true = rising edge */
+	unsigned enable_pol:1;
+	unsigned Hsync_pol:1;	/* true = active high */
+	unsigned Vsync_pol:1;
+
+	u16 width;
+	u16 height;
+	u32 pixel_fmt;
+	u16 h_start_width;
+	u16 h_sync_width;
+	u16 h_end_width;
+	u16 v_start_width;
+	u16 v_sync_width;
+	u16 v_end_width;
+	u32 v_to_h_sync;
+};
+
+typedef enum {
+	IPU_COLORSPACE_RGB,
+	IPU_COLORSPACE_YCBCR,
+	IPU_COLORSPACE_YUV,
+	IPU_COLORSPACE_UNKNOWN,
+} ipu_color_space_t;
+
+#define IPU_IRQ_EOF(channel)		(channel)		/* 0 .. 63 */
+#define IPU_IRQ_NFACK(channel)		((channel) + 64)	/* 64 .. 127 */
+#define IPU_IRQ_NFB4EOF(channel)	((channel) + 128)	/* 128 .. 191 */
+#define IPU_IRQ_EOS(channel)		((channel) + 192)	/* 192 .. 255 */
+
+#define IPU_IRQ_DP_SF_START		(448 + 2)
+#define IPU_IRQ_DP_SF_END		(448 + 3)
+#define IPU_IRQ_BG_SF_END		IPU_IRQ_DP_SF_END,
+#define IPU_IRQ_DC_FC_0			(448 + 8)
+#define IPU_IRQ_DC_FC_1			(448 + 9)
+#define IPU_IRQ_DC_FC_2			(448 + 10)
+#define IPU_IRQ_DC_FC_3			(448 + 11)
+#define IPU_IRQ_DC_FC_4			(448 + 12)
+#define IPU_IRQ_DC_FC_6			(448 + 13)
+#define IPU_IRQ_VSYNC_PRE_0		(448 + 14)
+#define IPU_IRQ_VSYNC_PRE_1		(448 + 15)
+
+#define IPU_IRQ_COUNT	(15 * 32)
+
+struct ipu_channel;
+
+/*
+ * IPU Image DMA Controller (idmac) functions
+ */
+struct ipu_channel *ipu_idmac_get(struct ipu_soc *ipu, unsigned channel);
+void ipu_idmac_put(struct ipu_channel *);
+
+int ipu_idmac_enable_channel(struct ipu_channel *channel);
+int ipu_idmac_disable_channel(struct ipu_channel *channel);
+
+void ipu_idmac_set_double_buffer(struct ipu_channel *channel, bool doublebuffer);
+void ipu_idmac_select_buffer(struct ipu_channel *channel, u32 buf_num);
+
+/*
+ * IPU Display Controller (dc) functions
+ */
+struct ipu_dc;
+struct ipu_dc *ipu_dc_get(struct ipu_soc *ipu, int channel);
+void ipu_dc_put(struct ipu_dc *dc);
+int ipu_dc_init_sync(struct ipu_dc *dc, int di, bool interlaced,
+		u32 pixel_fmt, u32 width);
+void ipu_dc_init_async(struct ipu_dc *dc, int di, bool interlaced);
+void ipu_dc_enable_channel(struct ipu_dc *dc);
+void ipu_dc_disable_channel(struct ipu_dc *dc);
+
+/*
+ * IPU Display Interface (di) functions
+ */
+struct ipu_di;
+struct ipu_di *ipu_di_get(struct ipu_soc *ipu, int disp);
+void ipu_di_put(struct ipu_di *);
+int ipu_di_disable(struct ipu_di *);
+int ipu_di_enable(struct ipu_di *);
+int ipu_di_init_sync_panel(struct ipu_di *, struct ipu_di_signal_cfg *sig);
+
+/*
+ * IPU Display Multi FIFO Controller (dmfc) functions
+ */
+struct dmfc_channel;
+int ipu_dmfc_enable_channel(struct dmfc_channel *dmfc);
+void ipu_dmfc_disable_channel(struct dmfc_channel *dmfc);
+int ipu_dmfc_alloc_bandwidth(struct dmfc_channel *dmfc, unsigned long bandwidth_mbs);
+void ipu_dmfc_free_bandwidth(struct dmfc_channel *dmfc);
+int ipu_dmfc_init_channel(struct dmfc_channel *dmfc, int width);
+struct dmfc_channel *ipu_dmfc_get(struct ipu_soc *ipu, int ipu_channel);
+void ipu_dmfc_put(struct dmfc_channel *dmfc);
+
+/*
+ * IPU Display Processor (dp) functions
+ */
+#define IPU_DP_FLOW_SYNC_BG	0
+#define IPU_DP_FLOW_SYNC_FG	1
+#define IPU_DP_FLOW_ASYNC0_BG	2
+#define IPU_DP_FLOW_ASYNC0_FG	3
+#define IPU_DP_FLOW_ASYNC1_BG	4
+#define IPU_DP_FLOW_ASYNC1_FG	5
+
+struct ipu_dp *ipu_dp_get(struct ipu_soc *ipu, unsigned int flow);
+void ipu_dp_put(struct ipu_dp *);
+int ipu_dp_enable_channel(struct ipu_dp *dp);
+void ipu_dp_disable_channel(struct ipu_dp *dp);
+int ipu_dp_setup_channel(struct ipu_dp *dp,
+		ipu_color_space_t in, ipu_color_space_t out);
+int ipu_dp_set_window_pos(struct ipu_dp *, u16 x_pos, u16 y_pos);
+int ipu_dp_set_global_alpha(struct ipu_dp *dp, bool enable, u8 alpha,
+		bool bg_chan);
+
+#define IPU_CPMEM_WORD(word, ofs, size) ((((word) * 160 + (ofs)) << 8) | (size))
+
+#define IPU_FIELD_UBO		IPU_CPMEM_WORD(0, 46, 22)
+#define IPU_FIELD_VBO		IPU_CPMEM_WORD(0, 68, 22)
+#define IPU_FIELD_IOX		IPU_CPMEM_WORD(0, 90, 4)
+#define IPU_FIELD_RDRW		IPU_CPMEM_WORD(0, 94, 1)
+#define IPU_FIELD_SO		IPU_CPMEM_WORD(0, 113, 1)
+#define IPU_FIELD_SLY		IPU_CPMEM_WORD(1, 102, 14)
+#define IPU_FIELD_SLUV		IPU_CPMEM_WORD(1, 128, 14)
+
+#define IPU_FIELD_XV		IPU_CPMEM_WORD(0, 0, 10)
+#define IPU_FIELD_YV		IPU_CPMEM_WORD(0, 10, 9)
+#define IPU_FIELD_XB		IPU_CPMEM_WORD(0, 19, 13)
+#define IPU_FIELD_YB		IPU_CPMEM_WORD(0, 32, 12)
+#define IPU_FIELD_NSB_B		IPU_CPMEM_WORD(0, 44, 1)
+#define IPU_FIELD_CF		IPU_CPMEM_WORD(0, 45, 1)
+#define IPU_FIELD_SX		IPU_CPMEM_WORD(0, 46, 12)
+#define IPU_FIELD_SY		IPU_CPMEM_WORD(0, 58, 11)
+#define IPU_FIELD_NS		IPU_CPMEM_WORD(0, 69, 10)
+#define IPU_FIELD_SDX		IPU_CPMEM_WORD(0, 79, 7)
+#define IPU_FIELD_SM		IPU_CPMEM_WORD(0, 86, 10)
+#define IPU_FIELD_SCC		IPU_CPMEM_WORD(0, 96, 1)
+#define IPU_FIELD_SCE		IPU_CPMEM_WORD(0, 97, 1)
+#define IPU_FIELD_SDY		IPU_CPMEM_WORD(0, 98, 7)
+#define IPU_FIELD_SDRX		IPU_CPMEM_WORD(0, 105, 1)
+#define IPU_FIELD_SDRY		IPU_CPMEM_WORD(0, 106, 1)
+#define IPU_FIELD_BPP		IPU_CPMEM_WORD(0, 107, 3)
+#define IPU_FIELD_DEC_SEL	IPU_CPMEM_WORD(0, 110, 2)
+#define IPU_FIELD_DIM		IPU_CPMEM_WORD(0, 112, 1)
+#define IPU_FIELD_BNDM		IPU_CPMEM_WORD(0, 114, 3)
+#define IPU_FIELD_BM		IPU_CPMEM_WORD(0, 117, 2)
+#define IPU_FIELD_ROT		IPU_CPMEM_WORD(0, 119, 1)
+#define IPU_FIELD_HF		IPU_CPMEM_WORD(0, 120, 1)
+#define IPU_FIELD_VF		IPU_CPMEM_WORD(0, 121, 1)
+#define IPU_FIELD_THE		IPU_CPMEM_WORD(0, 122, 1)
+#define IPU_FIELD_CAP		IPU_CPMEM_WORD(0, 123, 1)
+#define IPU_FIELD_CAE		IPU_CPMEM_WORD(0, 124, 1)
+#define IPU_FIELD_FW		IPU_CPMEM_WORD(0, 125, 13)
+#define IPU_FIELD_FH		IPU_CPMEM_WORD(0, 138, 12)
+#define IPU_FIELD_EBA0		IPU_CPMEM_WORD(1, 0, 29)
+#define IPU_FIELD_EBA1		IPU_CPMEM_WORD(1, 29, 29)
+#define IPU_FIELD_ILO		IPU_CPMEM_WORD(1, 58, 20)
+#define IPU_FIELD_NPB		IPU_CPMEM_WORD(1, 78, 7)
+#define IPU_FIELD_PFS		IPU_CPMEM_WORD(1, 85, 4)
+#define IPU_FIELD_ALU		IPU_CPMEM_WORD(1, 89, 1)
+#define IPU_FIELD_ALBM		IPU_CPMEM_WORD(1, 90, 3)
+#define IPU_FIELD_ID		IPU_CPMEM_WORD(1, 93, 2)
+#define IPU_FIELD_TH		IPU_CPMEM_WORD(1, 95, 7)
+#define IPU_FIELD_SL		IPU_CPMEM_WORD(1, 102, 14)
+#define IPU_FIELD_WID0		IPU_CPMEM_WORD(1, 116, 3)
+#define IPU_FIELD_WID1		IPU_CPMEM_WORD(1, 119, 3)
+#define IPU_FIELD_WID2		IPU_CPMEM_WORD(1, 122, 3)
+#define IPU_FIELD_WID3		IPU_CPMEM_WORD(1, 125, 3)
+#define IPU_FIELD_OFS0		IPU_CPMEM_WORD(1, 128, 5)
+#define IPU_FIELD_OFS1		IPU_CPMEM_WORD(1, 133, 5)
+#define IPU_FIELD_OFS2		IPU_CPMEM_WORD(1, 138, 5)
+#define IPU_FIELD_OFS3		IPU_CPMEM_WORD(1, 143, 5)
+#define IPU_FIELD_SXYS		IPU_CPMEM_WORD(1, 148, 1)
+#define IPU_FIELD_CRE		IPU_CPMEM_WORD(1, 149, 1)
+#define IPU_FIELD_DEC_SEL2	IPU_CPMEM_WORD(1, 150, 1)
+
+struct ipu_cpmem_word {
+	u32 data[5];
+	u32 res[3];
+};
+
+struct ipu_ch_param {
+	struct ipu_cpmem_word word[2];
+};
+
+void ipu_ch_param_set_field(struct ipu_ch_param *base, u32 wbs, u32 v);
+
+struct ipu_ch_param *ipu_get_cpmem(struct ipu_channel *channel);
+
+void ipu_ch_param_dump(struct ipu_ch_param *p);
+
+static inline void ipu_cpmem_set_buffer(struct ipu_ch_param *p, int bufnum,
+		dma_addr_t buf)
+{
+	if (bufnum)
+		ipu_ch_param_set_field(p, IPU_FIELD_EBA1, buf >> 3);
+	else
+		ipu_ch_param_set_field(p, IPU_FIELD_EBA0, buf >> 3);
+}
+
+static inline void ipu_cpmem_set_resolution(struct ipu_ch_param *p, int xres,
+		int yres)
+{
+	ipu_ch_param_set_field(p, IPU_FIELD_FW, xres - 1);
+	ipu_ch_param_set_field(p, IPU_FIELD_FH, yres - 1);
+}
+
+static inline void ipu_cpmem_set_stride(struct ipu_ch_param *p, int stride)
+{
+	ipu_ch_param_set_field(p, IPU_FIELD_SLY, stride - 1);
+}
+
+static inline void ipu_cpmem_set_high_priority(struct ipu_ch_param *p)
+{
+	ipu_ch_param_set_field(p, IPU_FIELD_ID, 1);
+};
+
+struct ipu_rgb {
+	struct fb_bitfield	red;
+	struct fb_bitfield	green;
+	struct fb_bitfield	blue;
+	struct fb_bitfield	transp;
+	int			bits_per_pixel;	
+};
+
+void ipu_cpmem_set_format_rgb(struct ipu_ch_param *, struct ipu_rgb *rgb);
+
+static inline void ipu_cpmem_interlaced_scan(struct ipu_ch_param *p, int stride)
+{
+	ipu_ch_param_set_field(p, IPU_FIELD_SO, 1);
+	ipu_ch_param_set_field(p, IPU_FIELD_ILO, stride / 8);
+	ipu_ch_param_set_field(p, IPU_FIELD_SLY, (stride * 2) - 1);
+};
+
+void ipu_cpmem_set_yuv_interleaved(struct ipu_ch_param *p, u32 pixel_format);
+
+#endif
-- 
1.7.5.3
