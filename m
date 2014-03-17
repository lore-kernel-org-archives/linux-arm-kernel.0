From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 17 Mar 2014 18:39:55 +0530
Subject: [PATCH v2 3/3] arm: exynos5260: add support for S2R
In-Reply-To: <1395061795-17777-1-git-send-email-vikas.sajjan@samsung.com>
References: <1395061795-17777-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1395061795-17777-4-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds Suspend to RAM (S2R) support to exynos5260.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/mach-exynos/pm.c       |   62 +++++++++++++++++++++++++++++++--------
 arch/arm/mach-exynos/regs-pmu.h |   12 ++++++++
 2 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index dbe9670..12cc241 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -77,12 +77,20 @@ static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
 	{ /* sentinel */ },
 };
 
+static const struct exynos_wkup_irq exynos5260_wkup_irq[] = {
+	{ 105, BIT(1) }, /* RTC alarm */
+	{ 106, BIT(2) }, /* RTC tick */
+	{ /* sentinel */ },
+};
+
 static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 {
 	const struct exynos_wkup_irq *wkup_irq;
 
 	if (soc_is_exynos5250())
 		wkup_irq = exynos5250_wkup_irq;
+	else if (soc_is_exynos5260())
+		wkup_irq = exynos5260_wkup_irq;
 	else
 		wkup_irq = exynos4_wkup_irq;
 
@@ -124,10 +132,20 @@ static void exynos_pm_prepare(void)
 	unsigned int tmp;
 
 	/* Set wake-up mask registers */
-	__raw_writel(exynos_get_eint_wake_mask(), S5P_EINT_WAKEUP_MASK);
-	__raw_writel(exynos_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
+	if (soc_is_exynos5260()) {
+		__raw_writel(exynos_get_eint_wake_mask(),
+					EXYNOS5260_EINT_WAKEUP_MASK);
+		__raw_writel(exynos_irqwake_intmask & ~(1 << 31),
+					EXYNOS5260_WAKEUP_MASK);
+	} else {
+		__raw_writel(exynos_get_eint_wake_mask(),
+					S5P_EINT_WAKEUP_MASK);
+		__raw_writel(exynos_irqwake_intmask & ~(1 << 31),
+					S5P_WAKEUP_MASK);
+	}
 
-	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
+	if (!soc_is_exynos5260())
+		s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
 	if (soc_is_exynos5250()) {
 		s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
@@ -221,21 +239,39 @@ static void exynos_pm_resume(void)
 			      : "cc");
 	}
 
-	/* For release retention */
-
-	__raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
-	__raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
-	__raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
-	__raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
-	__raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
-	__raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
-	__raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
+	if (soc_is_exynos5250()) {
+		/* For release retention */
+
+		__raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
+		__raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
+		__raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
+		__raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
+		__raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
+		__raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
+		__raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
+	} else if (soc_is_exynos5260()) {
+		/* For release retention */
+		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_LPDDR3_OPTION);
+		__raw_writel((1 << 28), EXYNOS5260_PAD_RET_MAUDIO_OPTION);
+		__raw_writel((1 << 28), EXYNOS5260_PAD_RET_JTAG_OPTION);
+		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_MMC2_OPTION);
+		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_TOP_OPTION);
+		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_UART_OPTION);
+		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_MMC0_OPTION);
+		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_MMC1_OPTION);
+		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_SPI_OPTION);
+		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_MIF_OPTION);
+		__raw_writel((1 << 28),
+				EXYNOS5260_PAD_RETENTION_BOOTLDO_OPTION);
+	}
 
 	if (soc_is_exynos5250())
 		s3c_pm_do_restore(exynos5_sys_save,
 			ARRAY_SIZE(exynos5_sys_save));
 
-	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
+	if (!soc_is_exynos5260())
+		s3c_pm_do_restore_core(exynos_core_save,
+				ARRAY_SIZE(exynos_core_save));
 
 	if (IS_ENABLED(CONFIG_SMP) && !soc_is_exynos5250())
 		scu_enable(S5P_VA_SCU);
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index a81926b..906dc1e 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -532,6 +532,18 @@
 #define EXYNOS5260_EAGLE_L2_STATUS			S5P_PMUREG(0x2604)
 #define EXYNOS5260_KFC_L2_STATUS			S5P_PMUREG(0x2624)
 
+#define EXYNOS5260_PAD_RETENTION_LPDDR3_OPTION	S5P_PMUREG(0x3008)
+#define EXYNOS5260_PAD_RET_MAUDIO_OPTION	S5P_PMUREG(0x3028)
+#define EXYNOS5260_PAD_RET_JTAG_OPTION		S5P_PMUREG(0x3048)
+#define EXYNOS5260_PAD_RETENTION_MMC2_OPTION	S5P_PMUREG(0x30C8)
+#define EXYNOS5260_PAD_RETENTION_TOP_OPTION	S5P_PMUREG(0x3108)
+#define EXYNOS5260_PAD_RETENTION_UART_OPTION	S5P_PMUREG(0x3128)
+#define EXYNOS5260_PAD_RETENTION_MMC0_OPTION	S5P_PMUREG(0x3148)
+#define EXYNOS5260_PAD_RETENTION_MMC1_OPTION	S5P_PMUREG(0x3168)
+#define EXYNOS5260_PAD_RETENTION_SPI_OPTION	S5P_PMUREG(0x31C8)
+#define EXYNOS5260_PAD_RETENTION_MIF_OPTION	S5P_PMUREG(0x31E8)
+#define EXYNOS5260_PAD_RETENTION_BOOTLDO_OPTION	S5P_PMUREG(0x3248)
+
 /* CENTRAL_SEQ_OPTION */
 #define EXYNOS5260_ARM_USE_STANDBY_WFI0			(1 << 16)
 #define EXYNOS5260_ARM_USE_STANDBY_WFI1			(1 << 17)
-- 
1.7.9.5
