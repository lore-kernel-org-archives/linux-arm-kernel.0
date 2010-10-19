From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Oct 2010 16:39:02 +0200
Subject: [PATCH 07/12] ARM: Convert v4 minicache_lock to raw_spinlock
In-Reply-To: <20101019143717.GH11713@pengutronix.de>
References: <20101019143717.GH11713@pengutronix.de>
Message-ID: <1287499147-13846-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

minicache_lock needs to be a real spinlock on preempt-rt. Convert it
to a raw_spinlock. No change for !RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mm/copypage-v4mc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index 598c51a..bb17acd 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -30,7 +30,7 @@
 #define minicache_pgprot __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | \
 				  L_PTE_MT_MINICACHE)
 
-static DEFINE_SPINLOCK(minicache_lock);
+static DEFINE_RAW_SPINLOCK(minicache_lock);
 
 /*
  * ARMv4 mini-dcache optimised copy_user_highpage
@@ -76,14 +76,14 @@ void v4_mc_copy_user_highpage(struct page *to, struct page *from,
 	if (test_and_clear_bit(PG_dcache_dirty, &from->flags))
 		__flush_dcache_page(page_mapping(from), from);
 
-	spin_lock(&minicache_lock);
+	raw_spin_lock(&minicache_lock);
 
 	set_pte_ext(TOP_PTE(0xffff8000), pfn_pte(page_to_pfn(from), minicache_pgprot), 0);
 	flush_tlb_kernel_page(0xffff8000);
 
 	mc_copy_user_page((void *)0xffff8000, kto);
 
-	spin_unlock(&minicache_lock);
+	raw_spin_unlock(&minicache_lock);
 
 	kunmap_atomic(kto, KM_USER1);
 }
-- 
1.7.2.3
