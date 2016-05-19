From: austinwc@codeaurora.org (Austin Christ)
Date: Thu, 19 May 2016 15:44:27 -0600
Subject: [PATCH v3 1/2] i2c: qup: add ACPI support
Message-ID: <1463694268-9473-1-git-send-email-austinwc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Kaje <nkaje@codeaurora.org>

Add support to get the device parameters from ACPI. Assume
that the clocks are managed by firmware.

Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
Signed-off-by: Austin Christ <austinwc@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 60 ++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 16 deletions(-)

Changes:
- v3:
 - clean up unused variable
- v2:
 - clean up redundant checks and variables

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index dddd4da..ea6ca5f 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -29,6 +29,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
+#include <linux/acpi.h>
 
 /* QUP Registers */
 #define QUP_CONFIG		0x000
@@ -132,6 +133,10 @@
 /* Max timeout in ms for 32k bytes */
 #define TOUT_MAX			300
 
+/* Default values. Use these if FW query fails */
+#define DEFAULT_CLK_FREQ 100000
+#define DEFAULT_SRC_CLK 20000000
+
 struct qup_i2c_block {
 	int	count;
 	int	pos;
@@ -1354,14 +1359,13 @@ static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
 static int qup_i2c_probe(struct platform_device *pdev)
 {
 	static const int blk_sizes[] = {4, 16, 32};
-	struct device_node *node = pdev->dev.of_node;
 	struct qup_i2c_dev *qup;
 	unsigned long one_bit_t;
 	struct resource *res;
 	u32 io_mode, hw_ver, size;
 	int ret, fs_div, hs_div;
-	int src_clk_freq;
-	u32 clk_freq = 100000;
+	u32 src_clk_freq = 0;
+	u32 clk_freq = 0;
 	int blocks;
 
 	qup = devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
@@ -1372,7 +1376,12 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	init_completion(&qup->xfer);
 	platform_set_drvdata(pdev, qup);
 
-	of_property_read_u32(node, "clock-frequency", &clk_freq);
+	ret = device_property_read_u32(qup->dev, "clock-frequency", &clk_freq);
+	if (ret) {
+		dev_warn(qup->dev, "using default clock-frequency %d",
+			DEFAULT_CLK_FREQ);
+		clk_freq = DEFAULT_CLK_FREQ;
+	}
 
 	if (of_device_is_compatible(pdev->dev.of_node, "qcom,i2c-qup-v1.1.1")) {
 		qup->adap.algo = &qup_i2c_algo;
@@ -1454,20 +1463,31 @@ nodma:
 		return qup->irq;
 	}
 
-	qup->clk = devm_clk_get(qup->dev, "core");
-	if (IS_ERR(qup->clk)) {
-		dev_err(qup->dev, "Could not get core clock\n");
-		return PTR_ERR(qup->clk);
-	}
+	if (ACPI_HANDLE(qup->dev)) {
+		ret = device_property_read_u32(qup->dev,
+				"src-clock-hz", &src_clk_freq);
+		if (ret) {
+			dev_warn(qup->dev, "using default src-clock-hz %d",
+				DEFAULT_SRC_CLK);
+			src_clk_freq = DEFAULT_SRC_CLK;
+		}
+		ACPI_COMPANION_SET(&qup->adap.dev, ACPI_COMPANION(qup->dev));
+	} else {
+		qup->clk = devm_clk_get(qup->dev, "core");
+		if (IS_ERR(qup->clk)) {
+			dev_err(qup->dev, "Could not get core clock\n");
+			return PTR_ERR(qup->clk);
+		}
 
-	qup->pclk = devm_clk_get(qup->dev, "iface");
-	if (IS_ERR(qup->pclk)) {
-		dev_err(qup->dev, "Could not get iface clock\n");
-		return PTR_ERR(qup->pclk);
+		qup->pclk = devm_clk_get(qup->dev, "iface");
+		if (IS_ERR(qup->pclk)) {
+			dev_err(qup->dev, "Could not get iface clock\n");
+			return PTR_ERR(qup->pclk);
+		}
+		qup_i2c_enable_clocks(qup);
+		src_clk_freq = clk_get_rate(qup->clk);
 	}
 
-	qup_i2c_enable_clocks(qup);
-
 	/*
 	 * Bootloaders might leave a pending interrupt on certain QUP's,
 	 * so we reset the core before registering for interrupts.
@@ -1514,7 +1534,6 @@ nodma:
 	size = QUP_INPUT_FIFO_SIZE(io_mode);
 	qup->in_fifo_sz = qup->in_blk_sz * (2 << size);
 
-	src_clk_freq = clk_get_rate(qup->clk);
 	fs_div = ((src_clk_freq / clk_freq) / 2) - 3;
 	hs_div = 3;
 	qup->clk_ctl = (hs_div << 8) | (fs_div & 0xff);
@@ -1639,6 +1658,14 @@ static const struct of_device_id qup_i2c_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, qup_i2c_dt_match);
 
+#if IS_ENABLED(CONFIG_ACPI)
+static const struct acpi_device_id qup_i2c_acpi_match[] = {
+	{ "QCOM8010"},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, qup_i2c_acpi_ids);
+#endif
+
 static struct platform_driver qup_i2c_driver = {
 	.probe  = qup_i2c_probe,
 	.remove = qup_i2c_remove,
@@ -1646,6 +1673,7 @@ static struct platform_driver qup_i2c_driver = {
 		.name = "i2c_qup",
 		.pm = &qup_i2c_qup_pm_ops,
 		.of_match_table = qup_i2c_dt_match,
+		.acpi_match_table = ACPI_PTR(qup_i2c_acpi_match),
 	},
 };
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
