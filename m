From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 9 Aug 2013 20:16:01 +0800
Subject: [PATCH v14 11/12] usb: chipidea: udc: misuse flag
 CI_HDRC_REGS_SHARED and CI_HDRC_PULLUP_ON_VBUS
In-Reply-To: <20130809114559.GC24763@shlinux1.ap.freescale.net>
References: <1375432445-31918-1-git-send-email-peter.chen@freescale.com>
 <1375432445-31918-12-git-send-email-peter.chen@freescale.com>
 <874nazathc.fsf@ashishki-desk.ger.corp.intel.com>
 <20130809114559.GC24763@shlinux1.ap.freescale.net>
Message-ID: <20130809121600.GA26158@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 07:46:00PM +0800, Peter Chen wrote:
> On Fri, Aug 09, 2013 at 04:23:11PM +0300, Alexander Shishkin wrote:
> > Peter Chen <peter.chen@freescale.com> writes:
> > 
> > > CI_HDRC_REGS_SHARED stands for the controller registers is shared
> > > with other USB drivers, if all USB drivers are at chipidea/, it doesn't
> > > needed to set.
> > 
> > We still have the msm driver that uses REGS_SHARED.
> > 
> 
> Yes, I have considered it. At udc interrupt handler, the REGS_SHARED
> is still used. The msm set both CI_HDRC_REGS_SHARED and CI_HDRC_PULLUP_ON_VBUS.
> 
> > > CI_HDRC_PULLUP_ON_VBUS stands for pullup dp when the vbus is on. This
> > > flag doesn't need to set if the vbus is always on for gadget
> > > since dp has always pulled up after the gadget has initialized.
> > 
> > Didn't we agree at some point to get rid of this flag altogether once we
> > have proper VBUS detection?
> 
> Yes, we can delete it now, the reason why I haven't remove it is:
> I met some use cases that the vbus is always on recently,
> no connection/disconnection. Eg, the USB audio device connects
> to Apple Sound machine, the vbus is the power of the device system.
> 
> I checked the code just now again, we can cover such kind of case.

I will have a patch to delete CI_HDRC_PULLUP_ON_VBUS. If we squash
two patches, the change like below:

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index bd1fe25..ab3e74a 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -91,7 +91,6 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		.name		= "ci_hdrc_imx",
 		.capoffset	= DEF_CAPOFFSET,
 		.flags		= CI_HDRC_REQUIRE_TRANSCEIVER |
-				  CI_HDRC_PULLUP_ON_VBUS |
 				  CI_HDRC_DISABLE_STREAMING,
 	};
 	int ret;
diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index fb657ef..2d51d85 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -49,7 +49,6 @@ static struct ci_hdrc_platform_data ci_hdrc_msm_platdata = {
 	.name			= "ci_hdrc_msm",
 	.flags			= CI_HDRC_REGS_SHARED |
 				  CI_HDRC_REQUIRE_TRANSCEIVER |
-				  CI_HDRC_PULLUP_ON_VBUS |
 				  CI_HDRC_DISABLE_STREAMING,
 
 	.notify_event		= ci_hdrc_msm_notify_event,
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index c70ce38..f77c904 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1635,14 +1635,11 @@ static int ci_udc_start(struct usb_gadget *gadget,
 
 	ci->driver = driver;
 	pm_runtime_get_sync(&ci->gadget.dev);
-	if (ci->platdata->flags & CI_HDRC_PULLUP_ON_VBUS) {
-		if (ci->vbus_active) {
-			if (ci->platdata->flags & CI_HDRC_REGS_SHARED)
-				hw_device_reset(ci, USBMODE_CM_DC);
-		} else {
-			pm_runtime_put_sync(&ci->gadget.dev);
-			goto done;
-		}
+	if (ci->vbus_active) {
+		hw_device_reset(ci, USBMODE_CM_DC);
+	} else {
+		pm_runtime_put_sync(&ci->gadget.dev);
+		goto done;
 	}
 
 	retval = hw_device_state(ci, ci->ep0out->qh.dma);
@@ -1665,8 +1662,7 @@ static int ci_udc_stop(struct usb_gadget *gadget,
 
 	spin_lock_irqsave(&ci->lock, flags);
 
-	if (!(ci->platdata->flags & CI_HDRC_PULLUP_ON_VBUS) ||
-			ci->vbus_active) {
+	if (ci->vbus_active) {
 		hw_device_state(ci, 0);
 		if (ci->platdata->notify_event)
 			ci->platdata->notify_event(ci,
@@ -1801,12 +1797,6 @@ static int udc_start(struct ci_hdrc *ci)
 		}
 	}
 
-	if (!(ci->platdata->flags & CI_HDRC_REGS_SHARED)) {
-		retval = hw_device_reset(ci, USBMODE_CM_DC);
-		if (retval)
-			goto put_transceiver;
-	}
-
 	if (ci->transceiver) {
 		retval = otg_set_peripheral(ci->transceiver->otg,
 						&ci->gadget);
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 10a607c..7c4ba37 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -18,13 +18,12 @@ struct ci_hdrc_platform_data {
 	unsigned long	 flags;
 #define CI_HDRC_REGS_SHARED		BIT(0)
 #define CI_HDRC_REQUIRE_TRANSCEIVER	BIT(1)
-#define CI_HDRC_PULLUP_ON_VBUS		BIT(2)
-#define CI_HDRC_DISABLE_STREAMING	BIT(3)
+#define CI_HDRC_DISABLE_STREAMING	BIT(2)
 	/*
 	 * Only set it when DCCPARAMS.DC==1 and DCCPARAMS.HC==1,
 	 * but otg is not supported (no register otgsc).
 	 */
-#define CI_HDRC_DUAL_ROLE_NOT_OTG	BIT(4)
+#define CI_HDRC_DUAL_ROLE_NOT_OTG	BIT(3)
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1

-- 

Best Regards,
Peter Chen
