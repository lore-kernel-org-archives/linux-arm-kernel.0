From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 26 Mar 2013 09:27:10 +0100
Subject: [PATCH] ARM: kirkwood: make use of DT mvsdio on guruplug board
In-Reply-To: <1364043489-17683-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1364043489-17683-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130326082710.GM5627@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 01:58:09PM +0100, Sebastian Hesselbarth wrote:
> Device tree based guruplug boards still use mvsdio platform_data and
> kirkwood_sdio_init to enable sdio. DT support for sdio is already there,
> so make use of it.
> 
> This also fixes mvsdio accidentially breaking nand by configuring mpp0
> to gpio, while used also by nand (nand_io2 on mpp0).
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Tested-by: Soeren Moch <smoch@web.de>

Acked-by: Andrew Lunn <andrew@lunn.ch>

> ---
> Cc: Soeren Moch <smoch@web.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts |    4 ++++
>  arch/arm/mach-kirkwood/board-guruplug.c             |    6 ------
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
> index 9555a86..44fd97d 100644
> --- a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
> +++ b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
> @@ -69,6 +69,10 @@
>  			status = "okay";
>  			nr-ports = <1>;
>  		};
> +
> +		mvsdio at 90000 {
> +			status = "okay";
> +		};
>  	};
>  
>  	gpio-leds {
> diff --git a/arch/arm/mach-kirkwood/board-guruplug.c b/arch/arm/mach-kirkwood/board-guruplug.c
> index 0a0df45..a857163 100644
> --- a/arch/arm/mach-kirkwood/board-guruplug.c
> +++ b/arch/arm/mach-kirkwood/board-guruplug.c
> @@ -13,7 +13,6 @@
>  #include <linux/init.h>
>  #include <linux/mv643xx_eth.h>
>  #include <linux/gpio.h>
> -#include <linux/platform_data/mmc-mvsdio.h>
>  #include "common.h"
>  
>  static struct mv643xx_eth_platform_data guruplug_ge00_data = {
> @@ -24,10 +23,6 @@ static struct mv643xx_eth_platform_data guruplug_ge01_data = {
>  	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
>  };
>  
> -static struct mvsdio_platform_data guruplug_mvsdio_data = {
> -	/* unfortunately the CD signal has not been connected */
> -};
> -
>  void __init guruplug_dt_init(void)
>  {
>  	/*
> @@ -35,5 +30,4 @@ void __init guruplug_dt_init(void)
>  	 */
>  	kirkwood_ge00_init(&guruplug_ge00_data);
>  	kirkwood_ge01_init(&guruplug_ge01_data);
> -	kirkwood_sdio_init(&guruplug_mvsdio_data);
>  }
> -- 
> 1.7.10.4
> 
