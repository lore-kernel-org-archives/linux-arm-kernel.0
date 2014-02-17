From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 17 Feb 2014 21:08:53 +0100
Subject: [PATCH v5 5/7] ARM: S3C24XX: prevent conflicts between ccf and
 non-ccf s3c24xx-socs
In-Reply-To: <2678040.KALsQ0bZFm@phil>
References: <2678040.KALsQ0bZFm@phil>
Message-ID: <7452395.HGklL2HQyK@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the conversion to the common-clock-framework is done in multiple
steps, it is necessary to prevent conflicts between the different
struct clk implementations.

For this include the s3c24xx_setup_clocks function only when
SAMSUNG_CLOCK is selected and make the socs we don't convert this
time explicitly depend on SAMSUNG_CLOCK, which gets only selected
automatically if COMMON_CLK is not enabled.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-s3c24xx/Kconfig  | 4 ++++
 arch/arm/mach-s3c24xx/common.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 4cbecaf..2ac7d1f 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -25,6 +25,7 @@ comment "S3C24XX SoCs"
 config CPU_S3C2410
 	bool "SAMSUNG S3C2410"
 	default y
+	depends on SAMSUNG_CLOCK
 	select CPU_ARM920T
 	select CPU_LLSERIAL_S3C2410
 	select S3C2410_CLOCK
@@ -38,6 +39,7 @@ config CPU_S3C2410
 
 config CPU_S3C2412
 	bool "SAMSUNG S3C2412"
+	depends on SAMSUNG_CLOCK
 	select CPU_ARM926T
 	select CPU_LLSERIAL_S3C2440
 	select S3C2412_DMA if S3C24XX_DMA
@@ -58,6 +60,7 @@ config CPU_S3C2416
 
 config CPU_S3C2440
 	bool "SAMSUNG S3C2440"
+	depends on SAMSUNG_CLOCK
 	select CPU_ARM920T
 	select CPU_LLSERIAL_S3C2440
 	select S3C2410_CLOCK
@@ -68,6 +71,7 @@ config CPU_S3C2440
 
 config CPU_S3C2442
 	bool "SAMSUNG S3C2442"
+	depends on SAMSUNG_CLOCK
 	select CPU_ARM920T
 	select CPU_LLSERIAL_S3C2440
 	select S3C2410_CLOCK
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 4adaa4b..46af4e5 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -319,6 +319,7 @@ struct s3c24xx_uart_resources s3c2410_uart_resources[] __initdata = {
 
 /* initialise all the clocks */
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 void __init_or_cpufreq s3c24xx_setup_clocks(unsigned long fclk,
 					   unsigned long hclk,
 					   unsigned long pclk)
@@ -331,6 +332,7 @@ void __init_or_cpufreq s3c24xx_setup_clocks(unsigned long fclk,
 	clk_p.rate = pclk;
 	clk_f.rate = fclk;
 }
+#endif
 
 #if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
 	defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2442)
-- 
1.8.5.3
