From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  7 Jun 2011 12:45:47 +0200
Subject: [PATCH 2/5] DRM i.MX IPU: Add support for IPU submodules
In-Reply-To: <1307443550-25549-1-git-send-email-s.hauer@pengutronix.de>
References: <1307443550-25549-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1307443550-25549-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can be squashed into the last patch, just split up to avoid hitting
list limits.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/gpu/drm/imx/ipu-v3/Makefile   |    2 +-
 drivers/gpu/drm/imx/ipu-v3/ipu-dc.c   |  440 ++++++++++++++++++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-di.c   |  665 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-dmfc.c |  393 +++++++++++++++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-dp.c   |  342 +++++++++++++++++
 5 files changed, 1841 insertions(+), 1 deletions(-)
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-dc.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-di.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-dmfc.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-dp.c

diff --git a/drivers/gpu/drm/imx/ipu-v3/Makefile b/drivers/gpu/drm/imx/ipu-v3/Makefile
index b073fd3..877433c 100644
--- a/drivers/gpu/drm/imx/ipu-v3/Makefile
+++ b/drivers/gpu/drm/imx/ipu-v3/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_DRM_IMX_IPUV3) += imx-ipu-v3.o
 
-imx-ipu-v3-objs := ipu-common.o
+imx-ipu-v3-objs := ipu-common.o ipu-dc.o ipu-di.o ipu-dp.o ipu-dmfc.o
diff --git a/drivers/gpu/drm/imx/ipu-v3/ipu-dc.c b/drivers/gpu/drm/imx/ipu-v3/ipu-dc.c
new file mode 100644
index 0000000..7841a35
--- /dev/null
+++ b/drivers/gpu/drm/imx/ipu-v3/ipu-dc.c
@@ -0,0 +1,440 @@
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
+#include <drm/imx-ipu-v3.h>
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
+#define DC_WR_CH_CONF		0x0
+#define DC_WR_CH_ADDR		0x4
+#define DC_RL_CH(evt)		(8 + ((evt) & ~0x1) * 2)
+
+#define DC_GEN			0x00d4
+#define DC_DISP_CONF1(disp)	(0x00d8 + (disp) * 4)
+#define DC_DISP_CONF2(disp)	(0x00e8 + (disp) * 4)
+#define DC_STAT			0x01c8
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
+struct ipu_dc_priv;
+
+struct ipu_dc {
+	unsigned int		di; /* The display interface number assigned to this dc channel */
+	void __iomem		*base;
+	struct ipu_dc_priv	*priv;
+	int			chno;
+	bool			in_use;
+};
+
+struct ipu_dc_priv {
+	void __iomem		*dc_reg;
+	void __iomem		*dc_tmpl_reg;
+	struct ipu_soc		*ipu;
+	struct device		*dev;
+	struct ipu_dc		channels[10];
+	struct mutex		mutex;
+};
+
+static void ipu_dc_link_event(struct ipu_dc *dc, int event, int addr, int priority)
+{
+	u32 reg;
+
+	reg = readl(dc->base + DC_RL_CH(event));
+	reg &= ~(0xffff << (16 * (event & 0x1)));
+	reg |= ((addr << 8) | priority) << (16 * (event & 0x1));
+	writel(reg, dc->base + DC_RL_CH(event));
+}
+
+static void ipu_dc_write_tmpl(struct ipu_dc *dc, int word, u32 opcode, u32 operand,
+		int map, int wave, int glue, int sync)
+{
+	struct ipu_dc_priv *priv = dc->priv;
+	u32 reg;
+	int stop = 1;
+
+	reg = sync;
+	reg |= glue << 4;
+	reg |= ++wave << 11;
+	reg |= ++map << 15;
+	reg |= (operand << 20) & 0xfff00000;
+	writel(reg, priv->dc_tmpl_reg + word * 8);
+
+	reg = operand >> 12;
+	reg |= opcode << 4;
+	reg |= stop << 9;
+	writel(reg, priv->dc_tmpl_reg + word * 8 + 4);
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
+	case IPU_PIX_FMT_GBR24:
+		return 13;
+	}
+
+	return -EINVAL;
+}
+
+#define SYNC_WAVE 0
+
+int ipu_dc_init_sync(struct ipu_dc *dc, int di, bool interlaced,
+		u32 pixel_fmt, u32 width)
+{
+	struct ipu_dc_priv *priv = dc->priv;
+	u32 reg = 0, map;
+
+	dc->di = di;
+
+	map = ipu_pixfmt_to_map(pixel_fmt);
+	if (map < 0) {
+		dev_dbg(priv->dev, "IPU_DISP: No MAP\n");
+		return -EINVAL;
+	}
+
+	ipu_get(priv->ipu);
+
+	if (interlaced) {
+		ipu_dc_link_event(dc, DC_EVT_NL, 0, 3);
+		ipu_dc_link_event(dc, DC_EVT_EOL, 0, 2);
+		ipu_dc_link_event(dc, DC_EVT_NEW_DATA, 0, 1);
+
+		/* Init template microcode */
+		ipu_dc_write_tmpl(dc, 0, WROD(0), 0, map, SYNC_WAVE, 0, 8);
+	} else {
+		if (di) {
+			ipu_dc_link_event(dc, DC_EVT_NL, 2, 3);
+			ipu_dc_link_event(dc, DC_EVT_EOL, 3, 2);
+			ipu_dc_link_event(dc, DC_EVT_NEW_DATA, 4, 1);
+			/* Init template microcode */
+			ipu_dc_write_tmpl(dc, 2, WROD(0), 0, map, SYNC_WAVE, 8, 5);
+			ipu_dc_write_tmpl(dc, 3, WROD(0), 0, map, SYNC_WAVE, 4, 5);
+			ipu_dc_write_tmpl(dc, 4, WROD(0), 0, map, SYNC_WAVE, 0, 5);
+		} else {
+			ipu_dc_link_event(dc, DC_EVT_NL, 5, 3);
+			ipu_dc_link_event(dc, DC_EVT_EOL, 6, 2);
+			ipu_dc_link_event(dc, DC_EVT_NEW_DATA, 7, 1);
+			/* Init template microcode */
+			ipu_dc_write_tmpl(dc, 5, WROD(0), 0, map, SYNC_WAVE, 8, 5);
+			ipu_dc_write_tmpl(dc, 6, WROD(0), 0, map, SYNC_WAVE, 4, 5);
+			ipu_dc_write_tmpl(dc, 7, WROD(0), 0, map, SYNC_WAVE, 0, 5);
+		}
+	}
+	ipu_dc_link_event(dc, DC_EVT_NF, 0, 0);
+	ipu_dc_link_event(dc, DC_EVT_NFIELD, 0, 0);
+	ipu_dc_link_event(dc, DC_EVT_EOF, 0, 0);
+	ipu_dc_link_event(dc, DC_EVT_EOFIELD, 0, 0);
+	ipu_dc_link_event(dc, DC_EVT_NEW_CHAN, 0, 0);
+	ipu_dc_link_event(dc, DC_EVT_NEW_ADDR, 0, 0);
+
+	reg = 0x2;
+	reg |= di << DC_WR_CH_CONF_PROG_DISP_ID_OFFSET;
+	reg |= di << 2;
+	if (interlaced)
+		reg |= DC_WR_CH_CONF_FIELD_MODE;
+
+	writel(reg, dc->base + DC_WR_CH_CONF);
+
+	writel(0x00000000, dc->base + DC_WR_CH_ADDR);
+
+	writel(0x00000084, priv->dc_reg + DC_GEN);
+
+	writel(width, priv->dc_reg + DC_DISP_CONF2(di));
+
+	ipu_module_enable(priv->ipu, IPU_CONF_DC_EN);
+
+	ipu_put(priv->ipu);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dc_init_sync);
+
+void ipu_dc_init_async(struct ipu_dc *dc, int di, bool interlaced)
+{
+	struct ipu_dc_priv *priv = dc->priv;
+	u32 reg = 0;
+
+	dc->di = di;
+
+	ipu_dc_link_event(dc, DC_EVT_NEW_DATA_W_0, 0x64, 1);
+	ipu_dc_link_event(dc, DC_EVT_NEW_DATA_W_1, 0x64, 1);
+
+	reg = 0x3;
+	reg |= DC_DISP_ID_SERIAL << DC_WR_CH_CONF_PROG_DISP_ID_OFFSET;
+	writel(reg, dc->base + DC_WR_CH_CONF);
+
+	writel(0x00000000, dc->base + DC_WR_CH_ADDR);
+
+	writel(0x00000084, priv->dc_reg + DC_GEN);
+
+	ipu_module_enable(priv->ipu, IPU_CONF_DC_EN);
+}
+EXPORT_SYMBOL_GPL(ipu_dc_init_async);
+
+void ipu_dc_enable_channel(struct ipu_dc *dc)
+{
+	int di;
+	u32 reg;
+
+	di = dc->di;
+
+	reg = readl(dc->base + DC_WR_CH_CONF);
+	reg |= 4 << DC_WR_CH_CONF_PROG_TYPE_OFFSET;
+	writel(reg, dc->base + DC_WR_CH_CONF);
+}
+EXPORT_SYMBOL_GPL(ipu_dc_enable_channel);
+
+void ipu_dc_disable_channel(struct ipu_dc *dc)
+{
+	struct ipu_dc_priv *priv = dc->priv;
+	u32 reg;
+	int irq = 0, timeout = 50;
+
+	if (dc->chno == 1) {
+		irq = IPU_IRQ_DC_FC_1;
+	} else if (dc->chno == 5) {
+		irq = IPU_IRQ_DP_SF_END;
+	} else {
+		return;
+	}
+
+	/* should wait for the interrupt here */
+	mdelay(50);
+
+	/* Wait for DC triple buffer to empty */
+	if (dc->di == 0)
+		while ((readl(priv->dc_reg + DC_STAT) & 0x00000002)
+			!= 0x00000002) {
+			msleep(2);
+			timeout -= 2;
+			if (timeout <= 0)
+				break;
+		}
+	else if (dc->di == 1)
+		while ((readl(priv->dc_reg + DC_STAT) & 0x00000020)
+			!= 0x00000020) {
+			msleep(2);
+			timeout -= 2;
+			if (timeout <= 0)
+				break;
+	}
+
+	reg = readl(dc->base + DC_WR_CH_CONF);
+	reg &= ~DC_WR_CH_CONF_PROG_TYPE_MASK;
+	writel(reg, dc->base + DC_WR_CH_CONF);
+}
+EXPORT_SYMBOL_GPL(ipu_dc_disable_channel);
+
+static void ipu_dc_map_link(struct ipu_dc_priv *priv, int current_map,
+		int base_map_0, int buf_num_0,
+		int base_map_1, int buf_num_1,
+		int base_map_2, int buf_num_2)
+{
+	int ptr_0 = base_map_0 * 3 + buf_num_0;
+	int ptr_1 = base_map_1 * 3 + buf_num_1;
+	int ptr_2 = base_map_2 * 3 + buf_num_2;
+	int ptr;
+	u32 reg;
+	ptr = (ptr_2 << 10) +  (ptr_1 << 5) + ptr_0;
+
+	reg = readl(priv->dc_reg + DC_MAP_CONF_PTR(current_map));
+	reg &= ~(0x1F << ((16 * (current_map & 0x1))));
+	reg |= ptr << ((16 * (current_map & 0x1)));
+	writel(reg, priv->dc_reg + DC_MAP_CONF_PTR(current_map));
+}
+
+static void ipu_dc_map_config(struct ipu_dc_priv *priv, int map,
+		int byte_num, int offset, int mask)
+{
+	int ptr = map * 3 + byte_num;
+	u32 reg;
+
+	reg = readl(priv->dc_reg + DC_MAP_CONF_VAL(ptr));
+	reg &= ~(0xffff << (16 * (ptr & 0x1)));
+	reg |= ((offset << 8) | mask) << (16 * (ptr & 0x1));
+	writel(reg, priv->dc_reg + DC_MAP_CONF_VAL(ptr));
+
+	reg = readl(priv->dc_reg + DC_MAP_CONF_PTR(map));
+	reg &= ~(0x1f << ((16 * (map & 0x1)) + (5 * byte_num)));
+	reg |= ptr << ((16 * (map & 0x1)) + (5 * byte_num));
+	writel(reg, priv->dc_reg + DC_MAP_CONF_PTR(map));
+}
+
+static void ipu_dc_map_clear(struct ipu_dc_priv *priv, int map)
+{
+	u32 reg = readl(priv->dc_reg + DC_MAP_CONF_PTR(map));
+	writel(reg & ~(0xffff << (16 * (map & 0x1))),
+		     priv->dc_reg + DC_MAP_CONF_PTR(map));
+}
+
+struct ipu_dc *ipu_dc_get(struct ipu_soc *ipu, int channel)
+{
+	struct ipu_dc_priv *priv = ipu->dc_priv;
+	struct ipu_dc *dc;
+
+	if (channel > 9)
+		return NULL;
+
+	dc = &priv->channels[channel];
+
+	mutex_lock(&priv->mutex);
+
+	if (dc->in_use) {
+		mutex_unlock(&priv->mutex);
+		ERR_PTR(-EBUSY);
+	}
+
+	dc->in_use = 1;
+
+	mutex_unlock(&priv->mutex);
+
+	return dc;
+}
+EXPORT_SYMBOL_GPL(ipu_dc_get);
+
+void ipu_dc_put(struct ipu_dc *dc)
+{
+	struct ipu_dc_priv *priv = dc->priv;
+
+	mutex_lock(&priv->mutex);
+	dc->in_use = 0;
+	mutex_unlock(&priv->mutex);
+}
+EXPORT_SYMBOL_GPL(ipu_dc_put);
+
+int ipu_dc_init(struct ipu_soc *ipu, struct device *dev,
+		unsigned long base, unsigned long template_base)
+{
+	struct ipu_dc_priv *priv;
+	static int channel_offsets[] = { 0, 0x1c, 0x38, 0x54, 0x58, 0x5c,
+		0x78, 0, 0x94, 0xb4};
+	int i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mutex_init(&priv->mutex);
+
+	priv->dev = dev;
+	priv->ipu = ipu;
+	priv->dc_reg = devm_ioremap(dev, base, PAGE_SIZE);
+	priv->dc_tmpl_reg = devm_ioremap(dev, template_base, PAGE_SIZE);
+	if (!priv->dc_reg || !priv->dc_tmpl_reg)
+		return -ENOMEM;
+
+	for (i = 0; i < 10; i++) {
+		priv->channels[i].chno = i;
+		priv->channels[i].priv = priv;
+		priv->channels[i].base = priv->dc_reg + channel_offsets[i];
+	}
+
+	ipu->dc_priv = priv;
+
+	dev_dbg(dev, "DC base: 0x%08lx template base: 0x%08lx\n",
+			base, template_base);
+
+	/* IPU_PIX_FMT_RGB24 */
+	ipu_dc_map_clear(priv, 0);
+	ipu_dc_map_config(priv, 0, 0, 7, 0xff);
+	ipu_dc_map_config(priv, 0, 1, 15, 0xff);
+	ipu_dc_map_config(priv, 0, 2, 23, 0xff);
+
+	/* IPU_PIX_FMT_RGB666 */
+	ipu_dc_map_clear(priv, 1);
+	ipu_dc_map_config(priv, 1, 0, 5, 0xfc);
+	ipu_dc_map_config(priv, 1, 1, 11, 0xfc);
+	ipu_dc_map_config(priv, 1, 2, 17, 0xfc);
+
+	/* IPU_PIX_FMT_YUV444 */
+	ipu_dc_map_clear(priv, 2);
+	ipu_dc_map_config(priv, 2, 0, 15, 0xff);
+	ipu_dc_map_config(priv, 2, 1, 23, 0xff);
+	ipu_dc_map_config(priv, 2, 2, 7, 0xff);
+
+	/* IPU_PIX_FMT_RGB565 */
+	ipu_dc_map_clear(priv, 3);
+	ipu_dc_map_config(priv, 3, 0, 4, 0xf8);
+	ipu_dc_map_config(priv, 3, 1, 10, 0xfc);
+	ipu_dc_map_config(priv, 3, 2, 15, 0xf8);
+
+	/* IPU_PIX_FMT_LVDS666 */
+	ipu_dc_map_clear(priv, 4);
+	ipu_dc_map_config(priv, 4, 0, 5, 0xfc);
+	ipu_dc_map_config(priv, 4, 1, 13, 0xfc);
+	ipu_dc_map_config(priv, 4, 2, 21, 0xfc);
+
+	/* IPU_PIX_FMT_GBR24 */
+	ipu_dc_map_clear(priv, 13);
+	ipu_dc_map_link(priv, 13, 0, 2, 0, 0, 0, 1);
+
+	return 0;
+}
+
+void ipu_dc_exit(struct ipu_soc *ipu)
+{
+}
diff --git a/drivers/gpu/drm/imx/ipu-v3/ipu-di.c b/drivers/gpu/drm/imx/ipu-v3/ipu-di.c
new file mode 100644
index 0000000..3580386
--- /dev/null
+++ b/drivers/gpu/drm/imx/ipu-v3/ipu-di.c
@@ -0,0 +1,665 @@
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
+#include <drm/imx-ipu-v3.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+
+#include "ipu-prv.h"
+
+#define SYNC_WAVE 0
+
+#define DC_DISP_ID_SYNC(di)	(di)
+
+struct ipu_di {
+	void __iomem *base;
+	int id;
+	u32 module;
+	struct clk *clk;
+	struct clk *ipu_clk;
+	bool external_clk;
+	bool inuse;
+	bool initialized;
+	struct clk ipu_di_clk;
+	struct clk_lookup *clk_lookup;
+	struct ipu_soc *ipu;
+};
+
+static struct ipu_di dis[2];
+
+static DEFINE_MUTEX(di_mutex);
+static struct device *ipu_dev;
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
+#define DI_GEN_DI_VSYNC_EXT			(1 << 21)
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
+static inline u32 ipu_di_read(struct ipu_di *di, unsigned offset)
+{
+	return readl(di->base + offset);
+}
+
+static inline void ipu_di_write(struct ipu_di *di, u32 value, unsigned offset)
+{
+	writel(value, di->base + offset);
+}
+
+static unsigned long ipu_di_clk_get_rate(struct clk *clk)
+{
+	struct ipu_di *di = container_of(clk, struct ipu_di, ipu_di_clk);
+	unsigned long inrate = clk_parent_get_rate(clk);
+	unsigned long outrate;
+	u32 div = ipu_di_read(di, DI_BS_CLKGEN0);
+
+	outrate = (inrate / div) * 16;
+
+	dev_dbg(ipu_dev, "%s: inrate: %ld div: 0x%08x outrate: %ld\n",
+			__func__, inrate, div, outrate);
+
+	return outrate;
+}
+
+static int ipu_di_clk_calc_div(unsigned long inrate, unsigned long outrate)
+{
+	int div;
+
+	if (inrate <= outrate)
+		return 1 * 16;
+
+	div = DIV_ROUND_UP((inrate * 16), outrate);
+
+	return div;
+}
+
+static long ipu_di_clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long inrate = clk_parent_get_rate(clk);
+	unsigned long outrate;
+	int div;
+
+	div = ipu_di_clk_calc_div(inrate, rate);
+
+	outrate = (inrate * 16) / div;
+
+	dev_dbg(ipu_dev, "%s: inrate: %ld div: 0x%08x outrate: %ld wanted: %ld\n",
+			__func__, inrate, div, outrate, rate);
+
+	return outrate;
+}
+
+static int ipu_di_clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct ipu_di *di = container_of(clk, struct ipu_di, ipu_di_clk);
+	unsigned long inrate = clk_parent_get_rate(clk);
+	int div;
+
+	div = ipu_di_clk_calc_div(inrate, rate);
+
+	ipu_di_write(di, div, DI_BS_CLKGEN0);
+
+	dev_dbg(ipu_dev, "%s: inrate: %ld div: 0x%08x\n", __func__, inrate, div);
+
+	return 0;
+}
+
+static struct clk *ipu_di_clk_get_parent(struct clk *clk)
+{
+	struct ipu_di *di = container_of(clk, struct ipu_di, ipu_di_clk);
+	return di->clk;
+}
+
+struct clk_ops ipu_di_clk_ops = {
+	.get_rate = ipu_di_clk_get_rate,
+	.round_rate = ipu_di_clk_round_rate,
+	.set_rate = ipu_di_clk_set_rate,
+	.get_parent = ipu_di_clk_get_parent,
+};
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
+static void ipu_di_sync_config(struct ipu_di *di, struct di_sync_config *config, int start, int count)
+{
+	u32 reg;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		struct di_sync_config *c = &config[i];
+		int wave_gen = start + i + 1;
+
+		pr_debug("%s %d\n", __func__, wave_gen);
+		if ((c->run_count >= 0x1000) || (c->offset_count >= 0x1000) || (c->repeat_count >= 0x1000) ||
+			(c->cnt_up >= 0x400) || (c->cnt_down >= 0x400)) {
+			dev_err(ipu_dev, "DI%d counters out of range.\n", di->id);
+			return;
+		}
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
+}
+
+static void ipu_di_sync_config_interlaced(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
+{
+	u32 h_total = sig->width + sig->h_sync_width + sig->h_start_width + sig->h_end_width;
+	u32 v_total = sig->height + sig->v_sync_width + sig->v_start_width + sig->v_end_width;
+	u32 reg;
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
+	ipu_di_sync_config(di, cfg, 0, ARRAY_SIZE(cfg));
+
+	/* set gentime select and tag sel */
+	reg = ipu_di_read(di, DI_SW_GEN1(9));
+	reg &= 0x1FFFFFFF;
+	reg |= (3 - 1) << 29 | 0x00008000;
+	ipu_di_write(di, reg, DI_SW_GEN1(9));
+
+	ipu_di_write(di, v_total / 2 - 1, DI_SCR_CONF);
+}
+
+static void ipu_di_sync_config_noninterlaced(struct ipu_di *di,
+		struct ipu_di_signal_cfg *sig, int div)
+{
+	u32 h_total = sig->width + sig->h_sync_width + sig->h_start_width +
+		sig->h_end_width;
+	u32 v_total = sig->height + sig->v_sync_width + sig->v_start_width +
+		sig->v_end_width;
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
+	ipu_di_sync_config(di, cfg, 0, ARRAY_SIZE(cfg));
+}
+
+int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
+{
+	u32 reg;
+	u32 di_gen, vsync_cnt;
+	u32 div;
+	u32 h_total, v_total;
+
+	dev_dbg(ipu_dev, "disp %d: panel size = %d x %d\n",
+		di->id, sig->width, sig->height);
+
+	if ((sig->v_sync_width == 0) || (sig->h_sync_width == 0))
+		return -EINVAL;
+
+	h_total = sig->width + sig->h_sync_width + sig->h_start_width + sig->h_end_width;
+	v_total = sig->height + sig->v_sync_width + sig->v_start_width + sig->v_end_width;
+
+	mutex_lock(&di_mutex);
+	ipu_get(di->ipu);
+sig->ext_clk = 1;
+	/* Init clocking */
+	if (sig->ext_clk) {
+		di->external_clk = true;
+	} else {
+		di->external_clk = false;
+	}
+
+	div = ipu_di_read(di, DI_BS_CLKGEN0);
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
+		di_gen |= DI_GEN_DI_CLK_EXT | DI_GEN_DI_VSYNC_EXT;
+
+	if (sig->interlaced) {
+		ipu_di_sync_config_interlaced(di, sig);
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
+		ipu_di_sync_config_noninterlaced(di, sig, div);
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
+
+	ipu_put(di->ipu);
+	mutex_unlock(&di_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_di_init_sync_panel);
+
+void ipu_set_vga_delayed_hsync_vsync(struct ipu_di_signal_cfg *sig,
+		uint32_t hsync_delay, uint32_t vsync_delay)
+{
+	int h_total = sig->width + sig->h_sync_width + sig->h_start_width + sig->h_end_width;
+	int v_total = sig->height + sig->v_sync_width + sig->v_start_width + sig->v_end_width;
+	u32 di_gen;
+	struct ipu_di *di = &dis[1];
+	struct di_sync_config cfg[] = {
+		{
+			/* counter 7 for delay HSYNC */
+			.run_count = h_total - 1,
+			.run_src = DI_SYNC_CLK,
+			.offset_count = hsync_delay,
+			.offset_src = DI_SYNC_CLK,
+			.repeat_count = 0,
+			.cnt_clr_src = DI_SYNC_NONE,
+			.cnt_polarity_gen_en = 1,
+			.cnt_polarity_clr_src = DI_SYNC_NONE,
+			.cnt_polarity_trigger_src = DI_SYNC_CLK,
+			.cnt_up = 0,
+			.cnt_down = sig->h_sync_width * 2,
+		}, {
+			/* counter 8 for delay VSYNC */
+			.run_count = v_total - 1,
+			.run_src = DI_SYNC_INT_HSYNC,
+			.offset_count = vsync_delay,
+			.offset_src = DI_SYNC_INT_HSYNC,
+			.repeat_count = 0,
+			.cnt_clr_src = DI_SYNC_NONE,
+			.cnt_polarity_gen_en = 1,
+			.cnt_polarity_clr_src = DI_SYNC_NONE,
+			.cnt_polarity_trigger_src = DI_SYNC_INT_HSYNC,
+			.cnt_up = 0,
+			.cnt_down = sig->v_sync_width * 2,
+		}
+	};
+
+	ipu_di_sync_config(di, cfg, 6, ARRAY_SIZE(cfg));
+
+	di_gen = ipu_di_read(di, DI_GENERAL);
+	di_gen &= ~DI_GEN_POLARITY_2;
+	di_gen &= ~DI_GEN_POLARITY_3;
+	di_gen &= ~DI_GEN_POLARITY_7;
+	di_gen &= ~DI_GEN_POLARITY_8;
+	if (sig->Hsync_pol)
+		di_gen |= DI_GEN_POLARITY_7;
+	if (sig->Vsync_pol)
+		di_gen |= DI_GEN_POLARITY_8;
+	ipu_di_write(di, di_gen, DI_GENERAL);
+}
+EXPORT_SYMBOL_GPL(ipu_set_vga_delayed_hsync_vsync);
+
+int ipu_di_enable(struct ipu_di *di)
+{
+	ipu_get(di->ipu);
+
+	if (di->external_clk)
+		clk_enable(di->clk);
+
+	ipu_module_enable(di->ipu, di->module);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_di_enable);
+
+int ipu_di_disable(struct ipu_di *di)
+{
+	ipu_module_disable(di->ipu, di->module);
+	ipu_put(di->ipu);
+
+	if (di->external_clk)
+		clk_disable(di->clk);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_di_disable);
+
+static DEFINE_MUTEX(ipu_di_lock);
+
+struct ipu_di *ipu_di_get(struct ipu_soc *ipu, int disp)
+{
+	struct ipu_di *di;
+
+	if (disp > 1)
+		return ERR_PTR(-EINVAL);
+
+	di = &dis[disp];
+
+	mutex_lock(&ipu_di_lock);
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
+	mutex_unlock(&ipu_di_lock);
+
+	return di;
+}
+EXPORT_SYMBOL_GPL(ipu_di_get);
+
+void ipu_di_put(struct ipu_di *di)
+{
+	mutex_lock(&ipu_di_lock);
+
+	di->inuse = false;
+
+	mutex_unlock(&ipu_di_lock);
+}
+EXPORT_SYMBOL_GPL(ipu_di_put);
+
+int ipu_di_init(struct ipu_soc *ipu, struct device *dev, int id,
+		unsigned long base,
+		u32 module, struct clk *ipu_clk)
+{
+	char *clk_id, *con_id;
+	struct ipu_di *di = &dis[id];
+
+	if (id > 1)
+		return -EINVAL;
+
+	if (id)
+		clk_id = "di1";
+	else
+		clk_id = "di0";
+
+	ipu_dev = dev;
+
+	di->clk = clk_get(dev, clk_id);
+	if (IS_ERR(di->clk))
+		return PTR_ERR(di->clk);
+
+	di->module = module;
+	di->id = id;
+	di->ipu_clk = ipu_clk;
+	di->base = devm_ioremap(dev, base, PAGE_SIZE);
+	dev_dbg(dev, "DI%d base: 0x%08lx\n", id, base);
+	di->initialized = true;
+	di->inuse = false;
+	di->ipu = ipu;
+	if (!di->base) {
+		printk("ficken?\n");
+		return -ENOMEM;
+	}
+
+	if (id == 0)
+		con_id = "pixclock0";
+	else
+		con_id = "pixclock1";
+
+	spin_lock_init(&di->ipu_di_clk.enable_lock);
+	mutex_init(&di->ipu_di_clk.prepare_lock);
+
+	strcpy(di->ipu_di_clk.name, "imx-drm.0");
+	di->ipu_di_clk.ops = &ipu_di_clk_ops;
+
+	di->clk_lookup = clkdev_alloc(&di->ipu_di_clk, con_id, "imx-drm.0");
+	clkdev_add(di->clk_lookup);
+
+	return 0;
+}
+
+void ipu_di_exit(struct ipu_soc *ipu, int id)
+{
+	struct ipu_di *di = &dis[id];
+
+	clkdev_drop(di->clk_lookup);
+	clk_put(di->clk);
+	di->initialized = false;
+}
diff --git a/drivers/gpu/drm/imx/ipu-v3/ipu-dmfc.c b/drivers/gpu/drm/imx/ipu-v3/ipu-dmfc.c
new file mode 100644
index 0000000..20387da
--- /dev/null
+++ b/drivers/gpu/drm/imx/ipu-v3/ipu-dmfc.c
@@ -0,0 +1,393 @@
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
+#define DEBUG
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <drm/imx-ipu-v3.h>
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
+struct dmfc_channel_data {
+	int		ipu_channel;
+	unsigned long	channel_reg;
+	unsigned long	shift;
+	unsigned	eot_shift;
+	unsigned	max_fifo_lines;
+};
+
+static const struct dmfc_channel_data dmfcdata[] = {
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
+#define DMFC_NUM_CHANNELS	ARRAY_SIZE(dmfcdata)
+
+struct ipu_dmfc_priv;
+
+struct dmfc_channel {
+	unsigned			slots;
+	unsigned			slotmask;
+	unsigned			segment;
+	struct ipu_soc			*ipu;
+	struct ipu_dmfc_priv		*priv;
+	const struct dmfc_channel_data	*data;
+};
+
+struct ipu_dmfc_priv {
+	struct ipu_soc *ipu;
+	struct device *dev;
+	struct dmfc_channel channels[DMFC_NUM_CHANNELS];
+	struct mutex mutex;
+	unsigned long bandwidth_per_slot;
+	void __iomem *base;
+	int use_count;
+};
+
+int ipu_dmfc_enable_channel(struct dmfc_channel *dmfc)
+{
+	struct ipu_dmfc_priv *priv = dmfc->priv;
+	mutex_lock(&priv->mutex);
+	ipu_get(dmfc->ipu);
+
+	if (!priv->use_count)
+		ipu_module_enable(priv->ipu, IPU_CONF_DMFC_EN);
+
+	priv->use_count++;
+
+	mutex_unlock(&priv->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_enable_channel);
+
+void ipu_dmfc_disable_channel(struct dmfc_channel *dmfc)
+{
+	struct ipu_dmfc_priv *priv = dmfc->priv;
+
+	mutex_lock(&priv->mutex);
+
+	priv->use_count--;
+
+	if (!priv->use_count)
+		ipu_module_disable(priv->ipu, IPU_CONF_DMFC_EN);
+
+	if (priv->use_count < 0)
+		priv->use_count = 0;
+
+	ipu_put(dmfc->ipu);
+	mutex_unlock(&priv->mutex);
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_disable_channel);
+
+static int ipu_dmfc_setup_channel(struct dmfc_channel *dmfc, int slots, int segment)
+{
+	struct ipu_dmfc_priv *priv = dmfc->priv;
+	u32 val, field;
+
+	dev_dbg(priv->dev, "dmfc: using %d slots starting from segment %d for IPU channel %d\n",
+			slots, segment, dmfc->data->ipu_channel);
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
+	val = readl(priv->base + dmfc->data->channel_reg);
+
+	val &= ~(0xff << dmfc->data->shift);
+	val |= field << dmfc->data->shift;
+
+	writel(val, priv->base + dmfc->data->channel_reg);
+
+	dmfc->slots = slots;
+	dmfc->segment = segment;
+	dmfc->slotmask = ((1 << slots) - 1) << segment;
+
+	return 0;
+}
+
+static int dmfc_bandwidth_to_slots(struct ipu_dmfc_priv *priv, unsigned long bandwidth)
+{
+	int slots = 1;
+
+	while (slots * priv->bandwidth_per_slot < bandwidth)
+		slots *= 2;
+
+	return slots;
+}
+
+static int dmfc_find_slots(struct ipu_dmfc_priv *priv, int slots)
+{
+	unsigned slotmask_need, slotmask_used = 0;
+	int i, segment = 0;
+
+	slotmask_need = (1 << slots) - 1;
+
+	for (i = 0; i < DMFC_NUM_CHANNELS; i++)
+		slotmask_used |= priv->channels[i].slotmask;
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
+	struct ipu_dmfc_priv *priv = dmfc->priv;
+	int i;
+
+	dev_dbg(priv->dev, "dmfc: freeing %d slots starting from segment %d\n",
+			dmfc->slots, dmfc->segment);
+
+	mutex_lock(&priv->mutex);
+
+	if (!dmfc->slots)
+		goto out;
+
+	dmfc->slotmask = 0;
+	dmfc->slots = 0;
+	dmfc->segment = 0;
+
+	for (i = 0; i < DMFC_NUM_CHANNELS; i++)
+		priv->channels[i].slotmask = 0;
+
+	for (i = 0; i < DMFC_NUM_CHANNELS; i++) {
+		if (priv->channels[i].slots > 0) {
+			priv->channels[i].segment = dmfc_find_slots(priv, priv->channels[i].slots);
+			priv->channels[i].slotmask = ((1 << priv->channels[i].slots) - 1) <<
+				priv->channels[i].segment;
+		}
+	}
+
+	for (i = 0; i < DMFC_NUM_CHANNELS; i++) {
+		if (priv->channels[i].slots > 0)
+			ipu_dmfc_setup_channel(&priv->channels[i],
+					priv->channels[i].slots,
+					priv->channels[i].segment);
+	}
+out:
+	mutex_unlock(&priv->mutex);
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_free_bandwidth);
+
+int ipu_dmfc_alloc_bandwidth(struct dmfc_channel *dmfc,
+		unsigned long bandwidth_pixel_per_second)
+{
+	struct ipu_dmfc_priv *priv = dmfc->priv;
+	int slots = dmfc_bandwidth_to_slots(priv, bandwidth_pixel_per_second);
+	int segment = 0, ret = 0;
+
+	dev_dbg(priv->dev, "dmfc: trying to allocate %ldMpixel/s for IPU channel %d\n",
+			bandwidth_pixel_per_second / 1000000, dmfc->data->ipu_channel);
+
+	ipu_dmfc_free_bandwidth(dmfc);
+
+	ipu_get(priv->ipu);
+	mutex_lock(&priv->mutex);
+
+	if (slots > 8) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	segment = dmfc_find_slots(priv, slots);
+	if (segment < 0) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ipu_dmfc_setup_channel(dmfc, slots, segment);
+
+out:
+	ipu_put(priv->ipu);
+	mutex_unlock(&priv->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_alloc_bandwidth);
+
+int ipu_dmfc_init_channel(struct dmfc_channel *dmfc, int width)
+{
+	struct ipu_dmfc_priv *priv = dmfc->priv;
+	u32 dmfc_gen1;
+
+	ipu_get(dmfc->ipu);
+
+	dmfc_gen1 = readl(priv->base + DMFC_GENERAL1);
+
+	if ((dmfc->slots * 64 * 4) / width > dmfc->data->max_fifo_lines)
+		dmfc_gen1 |= 1 << dmfc->data->eot_shift;
+	else
+		dmfc_gen1 &= ~(1 << dmfc->data->eot_shift);
+
+	writel(dmfc_gen1, priv->base + DMFC_GENERAL1);
+
+	ipu_put(dmfc->ipu);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_init_channel);
+
+struct dmfc_channel *ipu_dmfc_get(struct ipu_soc *ipu, int ipu_channel)
+{
+	struct ipu_dmfc_priv *priv = ipu->dmfc_priv;
+	int i;
+
+	for (i = 0; i < DMFC_NUM_CHANNELS; i++)
+		if (dmfcdata[i].ipu_channel == ipu_channel)
+			return &priv->channels[i];
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_get);
+
+void ipu_dmfc_put(struct dmfc_channel *dmfc)
+{
+	ipu_dmfc_free_bandwidth(dmfc);
+}
+EXPORT_SYMBOL_GPL(ipu_dmfc_put);
+
+int ipu_dmfc_init(struct ipu_soc *ipu, struct device *dev, unsigned long base,
+		struct clk *ipu_clk)
+{
+	struct ipu_dmfc_priv *priv;
+	int i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_ioremap(dev, base, PAGE_SIZE);
+	if (!priv->base)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->ipu = ipu;
+	mutex_init(&priv->mutex);
+
+	ipu->dmfc_priv = priv;
+
+	for (i = 0; i < DMFC_NUM_CHANNELS; i++) {
+		priv->channels[i].priv = priv;
+		priv->channels[i].ipu = ipu;
+		priv->channels[i].data = &dmfcdata[i];
+	}
+
+	writel(0x0, priv->base + DMFC_WR_CHAN);
+	writel(0x0, priv->base + DMFC_DP_CHAN);
+
+	/*
+	 * We have a total bandwidth of clkrate * 4pixel divided
+	 * into 8 slots.
+	 */
+	priv->bandwidth_per_slot = clk_get_rate(ipu_clk) / 4;
+
+	dev_dbg(dev, "dmfc: 8 slots with %ldMpixel/s bandwidth each\n",
+			priv->bandwidth_per_slot / 1000000);
+
+	writel(0x202020f6, priv->base + DMFC_WR_CHAN_DEF);
+	writel(0x2020f6f6, priv->base + DMFC_DP_CHAN_DEF);
+	writel(0x00000003, priv->base + DMFC_GENERAL1);
+
+	return 0;
+}
+
+void ipu_dmfc_exit(struct ipu_soc *ipu)
+{
+}
diff --git a/drivers/gpu/drm/imx/ipu-v3/ipu-dp.c b/drivers/gpu/drm/imx/ipu-v3/ipu-dp.c
new file mode 100644
index 0000000..4cd2c6d
--- /dev/null
+++ b/drivers/gpu/drm/imx/ipu-v3/ipu-dp.c
@@ -0,0 +1,342 @@
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
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <drm/imx-ipu-v3.h>
+
+#include "ipu-prv.h"
+
+#define DP_SYNC 0
+#define DP_ASYNC0 0x60
+#define DP_ASYNC1 0xBC
+
+#define DP_COM_CONF		0x0
+#define DP_GRAPH_WIND_CTRL	0x0004
+#define DP_FG_POS		0x0008
+#define DP_CSC_A_0		0x0044
+#define DP_CSC_A_1		0x0048
+#define DP_CSC_A_2		0x004C
+#define DP_CSC_A_3		0x0050
+#define DP_CSC_0		0x0054
+#define DP_CSC_1		0x0058
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
+struct ipu_dp_priv;
+
+struct ipu_dp {
+	u32 flow;
+	bool in_use;
+	bool foreground;
+	ipu_color_space_t in_cs;
+};
+
+struct ipu_flow {
+	struct ipu_dp foreground;
+	struct ipu_dp background;
+	ipu_color_space_t out_cs;
+	void __iomem *base;
+	struct ipu_dp_priv *priv;
+};
+
+struct ipu_dp_priv {
+	struct ipu_soc *ipu;
+	struct device *dev;
+	void __iomem *base;
+	struct ipu_flow flow[3];
+	struct mutex mutex;
+	int use_count;
+};
+
+static u32 ipu_dp_flow_base[] = {DP_SYNC, DP_ASYNC0, DP_ASYNC1};
+
+static inline struct ipu_flow *to_flow(struct ipu_dp *dp)
+{
+	if (dp->foreground)
+		return container_of(dp, struct ipu_flow, foreground);
+	else
+		return container_of(dp, struct ipu_flow, background);
+}
+
+int ipu_dp_set_global_alpha(struct ipu_dp *dp, bool enable,
+		u8 alpha, bool bg_chan)
+{
+	struct ipu_flow *flow = to_flow(dp);
+	struct ipu_dp_priv *priv = flow->priv;
+	u32 reg;
+
+	mutex_lock(&priv->mutex);
+
+	reg = readl(flow->base + DP_COM_CONF);
+	if (bg_chan)
+		reg &= ~DP_COM_CONF_GWSEL;
+	else
+		reg |= DP_COM_CONF_GWSEL;
+	writel(reg, flow->base + DP_COM_CONF);
+
+	if (enable) {
+		reg = readl(flow->base + DP_GRAPH_WIND_CTRL) & 0x00FFFFFFL;
+		writel(reg | ((u32) alpha << 24),
+			     flow->base + DP_GRAPH_WIND_CTRL);
+
+		reg = readl(flow->base + DP_COM_CONF);
+		writel(reg | DP_COM_CONF_GWAM, flow->base + DP_COM_CONF);
+	} else {
+		reg = readl(flow->base + DP_COM_CONF);
+		writel(reg & ~DP_COM_CONF_GWAM, flow->base + DP_COM_CONF);
+	}
+
+	ipu_srm_dp_sync_update(priv->ipu);
+
+	mutex_unlock(&priv->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dp_set_global_alpha);
+
+int ipu_dp_set_window_pos(struct ipu_dp *dp, u16 x_pos, u16 y_pos)
+{
+	struct ipu_flow *flow = to_flow(dp);
+	struct ipu_dp_priv *priv = flow->priv;
+
+	mutex_lock(&priv->mutex);
+
+	writel((x_pos << 16) | y_pos, flow->base + DP_FG_POS);
+
+	ipu_srm_dp_sync_update(priv->ipu);
+
+	mutex_unlock(&priv->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dp_set_window_pos);
+
+static void ipu_dp_csc_init(struct ipu_flow *flow,
+		ipu_color_space_t in,
+		ipu_color_space_t out,
+		u32 place)
+{
+	u32 reg;
+
+	reg = readl(flow->base + DP_COM_CONF);
+	reg &= ~DP_COM_CONF_CSC_DEF_MASK;
+
+	if (in == out) {
+		writel(reg, flow->base + DP_COM_CONF);
+		return;
+	};
+
+	if (in == IPU_COLORSPACE_RGB && out == IPU_COLORSPACE_YCBCR) {
+		writel(0x099 | (0x12d << 16), flow->base + DP_CSC_A_0);
+		writel(0x03a | (0x3a9 << 16), flow->base + DP_CSC_A_1);
+		writel(0x356 | (0x100 << 16), flow->base + DP_CSC_A_2);
+		writel(0x100 | (0x329 << 16), flow->base + DP_CSC_A_3);
+		writel(0x3d6 | (0x0000 << 16) | (2 << 30),
+				flow->base + DP_CSC_0);
+		writel(0x200 | (2 << 14) | (0x200 << 16) | (2 << 30),
+				flow->base + DP_CSC_1);
+	} else {
+		writel(0x095 | (0x000 << 16), flow->base + DP_CSC_A_0);
+		writel(0x0cc | (0x095 << 16), flow->base + DP_CSC_A_1);
+		writel(0x3ce | (0x398 << 16), flow->base + DP_CSC_A_2);
+		writel(0x095 | (0x0ff << 16), flow->base + DP_CSC_A_3);
+		writel(0x000 | (0x3e42 << 16) | (1 << 30),
+				flow->base + DP_CSC_0);
+		writel(0x10a | (1 << 14) | (0x3dd6 << 16) | (1 << 30),
+				flow->base + DP_CSC_1);
+	}
+
+	reg |= place;
+
+	writel(reg, flow->base + DP_COM_CONF);
+}
+
+int ipu_dp_setup_channel(struct ipu_dp *dp,
+		ipu_color_space_t in,
+		ipu_color_space_t out)
+{
+	struct ipu_flow *flow = to_flow(dp);
+	struct ipu_dp_priv *priv = flow->priv;
+
+	ipu_get(priv->ipu);
+	mutex_lock(&priv->mutex);
+
+	dp->in_cs = in;
+
+	if (!dp->foreground)
+		flow->out_cs = out;
+
+	if (flow->foreground.in_cs == flow->background.in_cs) {
+		/*
+		 * foreground and background are of same colorspace, put
+		 * colorspace converter after combining unit.
+		 */
+		ipu_dp_csc_init(flow, flow->foreground.in_cs, flow->out_cs,
+				DP_COM_CONF_CSC_DEF_BOTH);
+	} else {
+		if (flow->foreground.in_cs == flow->out_cs)
+			/*
+			 * foreground identical to output, apply color conversion
+			 * on background
+			 */
+			ipu_dp_csc_init(flow, flow->background.in_cs, flow->out_cs,
+				DP_COM_CONF_CSC_DEF_BG);
+		else
+			ipu_dp_csc_init(flow, flow->foreground.in_cs, flow->out_cs,
+				DP_COM_CONF_CSC_DEF_FG);
+	}
+
+	ipu_srm_dp_sync_update(priv->ipu);
+
+	mutex_unlock(&priv->mutex);
+	ipu_put(priv->ipu);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dp_setup_channel);
+
+int ipu_dp_enable_channel(struct ipu_dp *dp)
+{
+	struct ipu_flow *flow = to_flow(dp);
+	struct ipu_dp_priv *priv = flow->priv;
+
+	mutex_lock(&priv->mutex);
+	ipu_get(priv->ipu);
+
+	if (!priv->use_count)
+		ipu_module_enable(priv->ipu, IPU_CONF_DP_EN);
+
+	priv->use_count++;
+
+	if (dp->foreground) {
+		u32 reg;
+
+		reg = readl(flow->base + DP_COM_CONF);
+		reg |= DP_COM_CONF_FG_EN;
+		writel(reg, flow->base + DP_COM_CONF);
+
+		ipu_srm_dp_sync_update(priv->ipu);
+	}
+
+	mutex_unlock(&priv->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_dp_enable_channel);
+
+void ipu_dp_disable_channel(struct ipu_dp *dp)
+{
+	struct ipu_flow *flow = to_flow(dp);
+	struct ipu_dp_priv *priv = flow->priv;
+
+	mutex_lock(&priv->mutex);
+
+	priv->use_count--;
+
+	if (dp->foreground) {
+		u32 reg, csc;
+
+		reg = readl(flow->base + DP_COM_CONF);
+		csc = reg & DP_COM_CONF_CSC_DEF_MASK;
+		if (csc == DP_COM_CONF_CSC_DEF_FG)
+			reg &= ~DP_COM_CONF_CSC_DEF_MASK;
+
+		reg &= ~DP_COM_CONF_FG_EN;
+		writel(reg, flow->base + DP_COM_CONF);
+
+		ipu_srm_dp_sync_update(priv->ipu);
+	}
+
+	if (!priv->use_count)
+		ipu_module_disable(priv->ipu, IPU_CONF_DP_EN);
+
+	if (priv->use_count < 0)
+		priv->use_count = 0;
+
+	ipu_put(priv->ipu);
+	mutex_unlock(&priv->mutex);
+}
+EXPORT_SYMBOL_GPL(ipu_dp_disable_channel);
+
+struct ipu_dp *ipu_dp_get(struct ipu_soc *ipu, unsigned int flow)
+{
+	struct ipu_dp_priv *priv = ipu->dp_priv;
+	struct ipu_dp *dp;
+
+	if (flow > 5)
+		return ERR_PTR(-EINVAL);
+
+	if (flow & 1)
+		dp = &priv->flow[flow >> 1].foreground;
+	else
+		dp = &priv->flow[flow >> 1].background;
+
+	if (dp->in_use)
+		return ERR_PTR(-EBUSY);
+
+	dp->in_use = true;
+
+	return dp;
+}
+EXPORT_SYMBOL_GPL(ipu_dp_get);
+
+void ipu_dp_put(struct ipu_dp *dp)
+{
+	dp->in_use = false;
+}
+EXPORT_SYMBOL_GPL(ipu_dp_put);
+
+int ipu_dp_init(struct ipu_soc *ipu, struct device *dev, unsigned long base)
+{
+	struct ipu_dp_priv *priv;
+	int i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	priv->dev = dev;
+	priv->ipu = ipu;
+
+	ipu->dp_priv = priv;
+
+	priv->base = devm_ioremap(dev, base, PAGE_SIZE);
+	if (!priv->base) {
+		kfree(priv);
+		return -ENOMEM;
+	}
+
+	mutex_init(&priv->mutex);
+
+	for (i = 0; i < 3; i++) {
+		priv->flow[i].foreground.foreground = 1;
+		priv->flow[i].base = priv->base + ipu_dp_flow_base[i];
+		priv->flow[i].priv = priv;
+	}
+
+	return 0;
+}
+
+void ipu_dp_exit(struct ipu_soc *ipu)
+{
+}
-- 
1.7.5.3
