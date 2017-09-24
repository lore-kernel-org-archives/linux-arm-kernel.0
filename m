From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 24 Sep 2017 20:01:19 +0200
Subject: [PATCH] mtd: nand: gpio: Convert to use GPIO descriptors
In-Reply-To: <20170924173912.9199-1-linus.walleij@linaro.org>
References: <20170924173912.9199-1-linus.walleij@linaro.org>
Message-ID: <25a16804-3300-2ec5-fe90-ca59323f9dd3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2017 07:39 PM, Linus Walleij wrote:
> There is exactly one board in the kernel that defines platform data
> for the GPIO NAND driver.
> 
> Use the feature to provide a lookup table for the GPIOs in the board
> file so we can convert the driver as a whole to just use GPIO
> descriptors.
> 
> After this we can cut the use of <linux/of_gpio.h> and use the GPIO
> descriptor management from <linux/gpio/consumer.h> alone to grab and use
> the GPIOs used in the driver.
> 
> I also created a local struct device *dev in the probe() function
> because I was getting annoyed with all the &pdev->dev dereferencing.
> 
> Cc: arm at kernel.org
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Frans Klaver <fransklaver@gmail.com>
> Cc: Gerhard Sittig <gsi@denx.de>
> Cc: Jamie Iles <jamie.iles@oracle.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

> ---
> ARM SoC folks: Please ACK this so it can be merged through the MTD
> subsystem.
> 
> Everyone else on CC: can you test and/or ACK this?
> 
> I don't have this PXA board, and all device tree users seem to be
> out-of-tree so I rely on third parties to test this.
> ---
>  arch/arm/mach-pxa/cm-x255.c   |  19 ++++---
>  drivers/mtd/nand/gpio.c       | 112 +++++++++++++++++++++---------------------
>  include/linux/mtd/nand-gpio.h |   5 --
>  3 files changed, 70 insertions(+), 66 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/cm-x255.c b/arch/arm/mach-pxa/cm-x255.c
> index b592f79a1742..f8d67acb7194 100644
> --- a/arch/arm/mach-pxa/cm-x255.c
> +++ b/arch/arm/mach-pxa/cm-x255.c
> @@ -14,7 +14,7 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/mtd/nand-gpio.h>
> -
> +#include <linux/gpio/machine.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/pxa2xx_spi.h>
>  
> @@ -176,6 +176,17 @@ static inline void cmx255_init_nor(void) {}
>  #endif
>  
>  #if defined(CONFIG_MTD_NAND_GPIO) || defined(CONFIG_MTD_NAND_GPIO_MODULE)
> +
> +static struct gpiod_lookup_table cmx255_nand_gpiod_table = {
> +	.dev_id         = "cmx255-nand",
> +	.table          = {
> +		GPIO_LOOKUP("gpio-pxa", GPIO_NAND_CS, "nce", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("gpio-pxa", GPIO_NAND_CLE, "cle", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("gpio-pxa", GPIO_NAND_ALE, "ale", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("gpio-pxa", GPIO_NAND_RB, "rdy", GPIO_ACTIVE_HIGH),
> +	},
> +};
> +
>  static struct resource cmx255_nand_resource[] = {
>  	[0] = {
>  		.start = PXA_CS1_PHYS,
> @@ -198,11 +209,6 @@ static struct mtd_partition cmx255_nand_parts[] = {
>  };
>  
>  static struct gpio_nand_platdata cmx255_nand_platdata = {
> -	.gpio_nce = GPIO_NAND_CS,
> -	.gpio_cle = GPIO_NAND_CLE,
> -	.gpio_ale = GPIO_NAND_ALE,
> -	.gpio_rdy = GPIO_NAND_RB,
> -	.gpio_nwp = -1,
>  	.parts = cmx255_nand_parts,
>  	.num_parts = ARRAY_SIZE(cmx255_nand_parts),
>  	.chip_delay = 25,
> @@ -220,6 +226,7 @@ static struct platform_device cmx255_nand = {
>  
>  static void __init cmx255_init_nand(void)
>  {
> +	gpiod_add_lookup_table(&cmx255_nand_gpiod_table);
>  	platform_device_register(&cmx255_nand);
>  }
>  #else
> diff --git a/drivers/mtd/nand/gpio.c b/drivers/mtd/nand/gpio.c
> index fd3648952b5a..484f7fbc3f7d 100644
> --- a/drivers/mtd/nand/gpio.c
> +++ b/drivers/mtd/nand/gpio.c
> @@ -23,7 +23,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/io.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/rawnand.h>
> @@ -31,12 +31,16 @@
>  #include <linux/mtd/nand-gpio.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_gpio.h>
>  
>  struct gpiomtd {
>  	void __iomem		*io_sync;
>  	struct nand_chip	nand_chip;
>  	struct gpio_nand_platdata plat;
> +	struct gpio_desc *nce; /* Optional chip enable */
> +	struct gpio_desc *cle;
> +	struct gpio_desc *ale;
> +	struct gpio_desc *rdy;
> +	struct gpio_desc *nwp; /* Optional write protection */
>  };
>  
>  static inline struct gpiomtd *gpio_nand_getpriv(struct mtd_info *mtd)
> @@ -78,11 +82,10 @@ static void gpio_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
>  	gpio_nand_dosync(gpiomtd);
>  
>  	if (ctrl & NAND_CTRL_CHANGE) {
> -		if (gpio_is_valid(gpiomtd->plat.gpio_nce))
> -			gpio_set_value(gpiomtd->plat.gpio_nce,
> -				       !(ctrl & NAND_NCE));
> -		gpio_set_value(gpiomtd->plat.gpio_cle, !!(ctrl & NAND_CLE));
> -		gpio_set_value(gpiomtd->plat.gpio_ale, !!(ctrl & NAND_ALE));
> +		if (gpiomtd->nce)
> +			gpiod_set_value(gpiomtd->nce, !(ctrl & NAND_NCE));
> +		gpiod_set_value(gpiomtd->cle, !!(ctrl & NAND_CLE));
> +		gpiod_set_value(gpiomtd->ale, !!(ctrl & NAND_ALE));
>  		gpio_nand_dosync(gpiomtd);
>  	}
>  	if (cmd == NAND_CMD_NONE)
> @@ -96,7 +99,7 @@ static int gpio_nand_devready(struct mtd_info *mtd)
>  {
>  	struct gpiomtd *gpiomtd = gpio_nand_getpriv(mtd);
>  
> -	return gpio_get_value(gpiomtd->plat.gpio_rdy);
> +	return gpiod_get_value(gpiomtd->rdy);
>  }
>  
>  #ifdef CONFIG_OF
> @@ -123,12 +126,6 @@ static int gpio_nand_get_config_of(const struct device *dev,
>  		}
>  	}
>  
> -	plat->gpio_rdy = of_get_gpio(dev->of_node, 0);
> -	plat->gpio_nce = of_get_gpio(dev->of_node, 1);
> -	plat->gpio_ale = of_get_gpio(dev->of_node, 2);
> -	plat->gpio_cle = of_get_gpio(dev->of_node, 3);
> -	plat->gpio_nwp = of_get_gpio(dev->of_node, 4);
> -
>  	if (!of_property_read_u32(dev->of_node, "chip-delay", &val))
>  		plat->chip_delay = val;
>  
> @@ -201,10 +198,11 @@ static int gpio_nand_remove(struct platform_device *pdev)
>  
>  	nand_release(nand_to_mtd(&gpiomtd->nand_chip));
>  
> -	if (gpio_is_valid(gpiomtd->plat.gpio_nwp))
> -		gpio_set_value(gpiomtd->plat.gpio_nwp, 0);
> -	if (gpio_is_valid(gpiomtd->plat.gpio_nce))
> -		gpio_set_value(gpiomtd->plat.gpio_nce, 1);
> +	/* Enable write protection and disable the chip */
> +	if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
> +		gpiod_set_value(gpiomtd->nwp, 0);
> +	if (gpiomtd->nce && !IS_ERR(gpiomtd->nce))
> +		gpiod_set_value(gpiomtd->nce, 0);
>  
>  	return 0;
>  }
> @@ -215,66 +213,66 @@ static int gpio_nand_probe(struct platform_device *pdev)
>  	struct nand_chip *chip;
>  	struct mtd_info *mtd;
>  	struct resource *res;
> +	struct device *dev = &pdev->dev;
>  	int ret = 0;
>  
> -	if (!pdev->dev.of_node && !dev_get_platdata(&pdev->dev))
> +	if (!dev->of_node && !dev_get_platdata(dev))
>  		return -EINVAL;
>  
> -	gpiomtd = devm_kzalloc(&pdev->dev, sizeof(*gpiomtd), GFP_KERNEL);
> +	gpiomtd = devm_kzalloc(dev, sizeof(*gpiomtd), GFP_KERNEL);
>  	if (!gpiomtd)
>  		return -ENOMEM;
>  
>  	chip = &gpiomtd->nand_chip;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	chip->IO_ADDR_R = devm_ioremap_resource(&pdev->dev, res);
> +	chip->IO_ADDR_R = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(chip->IO_ADDR_R))
>  		return PTR_ERR(chip->IO_ADDR_R);
>  
>  	res = gpio_nand_get_io_sync(pdev);
>  	if (res) {
> -		gpiomtd->io_sync = devm_ioremap_resource(&pdev->dev, res);
> +		gpiomtd->io_sync = devm_ioremap_resource(dev, res);
>  		if (IS_ERR(gpiomtd->io_sync))
>  			return PTR_ERR(gpiomtd->io_sync);
>  	}
>  
> -	ret = gpio_nand_get_config(&pdev->dev, &gpiomtd->plat);
> +	ret = gpio_nand_get_config(dev, &gpiomtd->plat);
>  	if (ret)
>  		return ret;
>  
> -	if (gpio_is_valid(gpiomtd->plat.gpio_nce)) {
> -		ret = devm_gpio_request(&pdev->dev, gpiomtd->plat.gpio_nce,
> -					"NAND NCE");
> -		if (ret)
> -			return ret;
> -		gpio_direction_output(gpiomtd->plat.gpio_nce, 1);
> +	/* Just enable the chip */
> +	gpiomtd->nce = devm_gpiod_get_optional(dev, "nce", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpiomtd->nce))
> +		return PTR_ERR(gpiomtd->nce);
> +
> +	/* We disable write protection once we know probe() will succeed */
> +	gpiomtd->nwp = devm_gpiod_get_optional(dev, "nwp", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiomtd->nwp)) {
> +		ret = PTR_ERR(gpiomtd->nwp);
> +		goto out_ce;
>  	}
>  
> -	if (gpio_is_valid(gpiomtd->plat.gpio_nwp)) {
> -		ret = devm_gpio_request(&pdev->dev, gpiomtd->plat.gpio_nwp,
> -					"NAND NWP");
> -		if (ret)
> -			return ret;
> +	gpiomtd->nwp = devm_gpiod_get(dev, "ale", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiomtd->nwp)) {
> +		ret = PTR_ERR(gpiomtd->nwp);
> +		goto out_ce;
>  	}
>  
> -	ret = devm_gpio_request(&pdev->dev, gpiomtd->plat.gpio_ale, "NAND ALE");
> -	if (ret)
> -		return ret;
> -	gpio_direction_output(gpiomtd->plat.gpio_ale, 0);
> +	gpiomtd->cle = devm_gpiod_get(dev, "cle", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiomtd->cle)) {
> +		ret = PTR_ERR(gpiomtd->cle);
> +		goto out_ce;
> +	}
>  
> -	ret = devm_gpio_request(&pdev->dev, gpiomtd->plat.gpio_cle, "NAND CLE");
> -	if (ret)
> -		return ret;
> -	gpio_direction_output(gpiomtd->plat.gpio_cle, 0);
> -
> -	if (gpio_is_valid(gpiomtd->plat.gpio_rdy)) {
> -		ret = devm_gpio_request(&pdev->dev, gpiomtd->plat.gpio_rdy,
> -					"NAND RDY");
> -		if (ret)
> -			return ret;
> -		gpio_direction_input(gpiomtd->plat.gpio_rdy);
> -		chip->dev_ready = gpio_nand_devready;
> +	gpiomtd->rdy = devm_gpiod_get_optional(dev, "rdy", GPIOD_IN);
> +	if (IS_ERR(gpiomtd->rdy)) {
> +		ret = PTR_ERR(gpiomtd->rdy);
> +		goto out_ce;
>  	}
> +	/* Using RDY pin */
> +	if (gpiomtd->rdy)
> +		chip->dev_ready = gpio_nand_devready;
>  
>  	nand_set_flash_node(chip, pdev->dev.of_node);
>  	chip->IO_ADDR_W		= chip->IO_ADDR_R;
> @@ -285,12 +283,13 @@ static int gpio_nand_probe(struct platform_device *pdev)
>  	chip->cmd_ctrl		= gpio_nand_cmd_ctrl;
>  
>  	mtd			= nand_to_mtd(chip);
> -	mtd->dev.parent		= &pdev->dev;
> +	mtd->dev.parent		= dev;
>  
>  	platform_set_drvdata(pdev, gpiomtd);
>  
> -	if (gpio_is_valid(gpiomtd->plat.gpio_nwp))
> -		gpio_direction_output(gpiomtd->plat.gpio_nwp, 1);
> +	/* Disable write protection, if wired up */
> +	if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
> +		gpiod_direction_output(gpiomtd->nwp, 1);
>  
>  	ret = nand_scan(mtd, 1);
>  	if (ret)
> @@ -305,8 +304,11 @@ static int gpio_nand_probe(struct platform_device *pdev)
>  		return 0;
>  
>  err_wp:
> -	if (gpio_is_valid(gpiomtd->plat.gpio_nwp))
> -		gpio_set_value(gpiomtd->plat.gpio_nwp, 0);
> +	if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
> +		gpiod_set_value(gpiomtd->nwp, 0);
> +out_ce:
> +	if (gpiomtd->nce && !IS_ERR(gpiomtd->nce))
> +		gpiod_set_value(gpiomtd->nce, 0);
>  
>  	return ret;
>  }
> diff --git a/include/linux/mtd/nand-gpio.h b/include/linux/mtd/nand-gpio.h
> index be4f45d89be2..98f71908212d 100644
> --- a/include/linux/mtd/nand-gpio.h
> +++ b/include/linux/mtd/nand-gpio.h
> @@ -4,11 +4,6 @@
>  #include <linux/mtd/rawnand.h>
>  
>  struct gpio_nand_platdata {
> -	int	gpio_nce;
> -	int	gpio_nwp;
> -	int	gpio_cle;
> -	int	gpio_ale;
> -	int	gpio_rdy;
>  	void	(*adjust_parts)(struct gpio_nand_platdata *, size_t);
>  	struct mtd_partition *parts;
>  	unsigned int num_parts;
> 


-- 
Best regards,
Marek Vasut
