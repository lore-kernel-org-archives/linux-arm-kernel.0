From: saeed@marvell.com (Saeed Bishara)
Date: Sun,  2 May 2010 17:22:42 +0300
Subject: [PATCH 5/5] USB: add power management support for orion ehci
In-Reply-To: <1272810162-14858-5-git-send-email-saeed@marvell.com>
References: <1272810162-14858-1-git-send-email-saeed@marvell.com>
	<1272810162-14858-2-git-send-email-saeed@marvell.com>
	<1272810162-14858-3-git-send-email-saeed@marvell.com>
	<1272810162-14858-4-git-send-email-saeed@marvell.com>
	<1272810162-14858-5-git-send-email-saeed@marvell.com>
Message-ID: <1272810162-14858-6-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/usb/host/ehci-orion.c |   87 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 92680ad..2008ef2 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -427,11 +427,98 @@ static int __exit ehci_orion_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int ehci_orion_suspend(struct platform_device *pdev,
+			      pm_message_t state)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
+	unsigned long		flags;
+	int			rc = 0;
+
+	if (time_before(jiffies, ehci->next_statechange))
+		msleep(10);
+
+	/* Root hub was already suspended. Disable irq emission and
+	 * mark HW unaccessible, bail out if RH has been resumed. Use
+	 * the spinlock to properly synchronize with possible pending
+	 * RH suspend or resume activity.
+	 *
+	 * This is still racy as hcd->state is manipulated outside of
+	 * any locks =P But that will be a different fix.
+	 */
+	spin_lock_irqsave(&ehci->lock, flags);
+	if (hcd->state != HC_STATE_SUSPENDED) {
+		rc = -EINVAL;
+		goto bail;
+	}
+	ehci_writel(ehci, 0, &ehci->regs->intr_enable);
+	(void)ehci_readl(ehci, &ehci->regs->intr_enable);
+
+	/* make sure snapshot being resumed re-enumerates everything */
+	if (state.event == PM_EVENT_PRETHAW) {
+		ehci_halt(ehci);
+		ehci_reset(ehci);
+	}
+
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+bail:
+	spin_unlock_irqrestore(&ehci->lock, flags);
+
+	return rc;
+}
+static int ehci_orion_resume(struct platform_device *pdev)
+{
+	struct orion_ehci_data *pd = pdev->dev.platform_data;
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
+
+	if (time_before(jiffies, ehci->next_statechange))
+		msleep(100);
+
+	/* Mark hardware accessible again as we are out of D3 state by now */
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
+	ehci_dbg(ehci, "lost power, restarting\n");
+	usb_root_hub_lost_power(hcd->self.root_hub);
+
+	/* Else reset, to cope with power loss or flush-to-storage
+	 * style "resume" having let BIOS kick in during reboot.
+	 */
+	(void) ehci_halt(ehci);
+	(void) ehci_reset(ehci);
+	ehci_orion_hw_init(hcd, pd);
+
+	/* emptying the schedule aborts any urbs */
+	spin_lock_irq(&ehci->lock);
+	if (ehci->reclaim)
+		end_unlink_async(ehci);
+	ehci_work(ehci);
+	spin_unlock_irq(&ehci->lock);
+
+	ehci_writel(ehci, ehci->command, &ehci->regs->command);
+	ehci_writel(ehci, FLAG_CF, &ehci->regs->configured_flag);
+	ehci_readl(ehci, &ehci->regs->command);	/* unblock posted writes */
+
+	/* here we "know" root ports should always stay powered */
+	ehci_port_power(ehci, 1);
+
+	hcd->state = HC_STATE_SUSPENDED;
+	return 0;
+}
+
+#else
+#define ehci_orion_suspend	NULL
+#define ehci_orion_resume	NULL
+#endif
+
 MODULE_ALIAS("platform:orion-ehci");
 
 static struct platform_driver ehci_orion_driver = {
 	.probe		= ehci_orion_drv_probe,
 	.remove		= __exit_p(ehci_orion_drv_remove),
+	.suspend	= ehci_orion_suspend,
+	.resume		= ehci_orion_resume,
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver.name	= "orion-ehci",
 };
-- 
1.6.0.4
