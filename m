From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 25 Jan 2013 14:12:20 +0200
Subject: [RESEND PATCH v5 4/7] usb: chipidea: consolidate ci_role_driver's
 API for both roles
In-Reply-To: <20130125033013.GB29795@nchen-desktop>
References: <1358733418-17969-1-git-send-email-peter.chen@freescale.com>
 <1358733418-17969-5-git-send-email-peter.chen@freescale.com>
 <8738xqodhp.fsf@ashishki-desk.ger.corp.intel.com>
 <20130125033013.GB29795@nchen-desktop>
Message-ID: <87sj5pbgwr.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> On Thu, Jan 24, 2013 at 04:35:30PM +0200, Alexander Shishkin wrote:
>> Peter Chen <peter.chen@freescale.com> writes:
>> 
>> > - Create init/destroy API for probe and remove
>> > - start/stop API are only used otg id switch process
>> > - Create the gadget at ci_hdrc_probe if the gadget is supported
>> > at that port, the main purpose for this is to avoid gadget module
>> > load fail at init.rc
>> 
>> I don't think it's necessary to mention android-specific init scripts
>> here in our patches.
>
> Ok, will just mention init script.
>> 
>> >  
>> > +static inline void ci_role_destroy(struct ci13xxx *ci)
>> > +{
>> > +	enum ci_role role = ci->role;
>> > +
>> > +	if (role == CI_ROLE_END)
>> > +		return;
>> > +
>> > +	ci->role = CI_ROLE_END;
>> > +
>> > +	ci->roles[role]->destroy(ci);
>> > +}
>> 
>> What does this do? It should take role an a parameter, at least. Or it
>> can be called ci_roles_destroy() and, well, destroy all the roles. Now
>> we're in a situation where we destroy one.
> Yes, this function has some problems, I suggest just call two lines at
> ci_role_destory, do you think so?
>
> 	ci->roles[role]->destroy(ci);
> 	ci->role = CI_ROLE_END;

I just don't see why it's needed at all. See below.

>> 
>> The idea is that, with this api, we can (and should) have both roles
>> allocated all the time, but only one role start()'ed.
>> 
>> What we can do here is move the udc's .init() code to
>> ci_hdrc_gadget_init() and add a complementary ci_hdrc_gadget_destroy(),
>> which we call in ci_hdrc_remove() and probe's error path. And we can
>> probably do something similar for the host, or just leave it as it is
>> now. Seems simpler to me.
> Yes, current code has bug that it should call ci_role_destroy at probe's
> error path.
> For your comments, it still needs to add destory function for udc which will
> be called at core.c. I still prefer current way due to below reasons:
>
> - It can keep ci_hdrc_gadget_init() clean
> - .init and .remove are different logical function with .start and .stop.
> The .init and .remove are used for create and destroy, .start and .stop
> are used at id role switch.

True, and we can keep it that way: (again, untested)

---cut---
diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 342b430..36f495a 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -67,18 +67,14 @@ enum ci_role {
 
 /**
  * struct ci_role_driver - host/gadget role driver
- * init: init this role (used at module probe)
  * start: start this role (used at id switch)
  * stop: stop this role (used at id switch)
- * destroy: destroy this role (used at module remove)
  * irq: irq handler for this role
  * name: role name string (host/gadget)
  */
 struct ci_role_driver {
-	int		(*init)(struct ci13xxx *);
 	int		(*start)(struct ci13xxx *);
 	void		(*stop)(struct ci13xxx *);
-	void		(*destroy)(struct ci13xxx *);
 	irqreturn_t	(*irq)(struct ci13xxx *);
 	const char	*name;
 };
@@ -212,17 +208,6 @@ static inline void ci_role_stop(struct ci13xxx *ci)
 	ci->roles[role]->stop(ci);
 }
 
-static inline void ci_role_destroy(struct ci13xxx *ci)
-{
-	enum ci_role role = ci->role;
-
-	if (role == CI_ROLE_END)
-		return;
-
-	ci->role = CI_ROLE_END;
-
-	ci->roles[role]->destroy(ci);
-}
 /******************************************************************************
  * REGISTERS
  *****************************************************************************/
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index a61e759..83f35fa 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -402,6 +402,12 @@ static ssize_t store_role(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
+	/*
+	 * there won't be an interrupt in case of manual switching,
+	 * so we need to check vbus session manually
+	 */
+	ci_handle_vbus_change(ci);
+
 	return count;
 }
 
@@ -592,30 +598,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 
 	otgsc = hw_read(ci, OP_OTGSC, ~0);
 
-	/*
-	 * If the gadget is supported, call its init unconditionally,
-	 * We need to support load gadget module at init.rc.
-	 */
-	if (ci->roles[CI_ROLE_GADGET]) {
-		ret = ci->roles[CI_ROLE_GADGET]->init(ci);
-		if (ret) {
-			dev_err(dev, "can't init %s role, ret=%d\n",
-					ci_role(ci)->name, ret);
-			ret = -ENODEV;
-			goto rm_wq;
-		}
-	}
-
-	if (ci->role == CI_ROLE_HOST) {
-		ret = ci->roles[CI_ROLE_HOST]->init(ci);
-		if (ret) {
-			dev_err(dev, "can't init %s role, ret=%d\n",
-					ci_role(ci)->name, ret);
-			ret = -ENODEV;
-			goto rm_wq;
-		}
-	}
-
 	platform_set_drvdata(pdev, ci);
 	ret = request_irq(ci->irq, ci_irq, IRQF_SHARED, ci->platdata->name,
 			  ci);
@@ -626,6 +608,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	if (ret)
 		goto rm_attr;
 
+	ci_role_start(ci, ci->role);
+
 	/* Handle the situation that usb device at the MicroB to A cable */
 	if (ci->is_otg && !(otgsc & OTGSC_ID))
 		queue_delayed_work(ci->wq, &ci->dwork, msecs_to_jiffies(500));
@@ -651,7 +635,8 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 	destroy_workqueue(ci->wq);
 	device_remove_file(ci->dev, &dev_attr_role);
 	free_irq(ci->irq, ci);
-	ci_role_destroy(ci);
+	ci_hdrc_gadget_destroy(ci);
+	ci_hdrc_host_destroy(ci);
 
 	return 0;
 }
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index 7f4538c..ead3158 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -95,10 +95,8 @@ int ci_hdrc_host_init(struct ci13xxx *ci)
 	if (!rdrv)
 		return -ENOMEM;
 
-	rdrv->init	= host_start;
 	rdrv->start	= host_start;
 	rdrv->stop	= host_stop;
-	rdrv->destroy	= host_stop;
 	rdrv->irq	= host_irq;
 	rdrv->name	= "host";
 	ci->roles[CI_ROLE_HOST] = rdrv;
@@ -107,3 +105,9 @@ int ci_hdrc_host_init(struct ci13xxx *ci)
 
 	return 0;
 }
+
+void ci_hdrc_host_destroy(struct ci13xxx *ci)
+{
+	if (ci->role == CI_ROLE_HOST)
+		host_stop(ci);
+}
diff --git a/drivers/usb/chipidea/host.h b/drivers/usb/chipidea/host.h
index 761fb1f..2e529be 100644
--- a/drivers/usb/chipidea/host.h
+++ b/drivers/usb/chipidea/host.h
@@ -4,6 +4,7 @@
 #ifdef CONFIG_USB_CHIPIDEA_HOST
 
 int ci_hdrc_host_init(struct ci13xxx *ci);
+void ci_hdrc_host_destroy(struct ci13xxx *ci);
 
 #else
 
@@ -12,6 +13,10 @@ static inline int ci_hdrc_host_init(struct ci13xxx *ci)
 	return -ENXIO;
 }
 
+static void ci_hdrc_host_destroy(struct ci13xxx *ci)
+{
+}
+
 #endif
 
 #endif /* __DRIVERS_USB_CHIPIDEA_HOST_H */
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 38446de..38b06ac 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1750,10 +1750,10 @@ static int udc_start(struct ci13xxx *ci)
 	 * - Enable vbus detect
 	 * - If it has already connected to host, notify udc
 	 */
-	if (ci->role == CI_ROLE_GADGET) {
+	//if (ci->role == CI_ROLE_GADGET) {
 		ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
 		ci_handle_vbus_change(ci);
-	}
+		//}
 
 	return retval;
 
@@ -1798,11 +1798,10 @@ static void udc_id_switch_for_host(struct ci13xxx *ci)
 }
 
 /**
- * udc_remove: parent remove must call this to remove UDC
- *
- * No interrupts active, the IRQ has been released
+ * ci_hdrc_gadget_init - initialize device related bits
+ * ci: the controller
  */
-static void udc_stop(struct ci13xxx *ci)
+void ci_hdrc_gadget_destroy(struct ci13xxx *ci)
 {
 	if (ci == NULL)
 		return;
@@ -1821,8 +1820,6 @@ static void udc_stop(struct ci13xxx *ci)
 	}
 	dbg_remove_files(&ci->gadget.dev);
 	device_unregister(&ci->gadget.dev);
-	/* my kobject is dynamic, I swear! */
-	memset(&ci->gadget, 0, sizeof(ci->gadget));
 }
 
 /**
@@ -1842,13 +1839,11 @@ int ci_hdrc_gadget_init(struct ci13xxx *ci)
 	if (!rdrv)
 		return -ENOMEM;
 
-	rdrv->init	= udc_start;
 	rdrv->start	= udc_id_switch_for_device;
 	rdrv->stop	= udc_id_switch_for_host;
-	rdrv->destroy	= udc_stop;
 	rdrv->irq	= udc_irq;
 	rdrv->name	= "gadget";
 	ci->roles[CI_ROLE_GADGET] = rdrv;
 
-	return 0;
+	return udc_start(ci);
 }
diff --git a/drivers/usb/chipidea/udc.h b/drivers/usb/chipidea/udc.h
index 4ff2384d..12fd7cf 100644
--- a/drivers/usb/chipidea/udc.h
+++ b/drivers/usb/chipidea/udc.h
@@ -80,6 +80,7 @@ struct ci13xxx_req {
 #ifdef CONFIG_USB_CHIPIDEA_UDC
 
 int ci_hdrc_gadget_init(struct ci13xxx *ci);
+void ci_hdrc_gadget_destroy(struct ci13xxx *ci);
 
 #else
 
@@ -88,6 +89,10 @@ static inline int ci_hdrc_gadget_init(struct ci13xxx *ci)
 	return -ENXIO;
 }
 
+static void ci_hdrc_gadget_destroy(struct ci13xxx *ci)
+{
+}
+
 #endif
 
 #endif /* __DRIVERS_USB_CHIPIDEA_UDC_H */
---cut---

Which is shorter (32 insertions(+), 53 deletions(-)) and makes the main
probe easier on the eyes. What do you think?

Regards,
--
Alex
