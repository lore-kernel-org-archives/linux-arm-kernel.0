From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 06 Dec 2011 15:32:18 +0900
Subject: [PATCH v2 2/3] ARM: EXYNOS: Add USB OHCI support to SMDKV310 board
In-Reply-To: <001101ccb3e0$7fe48270$7fad8750$%han@samsung.com>
References: <001101ccb3e0$7fe48270$7fad8750$%han@samsung.com>
Message-ID: <001401ccb3e0$cd91ea80$68b5bf80$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds USB OHCI support to SMDKV310 board.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/mach-exynos/Kconfig         |    1 +
 arch/arm/mach-exynos/mach-smdkv310.c |   13 +++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index dec3ee3..bd1bb9f 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -190,6 +190,7 @@ config MACH_SMDKV310
 	select EXYNOS4_DEV_DMA
 	select EXYNOS4_DEV_PD
 	select SAMSUNG_DEV_PWM
+	select EXYNOS4_DEV_USB_OHCI
 	select EXYNOS4_DEV_SYSMMU
 	select EXYNOS4_SETUP_FIMD0
 	select EXYNOS4_SETUP_I2C1
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index cec2afa..25a5a40 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -42,6 +42,7 @@
 #include <plat/clock.h>
 
 #include <mach/map.h>
+#include <mach/ohci.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV310_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -245,6 +246,16 @@ static void __init smdkv310_ehci_init(void)
 	s5p_ehci_set_platdata(pdata);
 }
 
+/* USB OHCI */
+static struct exynos4_ohci_platdata smdkv310_ohci_pdata;
+
+static void __init smdkv310_ohci_init(void)
+{
+	struct exynos4_ohci_platdata *pdata = &smdkv310_ohci_pdata;
+
+	exynos4_ohci_set_platdata(pdata);
+}
+
 static struct platform_device *smdkv310_devices[] __initdata = {
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
@@ -261,6 +272,7 @@ static struct platform_device *smdkv310_devices[] __initdata = {
 	&s5p_device_fimc3,
 	&exynos4_device_ac97,
 	&exynos4_device_i2s0,
+	&exynos4_device_ohci,
 	&samsung_device_keypad,
 	&s5p_device_mfc,
 	&s5p_device_mfc_l,
@@ -363,6 +375,7 @@ static void __init smdkv310_machine_init(void)
 	s5p_fimd0_set_platdata(&smdkv310_lcd0_pdata);
 
 	smdkv310_ehci_init();
+	smdkv310_ohci_init();
 	clk_xusbxti.rate = 24000000;
 
 	platform_add_devices(smdkv310_devices, ARRAY_SIZE(smdkv310_devices));
-- 
1.7.1
