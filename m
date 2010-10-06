From: jeongbae.seo@samsung.com (Jeongbae Seo)
Date: Wed,  6 Oct 2010 15:00:46 +0900
Subject: [PATCH V2 3/3] ARM: S5PV310: Add support HSMMC on SMDKV310 and
	SMDKC210
In-Reply-To: <1286344846-21244-1-git-send-email-jeongbae.seo@samsung.com>
References: <1286344846-21244-1-git-send-email-jeongbae.seo@samsung.com>
Message-ID: <1286344846-21244-4-git-send-email-jeongbae.seo@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hyuk Lee <hyuk1.lee@samsung.com>

This patch adds support HSMMC for S5PV310(SMDKV310) and
S5PC210(SMDKC210).

Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
---
Changes since v1:
- Separated to board specific and common changes
  (This is for board specific part)

 arch/arm/mach-s5pv310/mach-smdkc210.c |   45 +++++++++++++++++++++++++++++++++
 arch/arm/mach-s5pv310/mach-smdkv310.c |   45 +++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-s5pv310/mach-smdkc210.c
index 1384d8b..a28daa4 100644
--- a/arch/arm/mach-s5pv310/mach-smdkc210.c
+++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
@@ -9,6 +9,9 @@
 */
 
 #include <linux/serial_core.h>
+#include <linux/gpio.h>
+#include <linux/mmc/host.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -18,6 +21,7 @@
 #include <plat/s5pv310.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/sdhci.h>
 
 #include <mach/map.h>
 
@@ -66,7 +70,43 @@ static struct s3c2410_uartcfg smdkc210_uartcfgs[] __initdata = {
 	},
 };
 
+static struct s3c_sdhci_platdata smdkc210_hsmmc0_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK0(2),
+	.ext_cd_gpio_invert	= 1,
+#ifdef CONFIG_S5PV310_SDHCI_CH0_8BIT
+	.max_width		= 8,
+	.host_caps		= MMC_CAP_8_BIT_DATA,
+#endif
+};
+
+static struct s3c_sdhci_platdata smdkc210_hsmmc1_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK0(2),
+	.ext_cd_gpio_invert	= 1,
+};
+
+static struct s3c_sdhci_platdata smdkc210_hsmmc2_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK2(2),
+	.ext_cd_gpio_invert	= 1,
+#ifdef CONFIG_S5PV310_SDHCI_CH2_8BIT
+	.max_width		= 8,
+	.host_caps		= MMC_CAP_8_BIT_DATA,
+#endif
+};
+
+static struct s3c_sdhci_platdata smdkc210_hsmmc3_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK2(2),
+	.ext_cd_gpio_invert	= 1,
+};
+
 static struct platform_device *smdkc210_devices[] __initdata = {
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
+	&s3c_device_hsmmc3,
 	&s3c_device_rtc,
 	&s3c_device_wdt,
 };
@@ -80,6 +120,11 @@ static void __init smdkc210_map_io(void)
 
 static void __init smdkc210_machine_init(void)
 {
+	s3c_sdhci0_set_platdata(&smdkc210_hsmmc0_pdata);
+	s3c_sdhci1_set_platdata(&smdkc210_hsmmc1_pdata);
+	s3c_sdhci2_set_platdata(&smdkc210_hsmmc2_pdata);
+	s3c_sdhci3_set_platdata(&smdkc210_hsmmc3_pdata);
+
 #ifdef CONFIG_CACHE_L2X0
 	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
 #endif
diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
index 9cb827d..6eff6ce 100644
--- a/arch/arm/mach-s5pv310/mach-smdkv310.c
+++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
@@ -9,6 +9,9 @@
 */
 
 #include <linux/serial_core.h>
+#include <linux/gpio.h>
+#include <linux/mmc/host.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -18,6 +21,7 @@
 #include <plat/s5pv310.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/sdhci.h>
 
 #include <mach/map.h>
 
@@ -66,7 +70,43 @@ static struct s3c2410_uartcfg smdkv310_uartcfgs[] __initdata = {
 	},
 };
 
+static struct s3c_sdhci_platdata smdkv310_hsmmc0_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK0(2),
+	.ext_cd_gpio_invert	= 1,
+#ifdef CONFIG_S5PV310_SDHCI_CH0_8BIT
+	.max_width		= 8,
+	.host_caps		= MMC_CAP_8_BIT_DATA,
+#endif
+};
+
+static struct s3c_sdhci_platdata smdkv310_hsmmc1_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK0(2),
+	.ext_cd_gpio_invert	= 1,
+};
+
+static struct s3c_sdhci_platdata smdkv310_hsmmc2_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK2(2),
+	.ext_cd_gpio_invert	= 1,
+#ifdef CONFIG_S5PV310_SDHCI_CH2_8BIT
+	.max_width		= 8,
+	.host_caps		= MMC_CAP_8_BIT_DATA,
+#endif
+};
+
+static struct s3c_sdhci_platdata smdkv310_hsmmc3_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK2(2),
+	.ext_cd_gpio_invert	= 1,
+};
+
 static struct platform_device *smdkv310_devices[] __initdata = {
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
+	&s3c_device_hsmmc3,
 	&s3c_device_rtc,
 	&s3c_device_wdt,
 };
@@ -80,6 +120,11 @@ static void __init smdkv310_map_io(void)
 
 static void __init smdkv310_machine_init(void)
 {
+	s3c_sdhci0_set_platdata(&smdkv310_hsmmc0_pdata);
+	s3c_sdhci1_set_platdata(&smdkv310_hsmmc1_pdata);
+	s3c_sdhci2_set_platdata(&smdkv310_hsmmc2_pdata);
+	s3c_sdhci3_set_platdata(&smdkv310_hsmmc3_pdata);
+
 #ifdef CONFIG_CACHE_L2X0
 	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
 #endif
-- 
1.6.2.5
