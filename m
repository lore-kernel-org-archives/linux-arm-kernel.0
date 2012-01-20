From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:35:22 +0000
Subject: [PATCH 2/5] ARM: pgtable: use mk_pte rather than
 pfn_pte(page_to_pfn())
In-Reply-To: <20120120103433.GF1068@n2100.arm.linux.org.uk>
References: <20120120103433.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBoY-0005oU-Lc@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mk_pte is provided to do this translation for us, so use it rather
than open-coding it in the copypage code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/copypage-v4mc.c   |    2 +-
 arch/arm/mm/copypage-v6.c     |    6 +++---
 arch/arm/mm/copypage-xscale.c |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index 87a23ca..e4dc2f4 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -74,7 +74,7 @@ void v4_mc_copy_user_highpage(struct page *to, struct page *from,
 
 	raw_spin_lock(&minicache_lock);
 
-	set_pte_ext(TOP_PTE(COPYPAGE_MINICACHE), pfn_pte(page_to_pfn(from), minicache_pgprot), 0);
+	set_pte_ext(TOP_PTE(COPYPAGE_MINICACHE), mk_pte(from, minicache_pgprot), 0);
 	flush_tlb_kernel_page(COPYPAGE_MINICACHE);
 
 	mc_copy_user_page((void *)COPYPAGE_MINICACHE, kto);
diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index c00a750..8652459 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -90,8 +90,8 @@ static void v6_copy_user_highpage_aliasing(struct page *to,
 	kfrom = COPYPAGE_V6_FROM + (offset << PAGE_SHIFT);
 	kto   = COPYPAGE_V6_TO + (offset << PAGE_SHIFT);
 
-	set_pte_ext(TOP_PTE(kfrom), pfn_pte(page_to_pfn(from), PAGE_KERNEL), 0);
-	set_pte_ext(TOP_PTE(kto), pfn_pte(page_to_pfn(to), PAGE_KERNEL), 0);
+	set_pte_ext(TOP_PTE(kfrom), mk_pte(from, PAGE_KERNEL), 0);
+	set_pte_ext(TOP_PTE(kto), mk_pte(to, PAGE_KERNEL), 0);
 
 	flush_tlb_kernel_page(kfrom);
 	flush_tlb_kernel_page(kto);
@@ -119,7 +119,7 @@ static void v6_clear_user_highpage_aliasing(struct page *page, unsigned long vad
 	 */
 	raw_spin_lock(&v6_lock);
 
-	set_pte_ext(TOP_PTE(to), pfn_pte(page_to_pfn(page), PAGE_KERNEL), 0);
+	set_pte_ext(TOP_PTE(to), mk_pte(page, PAGE_KERNEL), 0);
 	flush_tlb_kernel_page(to);
 	clear_page((void *)to);
 
diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
index 90f3bb5..2497dcf 100644
--- a/arch/arm/mm/copypage-xscale.c
+++ b/arch/arm/mm/copypage-xscale.c
@@ -94,7 +94,7 @@ void xscale_mc_copy_user_highpage(struct page *to, struct page *from,
 
 	raw_spin_lock(&minicache_lock);
 
-	set_pte_ext(TOP_PTE(COPYPAGE_MINICACHE), pfn_pte(page_to_pfn(from), minicache_pgprot), 0);
+	set_pte_ext(TOP_PTE(COPYPAGE_MINICACHE), mk_pte(from, minicache_pgprot), 0);
 	flush_tlb_kernel_page(COPYPAGE_MINICACHE);
 
 	mc_copy_user_page((void *)COPYPAGE_MINICACHE, kto);
-- 
1.7.4.4
