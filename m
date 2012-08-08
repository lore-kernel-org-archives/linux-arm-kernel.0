From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 08 Aug 2012 22:10:20 +0900
Subject: [PATCH 4/6] ARM: s3c24xx: use new PWM driver
In-Reply-To: <1344430493-5304-5-git-send-email-arnd@arndb.de>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
 <1344430493-5304-5-git-send-email-arnd@arndb.de>
Message-ID: <0b6801cd7567$29be48b0$7d3ada10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> The samsung PWM driver has moved to the new PWM subsystem, which
> changed the Kconfig symbol for that driver, but the rx1950 and
> gta02 boards still uses the old one.
> 
> Without this patch, building s3c2410_defconfig results in:
> 
> arch/arm/mach-s3c24xx/built-in.o: In function `rx1950_lcd_power':
> arch/arm/mach-s3c24xx/mach-rx1950.c:430: undefined reference to
> `pwm_config'
> arch/arm/mach-s3c24xx/mach-rx1950.c:431: undefined reference to
> `pwm_disable'
> arch/arm/mach-s3c24xx/mach-rx1950.c:437: undefined reference to
> `pwm_config'
> arch/arm/mach-s3c24xx/mach-rx1950.c:438: undefined reference to
> `pwm_enable'
> arch/arm/mach-s3c24xx/built-in.o: In function `rx1950_backlight_exit':
> arch/arm/mach-s3c24xx/mach-rx1950.c:504: undefined reference to `pwm_free'
> arch/arm/mach-s3c24xx/built-in.o: In function `rx1950_backlight_init':
> arch/arm/mach-s3c24xx/mach-rx1950.c:487: undefined reference to
> `pwm_request'
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c24xx/Kconfig |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index e249611..422133a 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -483,7 +483,8 @@ config MACH_NEO1973_GTA02
>  	select I2C
>  	select POWER_SUPPLY
>  	select MACH_NEO1973
> -	select S3C2410_PWM
> +	select PWM
> +	select PWM_SAMSUNG
>  	select S3C_DEV_USB_HOST
>  	help
>  	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM
> Phone
> @@ -493,7 +494,8 @@ config MACH_RX1950
>  	select S3C24XX_DCLK
>  	select PM_H1940 if PM
>  	select I2C
> -	select S3C2410_PWM
> +	select PWM
> +	select PWM_SAMSUNG
>  	select S3C_DEV_NAND
>  	select S3C2410_IOTIMING if S3C2440_CPUFREQ
>  	select S3C2440_XTAL_16934400
> --
> 1.7.10
> 
Hi Arnd,

There is following patch for fixing it in my tree now, its reference:

https://lkml.org/lkml/2012/8/8/185

So...?

From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH] ARM: SAMSUNG: Fix compilation error with s3c2410_defconfig

Commit 215c29d3d0e9 ("ARM Samsung: Move s3c pwm driver to pwm framework")
moved Samsung PWM driver to drivers/pwm and the config option to select
this driver has changed.

This patch fixes following build-error with s3c2410_defconfig.

arch/arm/mach-s3c24xx/built-in.o: In function 'rx1950_lcd_power':
arch/arm/mach-s3c24xx/mach-rx1950.c:430: undefined reference to 'pwm_config'
arch/arm/mach-s3c24xx/mach-rx1950.c:431: undefined reference to
'pwm_disable'
arch/arm/mach-s3c24xx/mach-rx1950.c:437: undefined reference to 'pwm_config'
arch/arm/mach-s3c24xx/mach-rx1950.c:438: undefined reference to 'pwm_enable'
arch/arm/mach-s3c24xx/built-in.o: In function 'rx1950_backlight_exit':
arch/arm/mach-s3c24xx/mach-rx1950.c:504: undefined reference to 'pwm_free'
arch/arm/mach-s3c24xx/built-in.o: In function 'rx1950_backlight_init':
arch/arm/mach-s3c24xx/mach-rx1950.c:487: undefined reference to
'pwm_request'

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
[kgene.kim at samsung.com: re-worked as per review comments]
Acked-by: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c24xx/Kconfig |    4 ++--
 arch/arm/plat-samsung/Kconfig |    2 +-
 drivers/pwm/Kconfig           |    6 ++----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index e249611..d56b0f7 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -483,7 +483,7 @@ config MACH_NEO1973_GTA02
 	select I2C
 	select POWER_SUPPLY
 	select MACH_NEO1973
-	select S3C2410_PWM
+	select S3C24XX_PWM
 	select S3C_DEV_USB_HOST
 	help
 	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM
Phone
@@ -493,7 +493,7 @@ config MACH_RX1950
 	select S3C24XX_DCLK
 	select PM_H1940 if PM
 	select I2C
-	select S3C2410_PWM
+	select S3C24XX_PWM
 	select S3C_DEV_NAND
 	select S3C2410_IOTIMING if S3C2440_CPUFREQ
 	select S3C2440_XTAL_16934400
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 7aca31c..dcdfb77 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -403,7 +403,7 @@ config S5P_DEV_USB_EHCI
 
 config S3C24XX_PWM
 	bool "PWM device support"
-	select HAVE_PWM
+	select PWM
 	help
 	  Support for exporting the PWM timer blocks via the pwm device
 	  system
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8fc3808..c74d055 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -58,14 +58,12 @@ config PWM_PXA
 	  will be called pwm-pxa.
 
 config PWM_SAMSUNG
-	tristate "Samsung pwm support"
+	bool "Samsung PWM support"
 	depends on PLAT_SAMSUNG
+	default y
 	help
 	  Generic PWM framework driver for Samsung.
 
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-samsung.
-
 config PWM_TEGRA
 	tristate "NVIDIA Tegra PWM support"
 	depends on ARCH_TEGRA
-- 
1.7.4.1

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
