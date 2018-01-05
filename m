From: ran.wang_1@nxp.com (Ran Wang)
Date: Fri, 5 Jan 2018 17:40:09 +0800
Subject: [PATCH 4/4] xHCI: Handle dwc3 erratum on USB3 HW LPM feature.
In-Reply-To: <20180105094009.22599-1-ran.wang_1@nxp.com>
References: <20180105094009.22599-1-ran.wang_1@nxp.com>
Message-ID: <20180105094009.22599-4-ran.wang_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Synopsys STARS ticket: 90000969472(A-010131)

Description: This erratum is applicable for the USB 3.0 Super
Speed host mode operation. When the U2 timer expires while in
U1 mode, the USB 3.0 controller completes a U1->U2 entry operation
lasting three mac3_clk (24 ns). If the xHCI driver issues a
U3 request during this operation, thecontroller drops this request.

Impact: The controller ignores the request when the xHCI driver
programs the U3 entry (PORTSC.PLS = U3).

Workaround:
1. Before initiating U3 entry, save PORTPMSC.
2. Disable U2 entry by programming PORTPMSC[U2 Timeout] = h'FF.
3. After U3 entry, re-enable the U2 timer by programming PORTPMSC
with the value saved in Step 1.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 drivers/usb/host/xhci-hub.c  |   22 ++++++++++++++++++++++
 drivers/usb/host/xhci-plat.c |    6 +++++-
 drivers/usb/host/xhci.h      |    1 +
 3 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index f070f94..a61185e 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -676,12 +676,34 @@ void xhci_set_link_state(struct xhci_hcd *xhci, __le32 __iomem **port_array,
 				int port_id, u32 link_state)
 {
 	u32 temp;
+	u32 portpmsc_u2_backup = 0;
+
+	/* Backup U2 timeout info before initiating U3 entry erratum A-010131 */
+	if (xhci->shared_hcd->speed >= HCD_USB3 &&
+			link_state == USB_SS_PORT_LS_U3 &&
+			(xhci->quirks & XHCI_DIS_U1U2_WHEN_U3)) {
+		portpmsc_u2_backup = readl(port_array[port_id] + PORTPMSC);
+		portpmsc_u2_backup &= PORT_U2_TIMEOUT_MASK;
+		temp = readl(port_array[port_id] + PORTPMSC);
+		temp |= PORT_U2_TIMEOUT_MASK;
+		writel(temp, port_array[port_id] + PORTPMSC);
+	}
 
 	temp = readl(port_array[port_id]);
 	temp = xhci_port_state_to_neutral(temp);
 	temp &= ~PORT_PLS_MASK;
 	temp |= PORT_LINK_STROBE | link_state;
 	writel(temp, port_array[port_id]);
+
+	/* Restore U2 timeout info after U3 entry complete */
+	if (xhci->shared_hcd->speed >= HCD_USB3 &&
+			link_state == USB_SS_PORT_LS_U3 &&
+			(xhci->quirks & XHCI_DIS_U1U2_WHEN_U3)) {
+		temp = readl(port_array[port_id] + PORTPMSC);
+		temp &= ~PORT_U2_TIMEOUT_MASK;
+		temp |= portpmsc_u2_backup;
+		writel(temp, port_array[port_id] + PORTPMSC);
+	}
 }
 
 static void xhci_set_remote_wake_mask(struct xhci_hcd *xhci,
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 1969e56..616c56e 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -266,8 +266,12 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (device_property_read_bool(sysdev, "usb2-lpm-disable"))
 		xhci->quirks |= XHCI_HW_LPM_DISABLE;
 
-	if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
+	if (device_property_read_bool(sysdev, "usb3-lpm-capable")) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
+		if (device_property_read_bool(sysdev,
+					"snps,dis-u1u2-when-u3-quirk"))
+			xhci->quirks |= XHCI_DIS_U1U2_WHEN_U3;
+	}
 
 	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
 		xhci->quirks |= XHCI_BROKEN_PORT_PED;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index b966cd8..9704779 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1835,6 +1835,7 @@ struct xhci_hcd {
 /* Reserved. It was XHCI_U2_DISABLE_WAKE */
 #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
 #define XHCI_HW_LPM_DISABLE	(1 << 29)
+#define XHCI_DIS_U1U2_WHEN_U3 (1 << 30)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
1.7.1
