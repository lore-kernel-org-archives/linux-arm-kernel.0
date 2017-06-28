From: net147@gmail.com (Jonathan Liu)
Date: Wed, 28 Jun 2017 20:41:53 +1000
Subject: [PATCH v6] drm/sun4i: hdmi: Implement I2C adapter for A10s DDC bus
Message-ID: <20170628104153.27066-1-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The documentation for drm_do_get_edid in drivers/gpu/drm/drm_edid.c states:
"As in the general case the DDC bus is accessible by the kernel at the I2C
level, drivers must make all reasonable efforts to expose it as an I2C
adapter and use drm_get_edid() instead of abusing this function."

Exposing the DDC bus as an I2C adapter is more beneficial as it can be used
for purposes other than reading the EDID such as modifying the EDID or
using the HDMI DDC pins as an I2C bus through the I2C dev interface from
userspace (e.g. i2c-tools).

Implement this for A10s.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
Changes for v6:
 - Use fixed byte time of 100 us instead of dynamically calculating from DDC
   clock that is set to a fixed 100 MHz rate anyway
 - Change is_fifo_flag_unset to not read the status register as well to be
   more consistent with is_err_status

Changes for v5:
 - Use devm_kzalloc instead of devm_kmemdup and remove const struct i2c_adapter
 - Rework to use readl_poll_timeout for checking FIFO status

Changes for v4:
 - Carry over copyright from initial I2C code into sun4i_hdmi_i2c.c
 - Clean up indentation in sun4i_hdmi.h
 - Rename SUN4I_HDMI_DDC_MAX_TRANSFER_SIZE to SUN4I_HDMI_DDC_BYTE_COUNT_MAX
   and group it under the SUN4I_HDMI_DDC_BYTE_COUNT_REG define, changing the
   value to use the GENMASK macro to make it clear that it is derived from
   the width of the field in the register
 - Fix SUN4I_HDMI_DDC_INT_STATUS_DDC_TX_FIFO_UNDERFLOW typo which should be
   SUN4I_HDMI_DDC_INT_STATUS_DDC_TX_FIFO_OVERFLOW
 - Remove redundant rewriting of SUN4I_HDMI_DDC_INT_STATUS_REG register
 - Change struct i2c_adapter to be const by using devm_kmemdup on creation
 - Return -ETIMEDOUT instead of -EIO if there is timeout while transferring an
   I2C message
 - Instead of waiting for 1-2 bytes to transfer, wait for the time it would
   take for remaining bytes to transfer (limited by FIFO size)
 - Add additional comments

Changes for v3:
 - Explain why drm_do_get_edid should be used and why it's better to expose it
   as an I2C adapter in commit message
 - Reorder bit defines in descending order for consistency
 - Keep old unused macros instead of removing them
 - The v2 algorithm split large transfers into 16 byte transfers but this may
   cause a large single write to be treated as multiple writes causing data
   corruption. The algorithm has been reworked to not split larger transfers
   and make more use of the FIFO to avoid this.
 - Moved the creation of the DDC clock from sun4i_hdmi_enc.c to
   sun4i_hdmi_i2c.c
 - Reformatted code
 - Instead of masking bits that we don't want to check for errors, explicitly
   check the error bits
 - Clear error bits at start of transfer in case of error from previous transfer
 - Poll for completion of FIFO clear after setting FIFO clear bit

Changes for v2:
 - Rebased against Maxime's sunxi-drm/for-next branch
 - Fix up error paths in sun4i_hdmi_bind so that the I2C adapter is deleted if
   any of the calls after the I2C adapter is created fails
 - Remove unnecessary includes in sun4i_hdmi_i2c.c

 drivers/gpu/drm/sun4i/Makefile         |   1 +
 drivers/gpu/drm/sun4i/sun4i_hdmi.h     |  23 ++++
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 101 ++------------
 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c | 233 +++++++++++++++++++++++++++++++++
 4 files changed, 268 insertions(+), 90 deletions(-)
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
index 2f2f2ff1ea63..eaff92fe236c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
@@ -96,6 +96,7 @@
 #define SUN4I_HDMI_DDC_CTRL_ENABLE		BIT(31)
 #define SUN4I_HDMI_DDC_CTRL_START_CMD		BIT(30)
 #define SUN4I_HDMI_DDC_CTRL_FIFO_DIR_MASK	BIT(8)
+#define SUN4I_HDMI_DDC_CTRL_FIFO_DIR_WRITE	(1 << 8)
 #define SUN4I_HDMI_DDC_CTRL_FIFO_DIR_READ	(0 << 8)
 #define SUN4I_HDMI_DDC_CTRL_RESET		BIT(0)
 
@@ -105,14 +106,33 @@
 #define SUN4I_HDMI_DDC_ADDR_OFFSET(off)		(((off) & 0xff) << 8)
 #define SUN4I_HDMI_DDC_ADDR_SLAVE(addr)		((addr) & 0xff)
 
+#define SUN4I_HDMI_DDC_INT_STATUS_REG		0x50c
+#define SUN4I_HDMI_DDC_INT_STATUS_ILLEGAL_FIFO_OPERATION	BIT(7)
+#define SUN4I_HDMI_DDC_INT_STATUS_DDC_RX_FIFO_UNDERFLOW		BIT(6)
+#define SUN4I_HDMI_DDC_INT_STATUS_DDC_TX_FIFO_OVERFLOW		BIT(5)
+#define SUN4I_HDMI_DDC_INT_STATUS_FIFO_REQUEST			BIT(4)
+#define SUN4I_HDMI_DDC_INT_STATUS_ARBITRATION_ERROR		BIT(3)
+#define SUN4I_HDMI_DDC_INT_STATUS_ACK_ERROR			BIT(2)
+#define SUN4I_HDMI_DDC_INT_STATUS_BUS_ERROR			BIT(1)
+#define SUN4I_HDMI_DDC_INT_STATUS_TRANSFER_COMPLETE		BIT(0)
+
 #define SUN4I_HDMI_DDC_FIFO_CTRL_REG	0x510
 #define SUN4I_HDMI_DDC_FIFO_CTRL_CLEAR		BIT(31)
 
+#define SUN4I_HDMI_DDC_FIFO_STATUS_REG	0x514
+#define SUN4I_HDMI_DDC_FIFO_STATUS_FULL		BIT(6)
+#define SUN4I_HDMI_DDC_FIFO_STATUS_EMPTY	BIT(5)
+#define SUN4I_HDMI_DDC_FIFO_STATUS_LEVEL_MASK	GENMASK(4, 0)
+
 #define SUN4I_HDMI_DDC_FIFO_DATA_REG	0x518
+
 #define SUN4I_HDMI_DDC_BYTE_COUNT_REG	0x51c
+#define SUN4I_HDMI_DDC_BYTE_COUNT_MAX		GENMASK(9, 0)
 
 #define SUN4I_HDMI_DDC_CMD_REG		0x520
 #define SUN4I_HDMI_DDC_CMD_EXPLICIT_EDDC_READ	6
+#define SUN4I_HDMI_DDC_CMD_IMPLICIT_READ	5
+#define SUN4I_HDMI_DDC_CMD_IMPLICIT_WRITE	3
 
 #define SUN4I_HDMI_DDC_CLK_REG		0x528
 #define SUN4I_HDMI_DDC_CLK_M(m)			(((m) & 0x7) << 3)
@@ -146,6 +166,8 @@ struct sun4i_hdmi {
 	struct clk		*ddc_clk;
 	struct clk		*tmds_clk;
 
+	struct i2c_adapter	*i2c;
+
 	struct sun4i_drv	*drv;
 
 	bool			hdmi_monitor;
@@ -153,5 +175,6 @@ struct sun4i_hdmi {
 
 int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *clk);
 int sun4i_tmds_create(struct sun4i_hdmi *hdmi);
+int sun4i_hdmi_i2c_create(struct device *dev, struct sun4i_hdmi *hdmi);
 
 #endif /* _SUN4I_HDMI_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index d3398f6250ef..b74607feb35c 100644
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
 
@@ -407,9 +323,9 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 		SUN4I_HDMI_PLL_CTRL_PLL_EN;
 	writel(reg, hdmi->base + SUN4I_HDMI_PLL_CTRL_REG);
 
-	ret = sun4i_ddc_create(hdmi, hdmi->tmds_clk);
+	ret = sun4i_hdmi_i2c_create(dev, hdmi);
 	if (ret) {
-		dev_err(dev, "Couldn't create the DDC clock\n");
+		dev_err(dev, "Couldn't create the HDMI I2C adapter\n");
 		return ret;
 	}
 
@@ -422,13 +338,15 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
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
@@ -451,6 +369,8 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 
 err_cleanup_connector:
 	drm_encoder_cleanup(&hdmi->encoder);
+err_del_i2c_adapter:
+	i2c_del_adapter(hdmi->i2c);
 	return ret;
 }
 
@@ -461,6 +381,7 @@ static void sun4i_hdmi_unbind(struct device *dev, struct device *master,
 
 	drm_connector_cleanup(&hdmi->connector);
 	drm_encoder_cleanup(&hdmi->encoder);
+	i2c_del_adapter(hdmi->i2c);
 }
 
 static const struct component_ops sun4i_hdmi_ops = {
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
new file mode 100644
index 000000000000..c5f8201e5c90
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
@@ -0,0 +1,233 @@
+/*
+ * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
+ * Copyright (C) 2017 Jonathan Liu <net147@gmail.com>
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
+#include <linux/ktime.h>
+
+#include "sun4i_hdmi.h"
+
+#define SUN4I_HDMI_DDC_INT_STATUS_ERROR_MASK ( \
+	SUN4I_HDMI_DDC_INT_STATUS_ILLEGAL_FIFO_OPERATION | \
+	SUN4I_HDMI_DDC_INT_STATUS_DDC_RX_FIFO_UNDERFLOW | \
+	SUN4I_HDMI_DDC_INT_STATUS_DDC_TX_FIFO_OVERFLOW | \
+	SUN4I_HDMI_DDC_INT_STATUS_ARBITRATION_ERROR | \
+	SUN4I_HDMI_DDC_INT_STATUS_ACK_ERROR | \
+	SUN4I_HDMI_DDC_INT_STATUS_BUS_ERROR \
+)
+
+static u32 read_fifo_status(struct sun4i_hdmi *hdmi)
+{
+	return readl(hdmi->base + SUN4I_HDMI_DDC_FIFO_STATUS_REG);
+}
+
+static bool is_err_status(u32 int_status)
+{
+	return !!(int_status & SUN4I_HDMI_DDC_INT_STATUS_ERROR_MASK);
+}
+
+static bool is_fifo_flag_unset(u32 fifo_status, u32 flag)
+{
+	return !(fifo_status & flag);
+}
+
+static int fifo_transfer(struct sun4i_hdmi *hdmi, u8 *buf, int len, bool read)
+{
+	/*
+	 * 1 byte takes 9 clock cycles (8 bits + 1 ACK) = 90 us for 100 MHz
+	 * clock. As clock rate is fixed, just round it up to 100 us.
+	 */
+	const unsigned long byte_time_ns = 100;
+	u32 int_status;
+	u32 fifo_status;
+	/* Read needs empty flag unset, write needs full flag unset */
+	u32 flag = read ? SUN4I_HDMI_DDC_FIFO_STATUS_EMPTY :
+			  SUN4I_HDMI_DDC_FIFO_STATUS_FULL;
+	int ret;
+
+	/* Wait until error or FIFO ready */
+	ret = readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG,
+				 int_status,
+				 is_err_status(int_status) ||
+				 is_fifo_flag_unset(fifo_status =
+						    read_fifo_status(hdmi),
+						    flag),
+				 min(len, SUN4I_HDMI_DDC_FIFO_SIZE) *
+				 byte_time_ns, 100000);
+
+	if (is_err_status(int_status))
+		return -EIO;
+	if (ret)
+		return -ETIMEDOUT;
+
+	/* Read FIFO level */
+	int level = (int)(fifo_status & SUN4I_HDMI_DDC_FIFO_STATUS_LEVEL_MASK);
+
+	/* Limit transfer length using FIFO level to avoid underflow/overflow */
+	len = min(len, read ? level : (SUN4I_HDMI_DDC_FIFO_SIZE - level));
+
+	if (read)
+		readsb(hdmi->base + SUN4I_HDMI_DDC_FIFO_DATA_REG, buf, len);
+	else
+		writesb(hdmi->base + SUN4I_HDMI_DDC_FIFO_DATA_REG, buf, len);
+
+	return len;
+}
+
+static int xfer_msg(struct sun4i_hdmi *hdmi, struct i2c_msg *msg)
+{
+	int i, len;
+	u32 reg;
+
+	/* Clear errors */
+	reg = readl(hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG);
+	reg &= ~SUN4I_HDMI_DDC_INT_STATUS_ERROR_MASK;
+	writel(reg, hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG);
+
+	/* Set FIFO direction */
+	reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
+	reg &= ~SUN4I_HDMI_DDC_CTRL_FIFO_DIR_MASK;
+	reg |= (msg->flags & I2C_M_RD) ?
+	       SUN4I_HDMI_DDC_CTRL_FIFO_DIR_READ :
+	       SUN4I_HDMI_DDC_CTRL_FIFO_DIR_WRITE;
+	writel(reg, hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
+
+	/* Set I2C address */
+	writel(SUN4I_HDMI_DDC_ADDR_SLAVE(msg->addr),
+	       hdmi->base + SUN4I_HDMI_DDC_ADDR_REG);
+
+	/* Clear FIFO */
+	reg = readl(hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
+	writel(reg | SUN4I_HDMI_DDC_FIFO_CTRL_CLEAR,
+	       hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
+	if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG,
+			       reg,
+			       !(reg & SUN4I_HDMI_DDC_FIFO_CTRL_CLEAR),
+			       100, 100000))
+		return -EIO;
+
+	/* Set transfer length */
+	writel(msg->len, hdmi->base + SUN4I_HDMI_DDC_BYTE_COUNT_REG);
+
+	/* Set command */
+	writel(msg->flags & I2C_M_RD ?
+	       SUN4I_HDMI_DDC_CMD_IMPLICIT_READ :
+	       SUN4I_HDMI_DDC_CMD_IMPLICIT_WRITE,
+	       hdmi->base + SUN4I_HDMI_DDC_CMD_REG);
+
+	/* Start command */
+	reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
+	writel(reg | SUN4I_HDMI_DDC_CTRL_START_CMD,
+	       hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
+
+	/* Transfer bytes */
+	for (i = 0; i < msg->len; i += len) {
+		len = fifo_transfer(hdmi, msg->buf + i, msg->len - i,
+				    msg->flags & I2C_M_RD);
+		if (len <= 0)
+			return len;
+	}
+
+	/* Wait for command to finish */
+	if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG,
+			       reg,
+			       !(reg & SUN4I_HDMI_DDC_CTRL_START_CMD),
+			       100, 100000))
+		return -EIO;
+
+	/* Check for errors */
+	reg = readl(hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG);
+	if ((reg & SUN4I_HDMI_DDC_INT_STATUS_ERROR_MASK) ||
+	    !(reg & SUN4I_HDMI_DDC_INT_STATUS_TRANSFER_COMPLETE)) {
+		return -EIO;
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
+	int err, i, ret = num;
+
+	for (i = 0; i < num; i++) {
+		if (!msgs[i].len)
+			return -EINVAL;
+		if (msgs[i].len > SUN4I_HDMI_DDC_BYTE_COUNT_MAX)
+			return -EINVAL;
+	}
+
+	/* Reset I2C controller */
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
+int sun4i_hdmi_i2c_create(struct device *dev, struct sun4i_hdmi *hdmi)
+{
+	struct i2c_adapter *adap;
+	int ret = 0;
+
+	ret = sun4i_ddc_create(hdmi, hdmi->tmds_clk);
+	if (ret)
+		return ret;
+
+	adap = devm_kzalloc(dev, sizeof(*adap), GFP_KERNEL);
+	if (!adap)
+		return -ENOMEM;
+
+	adap->owner = THIS_MODULE;
+	adap->class = I2C_CLASS_DDC;
+	adap->algo = &sun4i_hdmi_i2c_algorithm;
+	strlcpy(adap->name, "sun4i_hdmi_i2c adapter", sizeof(adap->name));
+	i2c_set_adapdata(adap, hdmi);
+
+	ret = i2c_add_adapter(adap);
+	if (ret)
+		return ret;
+
+	hdmi->i2c = adap;
+
+	return ret;
+}
-- 
2.13.1
