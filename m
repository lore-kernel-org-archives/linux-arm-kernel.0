From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:33:01 +0100
Subject: [RFC PATCH 07/18] ARM: msm: fix sirc code for multiplatform
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sirc irchip driver hardcodes interrupts for a particular
revision of the qsd8x50 chip, which breaks building a single
binary for multiple revisions.

This reorganizes the code to move this decision to the board
code and makes the irq range runtime dependent.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-msm/board-qsd8x50.c          | 12 +++++-
 arch/arm/mach-msm/include/mach/irqs-8x50.h | 40 ++++++++++++++++++
 arch/arm/mach-msm/include/mach/sirc.h      | 66 +-----------------------------
 arch/arm/mach-msm/sirc.c                   | 43 ++++++++++++++-----
 4 files changed, 83 insertions(+), 78 deletions(-)

diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 58c7ab45c1d4..24f4ae061f79 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -223,7 +223,7 @@ static void __init qsd8x50_init_mmc(void)
 static void __init qsd8x50_init_irq(void)
 {
 	msm_init_irq();
-	msm_init_sirc();
+	msm_init_sirc(FIRST_SIRC_IRQ, NR_SIRC_IRQS_REV_OTHER, INT_SIRC_0);
 }
 
 static void __init qsd8x50_init(void)
@@ -249,11 +249,19 @@ MACHINE_START(QSD8X50_SURF, "QCT QSD8X50 SURF")
 	.init_time	= qsd8x50_timer_init,
 MACHINE_END
 
+#ifdef CONFIG_MSM_SOC_REV_A
+static void __init qsd8x50_init_irq_rev_a(void)
+{
+	msm_init_irq();
+	msm_init_sirc(FIRST_SIRC_IRQ, NR_SIRC_IRQS_REV_A, INT_SIRC_0);
+}
+
 MACHINE_START(QSD8X50A_ST1_5, "QCT QSD8X50A ST1.5")
 	.atag_offset = 0x100,
 	.map_io = msm_map_qsd8x50_io_rev_a,
-	.init_irq = qsd8x50_init_irq,
+	.init_irq = qsd8x50_init_irq_rev_a,
 	.init_machine = qsd8x50_init,
 	.init_late = qsd8x50_init_late,
 	.init_time	= qsd8x50_timer_init,
 MACHINE_END
+#endif
diff --git a/arch/arm/mach-msm/include/mach/irqs-8x50.h b/arch/arm/mach-msm/include/mach/irqs-8x50.h
index 26adbe0e9406..9a6036119a8d 100644
--- a/arch/arm/mach-msm/include/mach/irqs-8x50.h
+++ b/arch/arm/mach-msm/include/mach/irqs-8x50.h
@@ -85,4 +85,44 @@
 #define NR_MSM_IRQS 64
 #define NR_BOARD_IRQS 64
 
+/*
+ * Secondary interrupt controller interrupts
+ */
+
+#define FIRST_SIRC_IRQ (NR_MSM_IRQS + NR_GPIO_IRQS)
+
+#define INT_UART1                     (FIRST_SIRC_IRQ + 0)
+#define INT_UART2                     (FIRST_SIRC_IRQ + 1)
+#define INT_UART3                     (FIRST_SIRC_IRQ + 2)
+#define INT_UART1_RX                  (FIRST_SIRC_IRQ + 3)
+#define INT_UART2_RX                  (FIRST_SIRC_IRQ + 4)
+#define INT_UART3_RX                  (FIRST_SIRC_IRQ + 5)
+#define INT_SPI_INPUT                 (FIRST_SIRC_IRQ + 6)
+#define INT_SPI_OUTPUT                (FIRST_SIRC_IRQ + 7)
+#define INT_SPI_ERROR                 (FIRST_SIRC_IRQ + 8)
+#define INT_GPIO_GROUP1               (FIRST_SIRC_IRQ + 9)
+#define INT_GPIO_GROUP2               (FIRST_SIRC_IRQ + 10)
+#define INT_GPIO_GROUP1_SECURE        (FIRST_SIRC_IRQ + 11)
+#define INT_GPIO_GROUP2_SECURE        (FIRST_SIRC_IRQ + 12)
+#define INT_AVS_SVIC                  (FIRST_SIRC_IRQ + 13)
+#define INT_AVS_REQ_UP                (FIRST_SIRC_IRQ + 14)
+#define INT_AVS_REQ_DOWN              (FIRST_SIRC_IRQ + 15)
+#define INT_PBUS_ERR                  (FIRST_SIRC_IRQ + 16)
+#define INT_AXI_ERR                   (FIRST_SIRC_IRQ + 17)
+#define INT_SMI_ERR                   (FIRST_SIRC_IRQ + 18)
+#define INT_EBI1_ERR                  (FIRST_SIRC_IRQ + 19)
+#define INT_IMEM_ERR                  (FIRST_SIRC_IRQ + 20)
+#define INT_TEMP_SENSOR               (FIRST_SIRC_IRQ + 21)
+#define INT_TV_ENC                    (FIRST_SIRC_IRQ + 22)
+#define INT_GRP2D                     (FIRST_SIRC_IRQ + 23)
+#define INT_GSBI_QUP                  (FIRST_SIRC_IRQ + 24)
+#define INT_SC_ACG                    (FIRST_SIRC_IRQ + 25)
+#define INT_WDT0                      (FIRST_SIRC_IRQ + 26)
+#define INT_WDT1                      (FIRST_SIRC_IRQ + 27)
+
+#define NR_SIRC_IRQS_REV_A		28
+#define NR_SIRC_IRQS_REV_OTHER		23
+
+#define LAST_SIRC_IRQ                 (FIRST_SIRC_IRQ + NR_SIRC_IRQS - 1)
+
 #endif
diff --git a/arch/arm/mach-msm/include/mach/sirc.h b/arch/arm/mach-msm/include/mach/sirc.h
index ef55868a5b8a..622555ddd2fd 100644
--- a/arch/arm/mach-msm/include/mach/sirc.h
+++ b/arch/arm/mach-msm/include/mach/sirc.h
@@ -27,72 +27,8 @@ struct sirc_cascade_regs {
 	unsigned int    cascade_irq;
 };
 
-void msm_init_sirc(void);
+void msm_init_sirc(int first, int nr_irqs, int cascade);
 void msm_sirc_enter_sleep(void);
 void msm_sirc_exit_sleep(void);
 
-#if defined(CONFIG_ARCH_MSM_SCORPION)
-
-#include <mach/msm_iomap.h>
-
-/*
- * Secondary interrupt controller interrupts
- */
-
-#define FIRST_SIRC_IRQ (NR_MSM_IRQS + NR_GPIO_IRQS)
-
-#define INT_UART1                     (FIRST_SIRC_IRQ + 0)
-#define INT_UART2                     (FIRST_SIRC_IRQ + 1)
-#define INT_UART3                     (FIRST_SIRC_IRQ + 2)
-#define INT_UART1_RX                  (FIRST_SIRC_IRQ + 3)
-#define INT_UART2_RX                  (FIRST_SIRC_IRQ + 4)
-#define INT_UART3_RX                  (FIRST_SIRC_IRQ + 5)
-#define INT_SPI_INPUT                 (FIRST_SIRC_IRQ + 6)
-#define INT_SPI_OUTPUT                (FIRST_SIRC_IRQ + 7)
-#define INT_SPI_ERROR                 (FIRST_SIRC_IRQ + 8)
-#define INT_GPIO_GROUP1               (FIRST_SIRC_IRQ + 9)
-#define INT_GPIO_GROUP2               (FIRST_SIRC_IRQ + 10)
-#define INT_GPIO_GROUP1_SECURE        (FIRST_SIRC_IRQ + 11)
-#define INT_GPIO_GROUP2_SECURE        (FIRST_SIRC_IRQ + 12)
-#define INT_AVS_SVIC                  (FIRST_SIRC_IRQ + 13)
-#define INT_AVS_REQ_UP                (FIRST_SIRC_IRQ + 14)
-#define INT_AVS_REQ_DOWN              (FIRST_SIRC_IRQ + 15)
-#define INT_PBUS_ERR                  (FIRST_SIRC_IRQ + 16)
-#define INT_AXI_ERR                   (FIRST_SIRC_IRQ + 17)
-#define INT_SMI_ERR                   (FIRST_SIRC_IRQ + 18)
-#define INT_EBI1_ERR                  (FIRST_SIRC_IRQ + 19)
-#define INT_IMEM_ERR                  (FIRST_SIRC_IRQ + 20)
-#define INT_TEMP_SENSOR               (FIRST_SIRC_IRQ + 21)
-#define INT_TV_ENC                    (FIRST_SIRC_IRQ + 22)
-#define INT_GRP2D                     (FIRST_SIRC_IRQ + 23)
-#define INT_GSBI_QUP                  (FIRST_SIRC_IRQ + 24)
-#define INT_SC_ACG                    (FIRST_SIRC_IRQ + 25)
-#define INT_WDT0                      (FIRST_SIRC_IRQ + 26)
-#define INT_WDT1                      (FIRST_SIRC_IRQ + 27)
-
-#if defined(CONFIG_MSM_SOC_REV_A)
-#define NR_SIRC_IRQS                  28
-#define SIRC_MASK                     0x0FFFFFFF
-#else
-#define NR_SIRC_IRQS                  23
-#define SIRC_MASK                     0x007FFFFF
-#endif
-
-#define LAST_SIRC_IRQ                 (FIRST_SIRC_IRQ + NR_SIRC_IRQS - 1)
-
-#define SPSS_SIRC_INT_SELECT          (MSM_SIRC_BASE + 0x00)
-#define SPSS_SIRC_INT_ENABLE          (MSM_SIRC_BASE + 0x04)
-#define SPSS_SIRC_INT_ENABLE_CLEAR    (MSM_SIRC_BASE + 0x08)
-#define SPSS_SIRC_INT_ENABLE_SET      (MSM_SIRC_BASE + 0x0C)
-#define SPSS_SIRC_INT_TYPE            (MSM_SIRC_BASE + 0x10)
-#define SPSS_SIRC_INT_POLARITY        (MSM_SIRC_BASE + 0x14)
-#define SPSS_SIRC_SECURITY            (MSM_SIRC_BASE + 0x18)
-#define SPSS_SIRC_IRQ_STATUS          (MSM_SIRC_BASE + 0x1C)
-#define SPSS_SIRC_IRQ1_STATUS         (MSM_SIRC_BASE + 0x20)
-#define SPSS_SIRC_RAW_STATUS          (MSM_SIRC_BASE + 0x24)
-#define SPSS_SIRC_INT_CLEAR           (MSM_SIRC_BASE + 0x28)
-#define SPSS_SIRC_SOFT_INT            (MSM_SIRC_BASE + 0x2C)
-
-#endif
-
 #endif
diff --git a/arch/arm/mach-msm/sirc.c b/arch/arm/mach-msm/sirc.c
index 689e78c95f38..bfef62c0e8dc 100644
--- a/arch/arm/mach-msm/sirc.c
+++ b/arch/arm/mach-msm/sirc.c
@@ -20,9 +20,27 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <asm/irq.h>
+#include <mach/msm_iomap-8x50.h>
+#include <mach/sirc.h>
+
+#define SPSS_SIRC_INT_SELECT          (MSM_SIRC_BASE + 0x00)
+#define SPSS_SIRC_INT_ENABLE          (MSM_SIRC_BASE + 0x04)
+#define SPSS_SIRC_INT_ENABLE_CLEAR    (MSM_SIRC_BASE + 0x08)
+#define SPSS_SIRC_INT_ENABLE_SET      (MSM_SIRC_BASE + 0x0C)
+#define SPSS_SIRC_INT_TYPE            (MSM_SIRC_BASE + 0x10)
+#define SPSS_SIRC_INT_POLARITY        (MSM_SIRC_BASE + 0x14)
+#define SPSS_SIRC_SECURITY            (MSM_SIRC_BASE + 0x18)
+#define SPSS_SIRC_IRQ_STATUS          (MSM_SIRC_BASE + 0x1C)
+#define SPSS_SIRC_IRQ1_STATUS         (MSM_SIRC_BASE + 0x20)
+#define SPSS_SIRC_RAW_STATUS          (MSM_SIRC_BASE + 0x24)
+#define SPSS_SIRC_INT_CLEAR           (MSM_SIRC_BASE + 0x28)
+#define SPSS_SIRC_SOFT_INT            (MSM_SIRC_BASE + 0x2C)
 
 static unsigned int int_enable;
 static unsigned int wake_enable;
+static int first_sirc_irq;
+static int nr_sirc_irqs;
+static int sirc_mask;
 
 static struct sirc_regs_t sirc_regs = {
 	.int_enable       = SPSS_SIRC_INT_ENABLE,
@@ -36,7 +54,6 @@ static struct sirc_regs_t sirc_regs = {
 static struct sirc_cascade_regs sirc_reg_table[] = {
 	{
 		.int_status  = SPSS_SIRC_IRQ_STATUS,
-		.cascade_irq = INT_SIRC_0,
 	}
 };
 
@@ -46,7 +63,7 @@ static void sirc_irq_mask(struct irq_data *d)
 {
 	unsigned int mask;
 
-	mask = 1 << (d->irq - FIRST_SIRC_IRQ);
+	mask = 1 << (d->irq - first_sirc_irq);
 	writel(mask, sirc_regs.int_enable_clear);
 	int_enable &= ~mask;
 	return;
@@ -58,7 +75,7 @@ static void sirc_irq_unmask(struct irq_data *d)
 {
 	unsigned int mask;
 
-	mask = 1 << (d->irq - FIRST_SIRC_IRQ);
+	mask = 1 << (d->irq - first_sirc_irq);
 	writel(mask, sirc_regs.int_enable_set);
 	int_enable |= mask;
 	return;
@@ -68,7 +85,7 @@ static void sirc_irq_ack(struct irq_data *d)
 {
 	unsigned int mask;
 
-	mask = 1 << (d->irq - FIRST_SIRC_IRQ);
+	mask = 1 << (d->irq - first_sirc_irq);
 	writel(mask, sirc_regs.int_clear);
 	return;
 }
@@ -78,7 +95,7 @@ static int sirc_irq_set_wake(struct irq_data *d, unsigned int on)
 	unsigned int mask;
 
 	/* Used to set the interrupt enable mask during power collapse. */
-	mask = 1 << (d->irq - FIRST_SIRC_IRQ);
+	mask = 1 << (d->irq - first_sirc_irq);
 	if (on)
 		wake_enable |= mask;
 	else
@@ -92,7 +109,7 @@ static int sirc_irq_set_type(struct irq_data *d, unsigned int flow_type)
 	unsigned int mask;
 	unsigned int val;
 
-	mask = 1 << (d->irq - FIRST_SIRC_IRQ);
+	mask = 1 << (d->irq - first_sirc_irq);
 	val = readl(sirc_regs.int_polarity);
 
 	if (flow_type & (IRQF_TRIGGER_LOW | IRQF_TRIGGER_FALLING))
@@ -128,15 +145,15 @@ static void sirc_irq_handler(unsigned int irq, struct irq_desc *desc)
 		reg++;
 
 	status = readl(sirc_reg_table[reg].int_status);
-	status &= SIRC_MASK;
+	status &= sirc_mask;
 	if (status == 0)
 		return;
 
 	for (sirq = 0;
-	     (sirq < NR_SIRC_IRQS) && ((status & (1U << sirq)) == 0);
+	     (sirq < nr_sirc_irqs) && ((status & (1U << sirq)) == 0);
 	     sirq++)
 		;
-	generic_handle_irq(sirq+FIRST_SIRC_IRQ);
+	generic_handle_irq(sirq+first_sirc_irq);
 
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 }
@@ -150,14 +167,18 @@ static struct irq_chip sirc_irq_chip = {
 	.irq_set_type  = sirc_irq_set_type,
 };
 
-void __init msm_init_sirc(void)
+void __init msm_init_sirc(int first, int count, int cascade)
 {
 	int i;
 
 	int_enable = 0;
 	wake_enable = 0;
+	first_sirc_irq = first;
+	nr_sirc_irqs = count;
+	sirc_mask = (1 << count) - 1;
+	sirc_reg_table[0].cascade_irq = cascade;
 
-	for (i = FIRST_SIRC_IRQ; i < LAST_SIRC_IRQ; i++) {
+	for (i = first; i < first + count; i++) {
 		irq_set_chip_and_handler(i, &sirc_irq_chip, handle_edge_irq);
 		set_irq_flags(i, IRQF_VALID);
 	}
-- 
2.1.0.rc2
