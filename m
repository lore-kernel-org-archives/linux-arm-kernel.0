From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 7 Apr 2014 08:31:00 +0200
Subject: [PATCH] i2c: cadence: fix Kconfig dependency
In-Reply-To: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20140407063100.GN29751@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Apr 06, 2014 at 09:07:07PM +0200, Wolfram Sang wrote:
> During development, the driver first really needed to depend on
> COMMON_CLK only. Later, it was switched to writel_relaxed, but it was
> forgotten to update the dependencies, so build errors occured:
> 
> config: make ARCH=i386 allyesconfig
> 
> All error/warnings:
> 
>    drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_clear_bus_hold':
> >> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit declaration
> >> of function 'writel_relaxed' [-Werror=implicit-function-declaration]
> 
> Use a very safe dependency for now.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/i2c/busses/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 93165ff453ab..3d3b9b3577c5 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -378,7 +378,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
>  
>  config I2C_CADENCE
>  	tristate "Cadence I2C Controller"
> -	depends on COMMON_CLK
> +	depends on ARCH_ZYNQ
I'd suggest:

	depends on ARM && (ARCH_ZYNC || COMPILE_TEST)

This way it's available for compile testing but still it doesn't appear
when configuring a kernel for a real machine.

Best regards
Uwe

>  	help
>  	  Say yes here to select Cadence I2C Host Controller. This controller is
>  	  e.g. used by Xilinx Zynq.
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
