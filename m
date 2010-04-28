From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 28 Apr 2010 13:45:40 +0200
Subject: [PATCH] USB: ohci-at91: fix power management hanging
Message-ID: <1272455140-32686-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Vilchez <patrice.vilchez@atmel.com>

A hanging has been detected in ohci-at91 while going in suspend to ram. This is
due to asynchronous operations between ohci reset and ohci clocks shutdown.
This patch adds the reading of the control register between the reset of the
ohci and clocks stop. This "flush the writes" idea was taken from ohci-hcd.c
file (ohci_shutdown() function).

Signed-off-by: Patrice Vilchez <patrice.vilchez@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
This patch has been tested on at91sam9g10 and is working ok.

 drivers/usb/host/ohci-at91.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 68b83ab..944291e 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -331,6 +331,8 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 	 */
 	if (at91_suspend_entering_slow_clock()) {
 		ohci_usb_reset (ohci);
+		/* flush the writes */
+		(void) ohci_readl (ohci, &ohci->regs->control);
 		at91_stop_clock();
 	}
 
-- 
1.5.6.5
