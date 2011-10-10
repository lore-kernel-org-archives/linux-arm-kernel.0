From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 10 Oct 2011 13:41:27 +0530
Subject: [PATCH 1/3] ARM: Samsung: Move timer irq numbers to end of linux irq
	space
In-Reply-To: <1318234289-22041-1-git-send-email-thomas.abraham@linaro.org>
References: <1318234289-22041-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1318234289-22041-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of Samsung's s5p platforms have timer irqs statically mapped from linux
irq numbers 11 to 15. These timer irqs are moved to end of the statically
mapped linux irq space and the hardware irqs, which were statically mapped
starting from 32 is moved to start from 0. The NR_IRQS macro is consolidated
for all the s5p platforms in this process.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/include/mach/entry-macro.S |    1 -
 arch/arm/mach-exynos4/include/mach/irqs.h        |    3 +--
 arch/arm/mach-s5p64x0/include/mach/irqs.h        |    4 +---
 arch/arm/mach-s5pc100/include/mach/irqs.h        |    3 +--
 arch/arm/mach-s5pv210/include/mach/irqs.h        |    3 +--
 arch/arm/plat-samsung/include/plat/irqs.h        |    7 +++++--
 6 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/entry-macro.S b/arch/arm/mach-exynos4/include/mach/entry-macro.S
index 4c9adbd..5c4fbcc 100644
--- a/arch/arm/mach-exynos4/include/mach/entry-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/entry-macro.S
@@ -72,7 +72,6 @@
 		cmpcc	\irqnr, \irqnr
 		cmpne	\irqnr, \tmp
 		cmpcs	\irqnr, \irqnr
-		addne	\irqnr, \irqnr, #32
 
 		.endm
 
diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
index dfd4b7e..43087c3 100644
--- a/arch/arm/mach-exynos4/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -163,7 +163,6 @@
 #define IRQ_GPIO2_NR_GROUPS	9
 #define IRQ_GPIO_END		(S5P_GPIOINT_BASE + S5P_GPIOINT_COUNT)
 
-/* Set the default NR_IRQS */
-#define NR_IRQS			(IRQ_GPIO_END + 64)
+#define IRQ_TIMER_BASE		(IRQ_GPIO_END + 64)
 
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-s5p64x0/include/mach/irqs.h b/arch/arm/mach-s5p64x0/include/mach/irqs.h
index 53982db..bea73cc 100644
--- a/arch/arm/mach-s5p64x0/include/mach/irqs.h
+++ b/arch/arm/mach-s5p64x0/include/mach/irqs.h
@@ -141,8 +141,6 @@
 
 #define IRQ_EINT_GROUP(grp, x)	(IRQ_EINT_GROUP##grp##_BASE + (x))
 
-/* Set the default NR_IRQS */
-
-#define NR_IRQS			(IRQ_EINT_GROUP8_BASE + IRQ_EINT_GROUP8_NR + 1)
+#define IRQ_TIMER_BASE		(IRQ_EINT_GROUP8_BASE + IRQ_EINT_GROUP8_NR + 1)
 
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-s5pc100/include/mach/irqs.h
index d2eb475..3a9d300 100644
--- a/arch/arm/mach-s5pc100/include/mach/irqs.h
+++ b/arch/arm/mach-s5pc100/include/mach/irqs.h
@@ -104,8 +104,7 @@
 #define S5P_GPIOINT_BASE	(IRQ_EINT(31) + 1)
 #define S5P_GPIOINT_GROUP_MAXNR	21
 
-/* Set the default NR_IRQS */
-#define NR_IRQS			(IRQ_EINT(31) + S5P_GPIOINT_COUNT + 1)
+#define IRQ_TIMER_BASE		(IRQ_EINT(31) + S5P_GPIOINT_COUNT + 1)
 
 /* Compatibility */
 #define IRQ_LCD_FIFO		IRQ_LCD0
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index 5e0de3a..df3173a 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -125,8 +125,7 @@
 #define S5P_GPIOINT_BASE	(IRQ_EINT(31) + 1)
 #define S5P_GPIOINT_GROUP_MAXNR	22
 
-/* Set the default NR_IRQS */
-#define NR_IRQS			(IRQ_EINT(31) + S5P_GPIOINT_COUNT + 1)
+#define IRQ_TIMER_BASE		(IRQ_EINT(31) + S5P_GPIOINT_COUNT + 1)
 
 /* Compatibility */
 #define IRQ_LCD_FIFO		IRQ_LCD0
diff --git a/arch/arm/plat-samsung/include/plat/irqs.h b/arch/arm/plat-samsung/include/plat/irqs.h
index 08d1a7e..b8918b3 100644
--- a/arch/arm/plat-samsung/include/plat/irqs.h
+++ b/arch/arm/plat-samsung/include/plat/irqs.h
@@ -22,7 +22,7 @@
  * mulitple of 32 to allow the common code to work
  */
 
-#define S5P_IRQ_OFFSET		(32)
+#define S5P_IRQ_OFFSET		(0)
 
 #define S5P_IRQ(x)		((x) + S5P_IRQ_OFFSET)
 
@@ -44,13 +44,14 @@
 #define S5P_IRQ_VIC2(x)		(S5P_VIC2_BASE + (x))
 #define S5P_IRQ_VIC3(x)		(S5P_VIC3_BASE + (x))
 
-#define S5P_TIMER_IRQ(x)	(11 + (x))
+#define S5P_TIMER_IRQ(x)	(IRQ_TIMER_BASE + (x))
 
 #define IRQ_TIMER0		S5P_TIMER_IRQ(0)
 #define IRQ_TIMER1		S5P_TIMER_IRQ(1)
 #define IRQ_TIMER2		S5P_TIMER_IRQ(2)
 #define IRQ_TIMER3		S5P_TIMER_IRQ(3)
 #define IRQ_TIMER4		S5P_TIMER_IRQ(4)
+#define IRQ_TIMER_COUNT		(5)
 
 #define IRQ_EINT(x)		((x) < 16 ? ((x) + S5P_EINT_BASE1) \
 					: ((x) - 16 + S5P_EINT_BASE2))
@@ -77,4 +78,6 @@
 #define S5P_IRQ_TYPE_EDGE_RISING	(0x03)
 #define S5P_IRQ_TYPE_EDGE_BOTH		(0x04)
 
+#define NR_IRQS			(IRQ_TIMER_BASE + IRQ_TIMER_COUNT)
+
 #endif /* __PLAT_SAMSUNG_IRQS_H */
-- 
1.6.6.rc2
