From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Dec 2011 14:43:19 +0000
Subject: [PATCH 3/7] s3c-hsudc: add a remove function
In-Reply-To: <201112181444.39812.heiko@sntech.de>
References: <201112172023.05519.heiko@sntech.de>
 <201112172026.34215.heiko@sntech.de>
 <20111218081048.GS14542@n2100.arm.linux.org.uk>
 <201112181444.39812.heiko@sntech.de>
Message-ID: <20111218144319.GU14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 18, 2011 at 02:44:39PM +0100, Heiko St?bner wrote:
> Am Sonntag 18 Dezember 2011, 09:10:48 schrieb Russell King - ARM Linux:
> > On Sat, Dec 17, 2011 at 08:26:33PM +0100, Heiko St?bner wrote:
> > > As the driver is also buildable as a module it should need
> > > a cleanup function for the removal of the module.
> > 
> > My guess is that this wasn't implemented because of the embedded struct
> > device lifetime rules for the gadget - to prevent the unbinding of the
> > driver.
> > 
> > Until the struct device lifetime gets fixed, you must not allow the module
> > nor the data structure containing the struct device to be freed.
> 
> I understand where this problem comes from (the release method is potentially 
> gone with the module before it is called) but after more reading, I have a 
> hard time believing that a lot of the other gadget drivers would be wrong as 
> well. Some of them since 2009 or possibly earlier.
> 
> Gadgets with embedded release methods: langwell_udc, goku_udc, fsl_qe_udc (and 
> fsl_udc_core), amd5536udc, net2280, pch_udc, cil13xxx_udc, dummy_hcd, 
> omap_udc, net2272, mc_udc_core
> 
> Gadgets which use the release method from its pdev->dev but also free the 
> struct with the gadget in their remove method: r8a66597-udc, m66592-udc, 
> fusb300_udc. (possibly before the release function is called)
> 
> On the other hand, the gets and puts of the udc->gadget.dev should be paired 
> correctly and it's only an intermediate device between the udc and the gadget 
> driver, so that the call to device_unregister in the remove method should put 
> the refcount to 0 and thus init the cleanup (including the call to release) 
> before the module is removed.
> 
> So, I am very confused :-).

Try this patch.  If your system oopses 5 seconds after you remove the
module, you have a lifetime bug.

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index ad81e1c..be1c97a 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -26,6 +26,9 @@
 #include <linux/kernel.h>
 #include <linux/wait.h>
 #include <linux/atomic.h>
+#include <linux/workqueue.h>
+
+#define KOBJECT_DEBUG_RELEASE
 
 #define UEVENT_HELPER_PATH_LEN		256
 #define UEVENT_NUM_ENVP			32	/* number of env pointers */
@@ -65,6 +68,9 @@ struct kobject {
 	struct kobj_type	*ktype;
 	struct sysfs_dirent	*sd;
 	struct kref		kref;
+#ifdef KOBJECT_DEBUG_RELEASE
+	struct delayed_work	release;
+#endif
 	unsigned int state_initialized:1;
 	unsigned int state_in_sysfs:1;
 	unsigned int state_add_uevent_sent:1;
diff --git a/lib/kobject.c b/lib/kobject.c
index 640bd98..fe57f3a 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -575,9 +575,23 @@ static void kobject_cleanup(struct kobject *kobj)
 	}
 }
 
+#ifdef KOBJECT_DEBUG_RELEASE
+static void kobject_delayed_cleanup(struct work_struct *work)
+{
+	kobject_cleanup(container_of(to_delayed_work(work),
+				     struct kobject, release));
+}
+#endif
+
 static void kobject_release(struct kref *kref)
 {
-	kobject_cleanup(container_of(kref, struct kobject, kref));
+	struct kobject *kobj = container_of(kref, struct kobject, kref);
+#ifdef KOBJECT_DEBUG_RELEASE
+	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
+	schedule_delayed_work(&kobj->release, 5 * HZ);
+#else
+	kobject_cleanup(kobj);
+#endif
 }
 
 /**
