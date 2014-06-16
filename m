From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Mon, 16 Jun 2014 14:40:49 +0900
Subject: [PATCH v3 -next 7/9] mm, CMA: clean-up CMA allocation error path
In-Reply-To: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <1402897251-23639-8-git-send-email-iamjoonsoo.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can remove one call sites for clear_cma_bitmap() if we first
call it before checking error number.

Acked-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Michal Nazarewicz <mina86@mina86.com>
Reviewed-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/mm/cma.c b/mm/cma.c
index 0cf50da..b442a13 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -285,11 +285,12 @@ struct page *cma_alloc(struct cma *cma, int count, unsigned int align)
 		if (ret == 0) {
 			page = pfn_to_page(pfn);
 			break;
-		} else if (ret != -EBUSY) {
-			cma_clear_bitmap(cma, pfn, count);
-			break;
 		}
+
 		cma_clear_bitmap(cma, pfn, count);
+		if (ret != -EBUSY)
+			break;
+
 		pr_debug("%s(): memory range at %p is busy, retrying\n",
 			 __func__, pfn_to_page(pfn));
 		/* try again with a bit different memory target */
-- 
1.7.9.5
