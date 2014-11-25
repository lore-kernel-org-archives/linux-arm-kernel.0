From: george.cherian@ti.com (George Cherian)
Date: Tue, 25 Nov 2014 18:41:40 +0530
Subject: [PATCH 04/19] usb: host xhci: Add XHCI_NEEDS_LHC_RESET quirk
In-Reply-To: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
References: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
Message-ID: <1416921115-10467-5-git-send-email-george.cherian@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds XHCI_NEEDS_LHC_RESET quirk, to make sure only Light Host Reset
is done during xhci_reset(). This is mainly useful when we switch roles
HOST to Device mode and viceversa.

The DWC3 IP shares internal RAM for both HOST and Device specific registers.
So while switching roles between HOST and Device modes, it's advbised to do
a LIGHT HC reset else the already configured global registers of the DWC3 IP
gets re-initialized.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 drivers/usb/host/xhci.c | 5 +++--
 drivers/usb/host/xhci.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index d4196f8..5dabf9a 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -170,11 +170,12 @@ int xhci_reset(struct xhci_hcd *xhci)
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "// Reset the HC");
 	command = readl(&xhci->op_regs->command);
-	command |= CMD_RESET;
+	command |= (xhci->quirks & XHCI_NEEDS_LHC_RESET) ? CMD_LRESET : CMD_RESET;
 	writel(command, &xhci->op_regs->command);
 
 	ret = xhci_handshake(xhci, &xhci->op_regs->command,
-			CMD_RESET, 0, 10 * 1000 * 1000);
+			(xhci->quirks & XHCI_NEEDS_LHC_RESET) ? CMD_LRESET : CMD_RESET,
+			0, 10 * 1000 * 1000);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 2248058..1b14b09 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1561,6 +1561,7 @@ struct xhci_hcd {
 /* For controllers with a broken beyond repair streams implementation */
 #define XHCI_BROKEN_STREAMS	(1 << 19)
 #define XHCI_DRD_SUPPORT	(1 << 20)
+#define XHCI_NEEDS_LHC_RESET	(1 << 21)
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
 	/* There are two roothubs to keep track of bus suspend info for */
-- 
1.8.3.1
