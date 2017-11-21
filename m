From: awallis@codeaurora.org (Adam Wallis)
Date: Tue, 21 Nov 2017 12:18:09 -0500
Subject: [PATCH 1/2] usb: xhci: add relaxed timing quirk bit
In-Reply-To: <1511284690-3878-1-git-send-email-awallis@codeaurora.org>
References: <1511284690-3878-1-git-send-email-awallis@codeaurora.org>
Message-ID: <1511284690-3878-2-git-send-email-awallis@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certain systems may run with CPUs at a very slow frequency. This
patch adds a quirk bit that can be used to relax certain timings, etc.

This quirk might be needed for other fields in the future, but
initially, it will be used only on the IRQ control register to allow
firmare to control the value of the register. This can prevent an
"interrupt storm" effect on certain systems.

Signed-off-by: Adam Wallis <awallis@codeaurora.org>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt |  1 +
 drivers/usb/host/xhci.c                            | 25 +++++++++++++++-------
 drivers/usb/host/xhci.h                            |  1 +
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index ae6e484..af2faa24 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -29,6 +29,7 @@ Optional properties:
   - usb2-lpm-disable: indicate if we don't want to enable USB2 HW LPM
   - usb3-lpm-capable: determines if platform is USB3 LPM capable
   - quirk-broken-port-ped: set if the controller has broken port disable mechanism
+  - quirk-relaxed-timing: allows firmware to relax timing on certain registers
 
 Example:
 	usb at f0931000 {
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 327ba8b..e14a204 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -582,16 +582,25 @@ int xhci_run(struct usb_hcd *hcd)
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"ERST deq = 64'h%0lx", (long unsigned int) temp_64);
 
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Set the interrupt modulation register");
-	temp = readl(&xhci->ir_set->irq_control);
-	temp &= ~ER_IRQ_INTERVAL_MASK;
 	/*
-	 * the increment interval is 8 times as much as that defined
-	 * in xHCI spec on MTK's controller
+	 * Systems with slow CPUs may not be able to tolerate
+	 * agressive interrupt timing that silicon can tolerate. The
+	 * XHCI_RELAXED_TIMING will allow firmware to set the IRQ
+	 * Control field.
 	 */
-	temp |= (u32) ((xhci->quirks & XHCI_MTK_HOST) ? 20 : 160);
-	writel(temp, &xhci->ir_set->irq_control);
+	if (!(xhci->quirks & XHCI_RELAXED_TIMING_QUIRK)) {
+		xhci_dbg_trace(xhci, trace_xhci_dbg_init,
+				"// Set the interrupt modulation register");
+		temp = readl(&xhci->ir_set->irq_control);
+		temp &= ~ER_IRQ_INTERVAL_MASK;
+
+		/*
+		 * the increment interval is 8 times as much as that defined
+		 * in xHCI spec on MTK's controller
+		 */
+		temp |= (u32) ((xhci->quirks & XHCI_MTK_HOST) ? 20 : 160);
+		writel(temp, &xhci->ir_set->irq_control);
+	}
 
 	/* Set the HCD state before we enable the irqs */
 	temp = readl(&xhci->op_regs->command);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 99a014a..6d451be 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1823,6 +1823,7 @@ struct xhci_hcd {
 /* Reserved. It was XHCI_U2_DISABLE_WAKE */
 #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
 #define XHCI_HW_LPM_DISABLE	(1 << 29)
+#define XHCI_RELAXED_TIMING_QUIRK	(1 << 30)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
