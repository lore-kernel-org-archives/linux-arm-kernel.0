From: johnyoun@synopsys.com (John Youn)
Date: Wed, 24 Aug 2016 16:20:05 -0700
Subject: [RFT PATCH v2 4/4] usb: dwc2: Force mode optimizations
In-Reply-To: <cover.1471991702.git.johnyoun@synopsys.com>
References: <cover.1471991702.git.johnyoun@synopsys.com>
Message-ID: <460a317d00ab3923f63ce2811887581fbdbd0edb.1471991702.git.johnyoun@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the dr_mode is USB_DR_MODE_OTG, forcing the mode is needed during
driver probe to get the host and device specific HW parameters. Then we
clear the force mode bits so that the core operates in OTG mode.

The force mode bits should not be touched at any other time during the
driver lifetime and they should be preserved whenever the GUSBCFG
register is written to. The force mode bit values will presist across
soft resets of the core.

If the dr_mode is either USB_DR_MODE_HOST or USB_DR_MODE_PERIPHERAL, the
force mode is set just once at probe to configure the core as either a
host or peripheral.

Given the above, we no longer need any other reset delays, force delays,
or any forced modes anywhere else in the driver. So replace all calls to
dwc2_core_reset_and_force_dr_mode() with dwc2_core_reset() and remove
all other unnecessary delays.

Also remove the dwc2_force_mode_if_needed() function since the "if
needed" part is already taken care of by the polling in
dwc2_force_mode().

Finally, remove all other calls to dwc2_clear_force_mode().

Signed-off-by: John Youn <johnyoun@synopsys.com>
---
 drivers/usb/dwc2/core.c     | 66 ++++++++++-----------------------------------
 drivers/usb/dwc2/core.h     |  1 -
 drivers/usb/dwc2/hcd.c      |  6 ++---
 drivers/usb/dwc2/platform.c |  9 ++++++-
 4 files changed, 25 insertions(+), 57 deletions(-)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index caad6121..9b83b20 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -377,14 +377,14 @@ int dwc2_core_reset(struct dwc2_hsotg *hsotg)
 	return 0;
 }
 
-/*
- * Force the mode of the controller.
+/**
+ * dwc2_force_mode() - Force the mode of the controller.
  *
  * Forcing the mode is needed for two cases:
  *
  * 1) If the dr_mode is set to either HOST or PERIPHERAL we force the
  * controller to stay in a particular mode regardless of ID pin
- * changes. We do this usually after a core reset.
+ * changes. We do this once during probe.
  *
  * 2) During probe we want to read reset values of the hw
  * configuration registers that are only available in either host or
@@ -401,7 +401,7 @@ int dwc2_core_reset(struct dwc2_hsotg *hsotg)
  * the filter is configured and enabled. We poll the current mode of
  * the controller to account for this delay.
  */
-static bool dwc2_force_mode(struct dwc2_hsotg *hsotg, bool host)
+static void dwc2_force_mode(struct dwc2_hsotg *hsotg, bool host)
 {
 	u32 gusbcfg;
 	u32 set;
@@ -413,17 +413,17 @@ static bool dwc2_force_mode(struct dwc2_hsotg *hsotg, bool host)
 	 * Force mode has no effect if the hardware is not OTG.
 	 */
 	if (!dwc2_hw_is_otg(hsotg))
-		return false;
+		return;
 
 	/*
 	 * If dr_mode is either peripheral or host only, there is no
 	 * need to ever force the mode to the opposite mode.
 	 */
 	if (WARN_ON(host && hsotg->dr_mode == USB_DR_MODE_PERIPHERAL))
-		return false;
+		return;
 
 	if (WARN_ON(!host && hsotg->dr_mode == USB_DR_MODE_HOST))
-		return false;
+		return;
 
 	gusbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
 
@@ -450,6 +450,11 @@ static void dwc2_clear_force_mode(struct dwc2_hsotg *hsotg)
 {
 	u32 gusbcfg;
 
+	if (!dwc2_hw_is_otg(hsotg))
+		return;
+
+	dev_dbg(hsotg->dev, "Clearing force mode bits\n");
+
 	gusbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
 	gusbcfg &= ~GUSBCFG_FORCEHOSTMODE;
 	gusbcfg &= ~GUSBCFG_FORCEDEVMODE;
@@ -481,25 +486,6 @@ void dwc2_force_dr_mode(struct dwc2_hsotg *hsotg)
 	}
 }
 
-/*
- * Do core a soft reset of the core.  Be careful with this because it
- * resets all the internal state machines of the core.
- *
- * Additionally this will apply force mode as per the hsotg->dr_mode
- * parameter.
- */
-int dwc2_core_reset_and_force_dr_mode(struct dwc2_hsotg *hsotg)
-{
-	int retval;
-
-	retval = dwc2_core_reset(hsotg);
-	if (retval)
-		return retval;
-
-	dwc2_force_dr_mode(hsotg);
-	return 0;
-}
-
 /**
  * dwc2_dump_host_registers() - Prints the host registers
  *
@@ -1418,22 +1404,6 @@ void dwc2_set_parameters(struct dwc2_hsotg *hsotg,
 	dwc2_set_param_hibernation(hsotg, params->hibernation);
 }
 
-/*
- * Forces either host or device mode if the controller is not
- * currently in that mode.
- *
- * Returns true if the mode was forced.
- */
-static bool dwc2_force_mode_if_needed(struct dwc2_hsotg *hsotg, bool host)
-{
-	if (host && dwc2_is_host_mode(hsotg))
-		return false;
-	else if (!host && dwc2_is_device_mode(hsotg))
-		return false;
-
-	return dwc2_force_mode(hsotg, host);
-}
-
 /*
  * Gets host hardware parameters. Forces host mode if not currently in
  * host mode. Should be called immediately after a core soft reset in
@@ -1444,21 +1414,17 @@ static void dwc2_get_host_hwparams(struct dwc2_hsotg *hsotg)
 	struct dwc2_hw_params *hw = &hsotg->hw_params;
 	u32 gnptxfsiz;
 	u32 hptxfsiz;
-	bool forced;
 
 	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
 		return;
 
-	forced = dwc2_force_mode_if_needed(hsotg, true);
+	dwc2_force_mode(hsotg, true);
 
 	gnptxfsiz = dwc2_readl(hsotg->regs + GNPTXFSIZ);
 	hptxfsiz = dwc2_readl(hsotg->regs + HPTXFSIZ);
 	dev_dbg(hsotg->dev, "gnptxfsiz=%08x\n", gnptxfsiz);
 	dev_dbg(hsotg->dev, "hptxfsiz=%08x\n", hptxfsiz);
 
-	if (forced)
-		dwc2_clear_force_mode(hsotg);
-
 	hw->host_nperio_tx_fifo_size = (gnptxfsiz & FIFOSIZE_DEPTH_MASK) >>
 				       FIFOSIZE_DEPTH_SHIFT;
 	hw->host_perio_tx_fifo_size = (hptxfsiz & FIFOSIZE_DEPTH_MASK) >>
@@ -1473,20 +1439,16 @@ static void dwc2_get_host_hwparams(struct dwc2_hsotg *hsotg)
 static void dwc2_get_dev_hwparams(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_hw_params *hw = &hsotg->hw_params;
-	bool forced;
 	u32 gnptxfsiz;
 
 	if (hsotg->dr_mode == USB_DR_MODE_HOST)
 		return;
 
-	forced = dwc2_force_mode_if_needed(hsotg, false);
+	dwc2_force_mode(hsotg, false);
 
 	gnptxfsiz = dwc2_readl(hsotg->regs + GNPTXFSIZ);
 	dev_dbg(hsotg->dev, "gnptxfsiz=%08x\n", gnptxfsiz);
 
-	if (forced)
-		dwc2_clear_force_mode(hsotg);
-
 	hw->dev_nperio_tx_fifo_size = (gnptxfsiz & FIFOSIZE_DEPTH_MASK) >>
 				       FIFOSIZE_DEPTH_SHIFT;
 }
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 2a21a04..b7ff083 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1021,7 +1021,6 @@ enum dwc2_halt_status {
  * and the DWC_otg controller
  */
 extern int dwc2_core_reset(struct dwc2_hsotg *hsotg);
-extern int dwc2_core_reset_and_force_dr_mode(struct dwc2_hsotg *hsotg);
 extern int dwc2_enter_hibernation(struct dwc2_hsotg *hsotg);
 extern int dwc2_exit_hibernation(struct dwc2_hsotg *hsotg, bool restore);
 
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index df5a065..6f09254 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -134,7 +134,7 @@ static int dwc2_fs_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 			dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
 
 			/* Reset after a PHY select */
-			retval = dwc2_core_reset_and_force_dr_mode(hsotg);
+			retval = dwc2_core_reset(hsotg);
 
 			if (retval) {
 				dev_err(hsotg->dev,
@@ -214,7 +214,7 @@ static int dwc2_hs_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 		dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
 
 		/* Reset after setting the PHY parameters */
-		retval = dwc2_core_reset_and_force_dr_mode(hsotg);
+		retval = dwc2_core_reset(hsotg);
 		if (retval) {
 			dev_err(hsotg->dev,
 				"%s: Reset failed, aborting", __func__);
@@ -2204,7 +2204,7 @@ static int dwc2_core_init(struct dwc2_hsotg *hsotg, bool initial_setup)
 	 * needed to in order to properly detect various parameters).
 	 */
 	if (!initial_setup) {
-		retval = dwc2_core_reset_and_force_dr_mode(hsotg);
+		retval = dwc2_core_reset(hsotg);
 		if (retval) {
 			dev_err(hsotg->dev, "%s(): Reset failed, aborting\n",
 				__func__);
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 530959a..1ef8bfe 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -590,7 +590,9 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	 * Reset before dwc2_get_hwparams() then it could get power-on real
 	 * reset value form registers.
 	 */
-	dwc2_core_reset_and_force_dr_mode(hsotg);
+	retval = dwc2_core_reset(hsotg);
+	if (retval)
+		goto error;
 
 	/* Detect config values from hardware */
 	retval = dwc2_get_hwparams(hsotg);
@@ -600,6 +602,11 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	/* Validate parameter values */
 	dwc2_set_parameters(hsotg, params);
 
+	/*
+	 * For OTG cores, set the force mode bits to reflect the value
+	 * of dr_mode. Force mode bits should not be touched at any
+	 * other time after this.
+	 */
 	dwc2_force_dr_mode(hsotg);
 
 	if (hsotg->dr_mode != USB_DR_MODE_HOST) {
-- 
2.9.0
