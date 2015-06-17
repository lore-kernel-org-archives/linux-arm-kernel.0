From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 17 Jun 2015 15:28:03 +0100
Subject: [PATCH v2 2/7] xen/xenbus: client: Fix call of virt_to_mfn in
 xenbus_grant_ring
In-Reply-To: <1434551288-14113-1-git-send-email-julien.grall@citrix.com>
References: <1434551288-14113-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1434551288-14113-3-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

virt_to_mfn should take a void* rather an unsigned long. While it
doesn't really matter now, it would throw a compiler warning later when
virt_to_mfn will enforce the type.

At the same time, avoid to compute new virtual address every time in the
loop and directly increment the parameter as we don't use it later.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: David Vrabel <david.vrabel@citrix.com>
Cc: Wei Liu <wei.liu2@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>

---
    Changes in v2:
        - Remove the cast to (char *)
        - Add David's Reviewed-by
---
 drivers/xen/xenbus/xenbus_client.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index a014016..9ad3272 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -379,16 +379,16 @@ int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
 	int i, j;
 
 	for (i = 0; i < nr_pages; i++) {
-		unsigned long addr = (unsigned long)vaddr +
-			(PAGE_SIZE * i);
 		err = gnttab_grant_foreign_access(dev->otherend_id,
-						  virt_to_mfn(addr), 0);
+						  virt_to_mfn(vaddr), 0);
 		if (err < 0) {
 			xenbus_dev_fatal(dev, err,
 					 "granting access to ring page");
 			goto fail;
 		}
 		grefs[i] = err;
+
+		vaddr = vaddr + PAGE_SIZE;
 	}
 
 	return 0;
-- 
2.1.4
