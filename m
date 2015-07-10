From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Fri, 10 Jul 2015 20:10:14 +0530
Subject: [PATCH v2] i2c: removed work arounds in i2c driver for Zynq
 Ultrascale+ MPSoC
Message-ID: <1436539214-21536-1-git-send-email-anuragku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cadence 1.0 version has bugs which have been fixed in the cadence 1.4 version.
This patch removes the quirks present in the driver for cadence 1.4 version.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
---
 Changes in v2:
	1.Changed the commit message.
	2.Changed the compatible string description in devicetree binding Documentation.
	3.Used BIT(0) in macro and moved "};" to next line in r1p10_i2c_def platform data. 
---
 .../devicetree/bindings/i2c/i2c-cadence.txt        |    6 ++-
 drivers/i2c/busses/i2c-cadence.c                   |   68 ++++++++++++++++---
 2 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-cadence.txt b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
index 7cb0b56..ebaa90c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
@@ -2,7 +2,11 @@ Binding for the Cadence I2C controller
 
 Required properties:
   - reg: Physical base address and size of the controller's register area.
-  - compatible: Compatibility string. Must be 'cdns,i2c-r1p10'.
+  - compatible: Should contain one of:
+		* "cdns,i2c-r1p10"
+		Note:	Use this when cadence i2c controller version 1.0 is used.
+		* "cdns,i2c-r1p14"
+		Note:	Use this when cadence i2c controller version 1.4 is used.
   - clocks: Input clock specifier. Refer to common clock bindings.
   - interrupts: Interrupt specifier. Refer to interrupt bindings.
   - #address-cells: Should be 1.
diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 2ee78e0..5df288b 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 /* Register offsets for the I2C device. */
 #define CDNS_I2C_CR_OFFSET		0x00 /* Control Register, RW */
@@ -113,6 +114,8 @@
 
 #define CDNS_I2C_TIMEOUT_MAX	0xFF
 
+#define CDNS_I2C_BROKEN_HOLD_BIT	BIT(0)
+
 #define cdns_i2c_readreg(offset)       readl_relaxed(id->membase + offset)
 #define cdns_i2c_writereg(val, offset) writel_relaxed(val, id->membase + offset)
 
@@ -135,6 +138,7 @@
  * @bus_hold_flag:	Flag used in repeated start for clearing HOLD bit
  * @clk:		Pointer to struct clk
  * @clk_rate_change_nb:	Notifier block for clock rate changes
+ * @quirks:		flag for broken hold bit usage in r1p10
  */
 struct cdns_i2c {
 	void __iomem *membase;
@@ -154,6 +158,11 @@ struct cdns_i2c {
 	unsigned int bus_hold_flag;
 	struct clk *clk;
 	struct notifier_block clk_rate_change_nb;
+	u32 quirks;
+};
+
+struct cdns_platform_data {
+	u32 quirks;
 };
 
 #define to_cdns_i2c(_nb)	container_of(_nb, struct cdns_i2c, \
@@ -172,6 +181,12 @@ static void cdns_i2c_clear_bus_hold(struct cdns_i2c *id)
 		cdns_i2c_writereg(reg & ~CDNS_I2C_CR_HOLD, CDNS_I2C_CR_OFFSET);
 }
 
+static inline bool cdns_is_holdquirk(struct cdns_i2c *id, bool hold_wrkaround)
+{
+	return (hold_wrkaround &&
+		(id->curr_recv_count == CDNS_I2C_FIFO_DEPTH + 1));
+}
+
 /**
  * cdns_i2c_isr - Interrupt handler for the I2C device
  * @irq:	irq number for the I2C device
@@ -186,6 +201,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 {
 	unsigned int isr_status, avail_bytes, updatetx;
 	unsigned int bytes_to_send;
+	bool hold_quirk;
 	struct cdns_i2c *id = ptr;
 	/* Signal completion only after everything is updated */
 	int done_flag = 0;
@@ -208,6 +224,8 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 	if (id->recv_count > id->curr_recv_count)
 		updatetx = 1;
 
+	hold_quirk = (id->quirks & CDNS_I2C_BROKEN_HOLD_BIT) && updatetx;
+
 	/* When receiving, handle data interrupt and completion interrupt */
 	if (id->p_recv_buf &&
 	    ((isr_status & CDNS_I2C_IXR_COMP) ||
@@ -229,8 +247,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 			id->recv_count--;
 			id->curr_recv_count--;
 
-			if (updatetx &&
-			    (id->curr_recv_count == CDNS_I2C_FIFO_DEPTH + 1))
+			if (cdns_is_holdquirk(id, hold_quirk))
 				break;
 		}
 
@@ -241,8 +258,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 		 * maintain transfer size non-zero while performing a large
 		 * receive operation.
 		 */
-		if (updatetx &&
-		    (id->curr_recv_count == CDNS_I2C_FIFO_DEPTH + 1)) {
+		if (cdns_is_holdquirk(id, hold_quirk)) {
 			/* wait while fifo is full */
 			while (cdns_i2c_readreg(CDNS_I2C_XFER_SIZE_OFFSET) !=
 			       (id->curr_recv_count - CDNS_I2C_FIFO_DEPTH))
@@ -264,6 +280,22 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 						  CDNS_I2C_XFER_SIZE_OFFSET);
 				id->curr_recv_count = id->recv_count;
 			}
+		} else if (id->recv_count && !hold_quirk &&
+						!id->curr_recv_count) {
+
+			/* Set the slave address in address register*/
+			cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
+						CDNS_I2C_ADDR_OFFSET);
+
+			if (id->recv_count > CDNS_I2C_TRANSFER_SIZE) {
+				cdns_i2c_writereg(CDNS_I2C_TRANSFER_SIZE,
+						CDNS_I2C_XFER_SIZE_OFFSET);
+				id->curr_recv_count = CDNS_I2C_TRANSFER_SIZE;
+			} else {
+				cdns_i2c_writereg(id->recv_count,
+						CDNS_I2C_XFER_SIZE_OFFSET);
+				id->curr_recv_count = id->recv_count;
+			}
 		}
 
 		/* Clear hold (if not repeated start) and signal completion */
@@ -535,11 +567,13 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	int ret, count;
 	u32 reg;
 	struct cdns_i2c *id = adap->algo_data;
+	bool hold_quirk;
 
 	/* Check if the bus is free */
 	if (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) & CDNS_I2C_SR_BA)
 		return -EAGAIN;
 
+	hold_quirk = !!(id->quirks & CDNS_I2C_BROKEN_HOLD_BIT);
 	/*
 	 * Set the flag to one when multiple messages are to be
 	 * processed with a repeated start.
@@ -552,7 +586,7 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		 * followed by any other message, an error is returned
 		 * indicating that this sequence is not supported.
 		 */
-		for (count = 0; count < num - 1; count++) {
+		for (count = 0; (count < num - 1 && hold_quirk); count++) {
 			if (msgs[count].flags & I2C_M_RD) {
 				dev_warn(adap->dev.parent,
 					 "Can't do repeated start after a receive message\n");
@@ -815,6 +849,17 @@ static int __maybe_unused cdns_i2c_resume(struct device *_dev)
 static SIMPLE_DEV_PM_OPS(cdns_i2c_dev_pm_ops, cdns_i2c_suspend,
 			 cdns_i2c_resume);
 
+static const struct cdns_platform_data r1p10_i2c_def = {
+				.quirks = CDNS_I2C_BROKEN_HOLD_BIT,
+				};
+
+static const struct of_device_id cdns_i2c_of_match[] = {
+	{ .compatible = "cdns,i2c-r1p10", .data = &r1p10_i2c_def },
+	{ .compatible = "cdns,i2c-r1p14",},
+	{ /* end of table */ }
+};
+MODULE_DEVICE_TABLE(of, cdns_i2c_of_match);
+
 /**
  * cdns_i2c_probe - Platform registration call
  * @pdev:	Handle to the platform device structure
@@ -830,6 +875,7 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 	struct resource *r_mem;
 	struct cdns_i2c *id;
 	int ret;
+	const struct of_device_id *match;
 
 	id = devm_kzalloc(&pdev->dev, sizeof(*id), GFP_KERNEL);
 	if (!id)
@@ -837,6 +883,12 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, id);
 
+	match = of_match_node(cdns_i2c_of_match, pdev->dev.of_node);
+	if (match && match->data) {
+		const struct cdns_platform_data *data = match->data;
+		id->quirks = data->quirks;
+	}
+
 	r_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	id->membase = devm_ioremap_resource(&pdev->dev, r_mem);
 	if (IS_ERR(id->membase))
@@ -935,12 +987,6 @@ static int cdns_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id cdns_i2c_of_match[] = {
-	{ .compatible = "cdns,i2c-r1p10", },
-	{ /* end of table */ }
-};
-MODULE_DEVICE_TABLE(of, cdns_i2c_of_match);
-
 static struct platform_driver cdns_i2c_drv = {
 	.driver = {
 		.name  = DRIVER_NAME,
-- 
1.7.4
