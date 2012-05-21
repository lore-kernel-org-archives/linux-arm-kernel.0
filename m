From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 21 May 2012 17:23:48 +0800
Subject: [PATCH v2 03/12] usb: ehci-hcd: notify phy when connect change
In-Reply-To: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337592237-5090-4-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It still has below limitations:
- it does not work for multi-phy ehci
- the best place is after debounce, but I can't get
  phy there

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/host/ehci-hcd.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 5597e60..389252e 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -928,6 +928,15 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
 			pstatus = ehci_readl(ehci,
 					 &ehci->regs->port_status[i]);
 
+			/* FIXME:
+			 * - it does not work for multi-phy ehci
+			 * - the best place is after debounce, but I can't get
+			 *   phy there
+			 */
+			if ((pstatus & PORT_CSC) && ehci->transceiver)
+				usb_phy_notify_connect_change(ehci->transceiver,
+						i, pstatus & PORT_CONNECT);
+
 			if (pstatus & PORT_OWNER)
 				continue;
 			if (!(test_bit(i, &ehci->suspended_ports) &&
-- 
1.7.5.4
