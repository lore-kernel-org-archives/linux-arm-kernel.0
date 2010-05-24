From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 24 May 2010 16:44:23 +0900
Subject: [PATCH] ARM: S5P: Fix the platform external interrupt issues.
Message-ID: <1274687063-748-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pannaga Bhushan <p.bhushan@samsung.com>

This patch does the following:

1. Corrects the common platform code for external interrupts for using the
   VIC mask/unmask bits also.
2. Moves the common defines related to external interrupt for plat-s5p
   to common files.
3. Based on the new common defines, corresponding changes are made in the
   affected platforms (S5P6440, S5P6442 and S5PC100).

Signed-off-by: Pannaga Bhushan <p.bhushan@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/include/mach/irqs.h      |    9 ++++++++-
 arch/arm/mach-s5p6442/include/mach/irqs.h      |    5 +++--
 arch/arm/mach-s5pc100/include/mach/irqs.h      |    3 ---
 arch/arm/mach-s5pv210/include/mach/irqs.h      |   14 ++------------
 arch/arm/mach-s5pv210/include/mach/regs-gpio.h |   14 +++++++++-----
 arch/arm/plat-s5p/Kconfig                      |    1 +
 arch/arm/plat-s5p/include/plat/irqs.h          |    7 +++++++
 arch/arm/plat-s5p/irq-eint.c                   |   15 ++++++++++-----
 8 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-s5p6440/include/mach/irqs.h b/arch/arm/mach-s5p6440/include/mach/irqs.h
index a4b9b40..911854d 100644
--- a/arch/arm/mach-s5p6440/include/mach/irqs.h
+++ b/arch/arm/mach-s5p6440/include/mach/irqs.h
@@ -72,7 +72,14 @@
 #define S5P_IRQ_EINT_BASE	(S5P_IRQ_VIC1(31) + 6)
 
 #define S5P_EINT(x)		((x) + S5P_IRQ_EINT_BASE)
-#define IRQ_EINT(x)		S5P_EINT(x)
+
+#define S5P_EINT_BASE1		(S5P_IRQ_EINT_BASE)
+/*
+ * S5P6440 has 0-15 external interrupts in group 0. Only these can be used
+ * to wake up from sleep. If request is beyond this range, by mistake, a large
+ * return value for an irq number should be indication of something amiss.
+ */
+#define S5P_EINT_BASE2		(0xf0000000)
 
 /*
  * Next the external interrupt groups. These are similar to the IRQ_EINT(x)
diff --git a/arch/arm/mach-s5p6442/include/mach/irqs.h b/arch/arm/mach-s5p6442/include/mach/irqs.h
index da66580..02c2374 100644
--- a/arch/arm/mach-s5p6442/include/mach/irqs.h
+++ b/arch/arm/mach-s5p6442/include/mach/irqs.h
@@ -77,8 +77,9 @@
 
 #define S5P_IRQ_EINT_BASE	(IRQ_VIC_END + 1)
 
-#define IRQ_EINT(x)             ((x) < 16 ? S5P_IRQ_VIC0(x) : \
-					(S5P_IRQ_EINT_BASE + (x)-16))
+#define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
+#define S5P_EINT_BASE2		(S5P_IRQ_EINT_BASE)
+
 /* Set the default NR_IRQS */
 
 #define NR_IRQS 		(IRQ_EINT(31) + 1)
diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-s5pc100/include/mach/irqs.h
index 15066df..28aa551 100644
--- a/arch/arm/mach-s5pc100/include/mach/irqs.h
+++ b/arch/arm/mach-s5pc100/include/mach/irqs.h
@@ -100,9 +100,6 @@
 #define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
 #define S5P_EINT_BASE2		(IRQ_VIC_END + 1)
 
-#define IRQ_EINT(x)		((x) < 16 ? S5P_IRQ_VIC0(x) : \
-				 (S5P_EINT_BASE2 + (x) - 16))
-
 #define S3C_IRQ_GPIO_BASE	(IRQ_EINT(31) + 1)
 #define S3C_IRQ_GPIO(x)		(S3C_IRQ_GPIO_BASE + (x))
 
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index 92fc6c7..9689537 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -118,22 +118,12 @@
 #define IRQ_MDNIE3		S5P_IRQ_VIC3(8)
 #define IRQ_VIC_END		S5P_IRQ_VIC3(31)
 
-#define S5P_EINT_16_31_BASE	(IRQ_VIC_END + 1)
-
-#define EINT_MODE		S3C_GPIO_SFN(0xf)
-
-#define IRQ_EINT(x)		((x) < 16 ? ((x) + S5P_IRQ_VIC0(0)) \
-					: ((x) + S5P_EINT_16_31_BASE))
+#define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
+#define S5P_EINT_BASE2		(IRQ_VIC_END + 1)
 
 /* Set the default NR_IRQS */
-
 #define NR_IRQS			(IRQ_EINT(31) + 1)
 
-#define EINT_GPIO_0(x)		S5PV210_GPH0(x)
-#define EINT_GPIO_1(x)		S5PV210_GPH1(x)
-#define EINT_GPIO_2(x)		S5PV210_GPH2(x)
-#define EINT_GPIO_3(x)		S5PV210_GPH3(x)
-
 /* Compatibility */
 #define IRQ_LCD_FIFO		IRQ_LCD0
 #define IRQ_LCD_VSYNC		IRQ_LCD1
diff --git a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
index 6d06809..49e029b 100644
--- a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
@@ -27,12 +27,9 @@
 #define S5PV210_EINT30PEND		(S5P_VA_GPIO + 0xF40)
 #define S5P_EINT_PEND(x)		(S5PV210_EINT30PEND + ((x) * 0x4))
 
-#define eint_offset(irq)	((irq) < IRQ_EINT16_31 ? ((irq) - IRQ_EINT(0)) \
-						: ((irq) - S5P_EINT_16_31_BASE))
+#define EINT_REG_NR(x)			(EINT_OFFSET(x) >> 3)
 
-#define EINT_REG_NR(x)			(eint_offset(x) >> 3)
-
-#define eint_irq_to_bit(irq)		(1 << (eint_offset(irq) & 0x7))
+#define eint_irq_to_bit(irq)		(1 << (EINT_OFFSET(irq) & 0x7))
 
 /* values for S5P_EXTINT0 */
 #define S5P_EXTINT_LOWLEV		(0x00)
@@ -41,4 +38,11 @@
 #define S5P_EXTINT_RISEEDGE		(0x03)
 #define S5P_EXTINT_BOTHEDGE		(0x04)
 
+#define EINT_MODE		S3C_GPIO_SFN(0xf)
+
+#define EINT_GPIO_0(x)		S5PV210_GPH0(x)
+#define EINT_GPIO_1(x)		S5PV210_GPH1(x)
+#define EINT_GPIO_2(x)		S5PV210_GPH2(x)
+#define EINT_GPIO_3(x)		S5PV210_GPH3(x)
+
 #endif /* __ASM_ARCH_REGS_GPIO_H */
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 5cb2dd1..11d6a1b 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -29,3 +29,4 @@ config S5P_EXT_INT
 	bool
 	help
 	  Use the external interrupts (other than GPIO interrupts.)
+	  Note: Do not choose this for S5P6440.
diff --git a/arch/arm/plat-s5p/include/plat/irqs.h b/arch/arm/plat-s5p/include/plat/irqs.h
index 9ff3d71..3fb3a3a 100644
--- a/arch/arm/plat-s5p/include/plat/irqs.h
+++ b/arch/arm/plat-s5p/include/plat/irqs.h
@@ -87,4 +87,11 @@
 #define IRQ_TIMER3		S5P_TIMER_IRQ(3)
 #define IRQ_TIMER4		S5P_TIMER_IRQ(4)
 
+#define IRQ_EINT(x)		((x) < 16 ? ((x) + S5P_EINT_BASE1) \
+					: ((x) - 16 + S5P_EINT_BASE2))
+
+#define EINT_OFFSET(irq)	((irq) < S5P_EINT_BASE2 ? \
+						((irq) - S5P_EINT_BASE1) : \
+						((irq) + 16 - S5P_EINT_BASE2))
+
 #endif /* __ASM_PLAT_S5P_IRQS_H */
diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
index eaa70aa..e56c807 100644
--- a/arch/arm/plat-s5p/irq-eint.c
+++ b/arch/arm/plat-s5p/irq-eint.c
@@ -60,7 +60,7 @@ static void s5p_irq_eint_maskack(unsigned int irq)
 
 static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
 {
-	int offs = eint_offset(irq);
+	int offs = EINT_OFFSET(irq);
 	int shift;
 	u32 ctrl, mask;
 	u32 newvalue = 0;
@@ -139,17 +139,16 @@ static struct irq_chip s5p_irq_eint = {
  */
 static inline void s5p_irq_demux_eint(unsigned int start)
 {
-	u32 status;
+	u32 status = __raw_readl(S5P_EINT_PEND(EINT_REG_NR(start)));
 	u32 mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(start)));
 	unsigned int irq;
 
-	status = __raw_readl(S5P_EINT_PEND(EINT_REG_NR(start)));
 	status &= ~mask;
 	status &= 0xff;
 
 	while (status) {
-		irq = fls(status);
-		generic_handle_irq(irq - 1 + start);
+		irq = fls(status) - 1;
+		generic_handle_irq(irq + start);
 		status &= ~(1 << irq);
 	}
 }
@@ -162,12 +161,18 @@ static void s5p_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 
 static inline void s5p_irq_vic_eint_mask(unsigned int irq)
 {
+	void __iomem *base = get_irq_chip_data(irq);
+
 	s5p_irq_eint_mask(irq);
+	writel(1 << EINT_OFFSET(irq), base + VIC_INT_ENABLE_CLEAR);
 }
 
 static void s5p_irq_vic_eint_unmask(unsigned int irq)
 {
+	void __iomem *base = get_irq_chip_data(irq);
+
 	s5p_irq_eint_unmask(irq);
+	writel(1 << EINT_OFFSET(irq), base + VIC_INT_ENABLE);
 }
 
 static inline void s5p_irq_vic_eint_ack(unsigned int irq)
-- 
1.6.3.3
