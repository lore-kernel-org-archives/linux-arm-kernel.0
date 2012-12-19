From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 19 Dec 2012 22:15:22 +0000
Subject: [PATCH] gpio: mvebu-gpio: Make mvebu-gpio depend on OF_CONFIG
In-Reply-To: <1355916672-26626-1-git-send-email-gregory.clement@free-electrons.com>
References: <1355916672-26626-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121219221522.4A3343E0AD6@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Dec 2012 12:31:11 +0100, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> When building without device tree support (for the mv78x00 SoCs for
> example), the build failed because of_irq_count is undeclared. However
> mvebu-gpio is not designed to build without device tree support. So
> make it depends on OF_CONFIG, remove the #ifdef OF_CONFIG line and the
> platform_device_id.
> 
> Tested on RD-78x00-mASA, DB-78460-BP, DB-88F6710-BP-DDR3,
> DB-MV784MP-GP, Mirabox and OpenBlocks AX3.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied, thanks.

g.

> ---
>  drivers/gpio/Kconfig      |    1 +
>  drivers/gpio/gpio-mvebu.c |   17 -----------------
>  2 files changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 8ae1f5b..682de75 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -172,6 +172,7 @@ config GPIO_MSM_V2
>  config GPIO_MVEBU
>  	def_bool y
>  	depends on PLAT_ORION
> +	depends on OF
>  	select GPIO_GENERIC
>  	select GENERIC_IRQ_CHIP
>  
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 6dd51d8..0961f2c 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -41,7 +41,6 @@
>  #include <linux/io.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_device.h>
> -#include <linux/platform_device.h>
>  #include <linux/pinctrl/consumer.h>
>  
>  /*
> @@ -469,19 +468,6 @@ static void mvebu_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  	}
>  }
>  
> -static struct platform_device_id mvebu_gpio_ids[] = {
> -	{
> -		.name = "orion-gpio",
> -	}, {
> -		.name = "mv78200-gpio",
> -	}, {
> -		.name = "armadaxp-gpio",
> -	}, {
> -		/* sentinel */
> -	},
> -};
> -MODULE_DEVICE_TABLE(platform, mvebu_gpio_ids);
> -
>  static struct of_device_id mvebu_gpio_of_match[] = {
>  	{
>  		.compatible = "marvell,orion-gpio",
> @@ -555,9 +541,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
>  	mvchip->chip.base = id * MVEBU_MAX_GPIO_PER_BANK;
>  	mvchip->chip.ngpio = ngpios;
>  	mvchip->chip.can_sleep = 0;
> -#ifdef CONFIG_OF
>  	mvchip->chip.of_node = np;
> -#endif
>  
>  	spin_lock_init(&mvchip->lock);
>  	mvchip->membase = devm_request_and_ioremap(&pdev->dev, res);
> @@ -698,7 +682,6 @@ static struct platform_driver mvebu_gpio_driver = {
>  		.of_match_table = mvebu_gpio_of_match,
>  	},
>  	.probe		= mvebu_gpio_probe,
> -	.id_table	= mvebu_gpio_ids,
>  };
>  
>  static int __init mvebu_gpio_init(void)
> -- 
> 1.7.9.5
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
