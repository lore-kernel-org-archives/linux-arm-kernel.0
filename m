From: jason.chen@freescale.com (jason.chen at freescale.com)
Date: Thu, 14 Apr 2011 10:04:56 +0800
Subject: [PATCH 1/7] Add a mfd IPUv3 driver
Message-ID: <1302746696-2666-1-git-send-email-jason.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Chen <b02280@freescale.com>

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
Signed-off-by: Jason Chen <Jason.Chen@freescale.com>
---
 arch/arm/plat-mxc/include/mach/ipu-v3.h |   52 ++
 drivers/video/Kconfig                   |    2 +
 drivers/video/Makefile                  |    1 +
 drivers/video/imx-ipu-v3/Kconfig        |   10 +
 drivers/video/imx-ipu-v3/Makefile       |    3 +
 drivers/video/imx-ipu-v3/ipu-common.c   | 1257 +++++++++++++++++++++++++++++++
 drivers/video/imx-ipu-v3/ipu-dc.c       |  442 +++++++++++
 drivers/video/imx-ipu-v3/ipu-di.c       |  572 ++++++++++++++
 drivers/video/imx-ipu-v3/ipu-dmfc.c     |  376 +++++++++
 drivers/video/imx-ipu-v3/ipu-dp.c       |  507 +++++++++++++
 drivers/video/imx-ipu-v3/ipu-prv.h      |  288 +++++++
 include/video/imx-ipu-v3.h              |  226 ++++++
 12 files changed, 3736 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/ipu-v3.h b/arch/arm/plat-mxc/include/mach/ipu-v3.h
new file mode 100644
index 0000000..184dfe5
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/ipu-v3.h
@@ -0,0 +1,52 @@
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
+/* IPU specific extensions to struct fb_videomode flag field */
+#define FB_SYNC_OE_LOW_ACT	(1 << 8)
+#define FB_SYNC_CLK_LAT_FALL	(1 << 9)
+#define FB_SYNC_DATA_INVERT	(1 << 10)
+#define FB_SYNC_CLK_IDLE_EN	(1 << 11)
+#define FB_SYNC_SHARP_MODE	(1 << 12)
+#define FB_SYNC_SWAP_RGB	(1 << 13)
+
+struct ipuv3_fb_platform_data {
+	const struct fb_videomode	*modes;
+	int				num_modes;
+	char				*mode_str;
+	u32				interface_pix_fmt;
+
+#define IMX_IPU_FB_USE_MODEDB	(1 << 0)
+#define IMX_IPU_FB_USE_OVERLAY	(1 << 1)
+	unsigned long			flags;
+
+	int				ipu_channel_bg;
+	int				ipu_channel_fg;
+	int				dc_channel;
+	int				dp_channel;
+	int				display;
+
+	void				*ipu;
+};
+
+struct imx_ipuv3_platform_data {
+	int rev;
+	int (*init) (struct platform_device *);
+	struct ipuv3_fb_platform_data	*fb_head0_platform_data;
+	struct ipuv3_fb_platform_data	*fb_head1_platform_data;
+};
+
+#endif /* __MACH_IPU_V3_H_ */
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e0ea23f..9698c00 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -26,6 +26,8 @@ source "drivers/gpu/drm/Kconfig"
 
 source "drivers/gpu/stub/Kconfig"
 
+source "drivers/video/imx-ipu-v3/Kconfig"
+
 config VGASTATE
        tristate
        default n
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 9a096ae..f6f15fd 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -154,6 +154,7 @@ obj-$(CONFIG_FB_BFIN_7393)        += bfin_adv7393fb.o
 obj-$(CONFIG_FB_MX3)		  += mx3fb.o
 obj-$(CONFIG_FB_DA8XX)		  += da8xx-fb.o
 obj-$(CONFIG_FB_MXS)		  += mxsfb.o
+obj-$(CONFIG_FB_IMX_IPU_V3)	  += imx-ipu-v3/
 
 # the test framebuffer is last
 obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
diff --git a/drivers/video/imx-ipu-v3/Kconfig b/drivers/video/imx-ipu-v3/Kconfig
new file mode 100644
index 0000000..75aa483
--- /dev/null
+++ b/drivers/video/imx-ipu-v3/Kconfig
@@ -0,0 +1,10 @@
+
+config FB_IMX_IPU_V3
+	tristate "Support the Image Processing Unit (IPU) found on the i.MX5x"
+	depends on ARCH_MX51 || ARCH_MX53
+	select MFD_SUPPORT
+	select MFD_CORE
+	help
+	  Say yes here to support the IPU on i.MX5x. This is used by the fb
+	  driver and also by the i.MX5x camera support.
+
diff --git a/drivers/video/imx-ipu-v3/Makefile b/drivers/video/imx-ipu-v3/Makefile
new file mode 100644
index 0000000..65b6153
--- /dev/null
+++ b/drivers/video/imx-ipu-v3/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_FB_IMX_IPU_V3) += imx-ipu-v3.o
+
+imx-ipu-v3-objs := ipu-common.o ipu-dc.o ipu-di.o ipu-dp.o ipu-dmfc.o
diff --git a/drivers/video/imx-ipu-v3/ipu-common.c b/drivers/video/imx-ipu-v3/ipu-common.c
new file mode 100644
index 0000000..082a5af
--- /dev/null
+++ b/drivers/video/imx-ipu-v3/ipu-common.c
@@ -0,0 +1,1257 @@
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
+#include <linux/bitrev.h>
+#include <linux/slab.h>
+#include <mach/common.h>
+#include <linux/mfd/core.h>
+#include <mach/ipu-v3.h>
+#include <video/imx-ipu-v3.h>
+
+#include "ipu-prv.h"
+
+static inline struct ipu_soc *idmachannel2ipu(struct ipu_channel *channel)
+{
+	struct ipu_soc *ipu;
+	struct ipu_channel *base = channel - channel->num;
+
+	ipu = container_of(base, struct ipu_soc, channels[0]);
+
+	return ipu;
+}
+
+struct ipu_channel *ipu_idmac_get(struct ipu_soc *ipu, unsigned num)
+{
+	struct ipu_channel *channel;
+
+	dev_dbg(ipu->ipu_dev, "%s %d\n", __func__, num);
+
+	if (num > (IPU_IDMA_CHAN_NUM - 1))
+		return ERR_PTR(-ENODEV);
+
+	mutex_lock(&ipu->ipu_channel_lock);
+
+	channel = &ipu->channels[num];
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
+	mutex_unlock(&ipu->ipu_channel_lock);
+
+	return channel;
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_get);
+
+void ipu_idmac_put(struct ipu_channel *channel)
+{
+	struct ipu_soc *ipu = idmachannel2ipu(channel);
+
+	dev_dbg(ipu->ipu_dev, "%s %d\n", __func__, channel->num);
+
+	mutex_lock(&ipu->ipu_channel_lock);
+
+	channel->busy = 0;
+
+	mutex_unlock(&ipu->ipu_channel_lock);
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_put);
+
+void ipu_idmac_set_double_buffer(struct ipu_channel *channel,
+			bool doublebuffer)
+{
+	struct ipu_soc *ipu = idmachannel2ipu(channel);
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&ipu->ipu_lock, flags);
+
+	reg = ipu_cm_read(ipu, IPU_CHA_DB_MODE_SEL(channel->num));
+	if (doublebuffer)
+		reg |= idma_mask(channel->num);
+	else
+		reg &= ~idma_mask(channel->num);
+	ipu_cm_write(ipu, reg, IPU_CHA_DB_MODE_SEL(channel->num));
+
+	spin_unlock_irqrestore(&ipu->ipu_lock, flags);
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_set_double_buffer);
+
+void ipu_idmac_select_buffer(struct ipu_channel *channel,
+			u32 buf_num)
+{
+	struct ipu_soc *ipu = idmachannel2ipu(channel);
+	unsigned int chno = channel->num;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ipu->ipu_lock, flags);
+
+	/* Mark buffer as ready. */
+	if (buf_num == 0)
+		ipu_cm_write(ipu, idma_mask(chno), IPU_CHA_BUF0_RDY(chno));
+	else
+		ipu_cm_write(ipu, idma_mask(chno), IPU_CHA_BUF1_RDY(chno));
+
+	spin_unlock_irqrestore(&ipu->ipu_lock, flags);
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_select_buffer);
+
+int ipu_idmac_enable_channel(struct ipu_channel *channel)
+{
+	struct ipu_soc *ipu = idmachannel2ipu(channel);
+	u32 val;
+	unsigned long flags;
+
+	ipu_get(ipu);
+
+	spin_lock_irqsave(&ipu->ipu_lock, flags);
+
+	val = ipu_idmac_read(ipu, IDMAC_CHA_EN(channel->num));
+	val |= idma_mask(channel->num);
+	ipu_idmac_write(ipu, val, IDMAC_CHA_EN(channel->num));
+
+	spin_unlock_irqrestore(&ipu->ipu_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_enable_channel);
+
+int ipu_idmac_disable_channel(struct ipu_channel *channel)
+{
+	struct ipu_soc *ipu = idmachannel2ipu(channel);
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ipu->ipu_lock, flags);
+
+	/* Disable DMA channel(s) */
+	val = ipu_idmac_read(ipu, IDMAC_CHA_EN(channel->num));
+	val &= ~idma_mask(channel->num);
+	ipu_idmac_write(ipu, val, IDMAC_CHA_EN(channel->num));
+
+	/* Set channel buffers NOT to be ready */
+	ipu_cm_write(ipu, 0xf0000000, IPU_GPR); /* write one to clear */
+
+	if (ipu_idma_is_set(ipu, IPU_CHA_BUF0_RDY, channel->num)) {
+		ipu_cm_write(ipu, idma_mask(channel->num),
+			     IPU_CHA_BUF0_RDY(channel->num));
+	}
+	if (ipu_idma_is_set(ipu, IPU_CHA_BUF1_RDY, channel->num)) {
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
+	spin_unlock_irqrestore(&ipu->ipu_lock, flags);
+
+	ipu_put(ipu);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_disable_channel);
+
+#define __F(word, ofs, size) ((((word) * 160 + (ofs)) << 8) | (size))
+
+#define IPU_FIELD_XV		__F(0, 0, 10)
+#define IPU_FIELD_YV		__F(0, 10, 9)
+#define IPU_FIELD_XB		__F(0, 19, 13)
+#define IPU_FIELD_YB		__F(0, 32, 12)
+#define IPU_FIELD_NSB_B		__F(0, 44, 1)
+#define IPU_FIELD_CF		__F(0, 45, 1)
+#define IPU_FIELD_UBO		__F(0, 46, 22)
+#define IPU_FIELD_VBO		__F(0, 68, 22)
+#define IPU_FIELD_IOX		__F(0, 90, 4)
+#define IPU_FIELD_RDRW		__F(0, 94, 1)
+#define IPU_FIELD_SO		__F(0, 113, 1)
+#define IPU_FIELD_BNDM		__F(0, 114, 3)
+#define IPU_FIELD_BM		__F(0, 117, 2)
+#define IPU_FIELD_ROT		__F(0, 119, 1)
+#define IPU_FIELD_HF		__F(0, 120, 1)
+#define IPU_FIELD_VF		__F(0, 121, 1)
+#define IPU_FIELD_THE		__F(0, 122, 1)
+#define IPU_FIELD_CAP		__F(0, 123, 1)
+#define IPU_FIELD_CAE		__F(0, 124, 1)
+#define IPU_FIELD_FW		__F(0, 125, 13)
+#define IPU_FIELD_FH		__F(0, 138, 12)
+#define IPU_FIELD_EBA0		__F(1, 0, 29)
+#define IPU_FIELD_EBA1		__F(1, 29, 29)
+#define IPU_FIELD_ILO		__F(1, 58, 20)
+#define IPU_FIELD_NPB		__F(1, 78, 7)
+#define IPU_FIELD_PFS		__F(1, 85, 4)
+#define IPU_FIELD_ALU		__F(1, 89, 1)
+#define IPU_FIELD_ALBM		__F(1, 90, 3)
+#define IPU_FIELD_ID		__F(1, 93, 2)
+#define IPU_FIELD_TH		__F(1, 95, 7)
+#define IPU_FIELD_SLY		__F(1, 102, 14)
+#define IPU_FIELD_WID3		__F(1, 125, 3)
+#define IPU_FIELD_SLUV		__F(1, 128, 14)
+#define IPU_FIELD_CRE		__F(1, 149, 1)
+
+#define IPU_FIELD_XV		__F(0, 0, 10)
+#define IPU_FIELD_YV		__F(0, 10, 9)
+#define IPU_FIELD_XB		__F(0, 19, 13)
+#define IPU_FIELD_YB		__F(0, 32, 12)
+#define IPU_FIELD_NSB_B		__F(0, 44, 1)
+#define IPU_FIELD_CF		__F(0, 45, 1)
+#define IPU_FIELD_SX		__F(0, 46, 12)
+#define IPU_FIELD_SY		__F(0, 58, 11)
+#define IPU_FIELD_NS		__F(0, 69, 10)
+#define IPU_FIELD_SDX		__F(0, 79, 7)
+#define IPU_FIELD_SM		__F(0, 86, 10)
+#define IPU_FIELD_SCC		__F(0, 96, 1)
+#define IPU_FIELD_SCE		__F(0, 97, 1)
+#define IPU_FIELD_SDY		__F(0, 98, 7)
+#define IPU_FIELD_SDRX		__F(0, 105, 1)
+#define IPU_FIELD_SDRY		__F(0, 106, 1)
+#define IPU_FIELD_BPP		__F(0, 107, 3)
+#define IPU_FIELD_DEC_SEL	__F(0, 110, 2)
+#define IPU_FIELD_DIM		__F(0, 112, 1)
+#define IPU_FIELD_SO		__F(0, 113, 1)
+#define IPU_FIELD_BNDM		__F(0, 114, 3)
+#define IPU_FIELD_BM		__F(0, 117, 2)
+#define IPU_FIELD_ROT		__F(0, 119, 1)
+#define IPU_FIELD_HF		__F(0, 120, 1)
+#define IPU_FIELD_VF		__F(0, 121, 1)
+#define IPU_FIELD_THE		__F(0, 122, 1)
+#define IPU_FIELD_CAP		__F(0, 123, 1)
+#define IPU_FIELD_CAE		__F(0, 124, 1)
+#define IPU_FIELD_FW		__F(0, 125, 13)
+#define IPU_FIELD_FH		__F(0, 138, 12)
+#define IPU_FIELD_EBA0		__F(1, 0, 29)
+#define IPU_FIELD_EBA1		__F(1, 29, 29)
+#define IPU_FIELD_ILO		__F(1, 58, 20)
+#define IPU_FIELD_NPB		__F(1, 78, 7)
+#define IPU_FIELD_PFS		__F(1, 85, 4)
+#define IPU_FIELD_ALU		__F(1, 89, 1)
+#define IPU_FIELD_ALBM		__F(1, 90, 3)
+#define IPU_FIELD_ID		__F(1, 93, 2)
+#define IPU_FIELD_TH		__F(1, 95, 7)
+#define IPU_FIELD_SL		__F(1, 102, 14)
+#define IPU_FIELD_WID0		__F(1, 116, 3)
+#define IPU_FIELD_WID1		__F(1, 119, 3)
+#define IPU_FIELD_WID2		__F(1, 122, 3)
+#define IPU_FIELD_WID3		__F(1, 125, 3)
+#define IPU_FIELD_OFS0		__F(1, 128, 5)
+#define IPU_FIELD_OFS1		__F(1, 133, 5)
+#define IPU_FIELD_OFS2		__F(1, 138, 5)
+#define IPU_FIELD_OFS3		__F(1, 143, 5)
+#define IPU_FIELD_SXYS		__F(1, 148, 1)
+#define IPU_FIELD_CRE		__F(1, 149, 1)
+#define IPU_FIELD_DEC_SEL2	__F(1, 150, 1)
+
+struct ipu_ch_param_word {
+	u32 data[5];
+	u32 res[3];
+};
+
+struct ipu_ch_param {
+	struct ipu_ch_param_word word[2];
+};
+
+static u32 ipu_bytes_per_pixel(u32 fmt)
+{
+	switch (fmt) {
+	case IPU_PIX_FMT_GENERIC:	/* generic data */
+	case IPU_PIX_FMT_RGB332:
+	case IPU_PIX_FMT_YUV420P:
+	case IPU_PIX_FMT_YUV422P:
+		return 1;
+
+	case IPU_PIX_FMT_RGB565:
+	case IPU_PIX_FMT_YUYV:
+	case IPU_PIX_FMT_UYVY:
+		return 2;
+
+	case IPU_PIX_FMT_BGR24:
+	case IPU_PIX_FMT_RGB24:
+		return 3;
+
+	case IPU_PIX_FMT_GENERIC_32:	/* generic data */
+	case IPU_PIX_FMT_BGR32:
+	case IPU_PIX_FMT_BGRA32:
+	case IPU_PIX_FMT_RGB32:
+	case IPU_PIX_FMT_RGBA32:
+	case IPU_PIX_FMT_ABGR32:
+		return 4;
+
+	default:
+		return 1;
+	}
+}
+
+bool ipu_pixel_format_has_alpha(u32 fmt)
+{
+	switch (fmt) {
+	case IPU_PIX_FMT_RGBA32:
+	case IPU_PIX_FMT_BGRA32:
+	case IPU_PIX_FMT_ABGR32:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+#define ipu_ch_param_addr(cpmem_base, ch) (((struct ipu_ch_param *)cpmem_base) + (ch))
+
+static inline void ipu_ch_param_set_field(struct ipu_ch_param *base, u32 wbs, u32 v)
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
+
+static inline u32 ipu_ch_param_read_field(struct ipu_ch_param *base, u32 wbs)
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
+
+static inline void ipu_ch_params_set_packing(struct ipu_ch_param *p,
+					      int red_width, int red_offset,
+					      int green_width, int green_offset,
+					      int blue_width, int blue_offset,
+					      int alpha_width, int alpha_offset)
+{
+	/* Setup red width and offset */
+	ipu_ch_param_set_field(p, IPU_FIELD_WID0, red_width - 1);
+	ipu_ch_param_set_field(p, IPU_FIELD_OFS0, red_offset);
+	/* Setup green width and offset */
+	ipu_ch_param_set_field(p, IPU_FIELD_WID1, green_width - 1);
+	ipu_ch_param_set_field(p, IPU_FIELD_OFS1, green_offset);
+	/* Setup blue width and offset */
+	ipu_ch_param_set_field(p, IPU_FIELD_WID2, blue_width - 1);
+	ipu_ch_param_set_field(p, IPU_FIELD_OFS2, blue_offset);
+	/* Setup alpha width and offset */
+	ipu_ch_param_set_field(p, IPU_FIELD_WID3, alpha_width - 1);
+	ipu_ch_param_set_field(p, IPU_FIELD_OFS3, alpha_offset);
+}
+
+static inline void ipu_ch_param_dump(struct ipu_soc *ipu, int ch)
+{
+	struct ipu_ch_param *p = ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch);
+	dev_dbg(ipu->ipu_dev, "ch %d word 0 - %08X %08X %08X %08X %08X\n", ch,
+		 p->word[0].data[0], p->word[0].data[1], p->word[0].data[2],
+		 p->word[0].data[3], p->word[0].data[4]);
+	dev_dbg(ipu->ipu_dev, "ch %d word 1 - %08X %08X %08X %08X %08X\n", ch,
+		 p->word[1].data[0], p->word[1].data[1], p->word[1].data[2],
+		 p->word[1].data[3], p->word[1].data[4]);
+	dev_dbg(ipu->ipu_dev, "PFS 0x%x\n", ipu_ch_param_read_field(p, IPU_FIELD_PFS));
+	dev_dbg(ipu->ipu_dev, "BPP 0x%x\n", ipu_ch_param_read_field(p, IPU_FIELD_BPP));
+	dev_dbg(ipu->ipu_dev, "NPB 0x%x\n", ipu_ch_param_read_field(p, IPU_FIELD_NPB));
+
+	dev_dbg(ipu->ipu_dev, "FW %d\n", ipu_ch_param_read_field(p, IPU_FIELD_FW));
+	dev_dbg(ipu->ipu_dev, "FH %d\n", ipu_ch_param_read_field(p, IPU_FIELD_FH));
+	dev_dbg(ipu->ipu_dev, "Stride %d\n", ipu_ch_param_read_field(p, IPU_FIELD_SL));
+
+	dev_dbg(ipu->ipu_dev, "Width0 %d+1\n", ipu_ch_param_read_field(p, IPU_FIELD_WID0));
+	dev_dbg(ipu->ipu_dev, "Width1 %d+1\n", ipu_ch_param_read_field(p, IPU_FIELD_WID1));
+	dev_dbg(ipu->ipu_dev, "Width2 %d+1\n", ipu_ch_param_read_field(p, IPU_FIELD_WID2));
+	dev_dbg(ipu->ipu_dev, "Width3 %d+1\n", ipu_ch_param_read_field(p, IPU_FIELD_WID3));
+	dev_dbg(ipu->ipu_dev, "Offset0 %d\n", ipu_ch_param_read_field(p, IPU_FIELD_OFS0));
+	dev_dbg(ipu->ipu_dev, "Offset1 %d\n", ipu_ch_param_read_field(p, IPU_FIELD_OFS1));
+	dev_dbg(ipu->ipu_dev, "Offset2 %d\n", ipu_ch_param_read_field(p, IPU_FIELD_OFS2));
+	dev_dbg(ipu->ipu_dev, "Offset3 %d\n", ipu_ch_param_read_field(p, IPU_FIELD_OFS3));
+}
+
+static inline void ipu_ch_param_set_burst_size(struct ipu_soc *ipu,
+						u32 ch, u16 burst_pixels)
+{
+	ipu_ch_param_set_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_NPB,
+			       burst_pixels - 1);
+};
+
+static inline int ipu_ch_param_get_burst_size(struct ipu_soc *ipu, u32 ch)
+{
+	return ipu_ch_param_read_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_NPB) + 1;
+};
+
+static inline int ipu_ch_param_get_bpp(struct ipu_soc *ipu, u32 ch)
+{
+	return ipu_ch_param_read_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_BPP);
+};
+
+static inline void ipu_ch_param_set_buffer(struct ipu_soc *ipu, u32 ch, int bufNum,
+					    dma_addr_t phyaddr)
+{
+	ipu_ch_param_set_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch),
+			bufNum ? IPU_FIELD_EBA1 : IPU_FIELD_EBA0,
+			phyaddr / 8);
+};
+
+#define IPU_FIELD_ROT_HF_VF		__F(0, 119, 3)
+
+static inline void ipu_ch_param_set_rotation(struct ipu_soc *ipu,
+				u32 ch, ipu_rotate_mode_t rot)
+{
+	u32 temp_rot = bitrev8(rot) >> 5;
+	ipu_ch_param_set_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_ROT_HF_VF, temp_rot);
+};
+
+static inline void ipu_ch_param_set_block_mode(struct ipu_soc *ipu, u32 ch)
+{
+	ipu_ch_param_set_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_BM, 1);
+};
+
+static inline void ipu_ch_param_set_alpha_use_separate_channel(struct ipu_soc *ipu,
+		u32 ch, bool option)
+{
+	if (option)
+		ipu_ch_param_set_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_ALU, 1);
+	else
+		ipu_ch_param_set_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_ALU, 0);
+};
+
+static inline void ipu_ch_param_set_alpha_condition_read(struct ipu_soc *ipu, u32 ch)
+{
+	ipu_ch_param_set_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_CRE, 1);
+};
+
+static inline void ipu_ch_param_set_alpha_buffer_memory(struct ipu_soc *ipu, u32 ch)
+{
+	int alp_mem_idx;
+
+	switch (ch) {
+	case 14: /* PRP graphic */
+		alp_mem_idx = 0;
+		break;
+	case 15: /* PP graphic */
+		alp_mem_idx = 1;
+		break;
+	case 23: /* DP BG SYNC graphic */
+		alp_mem_idx = 4;
+		break;
+	case 27: /* DP FG SYNC graphic */
+		alp_mem_idx = 2;
+		break;
+	default:
+		dev_err(ipu->ipu_dev, "unsupported correlated channel of local alpha channel\n");
+		return;
+	}
+
+	ipu_ch_param_set_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_ALBM, alp_mem_idx);
+};
+
+static inline void ipu_ch_param_set_interlaced_scan(struct ipu_soc *ipu, u32 ch)
+{
+	u32 stride;
+	ipu_ch_param_set_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_SO, 1);
+	stride = ipu_ch_param_read_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_SL) + 1;
+	ipu_ch_param_set_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_ILO, stride / 8);
+	stride *= 2;
+	ipu_ch_param_set_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_SLY, stride - 1);
+};
+
+static inline void ipu_ch_param_set_high_priority(struct ipu_soc *ipu, u32 ch)
+{
+	ipu_ch_param_set_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_ID, 1);
+};
+
+static inline void ipu_ch_params_set_alpha_width(struct ipu_soc *ipu, u32 ch, int alpha_width)
+{
+	ipu_ch_param_set_field(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), IPU_FIELD_WID3,
+			alpha_width - 1);
+}
+
+static int ipu_ch_param_init(struct ipu_soc *ipu,
+			int ch,
+			u32 pixel_fmt, u32 width,
+			u32 height, u32 stride,
+			u32 u, u32 v,
+			u32 uv_stride, dma_addr_t addr0,
+			dma_addr_t addr1)
+{
+	u32 u_offset = 0;
+	u32 v_offset = 0;
+	struct ipu_ch_param params;
+
+	memset(&params, 0, sizeof(params));
+
+	ipu_ch_param_set_field(&params, IPU_FIELD_FW, width - 1);
+	ipu_ch_param_set_field(&params, IPU_FIELD_FH, height - 1);
+	ipu_ch_param_set_field(&params, IPU_FIELD_SLY, stride - 1);
+	ipu_ch_param_set_field(&params, IPU_FIELD_EBA0, addr0 >> 3);
+	ipu_ch_param_set_field(&params, IPU_FIELD_EBA1, addr1 >> 3);
+
+	switch (pixel_fmt) {
+	case IPU_PIX_FMT_GENERIC:
+		/* Represents 8-bit Generic data */
+		ipu_ch_param_set_field(&params, IPU_FIELD_BPP, 5);	/* bits/pixel */
+		ipu_ch_param_set_field(&params, IPU_FIELD_PFS, 6);	/* pix format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_NPB, 63);	/* burst size */
+
+		break;
+	case IPU_PIX_FMT_GENERIC_32:
+		/* Represents 32-bit Generic data */
+		break;
+	case IPU_PIX_FMT_RGB565:
+		ipu_ch_param_set_field(&params, IPU_FIELD_BPP, 3);	/* bits/pixel */
+		ipu_ch_param_set_field(&params, IPU_FIELD_PFS, 7);	/* pix format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_NPB, 15);	/* burst size */
+
+		ipu_ch_params_set_packing(&params, 5, 0, 6, 5, 5, 11, 8, 16);
+		break;
+	case IPU_PIX_FMT_BGR24:
+		ipu_ch_param_set_field(&params, IPU_FIELD_BPP, 1);	/* bits/pixel */
+		ipu_ch_param_set_field(&params, IPU_FIELD_PFS, 7);	/* pix format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_NPB, 19);	/* burst size */
+
+		ipu_ch_params_set_packing(&params, 8, 0, 8, 8, 8, 16, 8, 24);
+		break;
+	case IPU_PIX_FMT_RGB24:
+	case IPU_PIX_FMT_YUV444:
+		ipu_ch_param_set_field(&params, IPU_FIELD_BPP, 1);	/* bits/pixel */
+		ipu_ch_param_set_field(&params, IPU_FIELD_PFS, 7);	/* pix format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_NPB, 19);	/* burst size */
+
+		ipu_ch_params_set_packing(&params, 8, 16, 8, 8, 8, 0, 8, 24);
+		break;
+	case IPU_PIX_FMT_BGRA32:
+	case IPU_PIX_FMT_BGR32:
+		ipu_ch_param_set_field(&params, IPU_FIELD_BPP, 0);	/* bits/pixel */
+		ipu_ch_param_set_field(&params, IPU_FIELD_PFS, 7);	/* pix format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_NPB, 15);	/* burst size */
+
+		ipu_ch_params_set_packing(&params, 8, 8, 8, 16, 8, 24, 8, 0);
+		break;
+	case IPU_PIX_FMT_RGBA32:
+	case IPU_PIX_FMT_RGB32:
+		ipu_ch_param_set_field(&params, IPU_FIELD_BPP, 0);	/* bits/pixel */
+		ipu_ch_param_set_field(&params, IPU_FIELD_PFS, 7);	/* pix format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_NPB, 15);	/* burst size */
+
+		ipu_ch_params_set_packing(&params, 8, 24, 8, 16, 8, 8, 8, 0);
+		break;
+	case IPU_PIX_FMT_ABGR32:
+		ipu_ch_param_set_field(&params, IPU_FIELD_BPP, 0);	/* bits/pixel */
+		ipu_ch_param_set_field(&params, IPU_FIELD_PFS, 7);	/* pix format */
+
+		ipu_ch_params_set_packing(&params, 8, 0, 8, 8, 8, 16, 8, 24);
+		break;
+	case IPU_PIX_FMT_UYVY:
+		ipu_ch_param_set_field(&params, IPU_FIELD_BPP, 3);	/* bits/pixel */
+		ipu_ch_param_set_field(&params, IPU_FIELD_PFS, 0xA);	/* pix format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_NPB, 15);	/* burst size */
+		break;
+	case IPU_PIX_FMT_YUYV:
+		ipu_ch_param_set_field(&params, IPU_FIELD_BPP, 3);	/* bits/pixel */
+		ipu_ch_param_set_field(&params, IPU_FIELD_PFS, 0x8);	/* pix format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_NPB, 31);	/* burst size */
+		break;
+	case IPU_PIX_FMT_YUV420P2:
+	case IPU_PIX_FMT_YUV420P:
+		ipu_ch_param_set_field(&params, IPU_FIELD_PFS, 2);	/* pix format */
+
+		if (uv_stride < stride / 2)
+			uv_stride = stride / 2;
+
+		u_offset = stride * height;
+		v_offset = u_offset + (uv_stride * height / 2);
+		ipu_ch_param_set_field(&params, IPU_FIELD_NPB, 31);  /* burst size */
+		break;
+	case IPU_PIX_FMT_YVU422P:
+		/* BPP & pixel format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_PFS, 1);	/* pix format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_NPB, 31);	/* burst size */
+
+		if (uv_stride < stride / 2)
+			uv_stride = stride / 2;
+
+		v_offset = (v == 0) ? stride * height : v;
+		u_offset = (u == 0) ? v_offset + v_offset / 2 : u;
+		break;
+	case IPU_PIX_FMT_YUV422P:
+		/* BPP & pixel format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_PFS, 1);	/* pix format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_NPB, 31);	/* burst size */
+
+		if (uv_stride < stride / 2)
+			uv_stride = stride / 2;
+
+		u_offset = (u == 0) ? stride * height : u;
+		v_offset = (v == 0) ? u_offset + u_offset / 2 : v;
+		break;
+	case IPU_PIX_FMT_NV12:
+		/* BPP & pixel format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_PFS, 4);	/* pix format */
+		ipu_ch_param_set_field(&params, IPU_FIELD_NPB, 31);	/* burst size */
+		uv_stride = stride;
+		u_offset = (u == 0) ? stride * height : u;
+		break;
+	default:
+		dev_err(ipu->ipu_dev, "mxc ipu: unimplemented pixel format: %d\n",
+			pixel_fmt);
+		return -EINVAL;
+	}
+	/* set burst size to 16 */
+	if (uv_stride)
+		ipu_ch_param_set_field(&params, IPU_FIELD_SLUV, uv_stride - 1);
+
+	if (u > u_offset)
+		u_offset = u;
+
+	if (v > v_offset)
+		v_offset = v;
+
+	ipu_ch_param_set_field(&params, IPU_FIELD_UBO, u_offset / 8);
+	ipu_ch_param_set_field(&params, IPU_FIELD_VBO, v_offset / 8);
+
+	dev_dbg(ipu->ipu_dev, "initializing idma ch %d @ %p\n",
+			ch, ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch));
+	memcpy(ipu_ch_param_addr(ipu->ipu_cpmem_reg, ch), &params, sizeof(params));
+	return 0;
+}
+
+/*
+ * This function is called to initialize a buffer for a IPU channel.
+ *
+ * @param       channel         The IPU channel.
+ *
+ * @param       pixel_fmt       Input parameter for pixel format of buffer.
+ *                              Pixel format is a FOURCC ASCII code.
+ *
+ * @param       width           Input parameter for width of buffer in pixels.
+ *
+ * @param       height          Input parameter for height of buffer in pixels.
+ *
+ * @param       stride          Input parameter for stride length of buffer
+ *                              in pixels.
+ *
+ * @param       rot_mode        Input parameter for rotation setting of buffer.
+ *                              A rotation setting other than
+ *                              IPU_ROTATE_VERT_FLIP
+ *                              should only be used for input buffers of
+ *                              rotation channels.
+ *
+ * @param       phyaddr_0       Input parameter buffer 0 physical address.
+ *
+ * @param       phyaddr_1       Input parameter buffer 1 physical address.
+ *                              Setting this to a value other than NULL enables
+ *                              double buffering mode.
+ *
+ * @param       u		private u offset for additional cropping,
+ *				zero if not used.
+ *
+ * @param       v		private v offset for additional cropping,
+ *				zero if not used.
+ *
+ * @return      Returns 0 on success or negative error code on fail
+ */
+int ipu_idmac_init_channel_buffer(struct ipu_channel *channel,
+				u32 pixel_fmt,
+				u16 width, u16 height,
+				u32 stride,
+				ipu_rotate_mode_t rot_mode,
+				dma_addr_t phyaddr_0, dma_addr_t phyaddr_1,
+				u32 u, u32 v, bool interlaced)
+{
+	struct ipu_soc *ipu = idmachannel2ipu(channel);
+	int ret = 0;
+	u32 dma_chan = channel->num;
+
+	if (stride < width * ipu_bytes_per_pixel(pixel_fmt))
+		stride = width * ipu_bytes_per_pixel(pixel_fmt);
+
+	if (stride % 4) {
+		dev_err(ipu->ipu_dev,
+			"Stride not 32-bit aligned, stride = %d\n", stride);
+		return -EINVAL;
+	}
+
+	ipu_get(ipu);
+
+	/* Build parameter memory data for DMA channel */
+	ret = ipu_ch_param_init(ipu, dma_chan, pixel_fmt, width, height, stride, u, v, 0,
+			   phyaddr_0, phyaddr_1);
+	if (ret)
+		goto out;
+
+	if (rot_mode)
+		ipu_ch_param_set_rotation(ipu, dma_chan, rot_mode);
+
+	if (interlaced)
+		ipu_ch_param_set_interlaced_scan(ipu, dma_chan);
+
+	if (idmac_idma_is_set(ipu, IDMAC_CHA_PRI, dma_chan))
+		ipu_ch_param_set_high_priority(ipu, dma_chan);
+
+	ipu_ch_param_dump(ipu, dma_chan);
+out:
+	ipu_put(ipu);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_init_channel_buffer);
+
+int ipu_idmac_update_channel_buffer(struct ipu_channel *channel,
+				  u32 buf_num, dma_addr_t phyaddr)
+{
+	struct ipu_soc *ipu = idmachannel2ipu(channel);
+	u32 dma_chan = channel->num;
+
+	ipu_ch_param_set_buffer(ipu, dma_chan, buf_num, phyaddr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_update_channel_buffer);
+
+int ipu_module_enable(struct ipu_soc *ipu, u32 mask)
+{
+	unsigned long lock_flags;
+	u32 ipu_conf;
+
+	spin_lock_irqsave(&ipu->ipu_lock, lock_flags);
+
+	ipu_conf = ipu_cm_read(ipu, IPU_CONF);
+	ipu_conf |= mask;
+	ipu_cm_write(ipu, ipu_conf, IPU_CONF);
+
+	spin_unlock_irqrestore(&ipu->ipu_lock, lock_flags);
+
+	return 0;
+}
+
+int ipu_module_disable(struct ipu_soc *ipu, u32 mask)
+{
+	unsigned long lock_flags;
+	u32 ipu_conf;
+
+	spin_lock_irqsave(&ipu->ipu_lock, lock_flags);
+
+	ipu_conf = ipu_cm_read(ipu, IPU_CONF);
+	ipu_conf &= ~mask;
+	ipu_cm_write(ipu, ipu_conf, IPU_CONF);
+
+	spin_unlock_irqrestore(&ipu->ipu_lock, lock_flags);
+
+	return 0;
+}
+
+
+/*
+ * should be called with ipu_lock.
+ */
+static void ipu_irq_update_irq_mask(struct ipu_soc *ipu)
+{
+	struct ipu_irq_handler *handler;
+	int i;
+
+	DECLARE_IPU_IRQ_BITMAP(irqs);
+
+	bitmap_zero(irqs, IPU_IRQ_COUNT);
+
+	list_for_each_entry(handler, &ipu->ipu_irq_handlers_list, list)
+		bitmap_or(irqs, irqs, handler->ipu_irqs, IPU_IRQ_COUNT);
+
+	for (i = 0; i < BITS_TO_LONGS(IPU_IRQ_COUNT); i++)
+		ipu_cm_write(ipu, irqs[i], IPU_INT_CTRL(i + 1));
+}
+
+int ipu_irq_add_handler(struct ipu_soc *ipu, struct ipu_irq_handler *ipuirq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ipu->ipu_lock, flags);
+
+	list_add_tail(&ipuirq->list, &ipu->ipu_irq_handlers_list);
+	ipu_irq_update_irq_mask(ipu);
+
+	spin_unlock_irqrestore(&ipu->ipu_lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_irq_add_handler);
+
+void ipu_irq_remove_handler(struct ipu_soc *ipu, struct ipu_irq_handler *handler)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ipu->ipu_lock, flags);
+
+	list_del(&handler->list);
+	ipu_irq_update_irq_mask(ipu);
+
+	spin_unlock_irqrestore(&ipu->ipu_lock, flags);
+}
+EXPORT_SYMBOL_GPL(ipu_irq_remove_handler);
+
+int ipu_irq_update_handler(struct ipu_soc *ipu,
+		struct ipu_irq_handler *handler,
+		unsigned long *bitmap)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ipu->ipu_lock, flags);
+
+	bitmap_copy(handler->ipu_irqs, bitmap, IPU_IRQ_COUNT);
+	ipu_irq_update_irq_mask(ipu);
+
+	spin_unlock_irqrestore(&ipu->ipu_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_irq_update_handler);
+
+static void ipu_completion_handler(unsigned long *bitmask, void *context)
+{
+	struct completion *completion = context;
+
+	complete(completion);
+}
+
+int ipu_wait_for_interrupt(struct ipu_soc *ipu, int interrupt, int timeout_ms)
+{
+	struct ipu_irq_handler handler;
+	DECLARE_COMPLETION_ONSTACK(completion);
+	unsigned long flags;
+	int ret;
+
+	bitmap_zero(handler.ipu_irqs, IPU_IRQ_COUNT);
+	bitmap_set(handler.ipu_irqs, interrupt, 1);
+
+	spin_lock_irqsave(&ipu->ipu_lock, flags);
+	ipu_cm_write(ipu, 1 << (interrupt % 32), IPU_INT_STAT(interrupt / 32 + 1));
+	spin_unlock_irqrestore(&ipu->ipu_lock, flags);
+
+	handler.handler = ipu_completion_handler;
+	handler.context = &completion;
+	ipu_irq_add_handler(ipu, &handler);
+
+	ret = wait_for_completion_timeout(&completion,
+			msecs_to_jiffies(timeout_ms));
+
+	ipu_irq_remove_handler(ipu, &handler);
+
+	return ret > 0 ? 0 : -ETIMEDOUT;
+}
+EXPORT_SYMBOL_GPL(ipu_wait_for_interrupt);
+
+static irqreturn_t ipu_irq_handler(int irq, void *desc)
+{
+	struct ipu_soc *ipu = container_of(desc, struct ipu_soc, ipu_dev);
+	DECLARE_IPU_IRQ_BITMAP(status);
+	struct ipu_irq_handler *handler;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&ipu->ipu_lock, flags);
+
+	for (i = 0; i < BITS_TO_LONGS(IPU_IRQ_COUNT); i++) {
+		status[i] = ipu_cm_read(ipu, IPU_INT_STAT(i + 1));
+		ipu_cm_write(ipu, status[i], IPU_INT_STAT(i + 1));
+	}
+
+	list_for_each_entry(handler, &ipu->ipu_irq_handlers_list, list) {
+		DECLARE_IPU_IRQ_BITMAP(tmp);
+		if (bitmap_and(tmp, status, handler->ipu_irqs, IPU_IRQ_COUNT))
+			handler->handler(tmp, handler->context);
+	}
+
+	spin_unlock_irqrestore(&ipu->ipu_lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+ipu_color_space_t format_to_colorspace(u32 fmt)
+{
+	switch (fmt) {
+	case IPU_PIX_FMT_RGB666:
+	case IPU_PIX_FMT_RGB565:
+	case IPU_PIX_FMT_BGR24:
+	case IPU_PIX_FMT_RGB24:
+	case IPU_PIX_FMT_BGR32:
+	case IPU_PIX_FMT_BGRA32:
+	case IPU_PIX_FMT_RGB32:
+	case IPU_PIX_FMT_RGBA32:
+	case IPU_PIX_FMT_ABGR32:
+	case IPU_PIX_FMT_LVDS666:
+	case IPU_PIX_FMT_LVDS888:
+		return RGB;
+
+	default:
+		return YCbCr;
+	}
+}
+
+static int ipu_reset(struct ipu_soc *ipu)
+{
+	int timeout = 1000;
+
+	ipu_cm_write(ipu, 0x807FFFFF, IPU_MEM_RST);
+
+	while (ipu_cm_read(ipu, IPU_MEM_RST) & 0x80000000) {
+		if (!timeout--)
+			return -ETIME;
+		msleep(1);
+	}
+
+	return 0;
+}
+
+static int ipu_submodules_init(struct platform_device *pdev, unsigned long ipu_base)
+{
+	char *unit;
+	int ret;
+
+	ret = ipu_di_init(pdev, 0, ipu_base + IPU_DI0_REG_BASE,
+			IPU_CONF_DI0_EN);
+	if (ret) {
+		unit = "di0";
+		goto err_di_0;
+	}
+
+	ret = ipu_di_init(pdev, 1, ipu_base + IPU_DI1_REG_BASE,
+			IPU_CONF_DI1_EN);
+	if (ret) {
+		unit = "di1";
+		goto err_di_1;
+	}
+
+	ret = ipu_dc_init(pdev, ipu_base + IPU_DC_REG_BASE,
+			ipu_base + IPU_DC_TMPL_REG_BASE);
+	if (ret) {
+		unit = "dc_template";
+		goto err_dc;
+	}
+
+	ret = ipu_dmfc_init(pdev, ipu_base + IPU_DMFC_REG_BASE);
+	if (ret) {
+		unit = "dmfc";
+		goto err_dmfc;
+	}
+
+	ret = ipu_dp_init(pdev, ipu_base + IPU_SRM_REG_BASE);
+	if (ret) {
+		unit = "dp";
+		goto err_dp;
+	}
+
+	return 0;
+
+err_dp:
+	ipu_dmfc_exit(pdev);
+err_dmfc:
+	ipu_dc_exit(pdev);
+err_dc:
+	ipu_di_exit(pdev, 1);
+err_di_1:
+	ipu_di_exit(pdev, 0);
+err_di_0:
+	dev_err(&pdev->dev, "init %s failed with %d\n", unit, ret);
+	return ret;
+}
+
+void ipu_get(struct ipu_soc *ipu)
+{
+	mutex_lock(&ipu->ipu_channel_lock);
+
+	ipu->ipu_use_count++;
+
+	if (ipu->ipu_use_count == 1)
+		clk_enable(ipu->ipu_clk);
+
+	mutex_unlock(&ipu->ipu_channel_lock);
+}
+
+void ipu_put(struct ipu_soc *ipu)
+{
+	mutex_lock(&ipu->ipu_channel_lock);
+
+	ipu->ipu_use_count--;
+
+	if (ipu->ipu_use_count == 0)
+		clk_disable(ipu->ipu_clk);
+
+	if (ipu->ipu_use_count < 0) {
+		dev_err(ipu->ipu_dev, "ipu use count < 0\n");
+		ipu->ipu_use_count = 0;
+	}
+
+	mutex_unlock(&ipu->ipu_channel_lock);
+}
+
+static void ipu_submodules_exit(struct platform_device *pdev,
+		unsigned long ipu_base)
+{
+	ipu_dp_exit(pdev);
+	ipu_dmfc_exit(pdev);
+	ipu_dc_exit(pdev);
+	ipu_di_exit(pdev, 1);
+	ipu_di_exit(pdev, 0);
+}
+
+static int ipu_add_subdevice_pdata(struct platform_device *pdev,
+		const char *name, int id, void *pdata, size_t pdata_size)
+{
+	struct mfd_cell cell = {
+		.platform_data = pdata,
+		.data_size = pdata_size,
+	};
+
+	cell.name = name;
+
+	return mfd_add_devices(&pdev->dev, id, &cell, 1, NULL, 0);
+}
+
+static int ipu_add_client_devices(struct platform_device *pdev)
+{
+	struct ipu_soc *ipu = platform_get_drvdata(pdev);
+	struct imx_ipuv3_platform_data *plat_data = pdev->dev.platform_data;
+	struct ipuv3_fb_platform_data *fbdata;
+
+	fbdata = plat_data->fb_head0_platform_data;
+	if (fbdata) {
+		fbdata->ipu = (void *)ipu;
+		fbdata->ipu_channel_bg =
+			MX5_IPU_CHANNEL_MEM_BG_SYNC;
+		fbdata->ipu_channel_fg =
+			MX5_IPU_CHANNEL_MEM_FG_SYNC;
+		fbdata->dc_channel = 5;
+		fbdata->dp_channel = IPU_DP_FLOW_SYNC;
+
+		ipu_add_subdevice_pdata(pdev, "imx-ipuv3-fb", 0,
+				fbdata, sizeof(*fbdata));
+	}
+
+	fbdata = plat_data->fb_head1_platform_data;
+	if (fbdata) {
+		fbdata->ipu = (void *)ipu;
+		fbdata->ipu_channel_bg =
+			MX5_IPU_CHANNEL_MEM_DC_SYNC;
+		fbdata->ipu_channel_fg = -1;
+		fbdata->dc_channel = 1;
+		fbdata->dp_channel = -1;
+
+		ipu_add_subdevice_pdata(pdev, "imx-ipuv3-fb", 1,
+				fbdata, sizeof(*fbdata));
+	}
+
+	return 0;
+}
+
+static int __devinit ipu_probe(struct platform_device *pdev)
+{
+	struct ipu_soc *ipu;
+	struct imx_ipuv3_platform_data *plat_data = pdev->dev.platform_data;
+	struct resource *res;
+	int ret;
+
+	ipu = kzalloc(sizeof(struct ipu_soc), GFP_KERNEL);
+	if (!ipu)
+		return -ENOMEM;
+
+	spin_lock_init(&ipu->ipu_lock);
+	mutex_init(&ipu->ipu_channel_lock);
+	INIT_LIST_HEAD(&ipu->ipu_irq_handlers_list);
+
+	ipu->ipu_dev = &pdev->dev;
+
+	if (plat_data->init)
+		plat_data->init(pdev);
+
+	ipu->irq1 = platform_get_irq(pdev, 0);
+	ipu->irq2 = platform_get_irq(pdev, 1);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res || ipu->irq1 < 0 || ipu->irq2 < 0)
+		return -ENODEV;
+
+	ipu->ipu_base = res->start;
+
+	ipu->ipu_cm_reg = ioremap(ipu->ipu_base + IPU_CM_REG_BASE, PAGE_SIZE);
+	if (!ipu->ipu_cm_reg) {
+		ret = -ENOMEM;
+		goto failed_ioremap1;
+	}
+
+	ipu->ipu_idmac_reg = ioremap(ipu->ipu_base + IPU_IDMAC_REG_BASE, PAGE_SIZE);
+	if (!ipu->ipu_idmac_reg) {
+		ret = -ENOMEM;
+		goto failed_ioremap2;
+	}
+
+	ipu->ipu_cpmem_reg = ioremap(ipu->ipu_base + IPU_CPMEM_REG_BASE, PAGE_SIZE);
+	if (!ipu->ipu_cpmem_reg) {
+		ret = -ENOMEM;
+		goto failed_ioremap3;
+	}
+
+	ipu->ipu_clk = clk_get(&pdev->dev, "ipu");
+	if (IS_ERR(ipu->ipu_clk)) {
+		ret = PTR_ERR(ipu->ipu_clk);
+		dev_err(&pdev->dev, "clk_get failed with %d", ret);
+		goto failed_clk_get;
+	}
+
+	ipu_get(ipu);
+
+	ret = request_irq(ipu->irq1, ipu_irq_handler, IRQF_DISABLED, pdev->name,
+			&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "request irq %d failed with: %d\n", ipu->irq1, ret);
+		goto failed_request_irq1;
+	}
+
+	ret = request_irq(ipu->irq2, ipu_irq_handler, IRQF_DISABLED, pdev->name,
+			&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "request irq %d failed with: %d\n", ipu->irq2, ret);
+		goto failed_request_irq2;
+	}
+
+	platform_set_drvdata(pdev, ipu);
+
+	ipu_reset(ipu);
+
+	ret = ipu_submodules_init(pdev, ipu->ipu_base);
+	if (ret)
+		goto failed_submodules_init;
+
+	/* Set sync refresh channels as high priority */
+	ipu_idmac_write(ipu, 0x18800000, IDMAC_CHA_PRI(0));
+
+	ret = ipu_add_client_devices(pdev);
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
+	ipu_submodules_exit(pdev, ipu->ipu_base);
+failed_submodules_init:
+	free_irq(ipu->irq2, &pdev->dev);
+failed_request_irq2:
+	free_irq(ipu->irq1, &pdev->dev);
+	ipu_put(ipu);
+failed_request_irq1:
+	clk_put(ipu->ipu_clk);
+failed_clk_get:
+	iounmap(ipu->ipu_cpmem_reg);
+failed_ioremap3:
+	iounmap(ipu->ipu_idmac_reg);
+failed_ioremap2:
+	iounmap(ipu->ipu_cm_reg);
+failed_ioremap1:
+	kfree(ipu);
+
+	return ret;
+}
+
+static int __devexit ipu_remove(struct platform_device *pdev)
+{
+	struct ipu_soc *ipu = platform_get_drvdata(pdev);
+
+	mfd_remove_devices(&pdev->dev);
+	ipu_submodules_exit(pdev, ipu->ipu_base);
+	free_irq(ipu->irq2, &pdev->dev);
+	free_irq(ipu->irq1, &pdev->dev);
+	iounmap(ipu->ipu_cpmem_reg);
+	iounmap(ipu->ipu_idmac_reg);
+	iounmap(ipu->ipu_cm_reg);
+
+	if (ipu->ipu_use_count != 0) {
+		dev_err(ipu->ipu_dev,
+			"unbalanced use count: %d\n", ipu->ipu_use_count);
+		clk_disable(ipu->ipu_clk);
+	}
+
+	clk_put(ipu->ipu_clk);
+
+	kfree(ipu);
+
+	return 0;
+}
+
+static struct platform_driver mxcipu_driver = {
+	.driver = {
+		.name = "imx-ipuv3",
+	},
+	.probe = ipu_probe,
+	.remove = __devexit_p(ipu_remove),
+};
+
+static int __init ipu_gen_init(void)
+{
+	int32_t ret;
+
+	ret = platform_driver_register(&mxcipu_driver);
+	return 0;
+}
+subsys_initcall(ipu_gen_init);
+
+static void __exit ipu_gen_uninit(void)
+{
+	platform_driver_unregister(&mxcipu_driver);
+}
+module_exit(ipu_gen_uninit);
+
+MODULE_DESCRIPTION("i.MX IPU v3 driver");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/imx-ipu-v3/ipu-dc.c b/drivers/video/imx-ipu-v3/ipu-dc.c
new file mode 100644
index 0000000..21aadb0
--- /dev/null
+++ b/drivers/video/imx-ipu-v3/ipu-dc.c
@@ -0,0 +1,442 @@
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
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <video/imx-ipu-v3.h>
+
+#include "ipu-prv.h"
+
+#define ASYNC_SER_WAVE 6
+
+#define DC_DISP_ID_SERIAL	2
+#define DC_DISP_ID_ASYNC	3
+
+#define DC_MAP_CONF_PTR(n)	(0x0108 + ((n) & ~0x1) * 2)
+#define DC_MAP_CONF_VAL(n)	(0x0144 + ((n) & ~0x1) * 2)
+
+#define DC_EVT_NF		0
+#define DC_EVT_NL		1
+#define DC_EVT_EOF		2
+#define DC_EVT_NFIELD		3
+#define DC_EVT_EOL		4
+#define DC_EVT_EOFIELD		5
+#define DC_EVT_NEW_ADDR		6
+#define DC_EVT_NEW_CHAN		7
+#define DC_EVT_NEW_DATA		8
+
+#define DC_EVT_NEW_ADDR_W_0	0
+#define DC_EVT_NEW_ADDR_W_1	1
+#define DC_EVT_NEW_CHAN_W_0	2
+#define DC_EVT_NEW_CHAN_W_1	3
+#define DC_EVT_NEW_DATA_W_0	4
+#define DC_EVT_NEW_DATA_W_1	5
+#define DC_EVT_NEW_ADDR_R_0	6
+#define DC_EVT_NEW_ADDR_R_1	7
+#define DC_EVT_NEW_CHAN_R_0	8
+#define DC_EVT_NEW_CHAN_R_1	9
+#define DC_EVT_NEW_DATA_R_0	10
+#define DC_EVT_NEW_DATA_R_1	11
+
+#define DC_WR_CH_CONF(ch)      (channel_offset[ch])
+#define DC_WR_CH_ADDR(ch)      (channel_offset[ch] + 4)
+#define DC_RL_CH(ch, evt)      (channel_offset[ch] + 8 + ((evt) & ~0x1) * 2)
+
+#define DC_GEN			(0x00D4)
+#define DC_DISP_CONF1(disp)	(0x00D8 + disp * 4)
+#define DC_DISP_CONF2(disp)	(0x00E8 + disp * 4)
+#define DC_STAT			(0x01C8)
+
+#define WROD(lf)		(0x18 | (lf << 1))
+
+#define DC_WR_CH_CONF_FIELD_MODE		(1 << 9)
+#define DC_WR_CH_CONF_PROG_TYPE_OFFSET		5
+#define DC_WR_CH_CONF_PROG_TYPE_MASK		(7 << 5)
+#define DC_WR_CH_CONF_PROG_DI_ID		(1 << 2)
+#define DC_WR_CH_CONF_PROG_DISP_ID_OFFSET	3
+#define DC_WR_CH_CONF_PROG_DISP_ID_MASK		(3 << 3)
+
+static int channel_offset[] = { 0, 0x1c, 0x38, 0x54, 0x58, 0x5c, 0x78, 0, 0x94, 0xb4};
+
+static inline struct ipu_soc *dcchannel2ipu(struct dc_channel *dc_chan)
+{
+	struct ipu_soc *ipu;
+	struct dc_channel *dc_base = dc_chan - dc_chan->num;
+
+	ipu = container_of(dc_base, struct ipu_soc, dc.dc_channels[0]);
+
+	return ipu;
+}
+
+static inline u32 ipu_dc_read(struct ipu_dc *dc, unsigned offset)
+{
+	return readl(dc->reg_base + offset);
+}
+
+static inline void ipu_dc_write(struct ipu_dc *dc, u32 value, unsigned offset)
+{
+	writel(value, dc->reg_base + offset);
+}
+
+static void ipu_dc_link_event(struct ipu_dc *dc, int chan, int event, int addr, int priority)
+{
+	u32 reg;
+
+	reg = ipu_dc_read(dc, DC_RL_CH(chan, event));
+	reg &= ~(0xFFFF << (16 * (event & 0x1)));
+	reg |= ((addr << 8) | priority) << (16 * (event & 0x1));
+	ipu_dc_write(dc, reg, DC_RL_CH(chan, event));
+}
+
+static void ipu_dc_write_tmpl(struct ipu_dc *dc, int word, u32 opcode, u32 operand, int map,
+			       int wave, int glue, int sync)
+{
+	u32 reg;
+	int stop = 1;
+
+	reg = sync;
+	reg |= (glue << 4);
+	reg |= (++wave << 11);
+	reg |= (++map << 15);
+	reg |= (operand << 20) & 0xFFF00000;
+	writel(reg, dc->tmpl_base + word * 8);
+
+	reg = (operand >> 12);
+	reg |= opcode << 4;
+	reg |= (stop << 9);
+	writel(reg, dc->tmpl_base + word * 8 + 4);
+}
+
+static int ipu_pixfmt_to_map(u32 fmt)
+{
+	switch (fmt) {
+	case IPU_PIX_FMT_GENERIC:
+	case IPU_PIX_FMT_RGB24:
+		return 0;
+	case IPU_PIX_FMT_RGB666:
+		return 1;
+	case IPU_PIX_FMT_YUV444:
+		return 2;
+	case IPU_PIX_FMT_RGB565:
+		return 3;
+	case IPU_PIX_FMT_LVDS666:
+		return 4;
+	}
+
+	return -EINVAL;
+}
+
+#define SYNC_WAVE 0
+
+int ipu_dc_init_sync(struct dc_channel *dc_chan, int di,
+		bool interlaced, u32 pixel_fmt, u32 width)
+{
+	struct ipu_soc *ipu = dcchannel2ipu(dc_chan);
+	struct ipu_dc *dc = &ipu->dc;
+	u32 reg = 0, map;
+
+	map = ipu_pixfmt_to_map(pixel_fmt);
+	if (map < 0) {
+		dev_dbg(ipu->ipu_dev, "IPU_DISP: No MAP\n");
+		return -EINVAL;
+	}
+
+	ipu_get(ipu);
+
+	mutex_lock(&dc->dc_mutex);
+
+	dc_chan->di = di;
+
+	if (interlaced) {
+		ipu_dc_link_event(dc, dc_chan->num, DC_EVT_NL, 0, 3);
+		ipu_dc_link_event(dc, dc_chan->num, DC_EVT_EOL, 0, 2);
+		ipu_dc_link_event(dc, dc_chan->num, DC_EVT_NEW_DATA, 0, 1);
+
+		/* Init template microcode */
+		ipu_dc_write_tmpl(dc, 0, WROD(0), 0, map, SYNC_WAVE, 0, 8);
+	} else {
+		if (di) {
+			ipu_dc_link_event(dc, dc_chan->num, DC_EVT_NL, 2, 3);
+			ipu_dc_link_event(dc, dc_chan->num, DC_EVT_EOL, 3, 2);
+			ipu_dc_link_event(dc, dc_chan->num, DC_EVT_NEW_DATA, 4, 1);
+			/* Init template microcode */
+			ipu_dc_write_tmpl(dc, 2, WROD(0), 0, map, SYNC_WAVE, 8, 5);
+			ipu_dc_write_tmpl(dc, 3, WROD(0), 0, map, SYNC_WAVE, 4, 5);
+			ipu_dc_write_tmpl(dc, 4, WROD(0), 0, map, SYNC_WAVE, 0, 5);
+		} else {
+			ipu_dc_link_event(dc, dc_chan->num, DC_EVT_NL, 5, 3);
+			ipu_dc_link_event(dc, dc_chan->num, DC_EVT_EOL, 6, 2);
+			ipu_dc_link_event(dc, dc_chan->num, DC_EVT_NEW_DATA, 7, 1);
+			/* Init template microcode */
+			ipu_dc_write_tmpl(dc, 5, WROD(0), 0, map, SYNC_WAVE, 8, 5);
+			ipu_dc_write_tmpl(dc, 6, WROD(0), 0, map, SYNC_WAVE, 4, 5);
+			ipu_dc_write_tmpl(dc, 7, WROD(0), 0, map, SYNC_WAVE, 0, 5);
+		}
+	}
+	ipu_dc_link_event(dc, dc_chan->num, DC_EVT_NF, 0, 0);
+	ipu_dc_link_event(dc, dc_chan->num, DC_EVT_NFIELD, 0, 0);
+	ipu_dc_link_event(dc, dc_chan->num, DC_EVT_EOF, 0, 0);
+	ipu_dc_link_event(dc, dc_chan->num, DC_EVT_EOFIELD, 0, 0);
+	ipu_dc_link_event(dc, dc_chan->num, DC_EVT_NEW_CHAN, 0, 0);
+	ipu_dc_link_event(dc, dc_chan->num, DC_EVT_NEW_ADDR, 0, 0);
+
+	reg = 0x2;
+	reg |= di << DC_WR_CH_CONF_PROG_DISP_ID_OFFSET;
+	reg |= di << 2;
+	if (interlaced)
+		reg |= DC_WR_CH_CONF_FIELD_MODE;
+
+	ipu_dc_write(dc, reg, DC_WR_CH_CONF(dc_chan->num));
+
+	ipu_dc_write(dc, 0x00000000, DC_WR_CH_ADDR(dc_chan->num));
+
+	ipu_dc_write(dc, 0x00000084, DC_GEN);
+
+	ipu_dc_write(dc, width, DC_DISP_CONF2(di));
+
+	mutex_unlock(&dc->dc_mutex);
+
+	ipu_put(ipu);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dc_init_sync);
+
+void ipu_dc_init_async(struct dc_channel *dc_chan, int di, bool interlaced)
+{
+	struct ipu_soc *ipu = dcchannel2ipu(dc_chan);
+	struct ipu_dc *dc = &ipu->dc;
+	u32 reg = 0;
+
+	ipu_get(ipu);
+
+	mutex_lock(&dc->dc_mutex);
+
+	dc_chan->di = di;
+	ipu_dc_link_event(dc, dc_chan->num, DC_EVT_NEW_DATA_W_0, 0x64, 1);
+	ipu_dc_link_event(dc, dc_chan->num, DC_EVT_NEW_DATA_W_1, 0x64, 1);
+
+	reg = 0x3;
+	reg |= DC_DISP_ID_SERIAL << DC_WR_CH_CONF_PROG_DISP_ID_OFFSET;
+	ipu_dc_write(dc, reg, DC_WR_CH_CONF(dc_chan->num));
+
+	ipu_dc_write(dc, 0x00000000, DC_WR_CH_ADDR(dc_chan->num));
+
+	ipu_dc_write(dc, 0x00000084, DC_GEN);
+
+	mutex_unlock(&dc->dc_mutex);
+
+	ipu_put(ipu);
+}
+EXPORT_SYMBOL_GPL(ipu_dc_init_async);
+
+void ipu_dc_enable_channel(struct dc_channel *dc_chan)
+{
+	struct ipu_soc *ipu = dcchannel2ipu(dc_chan);
+	struct ipu_dc *dc = &ipu->dc;
+	int di;
+	u32 reg;
+
+	ipu_get(ipu);
+
+	mutex_lock(&dc->dc_mutex);
+
+	if (!dc->use_count)
+		ipu_module_enable(ipu, IPU_CONF_DC_EN);
+	dc->use_count++;
+
+	di = dc_chan->di;
+
+	/* Make sure other DC sync channel is not assigned same DI */
+	reg = ipu_dc_read(dc, DC_WR_CH_CONF(6 - dc_chan->num));
+	if ((di << 2) == (reg & DC_WR_CH_CONF_PROG_DI_ID)) {
+		reg &= ~DC_WR_CH_CONF_PROG_DI_ID;
+		reg |= di ? 0 : DC_WR_CH_CONF_PROG_DI_ID;
+		ipu_dc_write(dc, reg, DC_WR_CH_CONF(6 - dc_chan->num));
+	}
+
+	reg = ipu_dc_read(dc, DC_WR_CH_CONF(dc_chan->num));
+	reg |= 4 << DC_WR_CH_CONF_PROG_TYPE_OFFSET;
+	ipu_dc_write(dc, reg, DC_WR_CH_CONF(dc_chan->num));
+
+	mutex_unlock(&dc->dc_mutex);
+}
+EXPORT_SYMBOL_GPL(ipu_dc_enable_channel);
+
+void ipu_dc_disable_channel(struct dc_channel *dc_chan)
+{
+	struct ipu_soc *ipu = dcchannel2ipu(dc_chan);
+	struct ipu_dc *dc = &ipu->dc;
+	u32 reg;
+	int irq = 0, ret;
+
+	if (dc->use_count <= 0) {
+		dc->use_count = 0;
+		return;
+	}
+
+	if (dc_chan->num == 1) {
+		irq = IPU_IRQ_DC_FC_1;
+	} else if (dc_chan->num == 5) {
+		irq = IPU_IRQ_DP_SF_END;
+	} else {
+		return;
+	}
+
+	ret = ipu_wait_for_interrupt(ipu, irq, 50);
+	if (ret)
+		return;
+
+	mutex_lock(&dc->dc_mutex);
+
+	reg = ipu_dc_read(dc, DC_WR_CH_CONF(dc_chan->num));
+	reg &= ~DC_WR_CH_CONF_PROG_TYPE_MASK;
+	ipu_dc_write(dc, reg, DC_WR_CH_CONF(dc_chan->num));
+
+	dc->use_count--;
+	if (!dc->use_count)
+		ipu_module_disable(ipu, IPU_CONF_DC_EN);
+
+	mutex_unlock(&dc->dc_mutex);
+
+	ipu_put(ipu);
+}
+EXPORT_SYMBOL_GPL(ipu_dc_disable_channel);
+
+struct dc_channel *ipu_dc_get(struct ipu_soc *ipu, int chan)
+{
+	struct dc_channel *dc_chan;
+
+	if (chan >= IPU_DC_CHAN_NUM)
+		return ERR_PTR(-EINVAL);
+
+	dc_chan = &ipu->dc.dc_channels[chan];
+
+	mutex_lock(&ipu->dc.dc_mutex);
+
+	if (dc_chan->inuse) {
+		dc_chan = ERR_PTR(-EBUSY);
+		goto out;
+	}
+
+	dc_chan->inuse = true;
+out:
+	mutex_unlock(&ipu->dc.dc_mutex);
+
+	return dc_chan;
+}
+EXPORT_SYMBOL_GPL(ipu_dc_get);
+
+void ipu_dc_put(struct dc_channel *dc_chan)
+{
+	struct ipu_soc *ipu = dcchannel2ipu(dc_chan);
+
+	mutex_lock(&ipu->dc.dc_mutex);
+
+	dc_chan->inuse = false;
+
+	mutex_unlock(&ipu->dc.dc_mutex);
+}
+EXPORT_SYMBOL_GPL(ipu_dc_put);
+
+static void ipu_dc_map_config(struct ipu_dc *dc, int map,
+		int byte_num, int offset, int mask)
+{
+	int ptr = map * 3 + byte_num;
+	u32 reg;
+
+	reg = ipu_dc_read(dc, DC_MAP_CONF_VAL(ptr));
+	reg &= ~(0xffff << (16 * (ptr & 0x1)));
+	reg |= ((offset << 8) | mask) << (16 * (ptr & 0x1));
+	ipu_dc_write(dc, reg, DC_MAP_CONF_VAL(ptr));
+
+	reg = ipu_dc_read(dc, DC_MAP_CONF_PTR(map));
+	reg &= ~(0x1f << ((16 * (map & 0x1)) + (5 * byte_num)));
+	reg |= ptr << ((16 * (map & 0x1)) + (5 * byte_num));
+	ipu_dc_write(dc, reg, DC_MAP_CONF_PTR(map));
+}
+
+static void ipu_dc_map_clear(struct ipu_dc *dc, int map)
+{
+	u32 reg = ipu_dc_read(dc, DC_MAP_CONF_PTR(map));
+	ipu_dc_write(dc, reg & ~(0xffff << (16 * (map & 0x1))),
+		     DC_MAP_CONF_PTR(map));
+}
+
+int ipu_dc_init(struct platform_device *pdev, unsigned long reg_base, unsigned long template_base)
+{
+	struct ipu_soc *ipu = platform_get_drvdata(pdev);
+	int i;
+
+	ipu->dc.reg_base = ioremap(reg_base, PAGE_SIZE);
+	if (!ipu->dc.reg_base)
+		return -ENOMEM;
+
+	ipu->dc.tmpl_base = ioremap(template_base, PAGE_SIZE);
+	if (!ipu->dc.tmpl_base) {
+		iounmap(ipu->dc.reg_base);
+		return -ENOMEM;
+	}
+
+	mutex_init(&ipu->dc.dc_mutex);
+
+	for (i = 0; i < IPU_DC_CHAN_NUM; i++) {
+		ipu->dc.dc_channels[i].num = i;
+		ipu->dc.dc_channels[i].inuse = false;
+	}
+
+	/* IPU_PIX_FMT_RGB24 */
+	ipu_dc_map_clear(&ipu->dc, 0);
+	ipu_dc_map_config(&ipu->dc, 0, 0, 7, 0xff);
+	ipu_dc_map_config(&ipu->dc, 0, 1, 15, 0xff);
+	ipu_dc_map_config(&ipu->dc, 0, 2, 23, 0xff);
+
+	/* IPU_PIX_FMT_RGB666 */
+	ipu_dc_map_clear(&ipu->dc, 1);
+	ipu_dc_map_config(&ipu->dc, 1, 0, 5, 0xfc);
+	ipu_dc_map_config(&ipu->dc, 1, 1, 11, 0xfc);
+	ipu_dc_map_config(&ipu->dc, 1, 2, 17, 0xfc);
+
+	/* IPU_PIX_FMT_YUV444 */
+	ipu_dc_map_clear(&ipu->dc, 2);
+	ipu_dc_map_config(&ipu->dc, 2, 0, 15, 0xff);
+	ipu_dc_map_config(&ipu->dc, 2, 1, 23, 0xff);
+	ipu_dc_map_config(&ipu->dc, 2, 2, 7, 0xff);
+
+	/* IPU_PIX_FMT_RGB565 */
+	ipu_dc_map_clear(&ipu->dc, 3);
+	ipu_dc_map_config(&ipu->dc, 3, 0, 4, 0xf8);
+	ipu_dc_map_config(&ipu->dc, 3, 1, 10, 0xfc);
+	ipu_dc_map_config(&ipu->dc, 3, 2, 15, 0xf8);
+
+	/* IPU_PIX_FMT_LVDS666 */
+	ipu_dc_map_clear(&ipu->dc, 4);
+	ipu_dc_map_config(&ipu->dc, 4, 0, 5, 0xfc);
+	ipu_dc_map_config(&ipu->dc, 4, 1, 13, 0xfc);
+	ipu_dc_map_config(&ipu->dc, 4, 2, 21, 0xfc);
+
+	return 0;
+}
+
+void ipu_dc_exit(struct platform_device *pdev)
+{
+	struct ipu_soc *ipu = platform_get_drvdata(pdev);
+
+	iounmap(ipu->dc.reg_base);
+	iounmap(ipu->dc.tmpl_base);
+}
diff --git a/drivers/video/imx-ipu-v3/ipu-di.c b/drivers/video/imx-ipu-v3/ipu-di.c
new file mode 100644
index 0000000..de8d0c0
--- /dev/null
+++ b/drivers/video/imx-ipu-v3/ipu-di.c
@@ -0,0 +1,572 @@
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
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <video/imx-ipu-v3.h>
+
+#include "ipu-prv.h"
+
+#define SYNC_WAVE 0
+
+#define DC_DISP_ID_SYNC(di)	(di)
+
+struct di_sync_config {
+	int run_count;
+	int run_src;
+	int offset_count;
+	int offset_src;
+	int repeat_count;
+	int cnt_clr_src;
+	int cnt_polarity_gen_en;
+	int cnt_polarity_clr_src;
+	int cnt_polarity_trigger_src;
+	int cnt_up;
+	int cnt_down;
+};
+
+enum di_pins {
+	DI_PIN11 = 0,
+	DI_PIN12 = 1,
+	DI_PIN13 = 2,
+	DI_PIN14 = 3,
+	DI_PIN15 = 4,
+	DI_PIN16 = 5,
+	DI_PIN17 = 6,
+	DI_PIN_CS = 7,
+
+	DI_PIN_SER_CLK = 0,
+	DI_PIN_SER_RS = 1,
+};
+
+enum di_sync_wave {
+	DI_SYNC_NONE = 0,
+	DI_SYNC_CLK = 1,
+	DI_SYNC_INT_HSYNC = 2,
+	DI_SYNC_HSYNC = 3,
+	DI_SYNC_VSYNC = 4,
+	DI_SYNC_DE = 6,
+};
+
+#define DI_GENERAL		0x0000
+#define DI_BS_CLKGEN0		0x0004
+#define DI_BS_CLKGEN1		0x0008
+#define DI_SW_GEN0(gen)		(0x000c + 4 * ((gen) - 1))
+#define DI_SW_GEN1(gen)		(0x0030 + 4 * ((gen) - 1))
+#define DI_STP_REP(gen)		(0x0148 + 4 * (((gen) - 1)/2))
+#define DI_SYNC_AS_GEN		0x0054
+#define DI_DW_GEN(gen)		(0x0058 + 4 * (gen))
+#define DI_DW_SET(gen, set)	(0x0088 + 4 * ((gen) + 0xc * (set)))
+#define DI_SER_CONF		0x015c
+#define DI_SSC			0x0160
+#define DI_POL			0x0164
+#define DI_AW0			0x0168
+#define DI_AW1			0x016c
+#define DI_SCR_CONF		0x0170
+#define DI_STAT			0x0174
+
+#define DI_SW_GEN0_RUN_COUNT(x)			((x) << 19)
+#define DI_SW_GEN0_RUN_SRC(x)			((x) << 16)
+#define DI_SW_GEN0_OFFSET_COUNT(x)		((x) << 3)
+#define DI_SW_GEN0_OFFSET_SRC(x)		((x) << 0)
+
+#define DI_SW_GEN1_CNT_POL_GEN_EN(x)		((x) << 29)
+#define DI_SW_GEN1_CNT_CLR_SRC(x)		((x) << 25)
+#define DI_SW_GEN1_CNT_POL_TRIGGER_SRC(x)	((x) << 12)
+#define DI_SW_GEN1_CNT_POL_CLR_SRC(x)		((x) << 9)
+#define DI_SW_GEN1_CNT_DOWN(x)			((x) << 16)
+#define DI_SW_GEN1_CNT_UP(x)			(x)
+#define DI_SW_GEN1_AUTO_RELOAD			(0x10000000)
+
+#define DI_DW_GEN_ACCESS_SIZE_OFFSET		24
+#define DI_DW_GEN_COMPONENT_SIZE_OFFSET		16
+
+#define DI_GEN_DI_CLK_EXT			(1 << 20)
+#define DI_GEN_POLARITY_1			(1 << 0)
+#define DI_GEN_POLARITY_2			(1 << 1)
+#define DI_GEN_POLARITY_3			(1 << 2)
+#define DI_GEN_POLARITY_4			(1 << 3)
+#define DI_GEN_POLARITY_5			(1 << 4)
+#define DI_GEN_POLARITY_6			(1 << 5)
+#define DI_GEN_POLARITY_7			(1 << 6)
+#define DI_GEN_POLARITY_8			(1 << 7)
+
+#define DI_POL_DRDY_DATA_POLARITY		(1 << 7)
+#define DI_POL_DRDY_POLARITY_15			(1 << 4)
+
+#define DI_VSYNC_SEL_OFFSET			13
+
+#define DI0_COUNTER_RELEASE			(1 << 24)
+#define DI1_COUNTER_RELEASE			(1 << 25)
+
+static inline struct ipu_soc *di2ipu(struct ipu_di *di)
+{
+	struct ipu_soc *ipu;
+
+	if (0 == di->id)
+		ipu = container_of(di, struct ipu_soc, dis[0]);
+	else
+		ipu = container_of(di, struct ipu_soc, dis[1]);
+
+	return ipu;
+}
+
+static inline u32 ipu_di_read(struct ipu_di *di, unsigned offset)
+{
+	return readl(di->reg_base + offset);
+}
+
+static inline void ipu_di_write(struct ipu_di *di, u32 value, unsigned offset)
+{
+	writel(value, di->reg_base + offset);
+}
+
+static void ipu_di_data_wave_config(struct ipu_di *di,
+				     int wave_gen,
+				     int access_size, int component_size)
+{
+	u32 reg;
+	reg = (access_size << DI_DW_GEN_ACCESS_SIZE_OFFSET) |
+	    (component_size << DI_DW_GEN_COMPONENT_SIZE_OFFSET);
+	ipu_di_write(di, reg, DI_DW_GEN(wave_gen));
+}
+
+static void ipu_di_data_pin_config(struct ipu_di *di, int wave_gen, int di_pin, int set,
+				    int up, int down)
+{
+	u32 reg;
+
+	reg = ipu_di_read(di, DI_DW_GEN(wave_gen));
+	reg &= ~(0x3 << (di_pin * 2));
+	reg |= set << (di_pin * 2);
+	ipu_di_write(di, reg, DI_DW_GEN(wave_gen));
+
+	ipu_di_write(di, (down << 16) | up, DI_DW_SET(wave_gen, set));
+}
+
+static int ipu_di_sync_config(struct ipu_di *di, struct di_sync_config *config, int count)
+{
+	u32 reg;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		struct di_sync_config *c = &config[i];
+		int wave_gen = i + 1;
+
+		pr_debug("%s %d\n", __func__, wave_gen);
+		if ((c->run_count >= 0x1000) || (c->offset_count >= 0x1000) || (c->repeat_count >= 0x1000) ||
+			(c->cnt_up >= 0x400) || (c->cnt_down >= 0x400))
+			return -EINVAL;
+
+		reg = DI_SW_GEN0_RUN_COUNT(c->run_count) |
+			DI_SW_GEN0_RUN_SRC(c->run_src) |
+			DI_SW_GEN0_OFFSET_COUNT(c->offset_count) |
+			DI_SW_GEN0_OFFSET_SRC(c->offset_src);
+		ipu_di_write(di, reg, DI_SW_GEN0(wave_gen));
+
+		reg = DI_SW_GEN1_CNT_POL_GEN_EN(c->cnt_polarity_gen_en) |
+			DI_SW_GEN1_CNT_CLR_SRC(c->cnt_clr_src) |
+			DI_SW_GEN1_CNT_POL_TRIGGER_SRC(c->cnt_polarity_trigger_src) |
+			DI_SW_GEN1_CNT_POL_CLR_SRC(c->cnt_polarity_clr_src) |
+			DI_SW_GEN1_CNT_DOWN(c->cnt_down) |
+			DI_SW_GEN1_CNT_UP(c->cnt_up);
+
+		if (c->repeat_count == 0) {
+			/* Enable auto reload */
+			reg |= DI_SW_GEN1_AUTO_RELOAD;
+		}
+
+		ipu_di_write(di, reg, DI_SW_GEN1(wave_gen));
+
+		reg = ipu_di_read(di, DI_STP_REP(wave_gen));
+		reg &= ~(0xffff << (16 * ((wave_gen - 1) & 0x1)));
+		reg |= c->repeat_count << (16 * ((wave_gen - 1) & 0x1));
+		ipu_di_write(di, reg, DI_STP_REP(wave_gen));
+	}
+	return 0;
+}
+
+static int ipu_di_sync_config_interlaced(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
+{
+	u32 h_total = sig->width + sig->h_sync_width + sig->h_start_width + sig->h_end_width;
+	u32 v_total = sig->height + sig->v_sync_width + sig->v_start_width + sig->v_end_width;
+	u32 reg;
+	int ret = 0;
+	struct di_sync_config cfg[] = {
+		{
+			.run_count = h_total / 2 - 1,
+			.run_src = DI_SYNC_CLK,
+		}, {
+			.run_count = h_total - 11,
+			.run_src = DI_SYNC_CLK,
+			.cnt_down = 4,
+		}, {
+			.run_count = v_total * 2 - 1,
+			.run_src = DI_SYNC_INT_HSYNC,
+			.offset_count = 1,
+			.offset_src = DI_SYNC_INT_HSYNC,
+			.cnt_down = 4,
+		}, {
+			.run_count = v_total / 2 - 1,
+			.run_src = DI_SYNC_HSYNC,
+			.offset_count = sig->v_start_width,
+			.offset_src = DI_SYNC_HSYNC,
+			.repeat_count = 2,
+			.cnt_clr_src = DI_SYNC_VSYNC,
+		}, {
+			.run_src = DI_SYNC_HSYNC,
+			.repeat_count = sig->height / 2,
+			.cnt_clr_src = 4,
+		}, {
+			.run_count = v_total - 1,
+			.run_src = DI_SYNC_HSYNC,
+		}, {
+			.run_count = v_total / 2 - 1,
+			.run_src = DI_SYNC_HSYNC,
+			.offset_count = 9,
+			.offset_src = DI_SYNC_HSYNC,
+			.repeat_count = 2,
+			.cnt_clr_src = DI_SYNC_VSYNC,
+		}, {
+			.run_src = DI_SYNC_CLK,
+			.offset_count = sig->h_start_width,
+			.offset_src = DI_SYNC_CLK,
+			.repeat_count = sig->width,
+			.cnt_clr_src = 5,
+		}, {
+			.run_count = v_total - 1,
+			.run_src = DI_SYNC_INT_HSYNC,
+			.offset_count = v_total / 2,
+			.offset_src = DI_SYNC_INT_HSYNC,
+			.cnt_clr_src = DI_SYNC_HSYNC,
+			.cnt_down = 4,
+		}
+	};
+
+	ret = ipu_di_sync_config(di, cfg, ARRAY_SIZE(cfg));
+	if (ret < 0)
+		return ret;
+
+	/* set gentime select and tag sel */
+	reg = ipu_di_read(di, DI_SW_GEN1(9));
+	reg &= 0x1FFFFFFF;
+	reg |= (3 - 1) << 29 | 0x00008000;
+	ipu_di_write(di, reg, DI_SW_GEN1(9));
+
+	ipu_di_write(di, v_total / 2 - 1, DI_SCR_CONF);
+
+	return ret;
+}
+
+static int ipu_di_sync_config_noninterlaced(struct ipu_di *di,
+		struct ipu_di_signal_cfg *sig, int div)
+{
+	u32 h_total = sig->width + sig->h_sync_width + sig->h_start_width +
+		sig->h_end_width;
+	u32 v_total = sig->height + sig->v_sync_width + sig->v_start_width +
+		sig->v_end_width + (sig->v_end_width < 2 ? 1 : 0);
+	struct di_sync_config cfg[] = {
+		{
+			.run_count = h_total - 1,
+			.run_src = DI_SYNC_CLK,
+		} , {
+			.run_count = h_total - 1,
+			.run_src = DI_SYNC_CLK,
+			.offset_count = div * sig->v_to_h_sync,
+			.offset_src = DI_SYNC_CLK,
+			.cnt_polarity_gen_en = 1,
+			.cnt_polarity_trigger_src = DI_SYNC_CLK,
+			.cnt_down = sig->h_sync_width * 2,
+		} , {
+			.run_count = v_total - 1,
+			.run_src = DI_SYNC_INT_HSYNC,
+			.cnt_polarity_gen_en = 1,
+			.cnt_polarity_trigger_src = DI_SYNC_INT_HSYNC,
+			.cnt_down = sig->v_sync_width * 2,
+		} , {
+			.run_src = DI_SYNC_HSYNC,
+			.offset_count = sig->v_sync_width + sig->v_start_width,
+			.offset_src = DI_SYNC_HSYNC,
+			.repeat_count = sig->height,
+			.cnt_clr_src = DI_SYNC_VSYNC,
+		} , {
+			.run_src = DI_SYNC_CLK,
+			.offset_count = sig->h_sync_width + sig->h_start_width,
+			.offset_src = DI_SYNC_CLK,
+			.repeat_count = sig->width,
+			.cnt_clr_src = 5,
+		} , {
+			/* unused */
+		} , {
+			/* unused */
+		} , {
+			/* unused */
+		} , {
+			/* unused */
+		},
+	};
+
+	ipu_di_write(di, v_total - 1, DI_SCR_CONF);
+	return ipu_di_sync_config(di, cfg, ARRAY_SIZE(cfg));
+}
+
+int ipu_di_init_sync_panel(struct ipu_di *di, u32 pixel_clk, struct ipu_di_signal_cfg *sig)
+{
+	struct ipu_soc *ipu = di2ipu(di);
+	u32 reg;
+	u32 disp_gen, di_gen, vsync_cnt;
+	u32 div;
+	u32 h_total, v_total;
+	int ret = 0;
+	struct clk *di_clk;
+
+	dev_dbg(ipu->ipu_dev, "disp %d: panel size = %d x %d\n",
+		di->id, sig->width, sig->height);
+
+	if ((sig->v_sync_width == 0) || (sig->h_sync_width == 0))
+		return -EINVAL;
+
+	h_total = sig->width + sig->h_sync_width + sig->h_start_width + sig->h_end_width;
+	v_total = sig->height + sig->v_sync_width + sig->v_start_width + sig->v_end_width;
+
+	mutex_lock(&di->di_mutex);
+
+	ipu_get(ipu);
+
+	/* Init clocking */
+	if (sig->ext_clk) {
+		di->external_clk = true;
+		di_clk = di->clk;
+	} else {
+		di->external_clk = false;
+		di_clk = ipu->ipu_clk;
+	}
+
+	/*
+	 * Calculate divider
+	 * Fractional part is 4 bits,
+	 * so simply multiply by 2^4 to get fractional part.
+	 */
+	div = (clk_get_rate(di_clk) * 16) / pixel_clk;
+	if (div < 0x10)	/* Min DI disp clock divider is 1 */
+		div = 0x10;
+
+	disp_gen = ipu_cm_read(ipu, IPU_DISP_GEN);
+	disp_gen &= di->id ? ~DI1_COUNTER_RELEASE : ~DI0_COUNTER_RELEASE;
+	ipu_cm_write(ipu, disp_gen, IPU_DISP_GEN);
+
+	ipu_di_write(di, div, DI_BS_CLKGEN0);
+
+	/* Setup pixel clock timing */
+	/* Down time is half of period */
+	ipu_di_write(di, (div / 16) << 16, DI_BS_CLKGEN1);
+
+	ipu_di_data_wave_config(di, SYNC_WAVE, div / 16 - 1, div / 16 - 1);
+	ipu_di_data_pin_config(di, SYNC_WAVE, DI_PIN15, 3, 0, div / 16 * 2);
+
+	div = div / 16;		/* Now divider is integer portion */
+
+	di_gen = 0;
+	if (sig->ext_clk)
+		di_gen |= DI_GEN_DI_CLK_EXT;
+
+	if (sig->interlaced) {
+		ret = ipu_di_sync_config_interlaced(di, sig);
+		if (ret < 0)
+			goto done;
+
+		/* set y_sel = 1 */
+		di_gen |= 0x10000000;
+		di_gen |= DI_GEN_POLARITY_5;
+		di_gen |= DI_GEN_POLARITY_8;
+
+		vsync_cnt = 7;
+
+		if (sig->Hsync_pol)
+			di_gen |= DI_GEN_POLARITY_3;
+		if (sig->Vsync_pol)
+			di_gen |= DI_GEN_POLARITY_2;
+	} else {
+		ret = ipu_di_sync_config_noninterlaced(di, sig, div);
+		if (ret < 0)
+			goto done;
+
+		vsync_cnt = 3;
+
+		if (sig->Hsync_pol)
+			di_gen |= DI_GEN_POLARITY_2;
+		if (sig->Vsync_pol)
+			di_gen |= DI_GEN_POLARITY_3;
+	}
+
+	ipu_di_write(di, di_gen, DI_GENERAL);
+	ipu_di_write(di, (--vsync_cnt << DI_VSYNC_SEL_OFFSET) | 0x00000002,
+		     DI_SYNC_AS_GEN);
+
+	reg = ipu_di_read(di, DI_POL);
+	reg &= ~(DI_POL_DRDY_DATA_POLARITY | DI_POL_DRDY_POLARITY_15);
+
+	if (sig->enable_pol)
+		reg |= DI_POL_DRDY_POLARITY_15;
+	if (sig->data_pol)
+		reg |= DI_POL_DRDY_DATA_POLARITY;
+
+	ipu_di_write(di, reg, DI_POL);
+done:
+	ipu_put(ipu);
+
+	mutex_unlock(&di->di_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ipu_di_init_sync_panel);
+
+int ipu_di_enable(struct ipu_di *di)
+{
+	u32 reg;
+	struct ipu_soc *ipu = di2ipu(di);
+	unsigned long flags;
+
+	ipu_get(ipu);
+
+	ipu_module_enable(ipu, di->module);
+
+	spin_lock_irqsave(&ipu->ipu_lock, flags);
+
+	reg = ipu_cm_read(ipu, IPU_DISP_GEN);
+	if (di->id)
+		reg |= DI1_COUNTER_RELEASE;
+	else
+		reg |= DI0_COUNTER_RELEASE;
+	ipu_cm_write(ipu, reg, IPU_DISP_GEN);
+
+	spin_unlock_irqrestore(&ipu->ipu_lock, flags);
+
+	if (di->external_clk)
+		clk_enable(di->clk);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_di_enable);
+
+int ipu_di_disable(struct ipu_di *di)
+{
+	u32 reg;
+	struct ipu_soc *ipu = di2ipu(di);
+	unsigned long flags;
+
+	if (di->external_clk)
+		clk_disable(di->clk);
+
+	spin_lock_irqsave(&ipu->ipu_lock, flags);
+
+	reg = ipu_cm_read(ipu, IPU_DISP_GEN);
+	if (di->id)
+		reg &= ~DI1_COUNTER_RELEASE;
+	else
+		reg &= ~DI0_COUNTER_RELEASE;
+	ipu_cm_write(ipu, reg, IPU_DISP_GEN);
+
+	spin_unlock_irqrestore(&ipu->ipu_lock, flags);
+
+	ipu_module_disable(ipu, di->module);
+
+	ipu_put(ipu);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_di_disable);
+
+struct ipu_di *ipu_di_get(struct ipu_soc *ipu, int disp)
+{
+	struct ipu_di *di;
+
+	if (disp > 1)
+		return ERR_PTR(-EINVAL);
+
+	di = &ipu->dis[disp];
+
+	mutex_lock(&di->di_mutex);
+
+	if (!di->initialized) {
+		di = ERR_PTR(-ENOSYS);
+		goto out;
+	}
+
+	if (di->inuse) {
+		di = ERR_PTR(-EBUSY);
+		goto out;
+	}
+
+	di->inuse = true;
+out:
+	mutex_unlock(&di->di_mutex);
+
+	return di;
+}
+EXPORT_SYMBOL_GPL(ipu_di_get);
+
+void ipu_di_put(struct ipu_di *di)
+{
+	mutex_lock(&di->di_mutex);
+
+	di->inuse = false;
+
+	mutex_unlock(&di->di_mutex);
+}
+EXPORT_SYMBOL_GPL(ipu_di_put);
+
+int ipu_di_init(struct platform_device *pdev, int id,
+		unsigned long reg_base, u32 module)
+{
+	struct ipu_soc *ipu = platform_get_drvdata(pdev);
+	char *clkid;
+
+	if (id > 1)
+		return -EINVAL;
+
+	if (id)
+		clkid = "di1";
+	else
+		clkid = "di0";
+
+	mutex_init(&ipu->dis[id].di_mutex);
+
+	ipu->dis[id].clk = clk_get(&pdev->dev, clkid);
+	ipu->dis[id].module = module;
+	ipu->dis[id].id = id;
+	ipu->dis[id].reg_base = ioremap(reg_base, PAGE_SIZE);
+	ipu->dis[id].initialized = true;
+	ipu->dis[id].inuse = false;
+	if (!ipu->dis[id].reg_base)
+		return -ENOMEM;
+
+	/* Set MCU_T to divide MCU access window into 2 */
+	ipu_cm_write(ipu, 0x00400000L | (IPU_MCU_T_DEFAULT << 18), IPU_DISP_GEN);
+
+	return 0;
+}
+
+void ipu_di_exit(struct platform_device *pdev, int id)
+{
+	struct ipu_soc *ipu = platform_get_drvdata(pdev);
+
+	clk_put(ipu->dis[id].clk);
+	iounmap(ipu->dis[id].reg_base);
+	ipu->dis[id].initialized = false;
+}
diff --git a/drivers/video/imx-ipu-v3/ipu-dmfc.c b/drivers/video/imx-ipu-v3/ipu-dmfc.c
new file mode 100644
index 0000000..230ddbf
--- /dev/null
+++ b/drivers/video/imx-ipu-v3/ipu-dmfc.c
@@ -0,0 +1,376 @@
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
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <video/imx-ipu-v3.h>
+
+#include "ipu-prv.h"
+
+#define DMFC_RD_CHAN		0x0000
+#define DMFC_WR_CHAN		0x0004
+#define DMFC_WR_CHAN_DEF	0x0008
+#define DMFC_DP_CHAN		0x000c
+#define DMFC_DP_CHAN_DEF	0x0010
+#define DMFC_GENERAL1		0x0014
+#define DMFC_GENERAL2		0x0018
+#define DMFC_IC_CTRL		0x001c
+#define DMFC_STAT		0x0020
+
+#define DMFC_WR_CHAN_1_28		0
+#define DMFC_WR_CHAN_2_41		8
+#define DMFC_WR_CHAN_1C_42		16
+#define DMFC_WR_CHAN_2C_43		24
+
+#define DMFC_DP_CHAN_5B_23		0
+#define DMFC_DP_CHAN_5F_27		8
+#define DMFC_DP_CHAN_6B_24		16
+#define DMFC_DP_CHAN_6F_29		24
+
+#define DMFC_FIFO_SIZE_64		(3 << 3)
+#define DMFC_FIFO_SIZE_128		(2 << 3)
+#define DMFC_FIFO_SIZE_256		(1 << 3)
+#define DMFC_FIFO_SIZE_512		(0 << 3)
+
+#define DMFC_SEGMENT(x)			((x & 0x7) << 0)
+#define DMFC_BURSTSIZE_32		(0 << 6)
+#define DMFC_BURSTSIZE_16		(1 << 6)
+#define DMFC_BURSTSIZE_8		(2 << 6)
+#define DMFC_BURSTSIZE_4		(3 << 6)
+
+static struct dmfc_channel dmfcs[] = {
+	{
+		.ipu_channel	= 23,
+		.channel_reg	= DMFC_DP_CHAN,
+		.shift		= DMFC_DP_CHAN_5B_23,
+		.eot_shift	= 20,
+		.max_fifo_lines	= 3,
+	}, {
+		.ipu_channel	= 24,
+		.channel_reg	= DMFC_DP_CHAN,
+		.shift		= DMFC_DP_CHAN_6B_24,
+		.eot_shift	= 22,
+		.max_fifo_lines	= 1,
+	}, {
+		.ipu_channel	= 27,
+		.channel_reg	= DMFC_DP_CHAN,
+		.shift		= DMFC_DP_CHAN_5F_27,
+		.eot_shift	= 21,
+		.max_fifo_lines	= 2,
+	}, {
+		.ipu_channel	= 28,
+		.channel_reg	= DMFC_WR_CHAN,
+		.shift		= DMFC_WR_CHAN_1_28,
+		.eot_shift	= 16,
+		.max_fifo_lines	= 2,
+	}, {
+		.ipu_channel	= 29,
+		.channel_reg	= DMFC_DP_CHAN,
+		.shift		= DMFC_DP_CHAN_6F_29,
+		.eot_shift	= 23,
+		.max_fifo_lines	= 1,
+	},
+};
+
+#define DMFC_NUM_CHANNELS	ARRAY_SIZE(dmfcs)
+
+static inline struct ipu_soc *dmfcchannel2ipu(struct dmfc_channel *dmfc)
+{
+	struct ipu_soc *ipu;
+	struct dmfc_channel *dmfc_base = dmfc - dmfc->idx;
+
+	ipu = container_of(dmfc_base, struct ipu_soc, dmfc.dmfcs[0]);
+
+	return ipu;
+}
+
+int ipu_dmfc_enable_channel(struct dmfc_channel *dmfc)
+{
+	struct ipu_soc *ipu = dmfcchannel2ipu(dmfc);
+
+	ipu_get(ipu);
+
+	mutex_lock(&ipu->dmfc.mutex);
+
+	if (!ipu->dmfc.use_count)
+		ipu_module_enable(ipu, IPU_CONF_DMFC_EN);
+
+	ipu->dmfc.use_count++;
+
+	mutex_unlock(&ipu->dmfc.mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_enable_channel);
+
+void ipu_dmfc_disable_channel(struct dmfc_channel *dmfc)
+{
+	struct ipu_soc *ipu = dmfcchannel2ipu(dmfc);
+
+	mutex_lock(&ipu->dmfc.mutex);
+
+	ipu->dmfc.use_count--;
+
+	if (!ipu->dmfc.use_count)
+		ipu_module_disable(ipu, IPU_CONF_DMFC_EN);
+
+	if (ipu->dmfc.use_count < 0)
+		ipu->dmfc.use_count = 0;
+
+	mutex_unlock(&ipu->dmfc.mutex);
+
+	ipu_put(ipu);
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_disable_channel);
+
+static int ipu_dmfc_setup_channel(struct dmfc_channel *dmfc, int slots, int segment)
+{
+	struct ipu_soc *ipu = dmfcchannel2ipu(dmfc);
+	u32 val, field;
+
+	dev_dbg(ipu->ipu_dev, "dmfc: using %d slots starting from segment %d for IPU channel %d\n",
+			slots, segment, dmfc->ipu_channel);
+
+	if (!dmfc)
+		return -EINVAL;
+
+	switch (slots) {
+	case 1:
+		field = DMFC_FIFO_SIZE_64;
+		break;
+	case 2:
+		field = DMFC_FIFO_SIZE_128;
+		break;
+	case 4:
+		field = DMFC_FIFO_SIZE_256;
+		break;
+	case 8:
+		field = DMFC_FIFO_SIZE_512;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	field |= DMFC_SEGMENT(segment) | DMFC_BURSTSIZE_8;
+
+	val = readl(ipu->dmfc.reg_base + dmfc->channel_reg);
+
+	val &= ~(0xff << dmfc->shift);
+	val |= field << dmfc->shift;
+
+	writel(val, ipu->dmfc.reg_base + dmfc->channel_reg);
+
+	dmfc->slots = slots;
+	dmfc->segment = segment;
+	dmfc->slotmask = ((1 << slots) - 1) << segment;
+
+	return 0;
+}
+
+static int dmfc_bandwidth_to_slots(unsigned long bandwidth,
+		unsigned long dmfc_bandwidth_per_slot)
+{
+	int slots = 1;
+
+	while (slots * dmfc_bandwidth_per_slot < bandwidth)
+		slots *= 2;
+
+	return slots;
+}
+
+static int dmfc_find_slots(struct ipu_soc *ipu, int slots)
+{
+	unsigned slotmask_need, slotmask_used = 0;
+	int i, segment = 0;
+
+	slotmask_need = (1 << slots) - 1;
+
+	for (i = 0; i < ipu->dmfc.dmfc_num; i++)
+		slotmask_used |= ipu->dmfc.dmfcs[i].slotmask;
+
+	while (slotmask_need <= 0xff) {
+		if (!(slotmask_used & slotmask_need))
+			return segment;
+
+		slotmask_need <<= 1;
+		segment++;
+	}
+
+	return -EBUSY;
+}
+
+void ipu_dmfc_free_bandwidth(struct dmfc_channel *dmfc)
+{
+	struct ipu_soc *ipu = dmfcchannel2ipu(dmfc);
+	int i;
+
+	dev_dbg(ipu->ipu_dev, "dmfc: freeing %d slots starting from segment %d\n",
+			dmfc->slots, dmfc->segment);
+
+	mutex_lock(&ipu->dmfc.mutex);
+
+	if (!dmfc->slots)
+		goto out;
+
+	dmfc->slotmask = 0;
+	dmfc->slots = 0;
+	dmfc->segment = 0;
+
+	for (i = 0; i < ipu->dmfc.dmfc_num; i++)
+		ipu->dmfc.dmfcs[i].slotmask = 0;
+
+	for (i = 0; i < ipu->dmfc.dmfc_num; i++) {
+		if (ipu->dmfc.dmfcs[i].slots > 0) {
+			ipu->dmfc.dmfcs[i].segment = dmfc_find_slots(ipu, ipu->dmfc.dmfcs[i].slots);
+			ipu->dmfc.dmfcs[i].slotmask =
+				((1 << ipu->dmfc.dmfcs[i].slots) - 1) << ipu->dmfc.dmfcs[i].segment;
+		}
+	}
+
+	for (i = 0; i < ipu->dmfc.dmfc_num; i++) {
+		if (ipu->dmfc.dmfcs[i].slots > 0)
+			ipu_dmfc_setup_channel(&ipu->dmfc.dmfcs[i],
+				ipu->dmfc.dmfcs[i].slots, ipu->dmfc.dmfcs[i].segment);
+	}
+out:
+	mutex_unlock(&ipu->dmfc.mutex);
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_free_bandwidth);
+
+int ipu_dmfc_alloc_bandwidth(struct dmfc_channel *dmfc,
+		unsigned long bandwidth_pixel_per_second)
+{
+	struct ipu_soc *ipu = dmfcchannel2ipu(dmfc);
+	int slots = dmfc_bandwidth_to_slots(bandwidth_pixel_per_second,
+			ipu->dmfc.dmfc_bandwidth_per_slot);
+	int segment = 0, ret = 0;
+
+	dev_dbg(ipu->ipu_dev, "dmfc: trying to allocate %ldMpixel/s for IPU channel %d\n",
+			bandwidth_pixel_per_second / 1000000, dmfc->ipu_channel);
+	ipu_get(ipu);
+
+	ipu_dmfc_free_bandwidth(dmfc);
+
+	mutex_lock(&ipu->dmfc.mutex);
+
+	if (slots > 8) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	segment = dmfc_find_slots(ipu, slots);
+	if (segment < 0) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ipu_dmfc_setup_channel(dmfc, slots, segment);
+
+out:
+	ipu_put(ipu);
+	mutex_unlock(&ipu->dmfc.mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_alloc_bandwidth);
+
+int ipu_dmfc_init_channel(struct dmfc_channel *dmfc, int width)
+{
+	struct ipu_soc *ipu = dmfcchannel2ipu(dmfc);
+	u32 dmfc_gen1;
+
+	ipu_get(ipu);
+
+	mutex_lock(&ipu->dmfc.mutex);
+
+	dmfc_gen1 = readl(ipu->dmfc.reg_base + DMFC_GENERAL1);
+
+	if ((dmfc->slots * 64 * 4) / width > dmfc->max_fifo_lines)
+		dmfc_gen1 |= 1 << dmfc->eot_shift;
+	else
+		dmfc_gen1 &= ~(1 << dmfc->eot_shift);
+
+	writel(dmfc_gen1, ipu->dmfc.reg_base + DMFC_GENERAL1);
+
+	mutex_unlock(&ipu->dmfc.mutex);
+
+	ipu_put(ipu);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_init_channel);
+
+struct dmfc_channel *ipu_dmfc_get(struct ipu_soc *ipu, int ipu_channel)
+{
+	int i;
+	struct ipu_dmfc *dmfc = &ipu->dmfc;
+
+	for (i = 0; i < ipu->dmfc.dmfc_num; i++)
+		if (dmfc->dmfcs[i].ipu_channel == ipu_channel)
+			return &dmfc->dmfcs[i];
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_get);
+
+void ipu_dmfc_put(struct dmfc_channel *dmfc)
+{
+	ipu_dmfc_free_bandwidth(dmfc);
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_put);
+
+int ipu_dmfc_init(struct platform_device *pdev, unsigned long reg_base)
+{
+	struct ipu_soc *ipu = platform_get_drvdata(pdev);
+	int i;
+
+	ipu->dmfc.reg_base = ioremap(reg_base, PAGE_SIZE);
+
+	if (!ipu->dmfc.reg_base)
+		return -ENOMEM;
+
+	writel(0x0, ipu->dmfc.reg_base + DMFC_WR_CHAN);
+	writel(0x0, ipu->dmfc.reg_base + DMFC_DP_CHAN);
+
+	ipu->dmfc.dmfc_num = DMFC_NUM_CHANNELS;
+	for (i = 0 ; i < ipu->dmfc.dmfc_num; i++) {
+		struct dmfc_channel *tmp = &(ipu->dmfc.dmfcs[i]);
+		memcpy(tmp, &dmfcs[i], sizeof(struct dmfc_channel));
+		tmp->idx = i;
+	}
+
+	mutex_init(&ipu->dmfc.mutex);
+
+	/*
+	 * We have a total bandwidth of clkrate * 4pixel divided
+	 * into 8 slots.
+	 */
+	ipu->dmfc.dmfc_bandwidth_per_slot = clk_get_rate(ipu->ipu_clk) / 4;
+
+	dev_dbg(ipu->ipu_dev, "dmfc: 8 slots with %ldMpixel/s bandwidth each\n",
+			ipu->dmfc.dmfc_bandwidth_per_slot / 1000000);
+
+	writel(0x202020f6, ipu->dmfc.reg_base + DMFC_WR_CHAN_DEF);
+	writel(0x2020f6f6, ipu->dmfc.reg_base + DMFC_DP_CHAN_DEF);
+	writel(0x00000003, ipu->dmfc.reg_base + DMFC_GENERAL1);
+
+	return 0;
+}
+
+void ipu_dmfc_exit(struct platform_device *pdev)
+{
+	struct ipu_soc *ipu = platform_get_drvdata(pdev);
+	iounmap(ipu->dmfc.reg_base);
+}
diff --git a/drivers/video/imx-ipu-v3/ipu-dp.c b/drivers/video/imx-ipu-v3/ipu-dp.c
new file mode 100644
index 0000000..cbf6494
--- /dev/null
+++ b/drivers/video/imx-ipu-v3/ipu-dp.c
@@ -0,0 +1,507 @@
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
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <video/imx-ipu-v3.h>
+
+#include "ipu-prv.h"
+
+#define DP_SYNC 0
+#define DP_ASYNC0 0x60
+#define DP_ASYNC1 0xBC
+
+#define DP_COM_CONF(flow)		(flow)
+#define DP_GRAPH_WIND_CTRL(flow)	(0x0004 + flow)
+#define DP_FG_POS(flow)			(0x0008 + flow)
+#define DP_CSC_A_0(flow)		(0x0044 + flow)
+#define DP_CSC_A_1(flow)		(0x0048 + flow)
+#define DP_CSC_A_2(flow)		(0x004C + flow)
+#define DP_CSC_A_3(flow)		(0x0050 + flow)
+#define DP_CSC_0(flow)			(0x0054 + flow)
+#define DP_CSC_1(flow)			(0x0058 + flow)
+
+#define DP_COM_CONF_FG_EN		(1 << 0)
+#define DP_COM_CONF_GWSEL		(1 << 1)
+#define DP_COM_CONF_GWAM		(1 << 2)
+#define DP_COM_CONF_GWCKE		(1 << 3)
+#define DP_COM_CONF_CSC_DEF_MASK	(3 << 8)
+#define DP_COM_CONF_CSC_DEF_OFFSET	8
+#define DP_COM_CONF_CSC_DEF_FG		(3 << 8)
+#define DP_COM_CONF_CSC_DEF_BG		(2 << 8)
+#define DP_COM_CONF_CSC_DEF_BOTH	(1 << 8)
+
+enum csc_type_t {
+	RGB2YUV = 0,
+	YUV2RGB,
+	RGB2RGB,
+	YUV2YUV,
+	CSC_NONE,
+	CSC_NUM
+};
+
+/*     Y = R *  .299 + G *  .587 + B *  .114;
+       U = R * -.169 + G * -.332 + B *  .500 + 128.;
+       V = R *  .500 + G * -.419 + B * -.0813 + 128.;*/
+static const int rgb2ycbcr_coeff[5][3] = {
+	{ 153, 301, 58, },
+	{ -87, -170, 0x0100, },
+	{ 0x100, -215, -42, },
+	{ 0x0000, 0x0200, 0x0200, },	/* B0, B1, B2 */
+	{ 0x2, 0x2, 0x2, },	/* S0, S1, S2 */
+};
+
+/*     R = (1.164 * (Y - 16)) + (1.596 * (Cr - 128));
+       G = (1.164 * (Y - 16)) - (0.392 * (Cb - 128)) - (0.813 * (Cr - 128));
+       B = (1.164 * (Y - 16)) + (2.017 * (Cb - 128); */
+static const int ycbcr2rgb_coeff[5][3] = {
+	{ 0x095, 0x000, 0x0CC, },
+	{ 0x095, 0x3CE, 0x398, },
+	{ 0x095, 0x0FF, 0x000, },
+	{ 0x3E42, 0x010A, 0x3DD6, },	/*B0,B1,B2 */
+	{ 0x1, 0x1, 0x1, },	/*S0,S1,S2 */
+};
+
+static inline struct ipu_soc *dp2ipu(struct ipu_dp *dp)
+{
+	struct ipu_soc *ipu;
+
+	ipu = container_of(dp, struct ipu_soc, dp);
+
+	return ipu;
+}
+
+static inline u32 ipu_dp_read(struct ipu_dp *dp, unsigned offset)
+{
+	return readl(dp->reg_base + offset);
+}
+
+static inline void ipu_dp_write(struct ipu_dp *dp, u32 value, unsigned offset)
+{
+	writel(value, dp->reg_base + offset);
+}
+
+/* Please keep S0, S1 and S2 as 0x2 by using this conversion */
+static int _rgb_to_yuv(int n, int red, int green, int blue)
+{
+	int c;
+
+	c = red * rgb2ycbcr_coeff[n][0];
+	c += green * rgb2ycbcr_coeff[n][1];
+	c += blue * rgb2ycbcr_coeff[n][2];
+	c /= 16;
+	c += rgb2ycbcr_coeff[3][n] * 4;
+	c += 8;
+	c /= 16;
+	if (c < 0)
+		c = 0;
+	if (c > 255)
+		c = 255;
+	return c;
+}
+
+struct dp_csc_param_t {
+	int mode;
+	void *coeff;
+};
+
+/*
+ * Row is for BG:	RGB2YUV YUV2RGB RGB2RGB YUV2YUV CSC_NONE
+ * Column is for FG:	RGB2YUV YUV2RGB RGB2RGB YUV2YUV CSC_NONE
+ */
+static struct dp_csc_param_t dp_csc_array[CSC_NUM][CSC_NUM] = {
+	{
+		{ DP_COM_CONF_CSC_DEF_BOTH, &rgb2ycbcr_coeff, },
+		{ 0, 0, },
+		{ 0, 0, },
+		{ DP_COM_CONF_CSC_DEF_BG, &rgb2ycbcr_coeff, },
+		{ DP_COM_CONF_CSC_DEF_BG, &rgb2ycbcr_coeff, },
+	}, {
+		{ 0, 0, },
+		{ DP_COM_CONF_CSC_DEF_BOTH, &ycbcr2rgb_coeff, },
+		{ DP_COM_CONF_CSC_DEF_BG, &ycbcr2rgb_coeff, },
+		{ 0, 0, },
+		{ DP_COM_CONF_CSC_DEF_BG, &ycbcr2rgb_coeff, },
+	}, {
+		{ 0, 0, },
+		{ DP_COM_CONF_CSC_DEF_FG, &ycbcr2rgb_coeff, },
+		{ 0, 0, },
+		{ 0, 0, },
+		{ 0, 0, },
+	}, {
+		{ DP_COM_CONF_CSC_DEF_FG, &rgb2ycbcr_coeff, },
+		{ 0, 0, },
+		{ 0, 0, },
+		{ 0, 0, },
+		{ 0, 0, },
+	}, {
+		{ DP_COM_CONF_CSC_DEF_FG, &rgb2ycbcr_coeff, },
+		{ DP_COM_CONF_CSC_DEF_FG, &ycbcr2rgb_coeff, },
+		{ 0, 0, },
+		{ 0, 0, },
+		{ 0, 0, },
+	}
+};
+
+static enum csc_type_t fg_csc_type = CSC_NONE, bg_csc_type = CSC_NONE;
+
+static int color_key_4rgb = 1;
+
+int ipu_dp_set_color_key(struct ipu_dp *dp, bool enable, u32 color_key)
+{
+	struct ipu_soc *ipu = dp2ipu(dp);
+	u32 reg;
+	int y, u, v;
+	int red, green, blue;
+
+	mutex_lock(&dp->mutex);
+
+	color_key_4rgb = 1;
+	/* Transform color key from rgb to yuv if CSC is enabled */
+	if (((fg_csc_type == RGB2YUV) && (bg_csc_type == YUV2YUV)) ||
+			((fg_csc_type == YUV2YUV) && (bg_csc_type == RGB2YUV)) ||
+			((fg_csc_type == YUV2YUV) && (bg_csc_type == YUV2YUV)) ||
+			((fg_csc_type == YUV2RGB) && (bg_csc_type == YUV2RGB))) {
+
+		dev_dbg(ipu->ipu_dev, "color key 0x%x need change to yuv fmt\n", color_key);
+
+		red = (color_key >> 16) & 0xFF;
+		green = (color_key >> 8) & 0xFF;
+		blue = color_key & 0xFF;
+
+		y = _rgb_to_yuv(0, red, green, blue);
+		u = _rgb_to_yuv(1, red, green, blue);
+		v = _rgb_to_yuv(2, red, green, blue);
+		color_key = (y << 16) | (u << 8) | v;
+
+		color_key_4rgb = 0;
+
+		dev_dbg(ipu->ipu_dev, "color key change to yuv fmt 0x%x\n", color_key);
+	}
+
+	if (enable) {
+		reg = ipu_dp_read(dp, DP_GRAPH_WIND_CTRL(DP_SYNC)) & 0xFF000000L;
+		ipu_dp_write(dp, reg | color_key, DP_GRAPH_WIND_CTRL(DP_SYNC));
+
+		reg = ipu_dp_read(dp, DP_COM_CONF(DP_SYNC));
+		ipu_dp_write(dp, reg | DP_COM_CONF_GWCKE, DP_COM_CONF(DP_SYNC));
+	} else {
+		reg = ipu_dp_read(dp, DP_COM_CONF(DP_SYNC));
+		ipu_dp_write(dp, reg & ~DP_COM_CONF_GWCKE, DP_COM_CONF(DP_SYNC));
+	}
+
+	reg = ipu_cm_read(ipu, IPU_SRM_PRI2) | 0x8;
+	ipu_cm_write(ipu, reg, IPU_SRM_PRI2);
+
+	mutex_unlock(&dp->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dp_set_color_key);
+
+int ipu_dp_set_global_alpha(struct ipu_dp *dp, bool enable, u8 alpha, bool bg_chan)
+{
+	struct ipu_soc *ipu = dp2ipu(dp);
+	u32 reg;
+
+	mutex_lock(&dp->mutex);
+
+	reg = ipu_dp_read(dp, DP_COM_CONF(DP_SYNC));
+	if (bg_chan)
+		reg &= ~DP_COM_CONF_GWSEL;
+	else
+		reg |= DP_COM_CONF_GWSEL;
+	ipu_dp_write(dp, reg, DP_COM_CONF(DP_SYNC));
+
+	if (enable) {
+		reg = ipu_dp_read(dp, DP_GRAPH_WIND_CTRL(DP_SYNC)) & 0x00FFFFFFL;
+		ipu_dp_write(dp, reg | ((u32) alpha << 24), DP_GRAPH_WIND_CTRL(DP_SYNC));
+
+		reg = ipu_dp_read(dp, DP_COM_CONF(DP_SYNC));
+		ipu_dp_write(dp, reg | DP_COM_CONF_GWAM, DP_COM_CONF(DP_SYNC));
+	} else {
+		reg = ipu_dp_read(dp, DP_COM_CONF(DP_SYNC));
+		ipu_dp_write(dp, reg & ~DP_COM_CONF_GWAM, DP_COM_CONF(DP_SYNC));
+	}
+
+	reg = ipu_cm_read(ipu, IPU_SRM_PRI2) | 0x8;
+	ipu_cm_write(ipu, reg, IPU_SRM_PRI2);
+
+	mutex_unlock(&dp->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dp_set_global_alpha);
+
+int ipu_dp_set_window_pos(struct ipu_dp *dp, u16 x_pos, u16 y_pos)
+{
+	struct ipu_soc *ipu = dp2ipu(dp);
+	u32 reg;
+
+	mutex_lock(&dp->mutex);
+
+	ipu_dp_write(dp, (x_pos << 16) | y_pos, DP_FG_POS(DP_SYNC));
+
+	reg = ipu_cm_read(ipu, IPU_SRM_PRI2);
+	reg |= 0x8;
+	ipu_cm_write(ipu, reg, IPU_SRM_PRI2);
+
+	mutex_unlock(&dp->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dp_set_window_pos);
+
+#define mask_a(a) ((u32)(a) & 0x3FF)
+#define mask_b(b) ((u32)(b) & 0x3FFF)
+
+void __ipu_dp_csc_setup(struct ipu_dp *dp, int flow,
+			struct dp_csc_param_t dp_csc_param,
+			bool srm_mode_update)
+{
+	u32 reg;
+	struct ipu_soc *ipu = dp2ipu(dp);
+	const int (*coeff)[5][3];
+
+	if (dp_csc_param.mode >= 0) {
+		reg = ipu_dp_read(dp, DP_COM_CONF(flow));
+		reg &= ~DP_COM_CONF_CSC_DEF_MASK;
+		reg |= dp_csc_param.mode;
+		ipu_dp_write(dp, reg, DP_COM_CONF(flow));
+	}
+
+	coeff = dp_csc_param.coeff;
+
+	if (coeff) {
+		ipu_dp_write(dp, mask_a((*coeff)[0][0]) |
+				(mask_a((*coeff)[0][1]) << 16), DP_CSC_A_0(flow));
+		ipu_dp_write(dp, mask_a((*coeff)[0][2]) |
+				(mask_a((*coeff)[1][0]) << 16), DP_CSC_A_1(flow));
+		ipu_dp_write(dp, mask_a((*coeff)[1][1]) |
+				(mask_a((*coeff)[1][2]) << 16), DP_CSC_A_2(flow));
+		ipu_dp_write(dp, mask_a((*coeff)[2][0]) |
+				(mask_a((*coeff)[2][1]) << 16), DP_CSC_A_3(flow));
+		ipu_dp_write(dp, mask_a((*coeff)[2][2]) |
+				(mask_b((*coeff)[3][0]) << 16) |
+				((*coeff)[4][0] << 30), DP_CSC_0(flow));
+		ipu_dp_write(dp, mask_b((*coeff)[3][1]) | ((*coeff)[4][1] << 14) |
+				(mask_b((*coeff)[3][2]) << 16) |
+				((*coeff)[4][2] << 30), DP_CSC_1(flow));
+	}
+
+	if (srm_mode_update) {
+		reg = ipu_cm_read(ipu, IPU_SRM_PRI2) | 0x8;
+		ipu_cm_write(ipu, reg, IPU_SRM_PRI2);
+	}
+}
+
+int ipu_dp_setup_channel(struct ipu_dp *dp, u32 in_pixel_fmt,
+		 u32 out_pixel_fmt, int bg)
+{
+	struct ipu_soc *ipu = dp2ipu(dp);
+	int in_fmt, out_fmt;
+	enum csc_type_t *csc_type;
+	u32 reg;
+
+	ipu_get(ipu);
+
+	mutex_lock(&dp->mutex);
+
+	if (bg)
+		csc_type = &bg_csc_type;
+	else
+		csc_type = &fg_csc_type;
+
+	in_fmt = format_to_colorspace(in_pixel_fmt);
+	out_fmt = format_to_colorspace(out_pixel_fmt);
+
+	if (in_fmt == RGB) {
+		if (out_fmt == RGB)
+			*csc_type = RGB2RGB;
+		else
+			*csc_type = RGB2YUV;
+	} else {
+		if (out_fmt == RGB)
+			*csc_type = YUV2RGB;
+		else
+			*csc_type = YUV2YUV;
+	}
+
+	/* Transform color key from rgb to yuv if CSC is enabled */
+	reg = ipu_dp_read(dp, DP_COM_CONF(DP_SYNC));
+	if (color_key_4rgb && (reg & DP_COM_CONF_GWCKE) &&
+			(((fg_csc_type == RGB2YUV) && (bg_csc_type == YUV2YUV)) ||
+			 ((fg_csc_type == YUV2YUV) && (bg_csc_type == RGB2YUV)) ||
+			 ((fg_csc_type == YUV2YUV) && (bg_csc_type == YUV2YUV)) ||
+			 ((fg_csc_type == YUV2RGB) && (bg_csc_type == YUV2RGB)))) {
+		int red, green, blue;
+		int y, u, v;
+		u32 color_key = ipu_dp_read(dp, DP_GRAPH_WIND_CTRL(DP_SYNC)) & 0xFFFFFFL;
+
+		dev_dbg(ipu->ipu_dev, "_ipu_dp_init color key 0x%x need change to yuv fmt!\n", color_key);
+
+		red = (color_key >> 16) & 0xFF;
+		green = (color_key >> 8) & 0xFF;
+		blue = color_key & 0xFF;
+
+		y = _rgb_to_yuv(0, red, green, blue);
+		u = _rgb_to_yuv(1, red, green, blue);
+		v = _rgb_to_yuv(2, red, green, blue);
+		color_key = (y << 16) | (u << 8) | v;
+
+		reg = ipu_dp_read(dp, DP_GRAPH_WIND_CTRL(DP_SYNC)) & 0xFF000000L;
+		ipu_dp_write(dp, reg | color_key, DP_GRAPH_WIND_CTRL(DP_SYNC));
+		color_key_4rgb = 0;
+
+		dev_dbg(ipu->ipu_dev, "_ipu_dp_init color key change to yuv fmt 0x%x!\n", color_key);
+	}
+
+	__ipu_dp_csc_setup(dp, DP_SYNC, dp_csc_array[bg_csc_type][fg_csc_type], true);
+
+	mutex_unlock(&dp->mutex);
+
+	ipu_put(ipu);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dp_setup_channel);
+
+int ipu_dp_enable_channel(struct ipu_dp *dp)
+{
+	struct ipu_soc *ipu = dp2ipu(dp);
+
+	ipu_get(ipu);
+
+	mutex_lock(&dp->mutex);
+
+	if (!dp->use_count)
+		ipu_module_enable(ipu, IPU_CONF_DP_EN);
+
+	dp->use_count++;
+
+	mutex_unlock(&dp->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dp_enable_channel);
+
+void ipu_dp_disable_channel(struct ipu_dp *dp)
+{
+	struct ipu_soc *ipu = dp2ipu(dp);
+
+	mutex_lock(&dp->mutex);
+
+	dp->use_count--;
+
+	if (!dp->use_count)
+		ipu_module_disable(ipu, IPU_CONF_DP_EN);
+
+	if (dp->use_count < 0)
+		dp->use_count = 0;
+
+	mutex_unlock(&dp->mutex);
+
+	ipu_put(ipu);
+}
+EXPORT_SYMBOL_GPL(ipu_dp_disable_channel);
+
+void ipu_dp_enable_fg(struct ipu_dp *dp)
+{
+	struct ipu_soc *ipu = dp2ipu(dp);
+	u32 reg;
+
+	mutex_lock(&dp->mutex);
+
+	/* Enable FG channel */
+	reg = ipu_dp_read(dp, DP_COM_CONF(DP_SYNC));
+	ipu_dp_write(dp, reg | DP_COM_CONF_FG_EN, DP_COM_CONF(DP_SYNC));
+
+	reg = ipu_cm_read(ipu, IPU_SRM_PRI2);
+	reg |= 0x8;
+	ipu_cm_write(ipu, reg, IPU_SRM_PRI2);
+
+	mutex_unlock(&dp->mutex);
+}
+EXPORT_SYMBOL_GPL(ipu_dp_enable_fg);
+
+void ipu_dp_disable_fg(struct ipu_dp *dp)
+{
+	struct ipu_soc *ipu = dp2ipu(dp);
+	u32 reg, csc;
+
+	ipu_get(ipu);
+
+	mutex_lock(&dp->mutex);
+
+	reg = ipu_dp_read(dp, DP_COM_CONF(DP_SYNC));
+	csc = reg & DP_COM_CONF_CSC_DEF_MASK;
+	if (csc == DP_COM_CONF_CSC_DEF_FG)
+		reg &= ~DP_COM_CONF_CSC_DEF_MASK;
+
+	reg &= ~DP_COM_CONF_FG_EN;
+	ipu_dp_write(dp, reg, DP_COM_CONF(DP_SYNC));
+
+	reg = ipu_cm_read(ipu, IPU_SRM_PRI2) | 0x8;
+	ipu_cm_write(ipu, reg, IPU_SRM_PRI2);
+
+	mutex_unlock(&dp->mutex);
+
+	ipu_put(ipu);
+}
+EXPORT_SYMBOL_GPL(ipu_dp_disable_fg);
+
+struct ipu_dp *ipu_dp_get(struct ipu_soc *ipu)
+{
+	mutex_lock(&ipu->dp.mutex);
+
+	if (ipu->dp.in_use)
+		return ERR_PTR(-EBUSY);
+
+	ipu->dp.in_use = true;
+
+	mutex_unlock(&ipu->dp.mutex);
+
+	return &ipu->dp;
+}
+EXPORT_SYMBOL_GPL(ipu_dp_get);
+
+void ipu_dp_put(struct ipu_dp *dp)
+{
+	mutex_lock(&dp->mutex);
+	dp->in_use = false;
+	mutex_unlock(&dp->mutex);
+}
+EXPORT_SYMBOL_GPL(ipu_dp_put);
+
+int ipu_dp_init(struct platform_device *pdev, unsigned long reg_base)
+{
+	struct ipu_soc *ipu = platform_get_drvdata(pdev);
+
+	ipu->dp.reg_base = ioremap(reg_base, PAGE_SIZE);
+	if (!ipu->dp.reg_base)
+		return -ENOMEM;
+
+	mutex_init(&ipu->dp.mutex);
+
+	return 0;
+}
+
+void ipu_dp_exit(struct platform_device *pdev)
+{
+	struct ipu_soc *ipu = platform_get_drvdata(pdev);
+	iounmap(ipu->dp.reg_base);
+}
diff --git a/drivers/video/imx-ipu-v3/ipu-prv.h b/drivers/video/imx-ipu-v3/ipu-prv.h
new file mode 100644
index 0000000..f22bd7d
--- /dev/null
+++ b/drivers/video/imx-ipu-v3/ipu-prv.h
@@ -0,0 +1,288 @@
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
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <mach/hardware.h>
+
+#define MX5_IPU_CHANNEL_CSI0			 0
+#define MX5_IPU_CHANNEL_CSI1			 1
+#define MX5_IPU_CHANNEL_CSI2			 2
+#define MX5_IPU_CHANNEL_CSI3			 3
+#define MX5_IPU_CHANNEL_MEM_BG_SYNC		23
+#define MX5_IPU_CHANNEL_MEM_FG_SYNC		27
+#define MX5_IPU_CHANNEL_MEM_DC_SYNC		28
+#define MX5_IPU_CHANNEL_MEM_FG_SYNC_ALPHA	31
+#define MX5_IPU_CHANNEL_MEM_DC_ASYNC		41
+#define MX5_IPU_CHANNEL_ROT_ENC_MEM		45
+#define MX5_IPU_CHANNEL_ROT_VF_MEM		46
+#define MX5_IPU_CHANNEL_ROT_PP_MEM		47
+#define MX5_IPU_CHANNEL_ROT_ENC_MEM_OUT	48
+#define MX5_IPU_CHANNEL_ROT_VF_MEM_OUT		49
+#define MX5_IPU_CHANNEL_ROT_PP_MEM_OUT		50
+#define MX5_IPU_CHANNEL_MEM_BG_SYNC_ALPHA	51
+
+#define IPU_DISP0_BASE		0x00000000
+#define IPU_MCU_T_DEFAULT	8
+#define IPU_DISP1_BASE		(IPU_MCU_T_DEFAULT << 25)
+#define IPU_CM_REG_BASE		0x1e000000
+#define IPU_IDMAC_REG_BASE	0x1e008000
+#define IPU_ISP_REG_BASE	0x1e010000
+#define IPU_DP_REG_BASE		0x1e018000
+#define IPU_IC_REG_BASE		0x1e020000
+#define IPU_IRT_REG_BASE	0x1e028000
+#define IPU_CSI0_REG_BASE	0x1e030000
+#define IPU_CSI1_REG_BASE	0x1e038000
+#define IPU_DI0_REG_BASE	0x1e040000
+#define IPU_DI1_REG_BASE	0x1e048000
+#define IPU_SMFC_REG_BASE	0x1e050000
+#define IPU_DC_REG_BASE		0x1e058000
+#define IPU_DMFC_REG_BASE	0x1e060000
+#define IPU_CPMEM_REG_BASE	0x1f000000
+#define IPU_LUT_REG_BASE	0x1f020000
+#define IPU_SRM_REG_BASE	0x1f040000
+#define IPU_TPM_REG_BASE	0x1f060000
+#define IPU_DC_TMPL_REG_BASE	0x1f080000
+#define IPU_ISP_TBPR_REG_BASE	0x1f0c0000
+#define IPU_VDI_REG_BASE	0x1e068000
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
+#define IPU_INT_CTRL(n)		IPU_CM_REG(0x003C + 4 * ((n) - 1))
+#define IPU_INT_CTRL_IRQ(irq)	IPU_INT_CTRL(((irq) / 32))
+#define IPU_INT_STAT_IRQ(irq)	IPU_INT_STAT(((irq) / 32))
+#define IPU_INT_STAT(n)		IPU_CM_REG(0x0200 + 4 * ((n) - 1))
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
+struct ipu_di {
+	int id;
+	u32 module;
+	struct clk *clk;
+	bool external_clk;
+	bool inuse;
+	bool initialized;
+	void __iomem *reg_base;
+	struct mutex di_mutex;
+};
+
+struct ipu_dc {
+#define IPU_DC_CHAN_NUM	10
+	struct dc_channel {
+		bool inuse;
+		unsigned int num;
+		unsigned int di; /* The display interface number assigned to this dc channel */
+	} dc_channels[IPU_DC_CHAN_NUM];
+	int use_count;
+	void __iomem *reg_base;
+	void __iomem *tmpl_base;
+	struct mutex dc_mutex;
+};
+
+struct dmfc_channel {
+	int		idx;
+	int		ipu_channel;
+	unsigned long	channel_reg;
+	unsigned long	shift;
+	unsigned	eot_shift;
+	unsigned	slots;
+	unsigned	max_fifo_lines;
+	unsigned	slotmask;
+	unsigned	segment;
+};
+
+struct ipu_dmfc {
+	int use_count;
+	void __iomem *reg_base;
+	unsigned long dmfc_bandwidth_per_slot;
+	struct mutex mutex;
+#define IPU_DMFC_CHAN_NUM	8
+	int dmfc_num;
+	struct dmfc_channel dmfcs[IPU_DMFC_CHAN_NUM];
+};
+
+struct ipu_dp {
+	int use_count;
+	void __iomem *reg_base;
+	struct mutex mutex;
+	bool in_use;
+};
+
+struct ipu_channel {
+	unsigned int num;
+
+	bool enabled;
+	bool busy;
+};
+
+struct ipu_soc {
+	struct device *ipu_dev;
+	struct clk *ipu_clk;
+	spinlock_t ipu_lock;
+	unsigned long ipu_base;
+	int irq1;
+	int irq2;
+
+	struct list_head ipu_irq_handlers_list;
+	int ipu_use_count;
+
+	void __iomem *ipu_cm_reg;
+	void __iomem *ipu_idmac_reg;
+	void __iomem *ipu_cpmem_reg;
+
+#define IPU_IDMA_CHAN_NUM	64
+	struct ipu_channel channels[IPU_IDMA_CHAN_NUM];
+	struct mutex ipu_channel_lock;
+
+	struct ipu_di dis[2];
+	struct ipu_dc dc;
+	struct ipu_dmfc dmfc;
+	struct ipu_dp dp;
+};
+
+static inline u32 ipu_cm_read(struct ipu_soc *ipu, unsigned offset)
+{
+	return readl(ipu->ipu_cm_reg + offset);
+}
+
+static inline void ipu_cm_write(struct ipu_soc *ipu,
+		u32 value, unsigned offset)
+{
+	writel(value, ipu->ipu_cm_reg + offset);
+}
+
+static inline u32 ipu_idmac_read(struct ipu_soc *ipu, unsigned offset)
+{
+	return readl(ipu->ipu_idmac_reg + offset);
+}
+
+static inline void ipu_idmac_write(struct ipu_soc *ipu,
+		u32 value, unsigned offset)
+{
+	writel(value, ipu->ipu_idmac_reg + offset);
+}
+
+#define idmac_idma_is_set(ipu, reg, dma)(ipu_idmac_read(ipu, reg(dma)) & idma_mask(dma))
+#define idma_mask(ch)			(1 << (ch & 0x1f))
+#define ipu_idma_is_set(ipu, reg, dma)	(ipu_cm_read(ipu, reg(dma)) & idma_mask(dma))
+
+ipu_color_space_t format_to_colorspace(u32 fmt);
+bool ipu_pixel_format_has_alpha(u32 fmt);
+
+u32 _ipu_channel_status(struct ipu_channel *channel);
+
+int _ipu_chan_is_interlaced(struct ipu_channel *channel);
+
+int ipu_module_enable(struct ipu_soc *ipu, u32 mask);
+int ipu_module_disable(struct ipu_soc *ipu, u32 mask);
+
+int ipu_di_init(struct platform_device *pdev, int id,
+		unsigned long base, u32 module);
+void ipu_di_exit(struct platform_device *pdev, int id);
+
+int ipu_dmfc_init(struct platform_device *pdev, unsigned long base);
+void ipu_dmfc_exit(struct platform_device *pdev);
+
+int ipu_dp_init(struct platform_device *pdev, unsigned long base);
+void ipu_dp_exit(struct platform_device *pdev);
+
+int ipu_dc_init(struct platform_device *pdev, unsigned long base,
+		unsigned long template_base);
+void ipu_dc_exit(struct platform_device *pdev);
+
+void ipu_get(struct ipu_soc *ipu);
+void ipu_put(struct ipu_soc *ipu);
+
+#endif				/* __IPU_PRV_H__ */
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
new file mode 100644
index 0000000..4928dba
--- /dev/null
+++ b/include/video/imx-ipu-v3.h
@@ -0,0 +1,226 @@
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
+
+/*
+ * Enumeration of IPU rotation modes
+ */
+typedef enum {
+	/* Note the enum values correspond to BAM value */
+	IPU_ROTATE_NONE = 0,
+	IPU_ROTATE_VERT_FLIP = 1,
+	IPU_ROTATE_HORIZ_FLIP = 2,
+	IPU_ROTATE_180 = 3,
+	IPU_ROTATE_90_RIGHT = 4,
+	IPU_ROTATE_90_RIGHT_VFLIP = 5,
+	IPU_ROTATE_90_RIGHT_HFLIP = 6,
+	IPU_ROTATE_90_LEFT = 7,
+} ipu_rotate_mode_t;
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
+	RGB,
+	YCbCr,
+	YUV
+} ipu_color_space_t;
+
+#define IPU_IRQ_EOF(channel)		(channel)		/* 0 .. 63 */
+#define IPU_IRQ_NFACK(channel)		((channel) + 64)	/* 64 .. 127 */
+#define IPU_IRQ_NFB4EOF(channel)	((channel) + 128)	/* 128 .. 191 */
+#define IPU_IRQ_EOS(channel)		((channel) + 192)	/* 192 .. 255 */
+
+#define IPU_IRQ_DP_SF_START		(448 + 2)
+#define IPU_IRQ_DP_SF_END		(448 + 3)
+#define IPU_IRQ_BG_SF_END		IPU_IRQ_DP_SF_END
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
+#define DECLARE_IPU_IRQ_BITMAP(name)	DECLARE_BITMAP(name, IPU_IRQ_COUNT)
+
+struct ipu_irq_handler {
+	struct list_head	list;
+	void			(*handler)(unsigned long *, void *);
+	void			*context;
+	DECLARE_IPU_IRQ_BITMAP(ipu_irqs);
+};
+
+struct ipu_soc;
+
+int ipu_irq_add_handler(struct ipu_soc *ipu, struct ipu_irq_handler *ipuirq);
+void ipu_irq_remove_handler(struct ipu_soc *ipu, struct ipu_irq_handler *handler);
+int ipu_irq_update_handler(struct ipu_soc *ipu,
+		struct ipu_irq_handler *handler,
+		unsigned long *bitmap);
+int ipu_wait_for_interrupt(struct ipu_soc *ipu, int interrupt, int timeout_ms);
+
+struct ipu_channel;
+
+/*
+ * IPU Image DMA Controller (idmac) functions
+ */
+struct ipu_channel *ipu_idmac_get(struct ipu_soc *ipu, unsigned num);
+void ipu_idmac_put(struct ipu_channel *);
+int ipu_idmac_init_channel_buffer(struct ipu_channel *channel,
+				u32 pixel_fmt,
+				u16 width, u16 height,
+				u32 stride,
+				ipu_rotate_mode_t rot_mode,
+				dma_addr_t phyaddr_0, dma_addr_t phyaddr_1,
+				u32 u_offset, u32 v_offset, bool interlaced);
+
+int ipu_idmac_update_channel_buffer(struct ipu_channel *channel,
+				  u32 bufNum, dma_addr_t phyaddr);
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
+struct dc_channel;
+struct dc_channel *ipu_dc_get(struct ipu_soc *ipu, int chan);
+void ipu_dc_put(struct dc_channel *dc_chan);
+int ipu_dc_init_sync(struct dc_channel *dc_chan, int di,
+		bool interlaced, u32 pixel_fmt, u32 width);
+void ipu_dc_init_async(struct dc_channel *dc_chan, int di, bool interlaced);
+void ipu_dc_enable_channel(struct dc_channel *dc_chan);
+void ipu_dc_disable_channel(struct dc_channel *dc_chan);
+
+/*
+ * IPU Display Interface (di) functions
+ */
+struct ipu_di;
+struct ipu_di *ipu_di_get(struct ipu_soc *ipu, int disp);
+void ipu_di_put(struct ipu_di *di);
+int ipu_di_disable(struct ipu_di *);
+int ipu_di_enable(struct ipu_di *);
+int ipu_di_init_sync_panel(struct ipu_di *, u32 pixel_clk,
+		struct ipu_di_signal_cfg *sig);
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
+#define IPU_DP_FLOW_SYNC	0
+#define IPU_DP_FLOW_ASYNC0	1
+#define IPU_DP_FLOW_ASYNC1	2
+
+struct ipu_dp *ipu_dp_get(struct ipu_soc *ipu);
+void ipu_dp_put(struct ipu_dp *);
+int ipu_dp_enable_channel(struct ipu_dp *dp);
+void ipu_dp_disable_channel(struct ipu_dp *dp);
+void ipu_dp_enable_fg(struct ipu_dp *dp);
+void ipu_dp_disable_fg(struct ipu_dp *dp);
+int ipu_dp_setup_channel(struct ipu_dp *dp, u32 in_pixel_fmt,
+		 u32 out_pixel_fmt, int bg);
+int ipu_dp_set_window_pos(struct ipu_dp *, u16 x_pos, u16 y_pos);
+int ipu_dp_set_color_key(struct ipu_dp *dp, bool enable, u32 colorKey);
+int ipu_dp_set_global_alpha(struct ipu_dp *dp, bool enable, u8 alpha,
+		bool bg_chan);
+
+#endif
-- 
1.7.1
