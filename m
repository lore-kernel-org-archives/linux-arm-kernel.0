From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 19 Jan 2015 12:06:02 +0100
Subject: [PATCHv6 1/6] USB: host: ehci-atmel: Add suspend/resume support
In-Reply-To: <1421665567-31759-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421665567-31759-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421665567-31759-2-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add suspend/resume support for Atmel EHCI, mostly
about disabling and unpreparing clocks so USB PLL is stopped
before entering sleep state.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/usb/host/ehci-atmel.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 56a8850..5a15e3d 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -37,6 +37,8 @@ static int clocked;
 
 static void atmel_start_clock(void)
 {
+	if (clocked)
+		return;
 	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
 		clk_set_rate(uclk, 48000000);
 		clk_prepare_enable(uclk);
@@ -48,6 +50,8 @@ static void atmel_start_clock(void)
 
 static void atmel_stop_clock(void)
 {
+	if (!clocked)
+		return;
 	clk_disable_unprepare(fclk);
 	clk_disable_unprepare(iclk);
 	if (IS_ENABLED(CONFIG_COMMON_CLK))
@@ -174,6 +178,29 @@ static int ehci_atmel_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int ehci_atmel_drv_suspend(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ehci_suspend(hcd, false);
+	if (ret)
+		return ret;
+
+	atmel_stop_clock();
+	return 0;
+}
+
+static int ehci_atmel_drv_resume(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+
+	atmel_start_clock();
+	return ehci_resume(hcd, false);
+}
+#endif
+
 #ifdef CONFIG_OF
 static const struct of_device_id atmel_ehci_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9g45-ehci" },
@@ -183,12 +210,16 @@ static const struct of_device_id atmel_ehci_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, atmel_ehci_dt_ids);
 #endif
 
+static SIMPLE_DEV_PM_OPS(ehci_atmel_pm_ops, ehci_atmel_drv_suspend,
+					ehci_atmel_drv_resume);
+
 static struct platform_driver ehci_atmel_driver = {
 	.probe		= ehci_atmel_drv_probe,
 	.remove		= ehci_atmel_drv_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver		= {
 		.name	= "atmel-ehci",
+		.pm	= &ehci_atmel_pm_ops,
 		.of_match_table	= of_match_ptr(atmel_ehci_dt_ids),
 	},
 };
-- 
2.1.4
