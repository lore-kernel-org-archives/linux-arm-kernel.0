From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 15:21:22 +0100
Subject: [PATCH v2 08/12] ARM: spinlock: use inner-shareable dsb variant prior
 to sev instruction
In-Reply-To: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
References: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
Message-ID: <1371738086-6707-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When unlocking a spinlock, we use the sev instruction to signal other
CPUs waiting on the lock. Since sev is not a memory access instruction,
we require a dsb in order to ensure that the sev is not issued ahead
of the store placing the lock in an unlocked state.

However, as sev is only concerned with other processors in a
multiprocessor system, we can restrict the scope of the preceding dsb
to the inner-shareable domain. Furthermore, we can restrict the scope to
consider only stores, since there are no independent loads on the unlock
path.

A side-effect of this change is that a spin_unlock operation no longer
forces completion of pending TLB invalidation, something which we rely
on when unlocking runqueues to ensure that CPU migration during TLB
maintenance routines doesn't cause us to continue before the operation
has completed.

This patch adds the -ishst suffix to the ARMv7 definition of dsb_sev()
and adds an inner-shareable dsb to the context-switch path when running
a preemptible, SMP, v7 kernel.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/spinlock.h  |  2 +-
 arch/arm/include/asm/switch_to.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 6220e9f..5a0261e 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -46,7 +46,7 @@ static inline void dsb_sev(void)
 {
 #if __LINUX_ARM_ARCH__ >= 7
 	__asm__ __volatile__ (
-		"dsb\n"
+		"dsb ishst\n"
 		SEV
 	);
 #else
diff --git a/arch/arm/include/asm/switch_to.h b/arch/arm/include/asm/switch_to.h
index fa09e6b..c99e259 100644
--- a/arch/arm/include/asm/switch_to.h
+++ b/arch/arm/include/asm/switch_to.h
@@ -4,6 +4,16 @@
 #include <linux/thread_info.h>
 
 /*
+ * For v7 SMP cores running a preemptible kernel we may be pre-empted
+ * during a TLB maintenance operation, so execute an inner-shareable dsb
+ * to ensure that the maintenance completes in case we migrate to another
+ * CPU.
+ */
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP) && defined(CONFIG_CPU_V7)
+#define finish_arch_switch(prev)	dsb(ish)
+#endif
+
+/*
  * switch_to(prev, next) should switch from task `prev' to `next'
  * `prev' will never be the same as `next'.  schedule() itself
  * contains the memory barrier to tell GCC not to cache `current'.
-- 
1.8.2.2
