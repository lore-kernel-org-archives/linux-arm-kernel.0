From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Jul 2012 16:33:51 +0100
Subject: [PATCH 09/24] xen/arm: compile and run xenbus
In-Reply-To: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
Message-ID: <1343316846-25860-9-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bind_evtchn_to_irqhandler can legitimately return 0 (irq 0): it is not
an error.

If Linux is running as an HVM domain and is running as Dom0, use
xenstored_local_init to initialize the xenstore page and event channel.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/xenbus/xenbus_comms.c |    2 +-
 drivers/xen/xenbus/xenbus_probe.c |   27 +++++++++++++++++----------
 drivers/xen/xenbus/xenbus_xs.c    |    1 +
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index 52fe7ad..c5aa55c 100644
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
index b793723..3ae47c2 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -729,16 +729,23 @@ static int __init xenbus_init(void)
 	xenbus_ring_ops_init();
 
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
+			xen_store_interface =
+				phys_to_virt(xen_store_mfn << PAGE_SHIFT);
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
+			xen_store_interface =
+				ioremap(xen_store_mfn << PAGE_SHIFT, PAGE_SIZE);
+		}
 	} else {
 		xen_store_evtchn = xen_start_info->store_evtchn;
 		xen_store_mfn = xen_start_info->store_mfn;
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index d1c217b..f7feb3d 100644
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
-- 
1.7.2.5
