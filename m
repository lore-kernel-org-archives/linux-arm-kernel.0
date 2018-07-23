From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 23 Jul 2018 19:52:57 +0200
Subject: [RFT v2 05/10] ARM: exynos: Define EINT_WAKEUP_MASK registers for
 S5Pv210 and Exynos5433
In-Reply-To: <20180723175302.22535-1-krzk@kernel.org>
References: <20180723175302.22535-1-krzk@kernel.org>
Message-ID: <20180723175302.22535-6-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5Pv210 and Exynos5433/Exynos7 have different address of
EINT_WAKEUP_MASK register.  Rename existing S5P_EINT_WAKEUP_MASK to
avoid confusion and add new ones.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-exynos/suspend.c              | 2 +-
 include/linux/soc/samsung/exynos-regs-pmu.h | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 0ec52f442b97..991938e19e17 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -272,7 +272,7 @@ static int exynos5420_cpu_suspend(unsigned long arg)
 static void exynos_pm_set_wakeup_mask(void)
 {
 	/* Set wake-up mask registers */
-	pmu_raw_writel(exynos_get_eint_wake_mask(), S5P_EINT_WAKEUP_MASK);
+	pmu_raw_writel(exynos_get_eint_wake_mask(), EXYNOS_EINT_WAKEUP_MASK);
 	pmu_raw_writel(exynos_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
 }
 
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index 66dcb9ec273a..eb0d240df7a7 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -42,7 +42,7 @@
 #define EXYNOS_SWRESET				0x0400
 
 #define S5P_WAKEUP_STAT				0x0600
-#define S5P_EINT_WAKEUP_MASK			0x0604
+#define EXYNOS_EINT_WAKEUP_MASK			0x0604
 #define S5P_WAKEUP_MASK				0x0608
 #define S5P_WAKEUP_MASK2				0x0614
 
@@ -180,6 +180,9 @@
 #define S5P_CORE_WAKEUP_FROM_LOCAL_CFG		(0x3 << 8)
 #define S5P_CORE_AUTOWAKEUP_EN			(1 << 31)
 
+/* Only for S5Pv210 */
+#define S5PV210_EINT_WAKEUP_MASK	0xC004
+
 /* Only for EXYNOS4210 */
 #define S5P_CMU_CLKSTOP_LCD1_LOWPWR	0x1154
 #define S5P_CMU_RESET_LCD1_LOWPWR	0x1174
@@ -641,6 +644,7 @@
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI3)
 
 /* For EXYNOS5433 */
+#define EXYNOS5433_EINT_WAKEUP_MASK				(0x060C)
 #define EXYNOS5433_USBHOST30_PHY_CONTROL			(0x0728)
 #define EXYNOS5433_PAD_RETENTION_AUD_OPTION			(0x3028)
 #define EXYNOS5433_PAD_RETENTION_MMC2_OPTION			(0x30C8)
-- 
2.14.1
