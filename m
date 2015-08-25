From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 25 Aug 2015 13:24:05 +0200
Subject: [PATCH] ARM: enable imprecise aborts during early kernel startup
Message-ID: <1440501845-25723-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

This patch adds imprecise abort enable/disable macros and uses them to
enable imprecise aborts early when starting the kernel.

This helps in tracking down the real cause for such imprecise abort, as
they are handled as soon as they occur. Until now those aborts would
only be enabled when entering the userspace and as a consequence crash
the first userspace process if any abort had been raised during kernel
startup.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
lst:
- rebased to current kernel
- reworked commit message
- moved abort enable to point where handlers could run
  (tested by hacking bootloader to leave a dangling abort behind)
---
 arch/arm/include/asm/irqflags.h | 10 ++++++++++
 arch/arm/kernel/smp.c           |  1 +
 arch/arm/mm/mmu.c               |  3 +++
 3 files changed, 14 insertions(+)

diff --git a/arch/arm/include/asm/irqflags.h b/arch/arm/include/asm/irqflags.h
index 43908146a5cf..e6b70d9d084e 100644
--- a/arch/arm/include/asm/irqflags.h
+++ b/arch/arm/include/asm/irqflags.h
@@ -54,6 +54,14 @@ static inline void arch_local_irq_disable(void)
 
 #define local_fiq_enable()  __asm__("cpsie f	@ __stf" : : : "memory", "cc")
 #define local_fiq_disable() __asm__("cpsid f	@ __clf" : : : "memory", "cc")
+
+#ifndef CONFIG_CPU_V7M
+#define local_abt_enable()  __asm__("cpsie a	@ __sta" : : : "memory", "cc")
+#define local_abt_disable() __asm__("cpsid a	@ __cla" : : : "memory", "cc")
+#else
+#define local_abt_enable()	do { } while (0)
+#define local_abt_disable()	do { } while (0)
+#endif
 #else
 
 /*
@@ -136,6 +144,8 @@ static inline void arch_local_irq_disable(void)
 	: "memory", "cc");					\
 	})
 
+#define local_abt_enable()	do { } while (0)
+#define local_abt_disable()	do { } while (0)
 #endif
 
 /*
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3d6b7821cff8..f6f0a76ee573 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -385,6 +385,7 @@ asmlinkage void secondary_start_kernel(void)
 
 	local_irq_enable();
 	local_fiq_enable();
+	local_abt_enable();
 
 	/*
 	 * OK, it's off to the idle thread for us
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 870838a46d52..862caeadcaf0 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1319,6 +1319,9 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
 	 */
 	local_flush_tlb_all();
 	flush_cache_all();
+
+	/* Enable asynchronous aborts */
+	local_abt_enable();
 }
 
 static void __init kmap_init(void)
-- 
2.4.6
