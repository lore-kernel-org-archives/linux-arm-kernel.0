From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 7 Sep 2015 16:33:48 +0100
Subject: [PATCH v4 10/20] xen/xenbus: Use Xen page definition
In-Reply-To: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1441640038-23615-11-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the ring (xenstore, and PV rings) are always based on the page
granularity of Xen.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: David Vrabel <david.vrabel@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>

    Changes in v3:
        - Fix errors reported by checkpatch.pl
        - s/MFN/GFN base on the new naming
        - Add David and Stefano's reviewed-by

    Changes in v2:
        - Also update the ring mapping function
---
 drivers/xen/xenbus/xenbus_client.c | 6 +++---
 drivers/xen/xenbus/xenbus_probe.c  | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index 2ba09c1..359e654 100644
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
index 3cbe055..33a31cf 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -802,7 +802,8 @@ static int __init xenbus_init(void)
 			goto out_error;
 		xen_store_gfn = (unsigned long)v;
 		xen_store_interface =
-			xen_remap(xen_store_gfn << PAGE_SHIFT, PAGE_SIZE);
+			xen_remap(xen_store_gfn << XEN_PAGE_SHIFT,
+				  XEN_PAGE_SIZE);
 		break;
 	default:
 		pr_warn("Xenstore state unknown\n");
-- 
2.1.4
