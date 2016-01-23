From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Sat, 23 Jan 2016 11:19:30 +0800
Subject: [PATCH v3 03/17] Xen: xlate: Use page_to_xen_pfn instead of
 page_to_pfn
In-Reply-To: <1453519184-11908-1-git-send-email-zhaoshenglong@huawei.com>
References: <1453519184-11908-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1453519184-11908-4-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Use page_to_xen_pfn in case of 64KB page.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 drivers/xen/xlate_mmu.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index 9692656..28f728b 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -207,9 +207,12 @@ int __init xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
 	void *vaddr;
 	int rc;
 	unsigned int i;
+	unsigned long nr_pages;
+	xen_pfn_t xen_pfn = 0;
 
 	BUG_ON(nr_grant_frames == 0);
-	pages = kcalloc(nr_grant_frames, sizeof(pages[0]), GFP_KERNEL);
+	nr_pages = DIV_ROUND_UP(nr_grant_frames, XEN_PFN_PER_PAGE);
+	pages = kcalloc(nr_pages, sizeof(pages[0]), GFP_KERNEL);
 	if (!pages)
 		return -ENOMEM;
 
@@ -218,22 +221,25 @@ int __init xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
 		kfree(pages);
 		return -ENOMEM;
 	}
-	rc = alloc_xenballooned_pages(nr_grant_frames, pages);
+	rc = alloc_xenballooned_pages(nr_pages, pages);
 	if (rc) {
-		pr_warn("%s Couldn't balloon alloc %ld pfns rc:%d\n", __func__,
-			nr_grant_frames, rc);
+		pr_warn("%s Couldn't balloon alloc %ld pages rc:%d\n", __func__,
+			nr_pages, rc);
 		kfree(pages);
 		kfree(pfns);
 		return rc;
 	}
-	for (i = 0; i < nr_grant_frames; i++)
-		pfns[i] = page_to_pfn(pages[i]);
+	for (i = 0; i < nr_grant_frames; i++) {
+		if ((i % XEN_PFN_PER_PAGE) == 0)
+			xen_pfn = page_to_xen_pfn(pages[i / XEN_PFN_PER_PAGE]);
+		pfns[i] = pfn_to_gfn(xen_pfn++);
+	}
 
-	vaddr = vmap(pages, nr_grant_frames, 0, PAGE_KERNEL);
+	vaddr = vmap(pages, nr_pages, 0, PAGE_KERNEL);
 	if (!vaddr) {
-		pr_warn("%s Couldn't map %ld pfns rc:%d\n", __func__,
-			nr_grant_frames, rc);
-		free_xenballooned_pages(nr_grant_frames, pages);
+		pr_warn("%s Couldn't map %ld pages rc:%d\n", __func__,
+			nr_pages, rc);
+		free_xenballooned_pages(nr_pages, pages);
 		kfree(pages);
 		kfree(pfns);
 		return -ENOMEM;
-- 
2.0.4
