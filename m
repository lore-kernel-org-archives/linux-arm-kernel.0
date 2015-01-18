From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 18 Jan 2015 20:36:03 +0100
Subject: [PATCHv4 3/6] USB: host: ohci-at91: Stop/start USB PLL for all sleep
 modes
In-Reply-To: <1421609766-11204-1-git-send-email-sylvain.rochet@finsecur.com>
References: <Pine.LNX.4.44L0.1501181220040.1499-100000@netrider.rowland.org>
 <1421609766-11204-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421609766-11204-4-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable/unprepare clocks without testing the sleep target_state, removed
the at91_suspend_entering_slow_clock() call (which is only a
target_state == PM_SUSPEND_MEM).

Other kind of suspend now benefit from the power save induced by this
PLL deactivation. The resume penalty is about 500 us, which is not
negligible but acceptable considering the amount of power we are saving.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Reported-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/usb/host/ohci-at91.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 65e7836..79e343e 100644
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
@@ -615,16 +619,14 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 	 *
 	 * REVISIT: some boards will be able to turn VBUS off...
 	 */
-	if (at91_suspend_entering_slow_clock()) {
-		ohci->hc_control = ohci_readl(ohci, &ohci->regs->control);
-		ohci->hc_control &= OHCI_CTRL_RWC;
-		ohci_writel(ohci, ohci->hc_control, &ohci->regs->control);
-		ohci->rh_state = OHCI_RH_HALTED;
-
-		/* flush the writes */
-		(void) ohci_readl (ohci, &ohci->regs->control);
-		at91_stop_clock();
-	}
+	ohci->hc_control = ohci_readl(ohci, &ohci->regs->control);
+	ohci->hc_control &= OHCI_CTRL_RWC;
+	ohci_writel(ohci, ohci->hc_control, &ohci->regs->control);
+	ohci->rh_state = OHCI_RH_HALTED;
+
+	/* flush the writes */
+	(void) ohci_readl (ohci, &ohci->regs->control);
+	at91_stop_clock();
 
 	return ret;
 }
@@ -636,8 +638,7 @@ static int ohci_hcd_at91_drv_resume(struct device *dev)
 	if (device_may_wakeup(dev))
 		disable_irq_wake(hcd->irq);
 
-	if (!clocked)
-		at91_start_clock();
+	at91_start_clock();
 
 	ohci_resume(hcd, false);
 	return 0;
-- 
2.1.4
