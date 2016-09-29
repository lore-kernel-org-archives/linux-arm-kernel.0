From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 29 Sep 2016 18:07:07 +0800
Subject: [PATCH v1] usb: ohci-at91: Set RemoteWakeupConnected bit explicitly.
Message-ID: <1475143628-6608-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reset value of RWC is 0, set RemoteWakeupConnected bit explicitly
before calling ohci_run, it also fixes the issue that the mass
storage stick connected wasn't suspended when the system suspend.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 drivers/usb/host/ohci-at91.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 98047bf..ff0d31a 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -202,6 +202,12 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 	ohci->num_ports = board->ports;
 	at91_start_hc(pdev);
 
+	/*
+	 * The RemoteWakeupConnected bit has to be set explicitly
+	 * before calling ohci_run. The reset value of this bit is 0.
+	 */
+	ohci->hc_control = OHCI_CTRL_RWC;
+
 	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (retval == 0) {
 		device_wakeup_enable(hcd->self.controller);
@@ -554,9 +560,6 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 	 * REVISIT: some boards will be able to turn VBUS off...
 	 */
 	if (!ohci_at91->wakeup) {
-		ohci->hc_control = ohci_readl(ohci, &ohci->regs->control);
-		ohci->hc_control &= OHCI_CTRL_RWC;
-		ohci_writel(ohci, ohci->hc_control, &ohci->regs->control);
 		ohci->rh_state = OHCI_RH_HALTED;
 
 		/* flush the writes */
-- 
2.7.4
