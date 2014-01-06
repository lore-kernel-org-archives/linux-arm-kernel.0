From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  7 Jan 2014 00:47:06 +0100
Subject: [PATCH RFC RFT 1/2] Power: Reset: Generalize qnap-poweroff to with on
 Synology devices.
In-Reply-To: <1389052027-16819-1-git-send-email-andrew@lunn.ch>
References: <1389052027-16819-1-git-send-email-andrew@lunn.ch>
Message-ID: <1389052027-16819-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Synology NAS devices use a very similar mechanism to QNAP NAS
devices to power off. Both send a single charactor command to a PIC,
over the second serial port. However the baud rate and the command
differ. Generalize the driver to support this.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../bindings/power_supply/qnap-poweroff.txt        |    5 ++-
 drivers/power/reset/qnap-poweroff.c                |   46 +++++++++++++++-----
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt b/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
index 0347d8350d94..4ac3ee80dead 100644
--- a/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
+++ b/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
@@ -6,8 +6,11 @@ Orion5x SoCs. Sending the character 'A', at 19200 baud, tells the
 microcontroller to turn the power off. This driver adds a handler to
 pm_power_off which is called to turn the power off.
 
+Synology NAS devices use a similar scheme, but a different baud rate,
+9660, and a different character, 1.
+
 Required Properties:
-- compatible: Should be "qnap,power-off"
+- compatible: Should be "qnap,power-off" or "synology,power-off"
 
 - reg: Address and length of the register set for UART1
 - clocks: tclk clock
diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index 37f56f7ee926..10c91fa2466c 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -1,5 +1,5 @@
 /*
- * QNAP Turbo NAS Board power off
+ * QNAP Turbo NAS Board power off. Can also be used on Synology devices.
  *
  * Copyright (C) 2012 Andrew Lunn <andrew@lunn.ch>
  *
@@ -25,17 +25,42 @@
 
 #define UART1_REG(x)	(base + ((UART_##x) << 2))
 
+struct power_off_cfg {
+	u32 baud;
+	char cmd;
+};
+
+static const struct power_off_cfg qnap_power_off_cfg = {
+	.baud = 19200,
+	.cmd = 'A',
+};
+
+static const struct power_off_cfg synology_power_off_cfg = {
+	.baud = 9600,
+	.cmd = '1',
+};
+
+static const struct of_device_id qnap_power_off_of_match_table[] = {
+	{ .compatible = "qnap,power-off",
+	  .data = (void *) &qnap_power_off_cfg,
+	},
+	{ .compatible = "synology,power-off",
+	  .data = (void *) &synology_power_off_cfg,
+	},
+	{}
+};
+
 static void __iomem *base;
 static unsigned long tclk;
+static struct power_off_cfg *cfg;
 
 static void qnap_power_off(void)
 {
-	/* 19200 baud divisor */
-	const unsigned divisor = ((tclk + (8 * 19200)) / (16 * 19200));
+	const unsigned divisor = ((tclk + (8 * cfg->baud)) / (16 * cfg->baud));
 
 	pr_err("%s: triggering power-off...\n", __func__);
 
-	/* hijack UART1 and reset into sane state (19200,8n1) */
+	/* hijack UART1 and reset into sane state */
 	writel(0x83, UART1_REG(LCR));
 	writel(divisor & 0xff, UART1_REG(DLL));
 	writel((divisor >> 8) & 0xff, UART1_REG(DLM));
@@ -44,16 +69,21 @@ static void qnap_power_off(void)
 	writel(0x00, UART1_REG(FCR));
 	writel(0x00, UART1_REG(MCR));
 
-	/* send the power-off command 'A' to PIC */
-	writel('A', UART1_REG(TX));
+	/* send the power-off command to PIC */
+	writel(cfg->cmd, UART1_REG(TX));
 }
 
 static int qnap_power_off_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct resource *res;
 	struct clk *clk;
 	char symname[KSYM_NAME_LEN];
 
+	const struct of_device_id *match =
+		of_match_node(qnap_power_off_of_match_table, np);
+	cfg = (struct power_off_cfg *)match->data;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "Missing resource");
@@ -94,10 +124,6 @@ static int qnap_power_off_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id qnap_power_off_of_match_table[] = {
-	{ .compatible = "qnap,power-off", },
-	{}
-};
 MODULE_DEVICE_TABLE(of, qnap_power_off_of_match_table);
 
 static struct platform_driver qnap_power_off_driver = {
-- 
1.7.10.4
