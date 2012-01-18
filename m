From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 19 Jan 2012 08:42:35 +1100
Subject: [PATCH] ep93xx: fix build of vision_ep93xx.c
In-Reply-To: <201201161305.23508.hartleys@visionengravers.com>
References: <201201161305.23508.hartleys@visionengravers.com>
Message-ID: <4F173CCB.2050009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/01/12 07:05, H Hartley Sweeten wrote:

> Fix build breakage due to the following commits:
> 
> Commit bd5f12a24766c1f299def0a78b008d4746f528f2
>   ARM: 7042/3: mach-ep93xx: break out GPIO driver specifics
> 
> Commit 257af9f9725aa8a863b306659208a031135d59e7
>   ARM: 7041/1: gpio-ep93xx: hookup the to_irq callback in the driver
> 
> The vision_ep9307 machine uses the ep93xx build-in gpios and needs to
> include <mach/gpio-ep93xx.h> to pickup the defines.
> 
> The gpio_to_irq() call is now a callback to the gpio-ep93xx.c driver
> and cannot be used as a constant initializer for the .irq member of
> struct i2c_board_info.
> 
> Signed-off-by: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>


Hi Hartley,

Sorry for the delay. This looks correct to me.

Acked-by: Ryan Mallon <rmallon@gmail.com>

> 
> ---
> 
> diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
> index 03dd401..d5fb44f 100644
> --- a/arch/arm/mach-ep93xx/vision_ep9307.c
> +++ b/arch/arm/mach-ep93xx/vision_ep9307.c
> @@ -32,6 +32,7 @@
>  #include <mach/hardware.h>
>  #include <mach/fb.h>
>  #include <mach/ep93xx_spi.h>
> +#include <mach/gpio-ep93xx.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
> @@ -153,7 +154,6 @@ static struct i2c_board_info vision_i2c_info[] __initdata = {
>  	}, {
>  		I2C_BOARD_INFO("pca9539", 0x74),
>  		.platform_data	= &pca953x_74_gpio_data,
> -		.irq		= gpio_to_irq(EP93XX_GPIO_LINE_F(7)),
>  	}, {
>  		I2C_BOARD_INFO("pca9539", 0x75),
>  		.platform_data	= &pca953x_75_gpio_data,
> @@ -348,6 +348,8 @@ static void __init vision_init_machine(void)
>  				"pca9539:74"))
>  		pr_warn("cannot request interrupt gpio for pca9539:74\n");
>  
> +	vision_i2c_info[1].irq = gpio_to_irq(EP93XX_GPIO_LINE_F(7));
> +
>  	ep93xx_register_i2c(&vision_i2c_gpio_data, vision_i2c_info,
>  				ARRAY_SIZE(vision_i2c_info));
>  	ep93xx_register_spi(&vision_spi_master, vision_spi_board_info,
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
