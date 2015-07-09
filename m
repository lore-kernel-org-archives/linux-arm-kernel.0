From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 9 Jul 2015 21:42:22 +0100
Subject: [PATCH v2 10/20] xen/xenbus: Use Xen page definition
In-Reply-To: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1436474552-31789-11-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the ring (xenstore, and PV rings) are always based on the page
granularity of Xen.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
---
    Changes in v2:
        - Also update the ring mapping function
---
 drivers/xen/xenbus/xenbus_client.c | 6 +++---
 drivers/xen/xenbus/xenbus_probe.c  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index 9ad3272..80272f6 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -388,7 +388,7 @@ int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
 		}
 		grefs[i] = err;
 
-		vaddr = vaddr + PAGE_SIZE;
+		vaddr = vaddr + XEN_PAGE_SIZE;
 	}
 
 	return 0;
@@ -555,7 +555,7 @@ static int xenbus_map_ring_valloc_pv(struct xenbus_device *dev,
 	if (!node)
 		return -ENOMEM;
 
-	area = alloc_vm_area(PAGE_SIZE * nr_grefs, ptes);
+	area = alloc_vm_area(XEN_PAGE_SIZE * nr_grefs, ptes);
 	if (!area) {
 		kfree(node);
 		return -ENOMEM;
@@ -750,7 +750,7 @@ static int xenbus_unmap_ring_vfree_pv(struct xenbus_device *dev, void *vaddr)
 		unsigned long addr;
 
 		memset(&unmap[i], 0, sizeof(unmap[i]));
-		addr = (unsigned long)vaddr + (PAGE_SIZE * i);
+		addr = (unsigned long)vaddr + (XEN_PAGE_SIZE * i);
 		unmap[i].host_addr = arbitrary_virt_to_machine(
 			lookup_address(addr, &level)).maddr;
 		unmap[i].dev_bus_addr = 0;
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 4308fb3..c67e5ba 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -713,7 +713,7 @@ static int __init xenstored_local_init(void)
 
 	xen_store_mfn = xen_start_info->store_mfn =
 		pfn_to_mfn(virt_to_phys((void *)page) >>
-			   PAGE_SHIFT);
+			   XEN_PAGE_SHIFT);
 
 	/* Next allocate a local port which xenstored can bind to */
 	alloc_unbound.dom        = DOMID_SELF;
@@ -804,7 +804,7 @@ static int __init xenbus_init(void)
 			goto out_error;
 		xen_store_mfn = (unsigned long)v;
 		xen_store_interface =
-			xen_remap(xen_store_mfn << PAGE_SHIFT, PAGE_SIZE);
+			xen_remap(xen_store_mfn << XEN_PAGE_SHIFT, XEN_PAGE_SIZE);
 		break;
 	default:
 		pr_warn("Xenstore state unknown\n");
-- 
2.1.4
