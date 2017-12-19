From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 19 Dec 2017 10:23:49 +0000
Subject: [PATCH] ARM: NOMMU: Setup VBAR/Hivecs for secondaries cores
Message-ID: <1513679029-5915-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With switch to dynamic exception base address setting, VBAR/Hivecs
set only for boot CPU, but secondaries stay unaware of that. That
might lead to weird effects when trying up to bring up secondaries.

Fixes: ad475117d201 ("ARM: 8649/2: nommu: remove Hivecs configuration is asm")
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/memory.h | 9 +++++++++
 arch/arm/kernel/smp.c         | 2 ++
 arch/arm/mm/nommu.c           | 4 ++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 1f54e4e..65c52ac 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -165,6 +165,15 @@ extern unsigned long vectors_base;
 
 #ifndef __ASSEMBLY__
 
+#ifndef CONFIG_MMU
+extern unsigned long setup_vectors_base(void);
+#else
+static inline unsigned long setup_vectors_base(void)
+{
+	return 0;
+}
+#endif
+
 /*
  * Physical vs virtual RAM address space conversion.  These are
  * private definitions which should NOT be used outside memory.h
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b4fbf00..248e33f 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -379,6 +379,8 @@ asmlinkage void secondary_start_kernel(void)
 
 	cpu_init();
 
+	setup_vectors_base();
+
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
