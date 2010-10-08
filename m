From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 8 Oct 2010 10:51:41 +0200
Subject: [PATCH for 2.6.36 2/2] cpuimx27: fix i2c bus selection
In-Reply-To: <1286527061-3013-2-git-send-email-eric@eukrea.com>
References: <1286527061-3013-1-git-send-email-eric@eukrea.com>
	<1286527061-3013-2-git-send-email-eric@eukrea.com>
Message-ID: <20101008085141.GB29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 08, 2010 at 10:37:41AM +0200, Eric B?nard wrote:
> Recent clean of i.MX devices registration changed the i2C bus number
s/clean/clean up/ ?

> selected for our platform (Freescale start peripheral ID at 1, kernel
> now start it at 0 so i.MX27's i2c 1 is kernel's i2c 0).
Note that I didn't change the base for numbering devices.  If you look
at c69871597dd173af2d7615429c0ee6aa10fae42b, it has:

-       mxc_register_device(&mxc_i2c_device0, &eukrea_cpuimx27_i2c_1_data);
+       imx27_add_i2c_imx1(&cpuimx27_i2c1_data);

So I just used imx27_add_i2c_imx1 to replace registering of
mxc_i2c_device0, probably I did this because of the 1 in the name of the
platform data (that was already inconsistant before).  I'd suggest do
change it to cpuimx27_i2c0_data, too.

And I'd like to have the commit id for the breaking patch in the commit
log please.

Best regards
Uwe

> Without this fix, i2c is unusable on this platform.
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-imx/mach-cpuimx27.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
> index 339150a..6830afd 100644
> --- a/arch/arm/mach-imx/mach-cpuimx27.c
> +++ b/arch/arm/mach-imx/mach-cpuimx27.c
> @@ -259,7 +259,7 @@ static void __init eukrea_cpuimx27_init(void)
>  	i2c_register_board_info(0, eukrea_cpuimx27_i2c_devices,
>  				ARRAY_SIZE(eukrea_cpuimx27_i2c_devices));
>  
> -	imx27_add_i2c_imx1(&cpuimx27_i2c1_data);
> +	imx27_add_i2c_imx0(&cpuimx27_i2c1_data);
>  
>  	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
>  
> -- 
> 1.7.0.4
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
