From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Wed, 20 Jul 2016 08:53:59 -0500
Subject: [PATCH V3 3/4] xen/arm: io: Use binary search for mmio handler lookup
In-Reply-To: <1469022840-2142-1-git-send-email-shankerd@codeaurora.org>
References: <1469022840-2142-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <1469022840-2142-4-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the number of I/O handlers increase, the overhead associated with
linear lookup also increases. The system might have maximum of 144
(assuming CONFIG_NR_CPUS=128) mmio handlers. In worst case scenario,
it would require 144 iterations for finding a matching handler. Now
it is time for us to change from linear (complexity O(n)) to a binary
search (complexity O(log n) for reducing mmio handler lookup overhead.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 xen/arch/arm/io.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/xen/arch/arm/io.c b/xen/arch/arm/io.c
index 40330f0..e8aa7fa 100644
--- a/xen/arch/arm/io.c
+++ b/xen/arch/arm/io.c
@@ -20,6 +20,7 @@
 #include <xen/lib.h>
 #include <xen/spinlock.h>
 #include <xen/sched.h>
+#include <xen/sort.h>
 #include <asm/current.h>
 #include <asm/mmio.h>
 
@@ -70,27 +71,31 @@ static int handle_write(const struct mmio_handler *handler, struct vcpu *v,
                                handler->priv);
 }
 
-static const struct mmio_handler *find_mmio_handler(struct domain *d,
-                                                    paddr_t gpa)
+/* This function assumes that mmio regions are not overlapped */
+static int cmp_mmio_handler(const void *key, const void *elem)
 {
-    const struct mmio_handler *handler;
-    unsigned int i;
-    struct vmmio *vmmio = &d->arch.vmmio;
+    const struct mmio_handler *handler0 = key;
+    const struct mmio_handler *handler1 = elem;
 
-    read_lock(&vmmio->lock);
+    if ( handler0->addr < handler1->addr )
+        return -1;
 
-    for ( i = 0; i < vmmio->num_entries; i++ )
-    {
-        handler = &vmmio->handlers[i];
+    if ( handler0->addr > (handler1->addr + handler1->size) )
+        return 1;
 
-        if ( (gpa >= handler->addr) &&
-             (gpa < (handler->addr + handler->size)) )
-            break;
-    }
+    return 0;
+}
 
-    if ( i == vmmio->num_entries )
-        handler = NULL;
+static const struct mmio_handler *find_mmio_handler(struct domain *d,
+                                                    paddr_t gpa)
+{
+    struct vmmio *vmmio = &d->arch.vmmio;
+    struct mmio_handler key = {.addr = gpa};
+    const struct mmio_handler *handler;
 
+    read_lock(&vmmio->lock);
+    handler = bsearch(&key, vmmio->handlers, vmmio->num_entries,
+                      sizeof(*handler), cmp_mmio_handler);
     read_unlock(&vmmio->lock);
 
     return handler;
@@ -131,6 +136,10 @@ void register_mmio_handler(struct domain *d,
 
     vmmio->num_entries++;
 
+    /* Sort mmio handlers in ascending order based on base address */
+    sort(vmmio->handlers, vmmio->num_entries, sizeof(struct mmio_handler),
+         cmp_mmio_handler, NULL);
+
     write_unlock(&vmmio->lock);
 }
 
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
