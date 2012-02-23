From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 23 Feb 2012 17:48:33 +0000
Subject: [PATCH-WIP 12/13] xen/arm: compile and run xenbus
In-Reply-To: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
Message-ID: <1330019314-20865-12-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bind_evtchn_to_irqhandler can legitimately return 0 (irq 0), it is not
an error.

If Linux is running as an HVM domain and is running as Dom0, use
xenstored_local_init to initialize the xenstore page and event channel,
and do not call xs_reset_watches at boot.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/xenbus/xenbus_comms.c |    2 +-
 drivers/xen/xenbus/xenbus_probe.c |   26 ++++++++++++++++----------
 drivers/xen/xenbus/xenbus_xs.c    |    3 ++-
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index 2eff7a6..57b8230 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -224,7 +224,7 @@ int xb_init_comms(void)
 		int err;
 		err = bind_evtchn_to_irqhandler(xen_store_evtchn, wake_waiting,
 						0, "xenbus", &xb_waitq);
-		if (err <= 0) {
+		if (err < 0) {
 			printk(KERN_ERR "XENBUS request irq failed %i\n", err);
 			return err;
 		}
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 1b178c6..f3d5105 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -731,16 +731,22 @@ static int __init xenbus_init(void)
 		return -ENODEV;
 
 	if (xen_hvm_domain()) {
-		uint64_t v = 0;
-		err = hvm_get_parameter(HVM_PARAM_STORE_EVTCHN, &v);
-		if (err)
-			goto out_error;
-		xen_store_evtchn = (int)v;
-		err = hvm_get_parameter(HVM_PARAM_STORE_PFN, &v);
-		if (err)
-			goto out_error;
-		xen_store_mfn = (unsigned long)v;
-		xen_store_interface = ioremap(xen_store_mfn << PAGE_SHIFT, PAGE_SIZE);
+		if (xen_initial_domain()) {
+			err = xenstored_local_init();
+			xen_store_interface = phys_to_virt(xen_store_mfn << PAGE_SHIFT);
+		} else {
+			uint64_t v = 0;
+			err = hvm_get_parameter(HVM_PARAM_STORE_EVTCHN, &v);
+			if (err)
+				goto out_error;
+			xen_store_evtchn = (int)v;
+			err = hvm_get_parameter(HVM_PARAM_STORE_PFN, &v);
+			if (err)
+				goto out_error;
+			xen_store_mfn = (unsigned long)v;
+			xen_store_interface = ioremap(xen_store_mfn << PAGE_SHIFT,
+					PAGE_SIZE);
+		}
 	} else {
 		xen_store_evtchn = xen_start_info->store_evtchn;
 		xen_store_mfn = xen_start_info->store_mfn;
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index b3b8f2f..edcef19 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -44,6 +44,7 @@
 #include <linux/rwsem.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <asm/xen/hypervisor.h>
 #include <xen/xenbus.h>
 #include <xen/xen.h>
 #include "xenbus_comms.h"
@@ -907,7 +908,7 @@ int xs_init(void)
 		return PTR_ERR(task);
 
 	/* shutdown watches for kexec boot */
-	if (xen_hvm_domain())
+	if (xen_hvm_domain() && !xen_initial_domain())
 		xs_reset_watches();
 
 	return 0;
-- 
1.7.2.5
