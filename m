From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Aug 2015 10:35:53 -0500
Subject: [PATCH v5 01/46] usb: gadget: encapsulate endpoint claiming
 mechanism
In-Reply-To: <1438351258-31578-2-git-send-email-r.baldyga@samsung.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-2-git-send-email-r.baldyga@samsung.com>
Message-ID: <20150820153553.GD1639@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 31, 2015 at 04:00:13PM +0200, Robert Baldyga wrote:
> So far it was necessary for usb functions to set ep->driver_data in
> endpoint obtained from autoconfig to non-null value, to indicate that
> endpoint is claimed by function (in autoconfig it was checked if endpoint
> has set this field to non-null value, and if it has, it was assumed that
> it is claimed). It could cause bugs because if some function doesn't
> set this field autoconfig could return the same endpoint more than one
> time.
> 
> To help to avoid such bugs this patch adds claimed flag to struct usb_ep,
> and  encapsulates endpoint claiming mechanism inside usb_ep_autoconfig_ss()
> and usb_ep_autoconfig_reset(), so now usb functions don't need to perform
> any additional actions to mark endpoint obtained from autoconfig as claimed.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

just letting you know that this regresses all gadget drivers making them
try to disable previously disabled endpoints and enable previously
enabled endpoints.

I have a possible fix (see below) but then it shows a problem on the
host side when using with g_zero (see further below):

commit 3b8932100aacb6cfbffe288ca93025d8b8430c00
Author: Felipe Balbi <balbi@ti.com>
Date:   Wed Aug 19 18:05:27 2015 -0500

    usb: gadget: fix ep->claimed lifetime
    
    In order to fix a regression introduced by commit
    cc476b42a39d ("usb: gadget: encapsulate endpoint
    claiming mechanism") we have to introduce a simple
    helper to check if a particular is enabled or not.
    
    After that, we need to move ep->claimed lifetime to
    usb_ep_enable() and usb_ep_disable() since those
    are the only functions which actually enable and
    disable endpoints.
    
    A follow-up patch will come to drop all driver_data
    checks from function drivers, since those are, now,
    pointless.
    
    Fixes: cc476b42a39d ("usb: gadget: encapsulate endpoint
    	claiming mechanism")
    Cc: Robert Baldyga <r.baldyga@samsung.com>
    Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 978435a51038..ad45070cd76f 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -126,7 +126,6 @@ found_ep:
 	ep->address = desc->bEndpointAddress;
 	ep->desc = NULL;
 	ep->comp_desc = NULL;
-	ep->claimed = true;
 	return ep;
 }
 EXPORT_SYMBOL_GPL(usb_ep_autoconfig_ss);
@@ -182,11 +181,6 @@ EXPORT_SYMBOL_GPL(usb_ep_autoconfig);
  */
 void usb_ep_autoconfig_reset (struct usb_gadget *gadget)
 {
-	struct usb_ep	*ep;
-
-	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
-		ep->claimed = false;
-	}
 	gadget->in_epnum = 0;
 	gadget->out_epnum = 0;
 }
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index c14a69b36d27..9b3d60c1cf9f 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -243,6 +243,22 @@ static inline void usb_ep_set_maxpacket_limit(struct usb_ep *ep,
 }
 
 /**
+ * usb_ep_enabled - is endpoint enabled ?
+ * @ep: the endpoint being checked. may not be the endpoint named "ep0".
+ *
+ * Whenever a function driver wants to check if a particular endpoint is
+ * enabled or not, it must check using this helper function. This will
+ * encapsulate details about how the endpoint is checked, saving the function
+ * driver from using private methods for doing so.
+ *
+ * return true if endpoint is enabled, false otherwise.
+ */
+static inline bool usb_ep_enabled(struct usb_ep *ep)
+{
+	return ep->claimed;
+}
+
+/**
  * usb_ep_enable - configure endpoint, making it usable
  * @ep:the endpoint being configured.  may not be the endpoint named "ep0".
  *	drivers discover endpoints through the ep_list of a usb_gadget.
@@ -264,7 +280,18 @@ static inline void usb_ep_set_maxpacket_limit(struct usb_ep *ep,
  */
 static inline int usb_ep_enable(struct usb_ep *ep)
 {
-	return ep->ops->enable(ep, ep->desc);
+	int ret;
+
+	if (usb_ep_enabled(ep))
+		return 0;
+
+	ret = ep->ops->enable(ep, ep->desc);
+	if (ret)
+		return ret;
+
+	ep->claimed = true;
+
+	return 0;
 }
 
 /**
@@ -281,7 +308,18 @@ static inline int usb_ep_enable(struct usb_ep *ep)
  */
 static inline int usb_ep_disable(struct usb_ep *ep)
 {
-	return ep->ops->disable(ep);
+	int ret;
+
+	if (!usb_ep_enabled(ep))
+		return 0;
+
+	ret = ep->ops->disable(ep);
+	if (ret)
+		return ret;
+
+	ep->claimed = false;
+
+	return 0;
 }
 
 /**



[   73.290345] WARNING: CPU: 0 PID: 300 at lib/kobject.c:240 kobject_add_internal+0x25c/0x2d8()
[   73.299172] kobject_add_internal failed for ep_81 with -EEXIST, don't try to register things with the same name in the same directory.
[   73.311825] Modules linked in: usbtest usb_f_ss_lb g_zero libcomposite xhci_plat_hcd xhci_hcd usbcore joydev dwc3 udc_core usb_common m25p80 evdev spi_nor omapfb cpufreq_dt cfbfillrect snd_soc_simple_card cfbimgblt thermal_sys cfbcopyarea hwmon leds_gpio matrix_keypad led_class matrix_keymap panel_dpi pwm_bl snd_soc_tlv320aic3x snd_soc_davinci_mcasp snd_soc_edma snd_soc_omap snd_soc_core omapdss snd_compress snd_pcm_dmaengine snd_pcm dwc3_omap extcon snd_timer pwm_tiecap snd lis3lv02d_i2c lis3lv02d soundcore  input_polldev spi_ti_qspi tps65218_pwrbutton rtc_omap omap_wdt phy_omap_usb2 autofs4
 [   73.367114] CPU: 0 PID: 300 Comm: testusb Tainted: G        W  4.2.0-rc7-next-20150819-00002-g3ccb6c8b6305 #1080
 [   73.378236] Hardware name: Generic AM43 (Flattened Device Tree)
 [   73.384439] [<c0016f14>] (unwind_backtrace) from [<c001339c>] (show_stack+0x10/0x14)
 [   73.392566] [<c001339c>] (show_stack) from [<c0636cec>] (dump_stack+0x84/0x9c)
 [   73.400164] [<c0636cec>] (dump_stack) from [<c003db48>] (warn_slowpath_common+0x78/0xb4)
 [   73.408649] [<c003db48>] (warn_slowpath_common) from [<c003dbb4>] (warn_slowpath_fmt+0x30/0x40)
 [   73.417783] [<c003dbb4>] (warn_slowpath_fmt) from [<c03473e4>] (kobject_add_internal+0x25c/0x2d8)
 [   73.427063] [<c03473e4>] (kobject_add_internal) from [<c03474ac>] (kobject_add+0x4c/0x98)
 [   73.435641] [<c03474ac>] (kobject_add) from [<c03d8a58>] (device_add+0xd4/0x56c)
 [   73.443466] [<c03d8a58>] (device_add) from [<bf2c17b0>] (usb_create_ep_devs+0x60/0xac [usbcore])
 [   73.452788] [<bf2c17b0>] (usb_create_ep_devs [usbcore]) from [<bf2bb210>] (create_intf_ep_devs+0x48/0x70 [usbcore])
 [   73.463801] [<bf2bb210>] (create_intf_ep_devs [usbcore]) from [<bf2bbae0>] (usb_set_interface+0x1c4/0x2f4 [usbcore])
 [   73.474891] [<bf2bbae0>] (usb_set_interface [usbcore]) from [<bf33d370>] (usbtest_ioctl+0x840/0x14c8 [usbtest])
 [   73.485659] [<bf33d370>] (usbtest_ioctl [usbtest]) from [<bf2c569c>] (usbdev_ioctl+0x1728/0x17fc [usbcore])
 [   73.495947] [<bf2c569c>] (usbdev_ioctl [usbcore]) from [<c0185764>] (do_vfs_ioctl+0x3f4/0x6c4)
 [   73.504989] [<c0185764>] (do_vfs_ioctl) from [<c0185aa0>] (SyS_ioctl+0x6c/0x7c)
 [   73.512662] [<c0185aa0>] (SyS_ioctl) from [<c000f540>] (ret_fast_syscall+0x0/0x54)
 [   73.520605] ---[ end trace 4576b2ea698fb13f ]---


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/a85def20/attachment.sig>
