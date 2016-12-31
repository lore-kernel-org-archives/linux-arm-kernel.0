From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 31 Dec 2016 22:58:09 +0100
Subject: [PATCH 1/6] staging: vchiq_arm: Use kmalloc_array() in dump_phys_mem()
In-Reply-To: <5acd65e7-0b5d-0972-5e1a-6e87d71dc1a4@users.sourceforge.net>
References: <5acd65e7-0b5d-0972-5e1a-6e87d71dc1a4@users.sourceforge.net>
Message-ID: <79db6271-a752-579e-df68-d9c917b9006a@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 31 Dec 2016 17:50:25 +0100

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 610e0d6d93bb..4af77d790ae0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1558,8 +1558,7 @@ dump_phys_mem(void *virt_addr, uint32_t num_bytes)
 	end_offset = (int)(long)end_virt_addr & (PAGE_SIZE - 1);
 
 	num_pages = (offset + num_bytes + PAGE_SIZE - 1) / PAGE_SIZE;
-
-	pages = kmalloc(sizeof(struct page *) * num_pages, GFP_KERNEL);
+	pages = kmalloc_array(num_pages, sizeof(*pages), GFP_KERNEL);
 	if (pages == NULL) {
 		vchiq_log_error(vchiq_arm_log_level,
 			"Unable to allocation memory for %d pages\n",
-- 
2.11.0
