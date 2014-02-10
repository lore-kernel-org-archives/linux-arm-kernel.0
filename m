From: fabrice.gasnier@st.com (Fabrice GASNIER)
Date: Mon, 10 Feb 2014 17:45:56 +0100
Subject: [PATCH v2] ARM: Add imprecise abort enable/disable macro
Message-ID: <1392050756-11145-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds imprecise abort enable/disable macros.
It also enables imprecise aborts when starting kernel.

Changes in v2:
Only ARMv6 and later have CPSR.A bit. On earlier CPUs,
and ARMv7M this should be a no-op.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/include/asm/irqflags.h |   10 ++++++++++
 arch/arm/kernel/smp.c           |    1 +
 arch/arm/kernel/traps.c         |    4 ++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/include/asm/irqflags.h b/arch/arm/include/asm/irqflags.h
index 3b763d6..8301f87 100644
--- a/arch/arm/include/asm/irqflags.h
+++ b/arch/arm/include/asm/irqflags.h
@@ -51,6 +51,14 @@ static inline void arch_local_irq_disable(void)
 
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
@@ -130,6 +138,8 @@ static inline void arch_local_irq_disable(void)
 	: "memory", "cc");					\
 	})
 
+#define local_abt_enable()	do { } while (0)
+#define local_abt_disable()	do { } while (0)
 #endif
 
 /*
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index dc894ab..c2093cb 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -377,6 +377,7 @@ asmlinkage void secondary_start_kernel(void)
 
 	local_irq_enable();
 	local_fiq_enable();
+	local_abt_enable();
 
 	/*
 	 * OK, it's off to the idle thread for us
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 4636d56..ef15709 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -900,6 +900,10 @@ void __init early_trap_init(void *vectors_base)
 
 	flush_icache_range(vectors, vectors + PAGE_SIZE * 2);
 	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
+
+	/* Enable imprecise aborts */
+	local_abt_enable();
+
 #else /* ifndef CONFIG_CPU_V7M */
 	/*
 	 * on V7-M there is no need to copy the vector table to a dedicated
-- 
1.7.9.5
