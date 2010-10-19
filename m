From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Oct 2010 16:39:03 +0200
Subject: [PATCH 08/12] ARM: Convert v6_lock to raw_spinlock
In-Reply-To: <20101019143717.GH11713@pengutronix.de>
References: <20101019143717.GH11713@pengutronix.de>
Message-ID: <1287499147-13846-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

v6_lock needs to be a real spinlock on preempt-rt. Convert it to a
raw_spinlock. No change for !RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mm/copypage-v6.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index f55fa10..32bd1fb 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -27,7 +27,7 @@
 #define from_address	(0xffff8000)
 #define to_address	(0xffffc000)
 
-static DEFINE_SPINLOCK(v6_lock);
+static DEFINE_RAW_SPINLOCK(v6_lock);
 
 /*
  * Copy the user page.  No aliasing to deal with so we can just
@@ -89,7 +89,7 @@ static void v6_copy_user_highpage_aliasing(struct page *to,
 	 * Now copy the page using the same cache colour as the
 	 * pages ultimate destination.
 	 */
-	spin_lock(&v6_lock);
+	raw_spin_lock(&v6_lock);
 
 	set_pte_ext(TOP_PTE(from_address) + offset, pfn_pte(page_to_pfn(from), PAGE_KERNEL), 0);
 	set_pte_ext(TOP_PTE(to_address) + offset, pfn_pte(page_to_pfn(to), PAGE_KERNEL), 0);
@@ -102,7 +102,7 @@ static void v6_copy_user_highpage_aliasing(struct page *to,
 
 	copy_page((void *)kto, (void *)kfrom);
 
-	spin_unlock(&v6_lock);
+	raw_spin_unlock(&v6_lock);
 }
 
 /*
@@ -122,13 +122,13 @@ static void v6_clear_user_highpage_aliasing(struct page *page, unsigned long vad
 	 * Now clear the page using the same cache colour as
 	 * the pages ultimate destination.
 	 */
-	spin_lock(&v6_lock);
+	raw_spin_lock(&v6_lock);
 
 	set_pte_ext(TOP_PTE(to_address) + offset, pfn_pte(page_to_pfn(page), PAGE_KERNEL), 0);
 	flush_tlb_kernel_page(to);
 	clear_page((void *)to);
 
-	spin_unlock(&v6_lock);
+	raw_spin_unlock(&v6_lock);
 }
 
 struct cpu_user_fns v6_user_fns __initdata = {
-- 
1.7.2.3
