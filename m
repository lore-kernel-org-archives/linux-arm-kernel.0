From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 04 Aug 2010 20:02:10 +0900
Subject: [PATCH] ARM: S5PV210: Add SDHCI devices for GONI board
In-Reply-To: <1279896420-29642-1-git-send-email-m.szyprowski@samsung.com>
References: <1279896420-29642-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <001801cb33c4$7febd680$7fc38380$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> This patch add support for SDHCI blocks on Samsung Goni board. The
> following host controllers are defined:
> 1. Internal MoviNAND device (permanently wired to the controller)
> 2. Internal WiFI SDIO device (card is activated by power regualor)
> 3. External MMC/SD socket (card detection is provided by external
> gpio interrupt)
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/Kconfig     |    4 +++
>  arch/arm/mach-s5pv210/mach-goni.c |   39
> +++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index c64dff1..13e0690 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -74,8 +74,12 @@ config MACH_GONI
>  	select CPU_S5PV210
>  	select ARCH_SPARSEMEM_ENABLE
>  	select S5PV210_SETUP_FB_24BPP
> +	select S5PV210_SETUP_SDHCI
>  	select S3C_DEV_FB
>  	select S5PC110_DEV_ONENAND
> +	select S3C_DEV_HSMMC
> +	select S3C_DEV_HSMMC1
> +	select S3C_DEV_HSMMC2
>  	help
>  	  Machine support for Samsung GONI board
>  	  S5PC110(MCP) is one of package option of S5PV210
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
b/arch/arm/mach-s5pv210/mach-
> goni.c
> index 7b18505..e374b34 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -35,6 +35,7 @@
>  #include <plat/devs.h>
>  #include <plat/cpu.h>
>  #include <plat/fb.h>
> +#include <plat/sdhci.h>
> 
>  /* Following are default values for UCON, ULCON and UFCON UART registers
*/
>  #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
> @@ -420,12 +421,47 @@ static void __init goni_pmic_init(void)
>  	s3c_gpio_setpull(S5PV210_GPH2(6), S3C_GPIO_PULL_UP);
>  }
> 
> +/* MoviNAND */
> +static struct s3c_sdhci_platdata goni_hsmmc0_data __initdata = {
> +	.max_width		= 4,
> +	.cd_type		= S3C_SDHCI_CD_PERMANENT,
> +};
> +
> +/* Wireless LAN */
> +static struct s3c_sdhci_platdata goni_hsmmc1_data __initdata = {
> +	.max_width		= 4,
> +	.cd_type		= S3C_SDHCI_CD_EXTERNAL,
> +	/* ext_cd_{init,cleanup} callbacks will be added later */
> +};
> +
> +/* External Flash */
> +#define GONI_EXT_FLASH_EN	S5PV210_MP05(4)
> +#define GONI_EXT_FLASH_CD	S5PV210_GPH3(4)
> +static struct s3c_sdhci_platdata goni_hsmmc2_data __initdata = {
> +	.max_width		= 4,
> +	.cd_type		= S3C_SDHCI_CD_GPIO,
> +	.ext_cd_gpio		= GONI_EXT_FLASH_CD,
> +	.ext_cd_gpio_invert	= 1,
> +};
> +
> +static void goni_setup_sdhci(void)
> +{
> +	gpio_request(GONI_EXT_FLASH_EN, "FLASH_EN");
> +	gpio_direction_output(GONI_EXT_FLASH_EN, 1);
> +
> +	s3c_sdhci0_set_platdata(&goni_hsmmc0_data);
> +	s3c_sdhci1_set_platdata(&goni_hsmmc1_data);
> +	s3c_sdhci2_set_platdata(&goni_hsmmc2_data);
> +};
> 
>  static struct platform_device *goni_devices[] __initdata = {
>  	&s3c_device_fb,
>  	&s5pc110_device_onenand,
>  	&goni_i2c_gpio_pmic,
>  	&goni_device_gpiokeys,
> +	&s3c_device_hsmmc0,
> +	&s3c_device_hsmmc1,
> +	&s3c_device_hsmmc2,
>  };
> 
>  static void __init goni_map_io(void)
> @@ -441,6 +477,9 @@ static void __init goni_machine_init(void)
>  	goni_pmic_init();
>  	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4,
> i2c_gpio_pmic_devs,
>  			ARRAY_SIZE(i2c_gpio_pmic_devs));
> +	/* SDHCI */
> +	goni_setup_sdhci();
> +
>  	/* FB */
>  	s3c_fb_set_platdata(&goni_lcd_pdata);
> 
> --
Hmm...as you know, this is same patch with previous Aquila SDHCI except only
name.
In future, we need to sort out about that.

Anyway, will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
