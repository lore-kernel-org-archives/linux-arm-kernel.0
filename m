From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 10 Jan 2011 20:37:25 +0100
Subject: [PATCH] ARM: imx/mx27_3ds: Add debug board support
In-Reply-To: <1294677761-11971-1-git-send-email-fabio.estevam@freescale.com>
References: <1294677761-11971-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110110193725.GH24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Mon, Jan 10, 2011 at 02:42:41PM -0200, Fabio Estevam wrote:
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig         |    1 +
>  arch/arm/mach-imx/mach-mx27_3ds.c |    7 +++++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 17d2e60..56684b5 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -243,6 +243,7 @@ config MACH_MX27_3DS
>  	select IMX_HAVE_PLATFORM_MXC_EHCI
>  	select IMX_HAVE_PLATFORM_MXC_MMC
>  	select IMX_HAVE_PLATFORM_SPI_IMX
> +	select MXC_DEBUG_BOARD
>  	select MXC_ULPI if USB_ULPI
>  	help
>  	  Include support for MX27PDK platform. This includes specific
> diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
> index 83f8e2b..4d72891 100644
> --- a/arch/arm/mach-imx/mach-mx27_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx27_3ds.c
> @@ -37,12 +37,15 @@
>  #include <mach/common.h>
>  #include <mach/iomux-mx27.h>
>  #include <mach/ulpi.h>
> +#include <mach/irqs.h>
> +#include <mach/3ds_debugboard.h>
>  
>  #include "devices-imx27.h"
>  
>  #define SD1_EN_GPIO (GPIO_PORTB + 25)
>  #define OTG_PHY_RESET_GPIO (GPIO_PORTB + 23)
>  #define SPI2_SS0 (GPIO_PORTD + 21)
> +#define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTC + 28)
>  
>  static const int mx27pdk_pins[] __initconst = {
>  	/* UART1 */
> @@ -276,6 +279,10 @@ static void __init mx27pdk_init(void)
>  	imx27_add_spi_imx1(&spi2_pdata);
>  	spi_register_board_info(mx27_3ds_spi_devs,
>  						ARRAY_SIZE(mx27_3ds_spi_devs));
> +
> +	if (mxc_expio_init(MX27_CS5_BASE_ADDR, EXPIO_PARENT_INT))
> +		pr_warn("Init of the debugboard failed, all "
> +				"devices on the debugboard are unusable.\n");
You don't need to break this.  In fact it's better when you don't.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
