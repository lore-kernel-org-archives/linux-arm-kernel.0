From: net147@gmail.com (Jonathan Liu)
Date: Mon, 12 Jun 2017 15:52:35 +1000
Subject: [PATCH v2] drm/sun4i: hdmi: Implement I2C adapter for A10s DDC bus
Message-ID: <20170612055235.31019-1-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drm_get_edid function should be used instead of drm_do_get_edid by
exposing the DDC bus as an I2C adapter. Implement this for A10s.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
Changes for v2:
 - Rebased against Maxime's sunxi-drm/for-next branch
 - Fix up error paths in sun4i_hdmi_bind so that the I2C adapter is deleted if
   any of the calls after the I2C adapter is created fails
 - Remove unnecessary includes in sun4i_hdmi_i2c.c

 drivers/gpu/drm/sun4i/Makefile         |   1 +
 drivers/gpu/drm/sun4i/sun4i_hdmi.h     |  11 ++-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 103 +++------------------
 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c | 163 +++++++++++++++++++++++++++++++++
 4 files changed, 189 insertions(+), 89 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index e29fd3a2ba9c..43c753cafc88 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -2,6 +2,7 @@ sun4i-drm-y += sun4i_drv.o
 sun4i-drm-y += sun4i_framebuffer.o
 
 sun4i-drm-hdmi-y += sun4i_hdmi_enc.o
+sun4i-drm-hdmi-y += sun4i_hdmi_i2c.o
 sun4i-drm-hdmi-y += sun4i_hdmi_ddc_clk.o
 sun4i-drm-hdmi-y += sun4i_hdmi_tmds_clk.o
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
index 2f2f2ff1ea63..4c01dbe89cd9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
@@ -97,6 +97,7 @@
 #define SUN4I_HDMI_DDC_CTRL_START_CMD		BIT(30)
 #define SUN4I_HDMI_DDC_CTRL_FIFO_DIR_MASK	BIT(8)
 #define SUN4I_HDMI_DDC_CTRL_FIFO_DIR_READ	(0 << 8)
+#define SUN4I_HDMI_DDC_CTRL_FIFO_DIR_WRITE	(1 << 8)
 #define SUN4I_HDMI_DDC_CTRL_RESET		BIT(0)
 
 #define SUN4I_HDMI_DDC_ADDR_REG		0x504
@@ -105,6 +106,10 @@
 #define SUN4I_HDMI_DDC_ADDR_OFFSET(off)		(((off) & 0xff) << 8)
 #define SUN4I_HDMI_DDC_ADDR_SLAVE(addr)		((addr) & 0xff)
 
+#define SUN4I_HDMI_DDC_INTERRUPT_STATUS_REG	0x50c
+#define SUN4I_HDMI_DDC_INTERRUPT_STATUS_FIFO_REQUEST	BIT(4)
+#define SUN4I_HDMI_DDC_INTERRUPT_STATUS_TRANSFER_COMPLETE	BIT(0)
+
 #define SUN4I_HDMI_DDC_FIFO_CTRL_REG	0x510
 #define SUN4I_HDMI_DDC_FIFO_CTRL_CLEAR		BIT(31)
 
@@ -112,7 +117,8 @@
 #define SUN4I_HDMI_DDC_BYTE_COUNT_REG	0x51c
 
 #define SUN4I_HDMI_DDC_CMD_REG		0x520
-#define SUN4I_HDMI_DDC_CMD_EXPLICIT_EDDC_READ	6
+#define SUN4I_HDMI_DDC_CMD_IMPLICIT_WRITE	3
+#define SUN4I_HDMI_DDC_CMD_IMPLICIT_READ	5
 
 #define SUN4I_HDMI_DDC_CLK_REG		0x528
 #define SUN4I_HDMI_DDC_CLK_M(m)			(((m) & 0x7) << 3)
@@ -146,6 +152,8 @@ struct sun4i_hdmi {
 	struct clk		*ddc_clk;
 	struct clk		*tmds_clk;
 
+	struct i2c_adapter	*i2c;
+
 	struct sun4i_drv	*drv;
 
 	bool			hdmi_monitor;
@@ -153,5 +161,6 @@ struct sun4i_hdmi {
 
 int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *clk);
 int sun4i_tmds_create(struct sun4i_hdmi *hdmi);
+int sun4i_hdmi_i2c_create(struct sun4i_hdmi *hdmi);
 
 #endif /* _SUN4I_HDMI_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index d3398f6250ef..2a8c0b14eabc 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -29,8 +29,6 @@
 #include "sun4i_hdmi.h"
 #include "sun4i_tcon.h"
 
-#define DDC_SEGMENT_ADDR	0x30
-
 static inline struct sun4i_hdmi *
 drm_encoder_to_sun4i_hdmi(struct drm_encoder *encoder)
 {
@@ -184,93 +182,13 @@ static const struct drm_encoder_funcs sun4i_hdmi_funcs = {
 	.destroy	= drm_encoder_cleanup,
 };
 
-static int sun4i_hdmi_read_sub_block(struct sun4i_hdmi *hdmi,
-				     unsigned int blk, unsigned int offset,
-				     u8 *buf, unsigned int count)
-{
-	unsigned long reg;
-	int i;
-
-	reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
-	reg &= ~SUN4I_HDMI_DDC_CTRL_FIFO_DIR_MASK;
-	writel(reg | SUN4I_HDMI_DDC_CTRL_FIFO_DIR_READ,
-	       hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
-
-	writel(SUN4I_HDMI_DDC_ADDR_SEGMENT(offset >> 8) |
-	       SUN4I_HDMI_DDC_ADDR_EDDC(DDC_SEGMENT_ADDR << 1) |
-	       SUN4I_HDMI_DDC_ADDR_OFFSET(offset) |
-	       SUN4I_HDMI_DDC_ADDR_SLAVE(DDC_ADDR),
-	       hdmi->base + SUN4I_HDMI_DDC_ADDR_REG);
-
-	reg = readl(hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
-	writel(reg | SUN4I_HDMI_DDC_FIFO_CTRL_CLEAR,
-	       hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
-
-	writel(count, hdmi->base + SUN4I_HDMI_DDC_BYTE_COUNT_REG);
-	writel(SUN4I_HDMI_DDC_CMD_EXPLICIT_EDDC_READ,
-	       hdmi->base + SUN4I_HDMI_DDC_CMD_REG);
-
-	reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
-	writel(reg | SUN4I_HDMI_DDC_CTRL_START_CMD,
-	       hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
-
-	if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG, reg,
-			       !(reg & SUN4I_HDMI_DDC_CTRL_START_CMD),
-			       100, 100000))
-		return -EIO;
-
-	for (i = 0; i < count; i++)
-		buf[i] = readb(hdmi->base + SUN4I_HDMI_DDC_FIFO_DATA_REG);
-
-	return 0;
-}
-
-static int sun4i_hdmi_read_edid_block(void *data, u8 *buf, unsigned int blk,
-				      size_t length)
-{
-	struct sun4i_hdmi *hdmi = data;
-	int retry = 2, i;
-
-	do {
-		for (i = 0; i < length; i += SUN4I_HDMI_DDC_FIFO_SIZE) {
-			unsigned char offset = blk * EDID_LENGTH + i;
-			unsigned int count = min((unsigned int)SUN4I_HDMI_DDC_FIFO_SIZE,
-						 length - i);
-			int ret;
-
-			ret = sun4i_hdmi_read_sub_block(hdmi, blk, offset,
-							buf + i, count);
-			if (ret)
-				return ret;
-		}
-	} while (!drm_edid_block_valid(buf, blk, true, NULL) && (retry--));
-
-	return 0;
-}
-
 static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 {
 	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
-	unsigned long reg;
 	struct edid *edid;
 	int ret;
 
-	/* Reset i2c controller */
-	writel(SUN4I_HDMI_DDC_CTRL_ENABLE | SUN4I_HDMI_DDC_CTRL_RESET,
-	       hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
-	if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG, reg,
-			       !(reg & SUN4I_HDMI_DDC_CTRL_RESET),
-			       100, 2000))
-		return -EIO;
-
-	writel(SUN4I_HDMI_DDC_LINE_CTRL_SDA_ENABLE |
-	       SUN4I_HDMI_DDC_LINE_CTRL_SCL_ENABLE,
-	       hdmi->base + SUN4I_HDMI_DDC_LINE_CTRL_REG);
-
-	clk_prepare_enable(hdmi->ddc_clk);
-	clk_set_rate(hdmi->ddc_clk, 100000);
-
-	edid = drm_do_get_edid(connector, sun4i_hdmi_read_edid_block, hdmi);
+	edid = drm_get_edid(connector, hdmi->i2c);
 	if (!edid)
 		return 0;
 
@@ -282,8 +200,6 @@ static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 	ret = drm_add_edid_modes(connector, edid);
 	kfree(edid);
 
-	clk_disable_unprepare(hdmi->ddc_clk);
-
 	return ret;
 }
 
@@ -413,6 +329,12 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	ret = sun4i_hdmi_i2c_create(hdmi);
+	if (ret) {
+		dev_err(dev, "Couldn't create the HDMI I2C adapter\n");
+		return ret;
+	}
+
 	drm_encoder_helper_add(&hdmi->encoder,
 			       &sun4i_hdmi_helper_funcs);
 	ret = drm_encoder_init(drm,
@@ -422,13 +344,15 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 			       NULL);
 	if (ret) {
 		dev_err(dev, "Couldn't initialise the HDMI encoder\n");
-		return ret;
+		goto err_del_i2c_adapter;
 	}
 
 	hdmi->encoder.possible_crtcs = drm_of_find_possible_crtcs(drm,
 								  dev->of_node);
-	if (!hdmi->encoder.possible_crtcs)
-		return -EPROBE_DEFER;
+	if (!hdmi->encoder.possible_crtcs) {
+		ret = -EPROBE_DEFER;
+		goto err_del_i2c_adapter;
+	}
 
 	drm_connector_helper_add(&hdmi->connector,
 				 &sun4i_hdmi_connector_helper_funcs);
@@ -451,6 +375,8 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 
 err_cleanup_connector:
 	drm_encoder_cleanup(&hdmi->encoder);
+err_del_i2c_adapter:
+	i2c_del_adapter(hdmi->i2c);
 	return ret;
 }
 
@@ -461,6 +387,7 @@ static void sun4i_hdmi_unbind(struct device *dev, struct device *master,
 
 	drm_connector_cleanup(&hdmi->connector);
 	drm_encoder_cleanup(&hdmi->encoder);
+	i2c_del_adapter(hdmi->i2c);
 }
 
 static const struct component_ops sun4i_hdmi_ops = {
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
new file mode 100644
index 000000000000..389b770be09b
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
@@ -0,0 +1,163 @@
+/*
+ * Copyright (C) 2017 Jonathan Liu
+ *
+ * Jonathan Liu <net147@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/i2c.h>
+#include <linux/iopoll.h>
+
+#include "sun4i_hdmi.h"
+
+static int xfer_msg_chunk(struct sun4i_hdmi *hdmi, struct i2c_msg *msg)
+{
+	u32 count = min_t(u32, msg->len, SUN4I_HDMI_DDC_FIFO_SIZE);
+	u32 reg;
+	int i;
+
+	reg = readl(hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
+	writel(reg | SUN4I_HDMI_DDC_FIFO_CTRL_CLEAR,
+	       hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
+
+	writel(count, hdmi->base
+	       + SUN4I_HDMI_DDC_BYTE_COUNT_REG);
+	writel(msg->flags & I2C_M_RD
+	       ? SUN4I_HDMI_DDC_CMD_IMPLICIT_READ
+	       : SUN4I_HDMI_DDC_CMD_IMPLICIT_WRITE,
+	       hdmi->base + SUN4I_HDMI_DDC_CMD_REG);
+
+	reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
+	writel(reg | SUN4I_HDMI_DDC_CTRL_START_CMD,
+	       hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
+
+	if (!(msg->flags & I2C_M_RD)) {
+		for (i = 0; i < count; i++) {
+			writeb(*msg->buf++, hdmi->base
+			       + SUN4I_HDMI_DDC_FIFO_DATA_REG);
+			--msg->len;
+		}
+	}
+
+	if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG,
+			       reg,
+			       !(reg & SUN4I_HDMI_DDC_CTRL_START_CMD),
+			       100, 100000))
+		return -EIO;
+
+	reg = readl(hdmi->base + SUN4I_HDMI_DDC_INTERRUPT_STATUS_REG);
+	reg &= ~SUN4I_HDMI_DDC_INTERRUPT_STATUS_FIFO_REQUEST;
+
+	if (reg != SUN4I_HDMI_DDC_INTERRUPT_STATUS_TRANSFER_COMPLETE)
+		return -EIO;
+
+	if (msg->flags & I2C_M_RD) {
+		for (i = 0; i < count; i++) {
+			*msg->buf++ = readb(hdmi->base
+					    + SUN4I_HDMI_DDC_FIFO_DATA_REG);
+			--msg->len;
+		}
+	}
+
+	return 0;
+}
+
+static int xfer_msg(struct sun4i_hdmi *hdmi, struct i2c_msg *msg)
+{
+	u32 reg;
+	int ret;
+
+	if (!msg->len)
+		return -EIO;
+
+	while (msg->len) {
+		reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
+		reg &= ~SUN4I_HDMI_DDC_CTRL_FIFO_DIR_MASK;
+
+		writel(reg | (msg->flags & I2C_M_RD
+			      ? SUN4I_HDMI_DDC_CTRL_FIFO_DIR_READ
+			      : SUN4I_HDMI_DDC_CTRL_FIFO_DIR_WRITE),
+		       hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
+
+		writel(SUN4I_HDMI_DDC_ADDR_SLAVE(msg->addr),
+		       hdmi->base + SUN4I_HDMI_DDC_ADDR_REG);
+
+		ret = xfer_msg_chunk(hdmi, msg);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int sun4i_hdmi_i2c_xfer(struct i2c_adapter *adap,
+			       struct i2c_msg *msgs, int num)
+{
+	struct sun4i_hdmi *hdmi = i2c_get_adapdata(adap);
+	u32 reg;
+	int err, ret = num;
+	int i;
+
+	/* Reset i2c controller */
+	writel(SUN4I_HDMI_DDC_CTRL_ENABLE | SUN4I_HDMI_DDC_CTRL_RESET,
+	       hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
+	if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG, reg,
+			       !(reg & SUN4I_HDMI_DDC_CTRL_RESET),
+			       100, 2000))
+		return -EIO;
+
+	writel(SUN4I_HDMI_DDC_LINE_CTRL_SDA_ENABLE |
+	       SUN4I_HDMI_DDC_LINE_CTRL_SCL_ENABLE,
+	       hdmi->base + SUN4I_HDMI_DDC_LINE_CTRL_REG);
+
+	clk_prepare_enable(hdmi->ddc_clk);
+	clk_set_rate(hdmi->ddc_clk, 100000);
+
+	for (i = 0; i < num; i++) {
+		err = xfer_msg(hdmi, &msgs[i]);
+		if (err) {
+			ret = err;
+			break;
+		}
+	}
+
+	clk_disable_unprepare(hdmi->ddc_clk);
+	return ret;
+}
+
+static u32 sun4i_hdmi_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm sun4i_hdmi_i2c_algorithm = {
+	.master_xfer	= sun4i_hdmi_i2c_xfer,
+	.functionality	= sun4i_hdmi_i2c_func,
+};
+
+static struct i2c_adapter sun4i_hdmi_i2c_adapter = {
+	.owner	= THIS_MODULE,
+	.class	= I2C_CLASS_DDC,
+	.algo	= &sun4i_hdmi_i2c_algorithm,
+	.name	= "sun4i_hdmi_i2c adapter",
+};
+
+int sun4i_hdmi_i2c_create(struct sun4i_hdmi *hdmi)
+{
+	int ret = 0;
+
+	i2c_set_adapdata(&sun4i_hdmi_i2c_adapter, hdmi);
+
+	ret = i2c_add_adapter(&sun4i_hdmi_i2c_adapter);
+	if (ret)
+		return ret;
+
+	hdmi->i2c = &sun4i_hdmi_i2c_adapter;
+
+	return ret;
+}
-- 
2.12.2
