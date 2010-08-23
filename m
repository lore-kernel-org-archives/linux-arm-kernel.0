From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 23 Aug 2010 14:07:42 +0900
Subject: [PATCH 1/4] ARM: S5PC110: Add keypad device to the GONI board
In-Reply-To: <1282207846-4578-1-git-send-email-jy0922.shim@samsung.com>
References: <1282207846-4578-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <007101cb4281$20511430$60f33c90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joonyoung Shim wrote:
> 
> This patch is to support keypad device to the GONI board.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/Kconfig     |    2 ++
>  arch/arm/mach-s5pv210/mach-goni.c |   27 +++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index d3a3895..3843210 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -89,7 +89,9 @@ config MACH_GONI
>  	select S3C_DEV_HSMMC1
>  	select S3C_DEV_HSMMC2
>  	select S5PC110_DEV_ONENAND
> +	select SAMSUNG_DEV_KEYPAD
>  	select S5PV210_SETUP_FB_24BPP
> +	select S5PV210_SETUP_KEYPAD
>  	select S5PV210_SETUP_SDHCI
>  	help
>  	  Machine support for Samsung GONI board
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
b/arch/arm/mach-s5pv210/mach-
> goni.c
> index 53754d7..2dabd7f 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -35,6 +35,7 @@
>  #include <plat/devs.h>
>  #include <plat/cpu.h>
>  #include <plat/fb.h>
> +#include <plat/keypad.h>
>  #include <plat/sdhci.h>
> 
>  /* Following are default values for UCON, ULCON and UFCON UART registers
*/
> @@ -111,6 +112,28 @@ static struct s3c_fb_platdata goni_lcd_pdata
__initdata =
> {
>  	.setup_gpio	= s5pv210_fb_gpio_setup_24bpp,
>  };
> 
> +/* KEYPAD */
> +static uint32_t keymap[] __initdata = {
> +	/* KEY(row, col, keycode) */
> +	KEY(0, 1, KEY_MENU),		/* Send */
> +	KEY(0, 2, KEY_BACK),		/* End */
> +	KEY(1, 1, KEY_CONFIG),		/* Half shot */
> +	KEY(1, 2, KEY_VOLUMEUP),
> +	KEY(2, 1, KEY_CAMERA),		/* Full shot */
> +	KEY(2, 2, KEY_VOLUMEDOWN),
> +};
> +
> +static struct matrix_keymap_data keymap_data __initdata = {
> +	.keymap		= keymap,
> +	.keymap_size	= ARRAY_SIZE(keymap),
> +};
> +
> +static struct samsung_keypad_platdata keypad_data __initdata = {
> +	.keymap_data	= &keymap_data,
> +	.rows		= 3,
> +	.cols		= 3,
> +};
> +
>  /* MAX8998 regulators */
>  #if defined(CONFIG_REGULATOR_MAX8998) ||
> defined(CONFIG_REGULATOR_MAX8998_MODULE)
> 
> @@ -465,6 +488,7 @@ static struct platform_device *goni_devices[]
__initdata = {
>  	&s3c_device_hsmmc0,
>  	&s3c_device_hsmmc1,
>  	&s3c_device_hsmmc2,
> +	&samsung_device_keypad,
>  };
> 
>  static void __init goni_map_io(void)
> @@ -486,6 +510,9 @@ static void __init goni_machine_init(void)
>  	/* FB */
>  	s3c_fb_set_platdata(&goni_lcd_pdata);
> 
> +	/* KEYPAD */
> +	samsung_keypad_set_platdata(&keypad_data);
> +
>  	platform_add_devices(goni_devices, ARRAY_SIZE(goni_devices));
>  }
> 
> --

Looks ok...will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
