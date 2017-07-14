From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 14 Jul 2017 14:40:04 -0700
Subject: [PATCH v2 2/3] usb: chipidea: Hook into mux framework to toggle usb
 switch
In-Reply-To: <20170714214005.14967-1-stephen.boyd@linaro.org>
References: <20170714214005.14967-1-stephen.boyd@linaro.org>
Message-ID: <20170714214005.14967-3-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the db410c 96boards platform we have a TC7USB40MU on the board
to mux the D+/D- lines coming from the controller between a micro
usb "device" port and a USB hub for "host" roles[1]. During a
role switch, we need to toggle this mux to forward the D+/D-
lines to either the port or the hub. Add the necessary code to do
the role switch in chipidea core via the generic mux framework.
Board configurations like on db410c are expected to change roles
via the sysfs API described in
Documentation/ABI/testing/sysfs-platform-chipidea-usb2.

[1] https://github.com/96boards/documentation/raw/master/ConsumerEdition/DragonBoard-410c/HardwareDocs/Schematics_DragonBoard.pdf

Cc: Peter Rosin <peda@axentia.se>
Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt |  6 ++++++
 drivers/usb/chipidea/Kconfig                           |  1 +
 drivers/usb/chipidea/core.c                            |  5 +++++
 drivers/usb/chipidea/host.c                            |  7 +++++++
 drivers/usb/chipidea/udc.c                             | 13 ++++++++++++-
 include/linux/usb/chipidea.h                           |  2 ++
 6 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index 0e03344e2e8b..2e9318151df7 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -76,6 +76,10 @@ Optional properties:
   needs to make sure it does not send more than 90%
   maximum_periodic_data_per_frame. The use case is multiple transactions, but
   less frame rate.
+- mux-controls: The mux control for toggling host/device output of this
+  controller. It's expected that a mux state of 0 indicates device mode and a
+  mux state of 1 indicates host mode.
+- mux-control-names: Shall be "usb_switch" if mux-controls is specified.
 
 i.mx specific properties
 - fsl,usbmisc: phandler of non-core register device, with one
@@ -102,4 +106,6 @@ Example:
 		rx-burst-size-dword = <0x10>;
 		extcon = <0>, <&usb_id>;
 		phy-clkgate-delay-us = <400>;
+		mux-controls = <&usb_switch>;
+		mux-control-names = "usb_switch";
 	};
diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
index 51f4157bbecf..3798e0e69d57 100644
--- a/drivers/usb/chipidea/Kconfig
+++ b/drivers/usb/chipidea/Kconfig
@@ -3,6 +3,7 @@ config USB_CHIPIDEA
 	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
 	select EXTCON
 	select RESET_CONTROLLER
+	select MULTIPLEXER
 	help
 	  Say Y here if your system has a dual role high speed USB
 	  controller based on ChipIdea silicon IP. It supports:
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index b17ed3a9a304..d088c262ebb8 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -64,6 +64,7 @@
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/ehci_def.h>
+#include <linux/mux/consumer.h>
 
 #include "ci.h"
 #include "udc.h"
@@ -690,6 +691,10 @@ static int ci_get_platdata(struct device *dev,
 	if (of_find_property(dev->of_node, "non-zero-ttctrl-ttha", NULL))
 		platdata->flags |= CI_HDRC_SET_NON_ZERO_TTHA;
 
+	platdata->usb_switch = devm_mux_control_get_optional(dev, "usb_switch");
+	if (IS_ERR(platdata->usb_switch))
+		return PTR_ERR(platdata->usb_switch);
+
 	ext_id = ERR_PTR(-ENODEV);
 	ext_vbus = ERR_PTR(-ENODEV);
 	if (of_property_read_bool(dev->of_node, "extcon")) {
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index 18cb8e46262d..9ef3ecf27ad3 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -25,6 +25,7 @@
 #include <linux/usb/hcd.h>
 #include <linux/usb/chipidea.h>
 #include <linux/regulator/consumer.h>
+#include <linux/mux/consumer.h>
 
 #include "../host/ehci.h"
 
@@ -175,6 +176,10 @@ static int host_start(struct ci_hdrc *ci)
 		if (ci_otg_is_fsm_mode(ci)) {
 			otg->host = &hcd->self;
 			hcd->self.otg_port = 1;
+		} else {
+			ret = mux_control_select(ci->platdata->usb_switch, 1);
+			if (ret)
+				goto disable_reg;
 		}
 	}
 
@@ -195,6 +200,8 @@ static void host_stop(struct ci_hdrc *ci)
 	struct usb_hcd *hcd = ci->hcd;
 
 	if (hcd) {
+		if (!ci_otg_is_fsm_mode(ci))
+			mux_control_deselect(ci->platdata->usb_switch);
 		if (ci->platdata->notify_event)
 			ci->platdata->notify_event(ci,
 				CI_HDRC_CONTROLLER_STOPPED_EVENT);
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index d68b125796f9..deb18099e168 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -22,6 +22,7 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg-fsm.h>
 #include <linux/usb/chipidea.h>
+#include <linux/mux/consumer.h>
 
 #include "ci.h"
 #include "udc.h"
@@ -1964,16 +1965,26 @@ void ci_hdrc_gadget_destroy(struct ci_hdrc *ci)
 
 static int udc_id_switch_for_device(struct ci_hdrc *ci)
 {
+	int ret = 0;
+
 	if (ci->is_otg)
 		/* Clear and enable BSV irq */
 		hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE,
 					OTGSC_BSVIS | OTGSC_BSVIE);
 
-	return 0;
+	if (!ci_otg_is_fsm_mode(ci))
+		ret = mux_control_select(ci->platdata->usb_switch, 0);
+
+	if (ci->is_otg && ret)
+		hw_write_otgsc(ci, OTGSC_BSVIE | OTGSC_BSVIS, OTGSC_BSVIS);
+
+	return ret;
 }
 
 static void udc_id_switch_for_host(struct ci_hdrc *ci)
 {
+	mux_control_deselect(ci->platdata->usb_switch);
+
 	/*
 	 * host doesn't care B_SESSION_VALID event
 	 * so clear and disbale BSV irq
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index c5fdfcf99828..3b27e333de1d 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -9,6 +9,7 @@
 #include <linux/usb/otg.h>
 
 struct ci_hdrc;
+struct mux_control;
 
 /**
  * struct ci_hdrc_cable - structure for external connector cable state tracking
@@ -74,6 +75,7 @@ struct ci_hdrc_platform_data {
 	/* VBUS and ID signal state tracking, using extcon framework */
 	struct ci_hdrc_cable		vbus_extcon;
 	struct ci_hdrc_cable		id_extcon;
+	struct mux_control		*usb_switch;
 	u32			phy_clkgate_delay_us;
 };
 
-- 
2.10.0.297.gf6727b0
