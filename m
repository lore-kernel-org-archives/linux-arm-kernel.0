From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:08:49 +0200
Subject: [PATCH 02/24] ste_dma40: Return directly after a failed
 kmalloc_array()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <9318d779-42d8-ad52-784d-1715439c209d@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 08:21:30 +0200

Return directly after a memory allocation failed in this function
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index fbebeff..80a199a 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3412,10 +3412,8 @@ static int __init d40_lcla_allocate(struct d40_base *base)
 	page_list = kmalloc_array(MAX_LCLA_ALLOC_ATTEMPTS,
 				  sizeof(*page_list),
 				  GFP_KERNEL);
-	if (!page_list) {
-		ret = -ENOMEM;
-		goto failure;
-	}
+	if (!page_list)
+		return -ENOMEM;
 
 	/* Calculating how many pages that are required */
 	base->lcla_pool.pages = SZ_1K * base->num_phy_chans / PAGE_SIZE;
-- 
2.10.0
