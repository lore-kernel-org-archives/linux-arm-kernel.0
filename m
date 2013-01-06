From: anton@enomsg.org (Anton Vorontsov)
Date: Sun, 6 Jan 2013 13:55:09 -0800
Subject: [PATCH 1/4] Power: Reset: Driver to turn QNAP board power off.
In-Reply-To: <1356697512-3950-2-git-send-email-andrew@lunn.ch>
References: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
 <1356697512-3950-2-git-send-email-andrew@lunn.ch>
Message-ID: <20130106215509.GD26928@lizard.sbx05280.losalca.wayport.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 28, 2012 at 01:25:09PM +0100, Andrew Lunn wrote:
> From: Andrew Lunn <andrew.lunn@ruag.com>
> 
> The QNAP NAS boxes have a microcontroller attached to the SoCs second
> serial port. By sending it a simple command, it will turn the power
> for the board off. This driver registers a function for pm_power_off
> to send such a command.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
[...]
> +MODULE_LICENSE("GPLv2+");

That doesn't make sense, and probably will result into a T (tainted) flag.
The kernel is under GPLv2 license, no '+'. Anyone who touches the code
assumes that it is "GPLv2 only". So, any changes on top of your code
automatically turns it into "GPLv2 only". IANAL, but that's how I believe
things work.

Anyway, fixed this warning:

  CC      drivers/power/reset/qnap-poweroff.o
drivers/power/reset/qnap-poweroff.c: In function ?qnap_power_off_probe?:
drivers/power/reset/qnap-poweroff.c:80:3: warning: passing argument 1 of ?lookup_symbol_name? makes integer from pointer without a cast [enabled by default]
In file included from drivers/power/reset/qnap-poweroff.c:21:0:
include/linux/kallsyms.h:45:5: note: expected ?long unsigned int? but argument is of type ?void (*)(void)?

... and have made a few cosmetic changes (see below). But I didn't change
the license string, you probably should send a patch for it.

diff --git a/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt b/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
index 0951952..9a599d2 100644
--- a/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
+++ b/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
@@ -11,4 +11,3 @@ Required Properties:
 
 - reg: Address and length of the register set for UART1
 - clocks: tclk clock
-
diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index ca0b476..cecb317 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -28,8 +28,7 @@
 static void __iomem *base;
 static unsigned long tclk;
 
-static void
-qnap_power_off(void)
+static void qnap_power_off(void)
 {
 	/* 19200 baud divisor */
 	const unsigned divisor = ((tclk + (8 * 19200)) / (16 * 19200));
@@ -49,28 +48,25 @@ qnap_power_off(void)
 	writel('A', UART1_REG(TX));
 }
 
-static int
-qnap_power_off_probe(struct platform_device *pdev)
+static int qnap_power_off_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct clk *clk;
 	char symname[KSYM_NAME_LEN];
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
+	if (!res) {
 		dev_err(&pdev->dev, "Missing resource");
 		return -EINVAL;
 	}
 
-	base = devm_ioremap(&pdev->dev, res->start,
-			    resource_size(res));
-	if (base == NULL) {
+	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!base) {
 		dev_err(&pdev->dev, "Unable to map resource");
 		return -EINVAL;
 	}
 
-	/* We need to know tclk in order to calculate the UART
-	   divisor */
+	/* We need to know tclk in order to calculate the UART divisor */
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "Clk missing");
@@ -80,8 +76,8 @@ qnap_power_off_probe(struct platform_device *pdev)
 	tclk = clk_get_rate(clk);
 
 	/* Check that nothing else has already setup a handler */
-	if (pm_power_off != NULL) {
-		lookup_symbol_name(pm_power_off, symname);
+	if (pm_power_off) {
+		lookup_symbol_name((ulong)pm_power_off, symname);
 		dev_err(&pdev->dev,
 			"pm_power_off already claimed %p %s",
 			pm_power_off, symname);
@@ -92,11 +88,9 @@ qnap_power_off_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int
-qnap_power_off_remove(struct platform_device *pdev)
+static int qnap_power_off_remove(struct platform_device *pdev)
 {
 	pm_power_off = NULL;
-
 	return 0;
 }
 
@@ -104,7 +98,6 @@ static const struct of_device_id qnap_power_off_of_match_table[] = {
 	{ .compatible = "qnap,power-off", },
 	{}
 };
-
 MODULE_DEVICE_TABLE(of, qnap_power_off_of_match_table);
 
 static struct platform_driver qnap_power_off_driver = {
@@ -116,7 +109,6 @@ static struct platform_driver qnap_power_off_driver = {
 		.of_match_table = of_match_ptr(qnap_power_off_of_match_table),
 	},
 };
-
 module_platform_driver(qnap_power_off_driver);
 
 MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
