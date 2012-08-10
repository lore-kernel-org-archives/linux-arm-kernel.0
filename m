From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Aug 2012 13:56:23 +0900
Subject: [PATCH 1/2] ARM: S3C64XX: Update configuration for WM5102 module
 on Cragganmore
In-Reply-To: <1344535549-4371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1344535549-4371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <0db901cd76b4$7daf1730$790d4590$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> SPI is also connected on the board, use that instead of I2C as it's much
> faster. Also define platform data now the core driver is in mainline.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c |   35
> ++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-
> s3c64xx/mach-crag6410-module.c
> index f81f089..22dd77b 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> @@ -192,9 +192,33 @@ static const struct i2c_board_info wm1277_devs[] = {
>  	},
>  };
> 
> -static const struct i2c_board_info wm5102_devs[] = {
> -	{ I2C_BOARD_INFO("wm5102", 0x1a),
> -	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2, },
> +static struct arizona_pdata wm5102_pdata = {
> +	.ldoena = S3C64XX_GPN(7),
> +	.gpio_base = CODEC_GPIO_BASE,
> +	.irq_active_high = true,
> +	.micd_pol_gpio = CODEC_GPIO_BASE + 4,
> +	.gpio_defaults = {
> +		[2] = 0x10000, /* AIF3TXLRCLK */
> +		[3] = 0x4,     /* OPCLK */
> +	},
> +};

Mark, happens error.

arch/arm/mach-s3c64xx/mach-crag6410-module.c:184: error: variable
'wm5102_pdata' has initializer but incomplete type
arch/arm/mach-s3c64xx/mach-crag6410-module.c:185: error: unknown field
'ldoena' specified in initializer
arch/arm/mach-s3c64xx/mach-crag6410-module.c:185: warning: excess elements
in struct initializer
arch/arm/mach-s3c64xx/mach-crag6410-module.c:185: warning: (near
initialization for 'wm5102_pdata')
arch/arm/mach-s3c64xx/mach-crag6410-module.c:186: error: unknown field
'gpio_base' specified in initializer
arch/arm/mach-s3c64xx/mach-crag6410-module.c:186: warning: excess elements
in struct initializer
arch/arm/mach-s3c64xx/mach-crag6410-module.c:186: warning: (near
initialization for 'wm5102_pdata')
arch/arm/mach-s3c64xx/mach-crag6410-module.c:187: error: unknown field
'irq_active_high' specified in initializer
arch/arm/mach-s3c64xx/mach-crag6410-module.c:187: warning: excess elements
in struct initializer
arch/arm/mach-s3c64xx/mach-crag6410-module.c:187: warning: (near
initialization for 'wm5102_pdata')
arch/arm/mach-s3c64xx/mach-crag6410-module.c:188: error: unknown field
'micd_pol_gpio' specified in initializer
arch/arm/mach-s3c64xx/mach-crag6410-module.c:188: warning: excess elements
in struct initializer
arch/arm/mach-s3c64xx/mach-crag6410-module.c:188: warning: (near
initialization for 'wm5102_pdata')
arch/arm/mach-s3c64xx/mach-crag6410-module.c:189: error: unknown field
'gpio_defaults' specified in initializer
arch/arm/mach-s3c64xx/mach-crag6410-module.c:189: error: extra brace group
at end of initializer
arch/arm/mach-s3c64xx/mach-crag6410-module.c:189: error: (near
initialization for 'wm5102_pdata')
arch/arm/mach-s3c64xx/mach-crag6410-module.c:192: warning: excess elements
in struct initializer
arch/arm/mach-s3c64xx/mach-crag6410-module.c:192: warning: (near
initialization for 'wm5102_pdata')
make[1]: *** [arch/arm/mach-s3c64xx/mach-crag6410-module.o] Error 1
make: *** [arch/arm/mach-s3c64xx] Error 2
make: *** Waiting for unfinished jobs....

Probably, this patch needs following?

--
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index c148384..7f4f9eb 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -16,6 +16,7 @@
 #include <linux/mfd/wm831x/irq.h>
 #include <linux/mfd/wm831x/gpio.h>
 #include <linux/mfd/wm8994/pdata.h>
+#include <linux/mfd/arizona/pdata.h>

 #include <linux/regulator/machine.h>
--

If you're ok, I will fix build error by above when I apply.

[...]

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
