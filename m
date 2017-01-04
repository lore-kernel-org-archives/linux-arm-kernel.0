From: manish.narani@xilinx.com (Manish Narani)
Date: Wed, 4 Jan 2017 18:52:57 +0530
Subject: [RFC PATCH] usb: dwc3: core: add OTG support function calls and
 modifications
In-Reply-To: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
References: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
Message-ID: <1483536181-22356-3-git-send-email-mnarani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds function call to initialize OTG driver. This patch
also adds support for OTG device structure in DWC3 device.

Modifications to event buffer related functions which are called
from OTG driver upon requirement.

Signed-off-by: Manish Narani <mnarani@xilinx.com>
---
 drivers/usb/dwc3/core.c | 17 ++++++++++++-----
 drivers/usb/dwc3/core.h | 14 ++++++++++++++
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 369bab1..9ab9c5b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -240,7 +240,7 @@ static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
  * dwc3_free_event_buffers - frees all allocated event buffers
  * @dwc: Pointer to our controller context structure
  */
-static void dwc3_free_event_buffers(struct dwc3 *dwc)
+void dwc3_free_event_buffers(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
@@ -257,7 +257,7 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
  * Returns 0 on success otherwise negative errno. In the error case, dwc
  * may contain some buffers allocated but not all which were requested.
  */
-static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
+int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
 {
 	struct dwc3_event_buffer *evt;
 
@@ -277,7 +277,7 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
  *
  * Returns 0 on success otherwise negative errno.
  */
-static int dwc3_event_buffers_setup(struct dwc3 *dwc)
+int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
@@ -862,10 +862,10 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_OTG:
-		ret = dwc3_host_init(dwc);
+		ret = dwc3_otg_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to initialize host\n");
+				dev_err(dev, "failed to initialize otg\n");
 			return ret;
 		}
 
@@ -875,6 +875,13 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 				dev_err(dev, "failed to initialize gadget\n");
 			return ret;
 		}
+
+		ret = dwc3_host_init(dwc);
+		if (ret) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "failed to initialize host\n");
+			return ret;
+		}
 		break;
 	default:
 		dev_err(dev, "Unsupported mode of operation %d\n", dwc->dr_mode);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index de5a857..6b92064 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -887,6 +887,8 @@ struct dwc3 {
 	struct usb_gadget	gadget;
 	struct usb_gadget_driver *gadget_driver;
 
+	struct dwc3_otg		*otg;
+
 	struct usb_phy		*usb2_phy;
 	struct usb_phy		*usb3_phy;
 
@@ -987,6 +989,7 @@ struct dwc3 {
 	unsigned		setup_packet_pending:1;
 	unsigned		three_stage_setup:1;
 	unsigned		usb3_lpm_capable:1;
+	unsigned		remote_wakeup:1;
 
 	unsigned		disable_scramble_quirk:1;
 	unsigned		u2exit_lfps_quirk:1;
@@ -1220,6 +1223,13 @@ static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
 { return 0; }
 #endif
 
+#if IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
+int dwc3_otg_init(struct dwc3 *dwc);
+#else
+static inline int dwc3_otg_init(struct dwc3 *dwc)
+{ return 0; }
+#endif
+
 /* power management interface */
 #if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
 int dwc3_gadget_suspend(struct dwc3 *dwc);
@@ -1251,4 +1261,8 @@ static inline void dwc3_ulpi_exit(struct dwc3 *dwc)
 { }
 #endif
 
+int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length);
+void dwc3_free_event_buffers(struct dwc3 *dwc);
+int dwc3_event_buffers_setup(struct dwc3 *dwc);
+
 #endif /* __DRIVERS_USB_DWC3_CORE_H */
-- 
2.1.1
