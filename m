From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sat, 17 Jan 2015 22:25:38 +0100
Subject: [PATCHv3 1/5] USB: host: ehci_atmel: Add suspend/resume support
In-Reply-To: <1421529942-18437-1-git-send-email-sylvain.rochet@finsecur.com>
References: <Pine.LNX.4.44L0.1501171524050.13485-100000@netrider.rowland.org>
 <1421529942-18437-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421529942-18437-2-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add suspend/resume support for Atmel EHCI, mostly
about disabling and unpreparing clocks so USB PLL is stopped
before entering sleep state.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/usb/host/ehci-atmel.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 56a8850..2e0043b 100644
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
@@ -174,6 +178,32 @@ static int ehci_atmel_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int ehci_atmel_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
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
+static int ehci_atmel_drv_resume(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	atmel_start_clock();
+	return ehci_resume(hcd, false);
+}
+#else
+#define ehci_atmel_drv_suspend NULL
+#define ehci_atmel_drv_resume  NULL
+#endif
+
 #ifdef CONFIG_OF
 static const struct of_device_id atmel_ehci_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9g45-ehci" },
@@ -187,6 +217,8 @@ static struct platform_driver ehci_atmel_driver = {
 	.probe		= ehci_atmel_drv_probe,
 	.remove		= ehci_atmel_drv_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
+	.suspend	= ehci_atmel_drv_suspend,
+	.resume		= ehci_atmel_drv_resume,
 	.driver		= {
 		.name	= "atmel-ehci",
 		.of_match_table	= of_match_ptr(atmel_ehci_dt_ids),
-- 
2.1.4
