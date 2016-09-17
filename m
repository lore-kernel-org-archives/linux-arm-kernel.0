From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:07:30 +0200
Subject: [PATCH 01/24] ste_dma40: Use kmalloc_array() in d40_lcla_allocate()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <ee94dee5-d88e-e42d-abc3-4e5a7727b561@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Sep 2016 17:56:07 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 73203ac..fbebeff 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3409,9 +3409,9 @@ static int __init d40_lcla_allocate(struct d40_base *base)
 	 * To full fill this hardware requirement without wasting 256 kb
 	 * we allocate pages until we get an aligned one.
 	 */
-	page_list = kmalloc(sizeof(unsigned long) * MAX_LCLA_ALLOC_ATTEMPTS,
-			    GFP_KERNEL);
-
+	page_list = kmalloc_array(MAX_LCLA_ALLOC_ATTEMPTS,
+				  sizeof(*page_list),
+				  GFP_KERNEL);
 	if (!page_list) {
 		ret = -ENOMEM;
 		goto failure;
-- 
2.10.0
