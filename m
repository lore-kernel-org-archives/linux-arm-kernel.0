From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 25 Jan 2013 11:40:10 +0200
Subject: [RESEND PATCH v5 3/7] usb: chipidea: add otg id switch and vbus
 connect/disconnect detect
In-Reply-To: <20130125062827.GD29795@nchen-desktop>
References: <1358733418-17969-1-git-send-email-peter.chen@freescale.com>
 <1358733418-17969-4-git-send-email-peter.chen@freescale.com>
 <87y5fimwma.fsf@ashishki-desk.ger.corp.intel.com>
 <20130125062827.GD29795@nchen-desktop>
Message-ID: <87wqv1bnyd.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> On Thu, Jan 24, 2013 at 05:25:17PM +0200, Alexander Shishkin wrote:
>> Peter Chen <peter.chen@freescale.com> writes:
>> 
>> > The main design flow is the same with msm otg driver, that is the id and
>> > vbus interrupt are handled at core driver, others are handled by
>> > individual drivers.
>> >
>> > - At former design, when switch usb role from device->host, it will call
>> > udc_stop, it will remove the gadget driver, so when switch role
>> > from host->device, it can't add gadget driver any more.
>> > At new design, when role switch occurs, the gadget just calls
>> > usb_gadget_vbus_disconnect/usb_gadget_vbus_connect as well as
>> > reset controller, it will not free any device/gadget structure
>> >
>> > - Add vbus connect and disconnect to core interrupt handler, it can
>> > notify udc driver by calling usb_gadget_vbus_disconnect
>> > /usb_gadget_vbus_connect.
>> >
>> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
>> 
>> [snip]
>> 
>> > @@ -483,6 +614,17 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>> >  		goto rm_wq;
>> >  	}
>> >  
>> > +	otgsc = hw_read(ci, OP_OTGSC, ~0);
>> > +	/*
>> > +	 * if it is device mode:
>> > +	 * - Enable vbus detect
>> > +	 * - If it has already connected to host, notify udc
>> > +	 */
>> > +	if (ci->role == CI_ROLE_GADGET) {
>> > +		ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
>> > +		ci_handle_vbus_change(ci);
>> > +	}
>> > +
>> 
>> Actually, this doesn't work, neither here, nor in udc_start(), where the
>> next patch moves it. If you start in host role with A plug, unplug it,
>> plug B and load a gadget module,
>
> When we unplug A, device's role start will be called, that is
> udc_id_switch_for_device in my patch, it will enable vbus interrupt.
> Then, when we plug B, there will be an vbus interrupt, then the
> ci->vbus_active will be set, then when we load a gadget module, 
> the enumeration will begin like I said at last email.

What doesn't happen is the reset into device mode (unless you have
_REGS_SHARED set, which by the way seems a bit misleading) and we're
still doing nothing till the vbus interrupt comes. So the REGS_SHARED is
the real problem in this case.

Now, looking at ci13xxx_{start,stop}(), I'm seeing some more code
duplication. What do think about something like this (untested):

---cut---
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index dcac77c..38446de 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1351,6 +1351,28 @@ static const struct usb_ep_ops usb_ep_ops = {
 	.fifo_flush    = ep_fifo_flush,
 };
 
+static int hw_device_connect(struct ci13xxx *ci, int connect)
+{
+	int ret;
+
+	if (connect) {
+		pm_runtime_get_sync(&ci->gadget.dev);
+		ret = hw_device_reset(ci, USBMODE_CM_DC);
+		hw_device_state(ci, ci->ep0out->qh.dma);
+		dev_dbg(ci->dev, "Connected to host\n");
+	} else {
+		hw_device_state(ci, 0);
+		if (ci->platdata->notify_event)
+			ci->platdata->notify_event(ci,
+					CI13XXX_CONTROLLER_STOPPED_EVENT);
+		ret = _gadget_stop_activity(&ci->gadget);
+		pm_runtime_put_sync(&ci->gadget.dev);
+		dev_dbg(ci->dev, "Disconnected from host\n");
+	}
+
+	return ret;
+}
+
 /******************************************************************************
  * GADGET block
  *****************************************************************************/
@@ -1358,7 +1380,7 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
 {
 	struct ci13xxx *ci = container_of(_gadget, struct ci13xxx, gadget);
 	unsigned long flags;
-	int gadget_ready = 0;
+	int gadget_ready = 0, ret = 0;
 
 	spin_lock_irqsave(&ci->lock, flags);
 	ci->vbus_active = is_active;
@@ -1366,24 +1388,10 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
 		gadget_ready = 1;
 	spin_unlock_irqrestore(&ci->lock, flags);
 
-	if (gadget_ready) {
-		if (is_active) {
-			pm_runtime_get_sync(&_gadget->dev);
-			hw_device_reset(ci, USBMODE_CM_DC);
-			hw_device_state(ci, ci->ep0out->qh.dma);
-			dev_dbg(ci->dev, "Connected to host\n");
-		} else {
-			hw_device_state(ci, 0);
-			if (ci->platdata->notify_event)
-				ci->platdata->notify_event(ci,
-				CI13XXX_CONTROLLER_STOPPED_EVENT);
-			_gadget_stop_activity(&ci->gadget);
-			pm_runtime_put_sync(&_gadget->dev);
-			dev_dbg(ci->dev, "Disconnected from host\n");
-		}
-	}
+	if (gadget_ready)
+		ret = hw_device_connect(ci, is_active);
 
-	return 0;
+	return ret;
 }
 
 static int ci13xxx_wakeup(struct usb_gadget *_gadget)
@@ -1546,20 +1554,9 @@ static int ci13xxx_start(struct usb_gadget *gadget,
 	spin_lock_irqsave(&ci->lock, flags);
 
 	ci->driver = driver;
-	pm_runtime_get_sync(&ci->gadget.dev);
-	if (ci->vbus_active) {
-		if (ci->platdata->flags & CI13XXX_REGS_SHARED)
-			hw_device_reset(ci, USBMODE_CM_DC);
-	} else {
-		pm_runtime_put_sync(&ci->gadget.dev);
-		goto done;
-	}
+	if (ci->vbus_active)
+		retval = hw_device_connect(ci, 1);
 
-	retval = hw_device_state(ci, ci->ep0out->qh.dma);
-	if (retval)
-		pm_runtime_put_sync(&ci->gadget.dev);
-
- done:
 	spin_unlock_irqrestore(&ci->lock, flags);
 	return retval;
 }
@@ -1572,24 +1569,18 @@ static int ci13xxx_stop(struct usb_gadget *gadget,
 {
 	struct ci13xxx *ci = container_of(gadget, struct ci13xxx, gadget);
 	unsigned long flags;
+	int ret = 0;
 
 	spin_lock_irqsave(&ci->lock, flags);
 
 	if (ci->vbus_active) {
-		hw_device_state(ci, 0);
-		if (ci->platdata->notify_event)
-			ci->platdata->notify_event(ci,
-			CI13XXX_CONTROLLER_STOPPED_EVENT);
 		ci->driver = NULL;
 		spin_unlock_irqrestore(&ci->lock, flags);
-		_gadget_stop_activity(&ci->gadget);
-		spin_lock_irqsave(&ci->lock, flags);
-		pm_runtime_put(&ci->gadget.dev);
-	}
-
-	spin_unlock_irqrestore(&ci->lock, flags);
+		ret = hw_device_connect(ci, 0);
+	} else
+		spin_unlock_irqrestore(&ci->lock, flags);
 
-	return 0;
+	return ret;
 }
 
 /******************************************************************************
---cut---

That's on top of your patchset. Then, I notice there's a mess with
locking around _gadget_stop_activity(), but that's out of scope of this
patchset, of course.

> Ok, I say "fully tested" means I tested cases for my development, which
> includes: host/device is plugged during boots up, device/host switch,
> host only controller, load gadget before/next cable plugs in. If you
> think it is not enough, I will skip "fully" when sends next version patch.

Sounds good, but it makes sense to mention that it's fully tested on
imx.

Regards,
--
Alex
