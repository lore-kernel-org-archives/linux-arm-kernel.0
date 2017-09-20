From: yinbo.zhu@nxp.com (yinbo.zhu at nxp.com)
Date: Wed, 20 Sep 2017 17:24:41 +0800
Subject: [PATCH v1] usb: host: Implement workaround for Erratum A-007463
Message-ID: <20170920092441.21292-1-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "yinbo.zhu" <yinbo.zhu@nxp.com>

When a transaction error (defined in Section 4.10.2.3, "USB
Transaction Error" of the xHCI Specification) occurs on the
USB, the host controller reports this through a transfer
event with the completion code "USB Transaction Error". When
this happens, the endpoint is placed in the Halted state.
In response, software must issue a Reset Endpoint command to
transition the endpoint to the Stopped state. In order to
restart the transfer, the driver can perform either of the
following:
? Ring the doorbell again, which restarts the transfer from
  where it stopped, or
? Issue a Set TR (Transfer Ring) Dequeue Pointer command for
  the endpoint to start the transfer from a different
  Transfer Ring pointer Consider the following scenario:
1. The xHCI driver prepares a control transfer read to one
   of the device's control endpoints;
2. During the IN data stage, a transaction error occurs on
   the USB, causing a transfer event with the completion
   code "USB Transaction Error";
3. The driver issues a Reset Endpoint command;
4. The driver rings the doorbell of the control endpoint to
   resume the transfer. In this scenario, the controller
   may reverse the direction of the data stage from IN to OUT.
   Instead of sending an ACK to the endpoint to poll for read
   data, it sends a Data Packet (DP) to the endpoint. It
   fetches the data from the data stage Transfer Request Block
   (TRB) that is being resumed, even though the data buffer is
   setup to receive data and not transmit it.
NOTE
This issue occurs only if the transaction error happens during
an IN data stage. There is no issue if the transaction error
happens during an OUT data stage.

Impact: When this issue occurs, the device likely responds in
one of the following ways:
? The device responds with a STALL because the data stage has
unexpectedly changed directions. The controller then generates
a Stall Error transfer event, to which software must issue a
Reset Endpoint command followed by a Set TR Dequeue Pointer
command pointing to a new Setup TRB to clear the STALL condition.
? The device does not respond to the inverted data stage and the
transaction times out. The controller generates another USB
Transaction Error transfer event, to which software likely
performs a USB Reset to the device because it is unresponsive.
It is not expected that any of these recovery steps will cause
instability in the system because this recovery is part of a
standard xHCI driver and could happen regardless of the defect.
Another possible system-level impact is that the controller
attempts to read from the memory location pointed at by the Data
Stage TRB or a Normal TRB chained to it. associated with this
TRB is intended to be written by the controller, but the
controller reads from it instead. Normally, this does not cause
a problem. However, if the system has some type of memory
protection where this unexpected read is treated as a bus error,
it may cause the system to become unstable or to crash.

Workaround: If a USB Transaction Error occurs during the IN
data phase of a control transfer, the driver must use the
Set TR Dequeue Pointer command to either restart the data
phase or restart the entire control transfer from the
Setup phase.

Configs Affected:
LS1021-20-22A-R1.0, LS1021-20-22A-R2.007463

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi |  1 +
 drivers/usb/dwc3/core.c        |  2 ++
 drivers/usb/dwc3/core.h        |  2 ++
 drivers/usb/dwc3/host.c        |  2 ++
 drivers/usb/host/xhci-plat.c   |  3 +++
 drivers/usb/host/xhci-ring.c   | 28 +++++++++++++++++++++++-----
 drivers/usb/host/xhci.h        |  3 ++-
 7 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 7bb9df2c1460..9f76b2b82dce 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -683,6 +683,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,quirk_reverse_in_out;
 		};
 
 		pcie at 3400000 {
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 03474d3575ab..e6a3be9280b1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1031,6 +1031,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				&hird_threshold);
 	dwc->usb3_lpm_capable = device_property_read_bool(dev,
 				"snps,usb3_lpm_capable");
+	dwc->quirk_reverse_in_out = device_property_read_bool(dev,
+				"snps,quirk_reverse_in_out");
 
 	dwc->disable_scramble_quirk = device_property_read_bool(dev,
 				"snps,disable_scramble_quirk");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index ea910acb4bb0..d4b5d8e87672 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1016,6 +1016,8 @@ struct dwc3 {
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
 
+	unsigned		quirk_reverse_in_out:1;
+
 	u16			imod_interval;
 };
 
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 76f0b0df37c1..1d412390b3c9 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -101,6 +101,8 @@ int dwc3_host_init(struct dwc3 *dwc)
 	if (dwc->usb3_lpm_capable)
 		props[prop_idx++].name = "usb3-lpm-capable";
 
+	if (dwc->quirk_reverse_in_out)
+		props[prop_idx++].name = "quirk-reverse-in-out";
 	/**
 	 * WORKAROUND: dwc3 revisions <=3.00a have a limitation
 	 * where Port Disable command doesn't work.
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c04144b25a67..a55dcb1a476b 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -273,6 +273,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
 		xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
+	if (device_property_read_bool(&pdev->dev, "quirk-reverse-in-out"))
+		xhci->quirks |= XHCI_REVERSE_IN_OUT;
+
 	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
 	if (IS_ERR(hcd->usb_phy)) {
 		ret = PTR_ERR(hcd->usb_phy);
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index cc368ad2b51e..02505ace0a2e 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1933,11 +1933,13 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	union xhci_trb *ep_trb, struct xhci_transfer_event *event,
 	struct xhci_virt_ep *ep, int *status)
 {
+	struct xhci_dequeue_state deq_state;
 	struct xhci_virt_device *xdev;
 	struct xhci_ep_ctx *ep_ctx;
 	struct xhci_ring *ep_ring;
 	unsigned int slot_id;
 	u32 trb_comp_code;
+	u32 remaining;
 	int ep_index;
 
 	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
@@ -1959,14 +1961,30 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	if (trb_comp_code == COMP_STALL_ERROR ||
 		xhci_requires_manual_halt_cleanup(xhci, ep_ctx,
 						trb_comp_code)) {
-		/* Issue a reset endpoint command to clear the host side
-		 * halt, followed by a set dequeue command to move the
-		 * dequeue pointer past the TD.
-		 * The class driver clears the device side halt later.
+		/*
+		 * A-007463: After transaction error, controller switches
+		 * control transfer data stage from IN to OUT direction.
 		 */
-		xhci_cleanup_halted_endpoint(xhci, slot_id, ep_index,
+		remaining = EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
+		if (remaining && xhci_requires_manual_halt_cleanup(xhci, ep_ctx,
+					trb_comp_code) &&
+					(xhci->quirks & XHCI_REVERSE_IN_OUT)) {
+			memset(&deq_state, 0, sizeof(deq_state));
+			xhci_find_new_dequeue_state(xhci, slot_id,
+				ep_index, td->urb->stream_id, td, &deq_state);
+			xhci_queue_new_dequeue_state(xhci, slot_id, ep_index,
+						     &deq_state);
+			xhci_ring_cmd_db(xhci);
+		} else {
+			/* Issue a reset endpoint command to clear the host side
+			 * halt, followed by a set dequeue command to move the
+			 * dequeue pointer past the TD.
+			 * The class driver clears the device side halt later.
+			 */
+			xhci_cleanup_halted_endpoint(xhci, slot_id, ep_index,
 					ep_ring->stream_id, td, ep_trb,
 					EP_HARD_RESET);
+		}
 	} else {
 		/* Update ring dequeue pointer */
 		while (ep_ring->dequeue != td->last_trb)
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index e3e935291ed6..0109965616d6 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1780,7 +1780,7 @@ struct xhci_hcd {
 #define XHCI_STATE_DYING	(1 << 0)
 #define XHCI_STATE_HALTED	(1 << 1)
 #define XHCI_STATE_REMOVING	(1 << 2)
-	unsigned int		quirks;
+	u64            quirks;
 #define	XHCI_LINK_TRB_QUIRK	(1 << 0)
 #define XHCI_RESET_EP_QUIRK	(1 << 1)
 #define XHCI_NEC_HOST		(1 << 2)
@@ -1821,6 +1821,7 @@ struct xhci_hcd {
 #define XHCI_LIMIT_ENDPOINT_INTERVAL_7	(1 << 26)
 #define XHCI_U2_DISABLE_WAKE	(1 << 27)
 #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
+#define XHCI_REVERSE_IN_OUT	(1 << 29)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.14.1
