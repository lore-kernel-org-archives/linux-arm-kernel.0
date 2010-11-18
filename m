From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Nov 2010 11:28:08 +0100
Subject: [PATCH] mx51_babbage: Add AT24C512 EEPROM support
In-Reply-To: <475095.26590.qm@web51005.mail.re2.yahoo.com>
References: <475095.26590.qm@web51005.mail.re2.yahoo.com>
Message-ID: <20101118102808.GY6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Wed, Nov 17, 2010 at 10:23:19AM -0800, Fabio Estevam wrote:
> MX51 Babbage has an AT24C512 connected to I2C1 on its expansion
> board.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx51_babbage.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index 66b07d8..ffb403e 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -22,6 +22,7 @@
>  #include <linux/input.h>
>  #include <linux/spi/flash.h>
>  #include <linux/spi/spi.h>
> +#include <linux/i2c/at24.h>
>  
>  #include <mach/common.h>
>  #include <mach/hardware.h>
> @@ -342,6 +343,19 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
>  	.num_chipselect = ARRAY_SIZE(mx51_babbage_spi_cs),
>  };
>  
> +static struct at24_platform_data at24c512 = {
> +	.byte_len = SZ_512K/8,
> +	.page_size = 128,
> +	.flags = AT24_FLAG_ADDR16,
> +};
> +
> +static struct i2c_board_info mx51_babbage_i2c_devices[] = {
> +	{
> +		I2C_BOARD_INFO("at24-eeprom", 0x50),
> +		.platform_data = &at24c512,
> +	},
> +};
> +
>  /*
>   * Board specific initialization.
>   */
> @@ -364,6 +378,8 @@ static void __init mxc_board_init(void)
>  	mxc_iomux_v3_setup_pad(&power_key);
>  	imx51_add_gpio_keys(&imx_button_data);
>  
> +	i2c_register_board_info(0, mx51_babbage_i2c_devices,
> +		ARRAY_SIZE(mx51_babbage_i2c_devices));

Can we move this call to a mx51_babbage_epansionboard_init() function?
This makes it clear that this is not available without the expansion
board and we can decide later to call this function only when an expansion
board is connected.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
