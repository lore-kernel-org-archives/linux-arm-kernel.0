From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 18:34:04 +0200
Subject: [PATCH v2 19/38] ARM: EXYNOS: Decouple ARCH_EXYNOS from PLAT_S5P
In-Reply-To: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371486863-12398-20-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After removing support for ATAGS based boot on Exynos, there is not much
that can be shared between Exynos and other S5P platforms. This patch
makes Exynos a standalone Samsung platform, not using PLAT_S5P.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/Kconfig                | 3 +++
 arch/arm/Makefile               | 1 +
 arch/arm/mach-exynos/Kconfig    | 1 +
 arch/arm/plat-samsung/Kconfig   | 8 +++-----
 arch/arm/plat-samsung/pm-gpio.c | 5 +++--
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9c69e6c..b3560c2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -795,7 +795,9 @@ config ARCH_EXYNOS
 	bool "Samsung EXYNOS"
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SPARSEMEM_ENABLE
+	select ARM_GIC
 	select CLKDEV_LOOKUP
 	select COMMON_CLK
 	select CPU_V7
@@ -807,6 +809,7 @@ config ARCH_EXYNOS
 	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
+	select S5P_GPIO_DRVSTR
 	select SAMSUNG_ATAGS
 	select USE_OF
 	help
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 1ba358b..60133fb 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -197,6 +197,7 @@ machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
+plat-$(CONFIG_ARCH_EXYNOS)	+= samsung
 plat-$(CONFIG_ARCH_OMAP)	+= omap
 plat-$(CONFIG_ARCH_S3C64XX)	+= samsung
 plat-$(CONFIG_PLAT_IOP)		+= iop
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 0d93ebe..65ca3ac 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -14,6 +14,7 @@ menu "SAMSUNG EXYNOS SoCs Support"
 config ARCH_EXYNOS4
 	bool "SAMSUNG EXYNOS4"
 	default y
+	select GIC_NON_BANKED
 	select HAVE_ARM_SCU if SMP
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 7b08b26..ca27cc9 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -6,7 +6,7 @@
 
 config PLAT_SAMSUNG
 	bool
-	depends on PLAT_S3C24XX || ARCH_S3C64XX || PLAT_S5P
+	depends on PLAT_S3C24XX || ARCH_S3C64XX || PLAT_S5P || ARCH_EXYNOS
 	default y
 	select GENERIC_IRQ_CHIP
 	select NO_IOPORT
@@ -15,12 +15,10 @@ config PLAT_SAMSUNG
 
 config PLAT_S5P
 	bool
-	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS)
+	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210)
 	default y
 	select ARCH_REQUIRE_GPIOLIB
-	select ARM_GIC if ARCH_EXYNOS
-	select ARM_VIC if !ARCH_EXYNOS
-	select GIC_NON_BANKED if ARCH_EXYNOS4
+	select ARM_VIC
 	select NO_IOPORT
 	select PLAT_SAMSUNG
 	select S3C_GPIO_TRACK
diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
index c2ff92c..a8de3cf 100644
--- a/arch/arm/plat-samsung/pm-gpio.c
+++ b/arch/arm/plat-samsung/pm-gpio.c
@@ -192,7 +192,8 @@ struct samsung_gpio_pm samsung_gpio_pm_2bit = {
 	.resume = samsung_gpio_pm_2bit_resume,
 };
 
-#if defined(CONFIG_ARCH_S3C64XX) || defined(CONFIG_PLAT_S5P)
+#if defined(CONFIG_ARCH_S3C64XX) || defined(CONFIG_PLAT_S5P) \
+	|| defined(CONFIG_ARCH_EXYNOS)
 static void samsung_gpio_pm_4bit_save(struct samsung_gpio_chip *chip)
 {
 	chip->pm_save[1] = __raw_readl(chip->base + OFFS_CON);
@@ -302,7 +303,7 @@ struct samsung_gpio_pm samsung_gpio_pm_4bit = {
 	.save	= samsung_gpio_pm_4bit_save,
 	.resume = samsung_gpio_pm_4bit_resume,
 };
-#endif /* CONFIG_ARCH_S3C64XX || CONFIG_PLAT_S5P */
+#endif /* CONFIG_ARCH_S3C64XX || CONFIG_PLAT_S5P || CONFIG_ARCH_EXYNOS */
 
 /**
  * samsung_pm_save_gpio() - save gpio chip data for suspend
-- 
1.8.2.1
