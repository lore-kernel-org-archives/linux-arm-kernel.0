From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Oct 2010 16:39:00 +0200
Subject: [PATCH 05/12] ARM: Convert cpu_asid_lock to raw_spinlock
In-Reply-To: <20101019143717.GH11713@pengutronix.de>
References: <20101019143717.GH11713@pengutronix.de>
Message-ID: <1287499147-13846-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

cpu_asid_lock needs to be a real spinlock on preempt-rt. Convert it to
a raw_spinlock. No change for !RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mm/context.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index b0ee9ba..f3a9336 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -16,7 +16,7 @@
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
-static DEFINE_SPINLOCK(cpu_asid_lock);
+static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
 unsigned int cpu_last_asid = ASID_FIRST_VERSION;
 #ifdef CONFIG_SMP
 DEFINE_PER_CPU(struct mm_struct *, current_mm);
@@ -117,7 +117,7 @@ void __new_context(struct mm_struct *mm)
 {
 	unsigned int asid;
 
-	spin_lock(&cpu_asid_lock);
+	raw_spin_lock(&cpu_asid_lock);
 #ifdef CONFIG_SMP
 	/*
 	 * Check the ASID again, in case the change was broadcast from
@@ -125,7 +125,7 @@ void __new_context(struct mm_struct *mm)
 	 */
 	if (unlikely(((mm->context.id ^ cpu_last_asid) >> ASID_BITS) == 0)) {
 		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
-		spin_unlock(&cpu_asid_lock);
+		raw_spin_unlock(&cpu_asid_lock);
 		return;
 	}
 #endif
@@ -153,5 +153,5 @@ void __new_context(struct mm_struct *mm)
 	}
 
 	set_mm_context(mm, asid);
-	spin_unlock(&cpu_asid_lock);
+	raw_spin_unlock(&cpu_asid_lock);
 }
-- 
1.7.2.3
