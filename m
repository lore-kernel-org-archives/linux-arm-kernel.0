From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 19 Dec 2017 14:38:13 +0000
Subject: [PATCH v2] ARM: NOMMU: Setup VBAR/Hivecs for secondaries cores
Message-ID: <1513694293-5441-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With switch to dynamic exception base address setting, VBAR/Hivecs
set only for boot CPU, but secondaries stay unaware of that. That
might lead to weird effects when trying up to bring up secondaries.

Fixes: ad475117d201 ("ARM: 8649/2: nommu: remove Hivecs configuration is asm")
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/memory.h | 1 +
 arch/arm/kernel/smp.c         | 3 +++
 arch/arm/mm/nommu.c           | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 1f54e4e..4966677 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -88,6 +88,7 @@
 #else /* CONFIG_MMU */
 
 #ifndef __ASSEMBLY__
+extern unsigned long setup_vectors_base(void);
 extern unsigned long vectors_base;
 #define VECTORS_BASE		vectors_base
 #endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b4fbf00..2da0879 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -379,6 +379,9 @@ asmlinkage void secondary_start_kernel(void)
 
 	cpu_init();
 
+#ifndef CONFIG_MMU
+	setup_vectors_base();
+#endif
 	pr_debug("CPU%u: Booted secondary processor\n", cpu);
 
 	preempt_disable();
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 885b106..c8beaab 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -31,7 +31,7 @@ struct mpu_rgn_info mpu_rgn_info;
 
 #ifdef CONFIG_CPU_CP15
 #ifdef CONFIG_CPU_HIGH_VECTOR
-static unsigned long __init setup_vectors_base(void)
+unsigned long setup_vectors_base(void)
 {
 	unsigned long reg = get_cr();
 
@@ -58,7 +58,7 @@ static inline bool security_extensions_enabled(void)
 	return 0;
 }
 
-static unsigned long __init setup_vectors_base(void)
+unsigned long setup_vectors_base(void)
 {
 	unsigned long base = 0, reg = get_cr();
 
-- 
2.0.0
