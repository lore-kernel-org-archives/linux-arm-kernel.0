From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 31 Aug 2016 18:45:37 +0200
Subject: [PATCH 5/5] misc: sram: add Atmel securam support
In-Reply-To: <20160831161108.8780-6-alexandre.belloni@free-electrons.com>
References: <20160831161108.8780-1-alexandre.belloni@free-electrons.com>
 <20160831161108.8780-6-alexandre.belloni@free-electrons.com>
Message-ID: <1472661937.9330.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

Am Mittwoch, den 31.08.2016, 18:11 +0200 schrieb Alexandre Belloni:
> The Atmel secure SRAM is connected to a security module and may be erased
> automatically under certain conditions. For that reason, it is necessary to
> wait for the security module to flag that SRAM accesses are allowed before
> accessing it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>  drivers/misc/sram.c | 52 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
> index f84b53d6ce50..8d411c64d07f 100644
> --- a/drivers/misc/sram.c
> +++ b/drivers/misc/sram.c
> @@ -19,12 +19,16 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/genalloc.h>
>  #include <linux/io.h>
>  #include <linux/list_sort.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/mfd/syscon.h>
> +#include <soc/at91/atmel-secumod.h>
>  
>  #define SRAM_GRANULARITY	32
>  
> @@ -334,12 +338,43 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
>  	return ret;
>  }
>  
> +static int atmel_securam_wait(void)
> +{
> +	struct regmap *regmap;
> +	unsigned long timeout = jiffies + HZ;

Can this really take up to a second?

> +	u32 val;
> +
> +	regmap = syscon_regmap_lookup_by_compatible("atmel,sama5d2-secumod");
> +	if (IS_ERR(regmap))
> +		return -ENODEV;
> +
> +	regmap_read(regmap, AT91_SECUMOD_RAMRDY, &val);
> +	while (!(val & AT91_SECUMOD_RAMRDY_READY) &&
> +	       time_before(jiffies, timeout)) {
> +		mdelay(10);
> +		regmap_read(regmap, AT91_SECUMOD_RAMRDY, &val);
> +	}
> +	if (!time_before(jiffies, timeout))
> +		return -ETIMEDOUT;
> +
> +	return 0;

Could you use regmap_read_poll_timeout here?

> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id sram_dt_ids[] = {
> +	{ .compatible = "mmio-sram" },
> +	{ .compatible = "atmel,sama5d2-securam", .data = atmel_securam_wait },
> +	{}
> +};
> +#endif
> +
>  static int sram_probe(struct platform_device *pdev)
>  {
>  	struct sram_dev *sram;
>  	struct resource *res;
>  	size_t size;
>  	int ret;
> +	const struct of_device_id *match;
>  
>  	sram = devm_kzalloc(&pdev->dev, sizeof(*sram), GFP_KERNEL);
>  	if (!sram)
> @@ -384,6 +419,16 @@ static int sram_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sram);
>  
> +	match = of_match_node(sram_dt_ids, pdev->dev.of_node);
> +	if (match->data) {

And of_device_get_match_data here?

> +		int (*init_func)(void);
> +
> +		init_func = match->data;
> +		ret = init_func();
> +		if (ret)
> +			return ret;
> +	}
> +
>  	dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
>  		gen_pool_size(sram->pool) / 1024, sram->virt_base);
>  
> @@ -405,13 +450,6 @@ static int sram_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_OF
> -static const struct of_device_id sram_dt_ids[] = {
> -	{ .compatible = "mmio-sram" },
> -	{}
> -};
> -#endif
> -
>  static struct platform_driver sram_driver = {
>  	.driver = {
>  		.name = "sram",

regards
Philipp
