From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:33:03 +0100
Subject: [RFC PATCH 09/18] ARM: msm: fix vic irqchip for multiplatform
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vic code is common between msm7x30 and qsd8x50, but has
minor differences in the number of registers and the mapping
between interrupt numbers and smsm numbers.

This moves the differences out to the soc-specific files so the
vic implementation can be shared.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-msm/board-msm7x30.c |  55 +++++++++++++++++-
 arch/arm/mach-msm/board-qsd8x50.c |  59 ++++++++++++++++++-
 arch/arm/mach-msm/common.h        |   1 +
 arch/arm/mach-msm/irq-vic.c       | 117 +++++---------------------------------
 4 files changed, 125 insertions(+), 107 deletions(-)

diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index a964e3e3724d..4718a661306e 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -31,6 +31,7 @@
 #include <asm/setup.h>
 
 #include <mach/clk.h>
+#include <mach/irqs-7x30.h>
 #include <mach/msm_iomap-7x30.h>
 
 #include <mach/vreg.h>
@@ -132,9 +133,61 @@ static struct platform_device *devices[] __initdata = {
 	&msm_device_hsusb_host,
 };
 
+#define SMSM_FAKE_IRQ (0xff)
+static uint8_t msm_irq_to_smsm[NR_IRQS] = {
+	[INT_MDDI_EXT] = 1,
+	[INT_MDDI_PRI] = 2,
+	[INT_MDDI_CLIENT] = 3,
+	[INT_USB_OTG] = 4,
+
+	[INT_PWB_I2C] = 5,
+	[INT_SDC1_0] = 6,
+	[INT_SDC1_1] = 7,
+	[INT_SDC2_0] = 8,
+
+	[INT_SDC2_1] = 9,
+	[INT_ADSP_A9_A11] = 10,
+	[INT_UART1] = 11,
+	[INT_UART2] = 12,
+
+	[INT_UART3] = 13,
+	[INT_UART1_RX] = 14,
+	[INT_UART2_RX] = 15,
+	[INT_UART3_RX] = 16,
+
+	[INT_UART1DM_IRQ] = 17,
+	[INT_UART1DM_RX] = 18,
+	[INT_KEYSENSE] = 19,
+
+	[INT_NAND_WR_ER_DONE] = 21,
+	[INT_NAND_OP_DONE] = 22,
+	[INT_TCHSCRN1] = 23,
+	[INT_TCHSCRN2] = 24,
+
+	[INT_TCHSCRN_SSBI] = 25,
+	[INT_USB_HS] = 26,
+	[INT_UART2DM_RX] = 27,
+	[INT_UART2DM_IRQ] = 28,
+
+	[INT_SDC4_1] = 29,
+	[INT_SDC4_0] = 30,
+	[INT_SDC3_1] = 31,
+	[INT_SDC3_0] = 32,
+
+	/* fake wakeup interrupts */
+	[INT_GPIO_GROUP1] = SMSM_FAKE_IRQ,
+	[INT_GPIO_GROUP2] = SMSM_FAKE_IRQ,
+	[INT_A9_M2A_0] = SMSM_FAKE_IRQ,
+	[INT_A9_M2A_1] = SMSM_FAKE_IRQ,
+	[INT_A9_M2A_5] = SMSM_FAKE_IRQ,
+	[INT_GP_TIMER_EXP] = SMSM_FAKE_IRQ,
+	[INT_DEBUG_TIMER_EXP] = SMSM_FAKE_IRQ,
+	[INT_ADSP_A11] = SMSM_FAKE_IRQ,
+};
+
 static void __init msm7x30_init_irq(void)
 {
-	msm_init_irq();
+	msm_init_vic(msm_irq_to_smsm, 4);
 }
 
 static void __init msm7x30_init(void)
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 259ea05c41b9..ff458806785b 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -221,9 +221,64 @@ static void __init qsd8x50_init_mmc(void)
 	msm_add_sdcc(1, &qsd8x50_sdc1_data, 0, 0);
 }
 
+#define SMSM_FAKE_IRQ (0xff)
+static uint8_t msm_irq_to_smsm[NR_IRQS] = {
+	[INT_MDDI_EXT] = 1,
+	[INT_MDDI_PRI] = 2,
+	[INT_MDDI_CLIENT] = 3,
+	[INT_USB_OTG] = 4,
+
+	[INT_PWB_I2C] = 5,
+	[INT_SDC1_0] = 6,
+	[INT_SDC1_1] = 7,
+	[INT_SDC2_0] = 8,
+
+	[INT_SDC2_1] = 9,
+	[INT_ADSP_A9_A11] = 10,
+	[INT_UART1] = 11,
+	[INT_UART2] = 12,
+
+	[INT_UART3] = 13,
+	[INT_UART1_RX] = 14,
+	[INT_UART2_RX] = 15,
+	[INT_UART3_RX] = 16,
+
+	[INT_UART1DM_IRQ] = 17,
+	[INT_UART1DM_RX] = 18,
+	[INT_KEYSENSE] = 19,
+	[INT_AD_HSSD] = 20,
+
+	[INT_NAND_WR_ER_DONE] = 21,
+	[INT_NAND_OP_DONE] = 22,
+	[INT_TCHSCRN1] = 23,
+	[INT_TCHSCRN2] = 24,
+
+	[INT_TCHSCRN_SSBI] = 25,
+	[INT_USB_HS] = 26,
+	[INT_UART2DM_RX] = 27,
+	[INT_UART2DM_IRQ] = 28,
+
+	[INT_SDC4_1] = 29,
+	[INT_SDC4_0] = 30,
+	[INT_SDC3_1] = 31,
+	[INT_SDC3_0] = 32,
+
+	/* fake wakeup interrupts */
+	[INT_GPIO_GROUP1] = SMSM_FAKE_IRQ,
+	[INT_GPIO_GROUP2] = SMSM_FAKE_IRQ,
+	[INT_A9_M2A_0] = SMSM_FAKE_IRQ,
+	[INT_A9_M2A_1] = SMSM_FAKE_IRQ,
+	[INT_A9_M2A_5] = SMSM_FAKE_IRQ,
+	[INT_GP_TIMER_EXP] = SMSM_FAKE_IRQ,
+	[INT_DEBUG_TIMER_EXP] = SMSM_FAKE_IRQ,
+	[INT_ADSP_A11] = SMSM_FAKE_IRQ,
+	[INT_SIRC_0] = SMSM_FAKE_IRQ,
+	[INT_SIRC_1] = SMSM_FAKE_IRQ,
+};
+
 static void __init qsd8x50_init_irq(void)
 {
-	msm_init_irq();
+	msm_init_vic(msm_irq_to_smsm, 2);
 	msm_init_sirc(FIRST_SIRC_IRQ, NR_SIRC_IRQS_REV_OTHER, INT_SIRC_0);
 }
 
@@ -255,7 +310,7 @@ MACHINE_END
 #ifdef CONFIG_MSM_SOC_REV_A
 static void __init qsd8x50_init_irq_rev_a(void)
 {
-	msm_init_irq();
+	msm_init_vic(msm_irq_to_smsm, 2);
 	msm_init_sirc(FIRST_SIRC_IRQ, NR_SIRC_IRQS_REV_A, INT_SIRC_0);
 }
 
diff --git a/arch/arm/mach-msm/common.h b/arch/arm/mach-msm/common.h
index 8267f6402325..7e4ddfdf4fe8 100644
--- a/arch/arm/mach-msm/common.h
+++ b/arch/arm/mach-msm/common.h
@@ -28,6 +28,7 @@ struct msm_mmc_platform_data;
 
 extern void msm_add_devices(void);
 extern void msm_init_irq(void);
+extern void msm_init_vic(uint8_t *irq_to_smsm, int nr);
 extern void msm_init_gpio(void);
 extern int msm_add_sdcc(unsigned int controller,
 			struct msm_mmc_platform_data *plat,
diff --git a/arch/arm/mach-msm/irq-vic.c b/arch/arm/mach-msm/irq-vic.c
index 1b54f807c2d0..33a52f570dae 100644
--- a/arch/arm/mach-msm/irq-vic.c
+++ b/arch/arm/mach-msm/irq-vic.c
@@ -71,15 +71,9 @@ module_param_named(debug_mask, msm_irq_debug_mask, int,
 #define VIC_INT_POLARITY3   VIC_REG(0x005C)  /* 1: NEG, 0: POS */
 #define VIC_NO_PEND_VAL     VIC_REG(0x0060)
 
-#if defined(CONFIG_ARCH_MSM_SCORPION)
 #define VIC_NO_PEND_VAL_FIQ VIC_REG(0x0064)
 #define VIC_INT_MASTEREN    VIC_REG(0x0068)  /* 1: IRQ, 2: FIQ     */
 #define VIC_CONFIG          VIC_REG(0x006C)  /* 1: USE SC VIC */
-#else
-#define VIC_INT_MASTEREN    VIC_REG(0x0064)  /* 1: IRQ, 2: FIQ     */
-#define VIC_PROTECTION      VIC_REG(0x006C)  /* 1: ENABLE          */
-#define VIC_CONFIG          VIC_REG(0x0068)  /* 1: USE ARM1136 VIC */
-#endif
 
 #define VIC_IRQ_STATUS0     VIC_REG(0x0080)
 #define VIC_IRQ_STATUS1     VIC_REG(0x0084)
@@ -105,7 +99,6 @@ module_param_named(debug_mask, msm_irq_debug_mask, int,
 #define VIC_IRQ_VEC_PEND_RD VIC_REG(0x00D4)  /* pending vector addr */
 #define VIC_IRQ_VEC_WR      VIC_REG(0x00D8)
 
-#if defined(CONFIG_ARCH_MSM_SCORPION)
 #define VIC_FIQ_VEC_RD      VIC_REG(0x00DC)
 #define VIC_FIQ_VEC_PEND_RD VIC_REG(0x00E0)
 #define VIC_FIQ_VEC_WR      VIC_REG(0x00E4)
@@ -115,40 +108,11 @@ module_param_named(debug_mask, msm_irq_debug_mask, int,
 #define VIC_FIQ_IN_STACK    VIC_REG(0x00F4)
 #define VIC_TEST_BUS_SEL    VIC_REG(0x00F8)
 #define VIC_IRQ_CTRL_CONFIG VIC_REG(0x00FC)
-#else
-#define VIC_IRQ_IN_SERVICE  VIC_REG(0x00E0)
-#define VIC_IRQ_IN_STACK    VIC_REG(0x00E4)
-#define VIC_TEST_BUS_SEL    VIC_REG(0x00E8)
-#endif
 
 #define VIC_VECTPRIORITY(n) VIC_REG(0x0200+((n) * 4))
 #define VIC_VECTADDR(n)     VIC_REG(0x0400+((n) * 4))
 
-#if defined(CONFIG_ARCH_MSM7X30)
-#define VIC_NUM_REGS	    4
-#else
-#define VIC_NUM_REGS	    2
-#endif
-
-#if VIC_NUM_REGS == 2
-#define DPRINT_REGS(base_reg, format, ...)	      			\
-	printk(KERN_INFO format " %x %x\n", ##__VA_ARGS__,		\
-			readl(base_reg ## 0), readl(base_reg ## 1))
-#define DPRINT_ARRAY(array, format, ...)				\
-	printk(KERN_INFO format " %x %x\n", ##__VA_ARGS__,		\
-			array[0], array[1])
-#elif VIC_NUM_REGS == 4
-#define DPRINT_REGS(base_reg, format, ...) \
-	printk(KERN_INFO format " %x %x %x %x\n", ##__VA_ARGS__,	\
-			readl(base_reg ## 0), readl(base_reg ## 1),	\
-			readl(base_reg ## 2), readl(base_reg ## 3))
-#define DPRINT_ARRAY(array, format, ...)				\
-	printk(KERN_INFO format " %x %x %x %x\n", ##__VA_ARGS__,	\
-			array[0], array[1],				\
-			array[2], array[3])
-#else
-#error "VIC_NUM_REGS set to illegal value"
-#endif
+#define VIC_MAX_REGS	    4
 
 static uint32_t msm_irq_smsm_wake_enable[2];
 static struct {
@@ -156,73 +120,17 @@ static struct {
 	uint32_t int_type;
 	uint32_t int_polarity;
 	uint32_t int_select;
-} msm_irq_shadow_reg[VIC_NUM_REGS];
-static uint32_t msm_irq_idle_disable[VIC_NUM_REGS];
+} msm_irq_shadow_reg[VIC_MAX_REGS];
+static uint32_t msm_irq_idle_disable[VIC_MAX_REGS];
 
 #define SMSM_FAKE_IRQ (0xff)
-static uint8_t msm_irq_to_smsm[NR_IRQS] = {
-	[INT_MDDI_EXT] = 1,
-	[INT_MDDI_PRI] = 2,
-	[INT_MDDI_CLIENT] = 3,
-	[INT_USB_OTG] = 4,
-
-	[INT_PWB_I2C] = 5,
-	[INT_SDC1_0] = 6,
-	[INT_SDC1_1] = 7,
-	[INT_SDC2_0] = 8,
-
-	[INT_SDC2_1] = 9,
-	[INT_ADSP_A9_A11] = 10,
-	[INT_UART1] = 11,
-	[INT_UART2] = 12,
-
-	[INT_UART3] = 13,
-	[INT_UART1_RX] = 14,
-	[INT_UART2_RX] = 15,
-	[INT_UART3_RX] = 16,
-
-	[INT_UART1DM_IRQ] = 17,
-	[INT_UART1DM_RX] = 18,
-	[INT_KEYSENSE] = 19,
-#if !defined(CONFIG_ARCH_MSM7X30)
-	[INT_AD_HSSD] = 20,
-#endif
-
-	[INT_NAND_WR_ER_DONE] = 21,
-	[INT_NAND_OP_DONE] = 22,
-	[INT_TCHSCRN1] = 23,
-	[INT_TCHSCRN2] = 24,
-
-	[INT_TCHSCRN_SSBI] = 25,
-	[INT_USB_HS] = 26,
-	[INT_UART2DM_RX] = 27,
-	[INT_UART2DM_IRQ] = 28,
-
-	[INT_SDC4_1] = 29,
-	[INT_SDC4_0] = 30,
-	[INT_SDC3_1] = 31,
-	[INT_SDC3_0] = 32,
-
-	/* fake wakeup interrupts */
-	[INT_GPIO_GROUP1] = SMSM_FAKE_IRQ,
-	[INT_GPIO_GROUP2] = SMSM_FAKE_IRQ,
-	[INT_A9_M2A_0] = SMSM_FAKE_IRQ,
-	[INT_A9_M2A_1] = SMSM_FAKE_IRQ,
-	[INT_A9_M2A_5] = SMSM_FAKE_IRQ,
-	[INT_GP_TIMER_EXP] = SMSM_FAKE_IRQ,
-	[INT_DEBUG_TIMER_EXP] = SMSM_FAKE_IRQ,
-	[INT_ADSP_A11] = SMSM_FAKE_IRQ,
-#ifdef CONFIG_ARCH_QSD8X50
-	[INT_SIRC_0] = SMSM_FAKE_IRQ,
-	[INT_SIRC_1] = SMSM_FAKE_IRQ,
-#endif
-};
+static uint8_t *msm_irq_to_smsm;
 
-static inline void msm_irq_write_all_regs(void __iomem *base, unsigned int val)
+static inline void msm_irq_write_all_regs(void __iomem *base, unsigned int val, int num)
 {
 	int i;
 
-	for (i = 0; i < VIC_NUM_REGS; i++)
+	for (i = 0; i < num; i++)
 		writel(val, base + (i * 4));
 }
 
@@ -334,21 +242,22 @@ static struct irq_chip msm_irq_chip = {
 	.irq_set_type  = msm_irq_set_type,
 };
 
-void __init msm_init_irq(void)
+void __init msm_init_vic(uint8_t *irq_to_smsm, int nr)
 {
 	unsigned n;
+	msm_irq_to_smsm = irq_to_smsm;
 
 	/* select level interrupts */
-	msm_irq_write_all_regs(VIC_INT_TYPE0, 0);
+	msm_irq_write_all_regs(VIC_INT_TYPE0, 0, nr / 32);
 
 	/* select highlevel interrupts */
-	msm_irq_write_all_regs(VIC_INT_POLARITY0, 0);
+	msm_irq_write_all_regs(VIC_INT_POLARITY0, 0, nr / 32);
 
 	/* select IRQ for all INTs */
-	msm_irq_write_all_regs(VIC_INT_SELECT0, 0);
+	msm_irq_write_all_regs(VIC_INT_SELECT0, 0, nr / 32);
 
 	/* disable all INTs */
-	msm_irq_write_all_regs(VIC_INT_EN0, 0);
+	msm_irq_write_all_regs(VIC_INT_EN0, 0, nr / 32);
 
 	/* don't use vic */
 	writel(0, VIC_CONFIG);
@@ -356,7 +265,7 @@ void __init msm_init_irq(void)
 	/* enable interrupt controller */
 	writel(3, VIC_INT_MASTEREN);
 
-	for (n = 0; n < NR_MSM_IRQS; n++) {
+	for (n = 0; n < nr; n++) {
 		irq_set_chip_and_handler(n, &msm_irq_chip, handle_level_irq);
 		set_irq_flags(n, IRQF_VALID);
 	}
-- 
2.1.0.rc2
