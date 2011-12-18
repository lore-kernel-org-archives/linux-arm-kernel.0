From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Dec 2011 19:45:18 +0000
Subject: [PATCH 3/7] s3c-hsudc: add a remove function
In-Reply-To: <201112182033.33640.heiko@sntech.de>
References: <201112172023.05519.heiko@sntech.de>
 <201112181950.38993.heiko@sntech.de>
 <20111218190102.GW14542@n2100.arm.linux.org.uk>
 <201112182033.33640.heiko@sntech.de>
Message-ID: <20111218194518.GX14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 18, 2011 at 08:33:32PM +0100, Heiko St?bner wrote:
> Am Sonntag 18 Dezember 2011, 20:01:02 schrieben Sie:
> > On Sun, Dec 18, 2011 at 07:50:37PM +0100, Heiko St?bner wrote:
> > > I didn't get this far. With your patch the Oopses already happen during
> > > the startup of the system / the loading of the modules.
> > 
> > > A bit of the message spew I got during testing with linux-next-20111216:
> > In some way, this is a good thing because it's showing that there's
> > problems with kobject lifetime rules.
> > 
> > The #2 and further oops dumps are a result of corrupting the work
> > queues as a result of #1, so #2 onwards should be ignored.
> > 
> > I suspect if you avoid loading the s3c_hsudc module these will go away.
> 
> nope :-), same faults happen even if s3c-hsudc is not present at all.
> So it seems, this delayed cleanup poses problems for other drivers as well.

Okay, let's try to find out which one it is.  Please use the attached
patch - it'll be a little more noisy, reporting which kobjects are
being released at the point when they're added to the workqueue.

Thanks.

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
index 640bd98..5c01a78 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -540,7 +540,7 @@ static void kobject_cleanup(struct kobject *kobj)
 	struct kobj_type *t = get_ktype(kobj);
 	const char *name = kobj->name;
 
-	pr_debug("kobject: '%s' (%p): %s\n",
+	pr_info("kobject: '%s' (%p): %s\n",
 		 kobject_name(kobj), kobj, __func__);
 
 	if (t && !t->release)
@@ -575,9 +575,25 @@ static void kobject_cleanup(struct kobject *kobj)
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
+	pr_info("kobject: '%s' (%p): %s\n",
+		 kobject_name(kobj), kobj, __func__);
+	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
+	schedule_delayed_work(&kobj->release, HZ);
+#else
+	kobject_cleanup(kobj);
+#endif
 }
 
 /**
