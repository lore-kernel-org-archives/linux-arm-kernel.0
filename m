From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue,  1 Nov 2011 06:31:27 +0530
Subject: [PATCH v2 1/3] ARM: Exynos4: Move timer irq numbers to end of linux
	irq space
In-Reply-To: <1320109289-2730-1-git-send-email-thomas.abraham@linaro.org>
References: <1320109289-2730-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1320109289-2730-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer irqs statically mapped from linux irq numbers 11 to 15 are moved to
the end of the statically mapped linux irq space. The GIC PPI and SPI interrupts
are relocated to start from 16 and 32 of the linux irq space. This is a required
to add device tree support for GIC and Interrupt combiner for Exynos4.

A new macro 'IRQ_TIMER_BASE' specifies a platform specific base of the linux
virq number for the timer interrupts. For exynos4, this base is set to end of
the linux virq space.  For the other s5p platforms, the existing base '11' is
retained.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/include/mach/entry-macro.S |    1 -
 arch/arm/mach-exynos4/include/mach/irqs.h        |    8 +++++---
 arch/arm/mach-s5p64x0/include/mach/irqs.h        |    2 ++
 arch/arm/mach-s5pc100/include/mach/irqs.h        |    2 ++
 arch/arm/mach-s5pv210/include/mach/irqs.h        |    2 ++
 arch/arm/plat-samsung/include/plat/irqs.h        |    3 ++-
 6 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/entry-macro.S b/arch/arm/mach-exynos4/include/mach/entry-macro.S
index f5e9fd8..d7dfcd7 100644
--- a/arch/arm/mach-exynos4/include/mach/entry-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/entry-macro.S
@@ -72,7 +72,6 @@
 		cmpcc	\irqnr, \irqnr
 		cmpne	\irqnr, \tmp
 		cmpcs	\irqnr, \irqnr
-		addne	\irqnr, \irqnr, #32
 
 		.endm
 
diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
index dfd4b7e..713dd52 100644
--- a/arch/arm/mach-exynos4/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -17,13 +17,13 @@
 
 /* PPI: Private Peripheral Interrupt */
 
-#define IRQ_PPI(x)		S5P_IRQ(x+16)
+#define IRQ_PPI(x)		(x+16)
 
 #define IRQ_MCT_LOCALTIMER	IRQ_PPI(12)
 
 /* SPI: Shared Peripheral Interrupt */
 
-#define IRQ_SPI(x)		S5P_IRQ(x+32)
+#define IRQ_SPI(x)		(x+32)
 
 #define IRQ_EINT0		IRQ_SPI(16)
 #define IRQ_EINT1		IRQ_SPI(17)
@@ -163,7 +163,9 @@
 #define IRQ_GPIO2_NR_GROUPS	9
 #define IRQ_GPIO_END		(S5P_GPIOINT_BASE + S5P_GPIOINT_COUNT)
 
+#define IRQ_TIMER_BASE		(IRQ_GPIO_END + 64)
+
 /* Set the default NR_IRQS */
-#define NR_IRQS			(IRQ_GPIO_END + 64)
+#define NR_IRQS			(IRQ_TIMER_BASE + IRQ_TIMER_COUNT)
 
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-s5p64x0/include/mach/irqs.h b/arch/arm/mach-s5p64x0/include/mach/irqs.h
index 53982db..5b845e8 100644
--- a/arch/arm/mach-s5p64x0/include/mach/irqs.h
+++ b/arch/arm/mach-s5p64x0/include/mach/irqs.h
@@ -141,6 +141,8 @@
 
 #define IRQ_EINT_GROUP(grp, x)	(IRQ_EINT_GROUP##grp##_BASE + (x))
 
+#define IRQ_TIMER_BASE		(11)
+
 /* Set the default NR_IRQS */
 
 #define NR_IRQS			(IRQ_EINT_GROUP8_BASE + IRQ_EINT_GROUP8_NR + 1)
diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-s5pc100/include/mach/irqs.h
index d2eb475..2870f12 100644
--- a/arch/arm/mach-s5pc100/include/mach/irqs.h
+++ b/arch/arm/mach-s5pc100/include/mach/irqs.h
@@ -97,6 +97,8 @@
 #define IRQ_SDMFIQ		S5P_IRQ_VIC2(31)
 #define IRQ_VIC_END		S5P_IRQ_VIC2(31)
 
+#define IRQ_TIMER_BASE		(11)
+
 #define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
 #define S5P_EINT_BASE2		(IRQ_VIC_END + 1)
 
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index 5e0de3a..e777e01 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -118,6 +118,8 @@
 #define IRQ_MDNIE3		S5P_IRQ_VIC3(8)
 #define IRQ_VIC_END		S5P_IRQ_VIC3(31)
 
+#define IRQ_TIMER_BASE		(11)
+
 #define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
 #define S5P_EINT_BASE2		(IRQ_VIC_END + 1)
 
diff --git a/arch/arm/plat-samsung/include/plat/irqs.h b/arch/arm/plat-samsung/include/plat/irqs.h
index 08d1a7e..df46b77 100644
--- a/arch/arm/plat-samsung/include/plat/irqs.h
+++ b/arch/arm/plat-samsung/include/plat/irqs.h
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
-- 
1.7.4.4
