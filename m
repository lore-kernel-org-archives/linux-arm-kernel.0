From: r65777@freescale.com (Bharat Bhushan)
Date: Wed, 5 Mar 2014 16:50:46 +0530
Subject: [PATCH] ARM64: Kernel managed pages are only flushed
Message-ID: <1394018446-16738-1-git-send-email-Bharat.Bhushan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel can only access pages which maps to managed memory.
So flush only valid kernel pages.

I observed kernel crash direct assigning a device using VFIO
and found that it was caused because of accessing invalid page

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>
---
 arch/arm64/mm/flush.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index e4193e3..2b4e8b0 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -72,7 +72,18 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 
 void __sync_icache_dcache(pte_t pte, unsigned long addr)
 {
-	struct page *page = pte_page(pte);
+	struct page *page;
+
+#ifdef CONFIG_HAVE_ARCH_PFN_VALID
+	/*
+	 * We can only access pages that the kernel maps
+	 * as memory. Bail out for unmapped ones.
+	 */
+	if (!pfn_valid(pfn))
+		return;
+
+#endif
+	page = pte_page(pte);
 
 	/* no flushing needed for anonymous pages */
 	if (!page_mapping(page))
-- 
1.7.0.4
