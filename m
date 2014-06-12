From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Thu, 12 Jun 2014 12:21:45 +0900
Subject: [PATCH v2 08/10] mm, cma: clean-up cma allocation error path
In-Reply-To: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <1402543307-29800-9-git-send-email-iamjoonsoo.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can remove one call sites for clear_cma_bitmap() if we first
call it before checking error number.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/mm/cma.c b/mm/cma.c
index 1e1b017..01a0713 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -282,11 +282,12 @@ struct page *cma_alloc(struct cma *cma, int count, unsigned int align)
 		if (ret == 0) {
 			page = pfn_to_page(pfn);
 			break;
-		} else if (ret != -EBUSY) {
-			clear_cma_bitmap(cma, pfn, count);
-			break;
 		}
+
 		clear_cma_bitmap(cma, pfn, count);
+		if (ret != -EBUSY)
+			break;
+
 		pr_debug("%s(): memory range at %p is busy, retrying\n",
 			 __func__, pfn_to_page(pfn));
 		/* try again with a bit different memory target */
-- 
1.7.9.5
