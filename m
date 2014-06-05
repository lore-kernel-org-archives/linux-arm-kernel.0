From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 05 Jun 2014 12:56:08 +0200
Subject: [PATCH] i2c: mux: pca954x needs gpiolib
In-Reply-To: <17059569.EZXzqhtzTf@wuerfel>
References: <17059569.EZXzqhtzTf@wuerfel>
Message-ID: <6840846.92XabYdCA4@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thursday 05 June 2014 12:44:47 Arnd Bergmann wrote:
> commit 4807e8459bce ("i2c: mux: pca954x: Use the descriptor-based GPIO
> API") moved this driver over to the gpio descriptor API, which means
> we now have a dependency on GPIOLIB and get this build error when
> it is disabled:
> 
> i2c/muxes/i2c-mux-pca954x.c: In function 'pca954x_probe':
> i2c/muxes/i2c-mux-pca954x.c:204:2: error: implicit declaration of function
> 'devm_gpiod_get' [-Werror=implicit-function-declaration] gpio =
> devm_gpiod_get(&client->dev, "reset");
>   ^
> i2c/muxes/i2c-mux-pca954x.c:204:7: warning: assignment makes pointer from
> integer without a cast [enabled by default] gpio =
> devm_gpiod_get(&client->dev, "reset");
>        ^
> i2c/muxes/i2c-mux-pca954x.c:206:3: error: implicit declaration of function
> 'gpiod_direction_output' [-Werror=implicit-function-declaration]
> gpiod_direction_output(gpio, 0);
>    ^
> 
> This adds the dependency in Kconfig as we do for other similar drivers.

I've sent "i2c: pca954x: Fix compilation without CONFIG_GPIOLIB" yesterday, 
which fixes the compilation issue by including <linux/gpio/consumer.h>. When 
CONFIG_GPIOLIB isn't set the header defines stub functions, keeping the driver 
usable without GPIOLIB support.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> 
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index f7f9865b..f6d313e 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -40,6 +40,7 @@ config I2C_MUX_PCA9541
> 
>  config I2C_MUX_PCA954x
>  	tristate "Philips PCA954x I2C Mux/switches"
> +	depends on GPIOLIB
>  	help
>  	  If you say yes here you get support for the Philips PCA954x
>  	  I2C mux/switch devices.

-- 
Regards,

Laurent Pinchart
