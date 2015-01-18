From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 18 Jan 2015 23:25:33 +0100
Subject: [PATCHv5 4/6] USB: host: ohci-at91: Fix wake-up support
In-Reply-To: <1421619935-5022-1-git-send-email-sylvain.rochet@finsecur.com>
References: <20150118211728.GA21128@gradator.net>
 <1421619935-5022-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421619935-5022-5-git-send-email-sylvain.rochet@finsecur.com>
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
---
 drivers/usb/host/ohci-at91.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 65e7836..2738352 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -49,6 +49,8 @@ extern int usb_disabled(void);
 
 static void at91_start_clock(void)
 {
+	if (clocked)
+		return;
 	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
 		clk_set_rate(uclk, 48000000);
 		clk_prepare_enable(uclk);
@@ -61,6 +63,8 @@ static void at91_start_clock(void)
 
 static void at91_stop_clock(void)
 {
+	if (!clocked)
+		return;
 	clk_disable_unprepare(fclk);
 	clk_disable_unprepare(iclk);
 	clk_disable_unprepare(hclk);
@@ -597,15 +601,20 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
-	bool		do_wakeup = device_may_wakeup(dev);
+	bool		do_wakeup;
 	int		ret;
 
+	if (at91_suspend_entering_slow_clock())
+		device_init_wakeup(dev, 0);
+
+	do_wakeup = device_may_wakeup(dev);
 	if (do_wakeup)
 		enable_irq_wake(hcd->irq);
 
 	ret = ohci_suspend(hcd, do_wakeup);
 	if (ret) {
-		disable_irq_wake(hcd->irq);
+		if (do_wakeup)
+			disable_irq_wake(hcd->irq);
 		return ret;
 	}
 	/*
@@ -615,7 +624,7 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 	 *
 	 * REVISIT: some boards will be able to turn VBUS off...
 	 */
-	if (at91_suspend_entering_slow_clock()) {
+	if (!do_wakeup) {
 		ohci->hc_control = ohci_readl(ohci, &ohci->regs->control);
 		ohci->hc_control &= OHCI_CTRL_RWC;
 		ohci_writel(ohci, ohci->hc_control, &ohci->regs->control);
@@ -635,9 +644,9 @@ static int ohci_hcd_at91_drv_resume(struct device *dev)
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(hcd->irq);
+	device_init_wakeup(dev, 1);
 
-	if (!clocked)
-		at91_start_clock();
+	at91_start_clock();
 
 	ohci_resume(hcd, false);
 	return 0;
-- 
2.1.4
