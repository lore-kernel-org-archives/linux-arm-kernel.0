From: johnyoun@synopsys.com (John Youn)
Date: Wed, 24 Aug 2016 16:19:58 -0700
Subject: [RFT PATCH v2 2/4] usb: dwc2: Add delay to core soft reset
In-Reply-To: <cover.1471991702.git.johnyoun@synopsys.com>
References: <cover.1471991702.git.johnyoun@synopsys.com>
Message-ID: <b0fed73f267ff65a7da17e24585e9d2a18779ec9.1471991702.git.johnyoun@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a delay to the core soft reset function to account for the IDDIG
debounce filter.

If the current mode is host, either due to the force mode bit being
set (which persists after core reset) or the connector id pin, a core
soft reset will temporarily reset the mode to device and a delay from
the IDDIG debounce filter will occur before going back to host mode.

Signed-off-by: John Youn <johnyoun@synopsys.com>
---
 drivers/usb/dwc2/core.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc2/core.h |  1 +
 drivers/usb/dwc2/hw.h   |  1 +
 3 files changed, 99 insertions(+)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index 4135a5f..bb903e2 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -238,6 +238,78 @@ int dwc2_enter_hibernation(struct dwc2_hsotg *hsotg)
 	return ret;
 }
 
+/**
+ * dwc2_wait_for_mode() - Waits for the controller mode.
+ * @hsotg:	Programming view of the DWC_otg controller.
+ * @host_mode:	If true, waits for host mode, otherwise device mode.
+ * @timeout:	Time to wait in ms.
+ */
+static void dwc2_wait_for_mode(struct dwc2_hsotg *hsotg,
+			       bool host_mode,
+			       unsigned int timeout)
+{
+	ktime_t start;
+	ktime_t end;
+
+	dev_vdbg(hsotg->dev, "Waiting for %s mode\n",
+		 host_mode ? "host" : "device");
+
+	start = ktime_get();
+
+	while (1) {
+		s64 ms;
+
+		if (dwc2_is_host_mode(hsotg) == host_mode) {
+			dev_vdbg(hsotg->dev, "%s mode set\n",
+				 host_mode ? "Host" : "Device");
+			break;
+		}
+
+		end = ktime_get();
+		ms = ktime_to_ms(ktime_sub(end, start));
+
+		if (ms >= (s64)timeout) {
+			dev_warn(hsotg->dev, "%s: Couldn't set %s mode\n",
+				 __func__, host_mode ? "host" : "device");
+			break;
+		}
+
+		usleep_range(1000, 2000);
+	}
+}
+
+/**
+ * dwc2_iddig_filter_enabled() - Returns true if the IDDIG debounce
+ * filter is enabled.
+ */
+static bool dwc2_iddig_filter_enabled(struct dwc2_hsotg *hsotg)
+{
+	u32 gsnpsid;
+	u32 ghwcfg4;
+
+	if (!dwc2_hw_is_otg(hsotg))
+		return false;
+
+	/* Check if core configuration includes the IDDIG filter. */
+	ghwcfg4 = dwc2_readl(hsotg->regs + GHWCFG4);
+	if (!(ghwcfg4 & GHWCFG4_IDDIG_FILT_EN))
+		return false;
+
+	/*
+	 * Check if the IDDIG debounce filter is bypassed. Available
+	 * in core version >= 3.10a.
+	 */
+	gsnpsid = dwc2_readl(hsotg->regs + GSNPSID);
+	if (gsnpsid >= DWC2_CORE_REV_3_10a) {
+		u32 gotgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+
+		if (gotgctl & GOTGCTL_DBNCE_FLTR_BYPASS)
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * Do core a soft reset of the core.  Be careful with this because it
  * resets all the internal state machines of the core.
@@ -246,9 +318,30 @@ int dwc2_core_reset(struct dwc2_hsotg *hsotg)
 {
 	u32 greset;
 	int count = 0;
+	bool wait_for_host_mode = false;
 
 	dev_vdbg(hsotg->dev, "%s()\n", __func__);
 
+	/*
+	 * If the current mode is host, either due to the force mode
+	 * bit being set (which persists after core reset) or the
+	 * connector id pin, a core soft reset will temporarily reset
+	 * the mode to device. A delay from the IDDIG debounce filter
+	 * will occur before going back to host mode.
+	 *
+	 * Determine whether we will go back into host mode after a
+	 * reset and account for this delay after the reset.
+	 */
+	if (dwc2_iddig_filter_enabled(hsotg)) {
+		u32 gotgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+		u32 gusbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+
+		if (!(gotgctl & GOTGCTL_CONID_B) ||
+		    (gusbcfg & GUSBCFG_FORCEHOSTMODE)) {
+			wait_for_host_mode = true;
+		}
+	}
+
 	/* Core Soft Reset */
 	greset = dwc2_readl(hsotg->regs + GRSTCTL);
 	greset |= GRSTCTL_CSFTRST;
@@ -277,6 +370,10 @@ int dwc2_core_reset(struct dwc2_hsotg *hsotg)
 		}
 	} while (!(greset & GRSTCTL_AHBIDLE));
 
+	/* Wait up to 50 ms for the IDDIG debounce filter. */
+	if (wait_for_host_mode)
+		dwc2_wait_for_mode(hsotg, true, 50);
+
 	return 0;
 }
 
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index d645512..2a21a04 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -890,6 +890,7 @@ struct dwc2_hsotg {
 #define DWC2_CORE_REV_2_92a	0x4f54292a
 #define DWC2_CORE_REV_2_94a	0x4f54294a
 #define DWC2_CORE_REV_3_00a	0x4f54300a
+#define DWC2_CORE_REV_3_10a	0x4f54310a
 
 #if IS_ENABLED(CONFIG_USB_DWC2_HOST) || IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
 	union dwc2_hcd_internal_flags {
diff --git a/drivers/usb/dwc2/hw.h b/drivers/usb/dwc2/hw.h
index efc3bcd..9105844 100644
--- a/drivers/usb/dwc2/hw.h
+++ b/drivers/usb/dwc2/hw.h
@@ -48,6 +48,7 @@
 #define GOTGCTL_ASESVLD			(1 << 18)
 #define GOTGCTL_DBNC_SHORT		(1 << 17)
 #define GOTGCTL_CONID_B			(1 << 16)
+#define GOTGCTL_DBNCE_FLTR_BYPASS	(1 << 15)
 #define GOTGCTL_DEVHNPEN		(1 << 11)
 #define GOTGCTL_HSTSETHNPEN		(1 << 10)
 #define GOTGCTL_HNPREQ			(1 << 9)
-- 
2.9.0
