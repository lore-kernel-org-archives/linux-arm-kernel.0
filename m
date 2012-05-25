From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 25 May 2012 10:24:16 +0800
Subject: [PATCH v3 03/12] usb: ehci-hcd: notify phy when connect change
In-Reply-To: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
References: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337912665-16615-4-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It still has below limitations:
- it does not work for multi-phy ehci
- the best place is after debounce, but I can't get
  phy there

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/host/ehci-hcd.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index b100f5f..8c39a7a 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -928,6 +928,20 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
 			pstatus = ehci_readl(ehci,
 					 &ehci->regs->port_status[i]);
 
+			/* FIXME:
+			 * - it does not work for multi-phy ehci
+			 * - the best place is after debounce, but I can't get
+			 *   phy there
+			 */
+			if ((pstatus & PORT_CSC) && ehci->transceiver) {
+				if (pstatus & PORT_CONNECT)
+					usb_phy_notify_connect(
+						ehci->transceiver, i);
+				else
+					usb_phy_notify_disconnect(
+						ehci->transceiver, i);
+			}
+
 			if (pstatus & PORT_OWNER)
 				continue;
 			if (!(test_bit(i, &ehci->suspended_ports) &&
-- 
1.7.5.4
