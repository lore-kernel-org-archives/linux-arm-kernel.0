From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 09:55:23 +0800
Subject: [PATCH v3 08/10] usb: chipidea: host: add quirk for ehci operation
In-Reply-To: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
References: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1383616525-10769-9-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For chipidea controller, it does not follow ehci spec strictly.
Taking resume signal as an example, it will stop resume signal about
20-21ms later automatically, but standard ehci spec says, the resume
signal is controlled by software (clear portsc.PORT_RESUME).

This operation causes some remote wakeup problems for high speed
devices due to host controller does not send SOF in time since
software can't guarantee set run/stop bit in time (run/stop bit
was cleared at the ehci suspend routine).

When software sets run/stop bit, it needs 1 SoF time to make it effect.
If we close the PHY clock just after setting run/stop bit, it does
not be set in practice, so a software delay is needed.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/host.c |   51 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index 06fd042..de0c2de 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -33,6 +33,53 @@
 #include "host.h"
 
 static struct hc_driver __read_mostly ci_ehci_hc_driver;
+static int (*orig_bus_suspend)(struct usb_hcd *hcd);
+
+static int ci_ehci_bus_suspend(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	int port;
+	u32 tmp;
+
+	int ret = orig_bus_suspend(hcd);
+
+	if (ret)
+		return ret;
+
+	port = HCS_N_PORTS(ehci->hcs_params);
+	while (port--) {
+		u32 __iomem *reg = &ehci->regs->port_status[port];
+		u32 portsc = ehci_readl(ehci, reg);
+
+		if (portsc & PORT_CONNECT) {
+			/*
+			 * For chipidea, the resume signal will be ended
+			 * automatically, so for remote wakeup case, the
+			 * usbcmd.rs may not be set before the resume has
+			 * ended if other resume path consumes too much
+			 * time (~23ms-24ms), in that case, the SOF will not
+			 * send out within 3ms after resume ends, then the
+			 * device will enter suspend again.
+			 */
+			if (hcd->self.root_hub->do_remote_wakeup) {
+				ehci_dbg(ehci,
+					"Remote wakeup is enabled, "
+					"and device is on the port\n");
+
+				tmp = ehci_readl(ehci, &ehci->regs->command);
+				tmp |= CMD_RUN;
+				ehci_writel(ehci, tmp, &ehci->regs->command);
+				/*
+				 * It needs a short delay between set RUNSTOP
+				 * and set PHCD.
+				 */
+				udelay(125);
+			}
+		}
+	}
+
+	return 0;
+}
 
 static irqreturn_t host_irq(struct ci_hdrc *ci)
 {
@@ -135,5 +182,9 @@ int ci_hdrc_host_init(struct ci_hdrc *ci)
 
 	ehci_init_driver(&ci_ehci_hc_driver, NULL);
 
+	orig_bus_suspend = ci_ehci_hc_driver.bus_suspend;
+
+	ci_ehci_hc_driver.bus_suspend = ci_ehci_bus_suspend;
+
 	return 0;
 }
-- 
1.7.1
