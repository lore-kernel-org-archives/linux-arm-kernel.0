From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 20 Jan 2015 14:39:04 +0100
Subject: [PATCHv7 6/6] USB: host: ohci-at91: Fix wake-up support
In-Reply-To: <1421761144-11767-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421761144-11767-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421761144-11767-7-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This device needs to be continuously clocked to provide wake up support,
previously, if STANDBY target were chosen the device were
enable_irq_wake()-prepared and clock still active and if MEM target were
chosen the device were also enable_irq_wake()-prepared but not clocked
anymore, which is wrong.

Now, if STANDBY target is chosen the device is still clocked with wake
up support enabled, which were the previous default and if MEM target is
chosen the device is declocked with wake up support disabled.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/usb/host/ohci-at91.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 970a776..1fc5610 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -42,6 +42,7 @@ struct ohci_at91_priv {
 	struct clk *uclk;
 	struct clk *hclk;
 	bool clocked;
+	bool wakeup;		/* Saved wake-up state for resume */
 };
 /* interface and function clocks; sometimes also an AHB clock */
 
@@ -61,6 +62,8 @@ extern int usb_disabled(void);
 
 static void at91_start_clock(struct ohci_at91_priv *ohci_at91)
 {
+	if (ohci_at91->clocked)
+		return;
 	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
 		clk_set_rate(ohci_at91->uclk, 48000000);
 		clk_prepare_enable(ohci_at91->uclk);
@@ -73,6 +76,8 @@ static void at91_start_clock(struct ohci_at91_priv *ohci_at91)
 
 static void at91_stop_clock(struct ohci_at91_priv *ohci_at91)
 {
+	if (!ohci_at91->clocked)
+		return;
 	clk_disable_unprepare(ohci_at91->fclk);
 	clk_disable_unprepare(ohci_at91->iclk);
 	clk_disable_unprepare(ohci_at91->hclk);
@@ -614,15 +619,22 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
 	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
-	bool		do_wakeup = device_may_wakeup(dev);
 	int		ret;
 
-	if (do_wakeup)
+	/*
+	 * Disable wakeup if we are going to sleep with slow clock mode
+	 * enabled.
+	 */
+	ohci_at91->wakeup = device_may_wakeup(dev)
+			&& !at91_suspend_entering_slow_clock();
+
+	if (ohci_at91->wakeup)
 		enable_irq_wake(hcd->irq);
 
-	ret = ohci_suspend(hcd, do_wakeup);
+	ret = ohci_suspend(hcd, ohci_at91->wakeup);
 	if (ret) {
-		disable_irq_wake(hcd->irq);
+		if (ohci_at91->wakeup)
+			disable_irq_wake(hcd->irq);
 		return ret;
 	}
 	/*
@@ -632,7 +644,7 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 	 *
 	 * REVISIT: some boards will be able to turn VBUS off...
 	 */
-	if (at91_suspend_entering_slow_clock()) {
+	if (!ohci_at91->wakeup) {
 		ohci->hc_control = ohci_readl(ohci, &ohci->regs->control);
 		ohci->hc_control &= OHCI_CTRL_RWC;
 		ohci_writel(ohci, ohci->hc_control, &ohci->regs->control);
@@ -651,11 +663,10 @@ static int ohci_hcd_at91_drv_resume(struct device *dev)
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
 
-	if (device_may_wakeup(dev))
+	if (ohci_at91->wakeup)
 		disable_irq_wake(hcd->irq);
 
-	if (!ohci_at91->clocked)
-		at91_start_clock(ohci_at91);
+	at91_start_clock(ohci_at91);
 
 	ohci_resume(hcd, false);
 	return 0;
-- 
2.1.4
