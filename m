From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 26 Sep 2012 10:28:27 +0200
Subject: [PATCH 6/6] spi: atmel: add dt property for DMA configuration
 for sam9x5 and sam9n12
In-Reply-To: <1348642261-27554-7-git-send-email-wenyou.yang@atmel.com>
References: <1348642261-27554-1-git-send-email-wenyou.yang@atmel.com>
 <1348642261-27554-7-git-send-email-wenyou.yang@atmel.com>
Message-ID: <5062BCAB.1050405@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2012 08:51 AM, Wenyou Yang :
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

This is not mainline material: we have a DMA-DT API, now.

> ---
>  arch/arm/boot/dts/at91sam9n12.dtsi |    2 ++
>  arch/arm/boot/dts/at91sam9x5.dtsi  |    4 +++
>  drivers/spi/spi-atmel.c            |   55 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index c6868a2..b51f94d 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -98,6 +98,7 @@
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffec00 0x200>;
>  				interrupts = <20 4 0>;
> +				#dma-cells = <1>;
>  			};
>  
>  			pioA: gpio at fffff400 {
> @@ -197,6 +198,7 @@
>  				has_dma_support = <1>;
>  				has_pdc_support = <0>;
>  				is_ver2 = <1>;
> +				dma = <&dma 0x10002212>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index f124473..ee46cb7 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -100,12 +100,14 @@
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffec00 0x200>;
>  				interrupts = <20 4 0>;
> +				#dma-cells = <1>;
>  			};
>  
>  			dma1: dma-controller at ffffee00 {
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffee00 0x200>;
>  				interrupts = <21 4 0>;
> +				#dma-cells = <1>;
>  			};
>  
>  			pioA: gpio at fffff400 {
> @@ -248,6 +250,7 @@
>  				has_dma_support = <1>;
>  				has_pdc_support = <0>;
>  				is_ver2 = <1>;
> +				dma = <&dma0 0x10002212>;
>  				status = "disabled";
>  			};
>  
> @@ -265,6 +268,7 @@
>  				has_dma_support = <1>;
>  				has_pdc_support = <0>;
>  				is_ver2 = <1>;
> +				dma = <&dma1 0x10002212>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 9930438..ad19423 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1436,6 +1436,57 @@ static void atmel_spi_cleanup(struct spi_device *spi)
>  	kfree(asd);
>  }
>  
> +static int at91_spi_of_init(struct device_node *np,
> +			struct at_dma_slave *atslave)
> +{
> +	struct of_phandle_args  dma_spec;
> +	struct device_node      *dmac_np;
> +	struct platform_device  *dmac_pdev;
> +	const __be32            *nbcells;
> +	int                     ret;
> +
> +	ret = of_parse_phandle_with_args(np, "dma", "#dma-cells", 0, &dma_spec);
> +	if (ret || !dma_spec.np) {
> +		pr_err("%s: can't parse dma property (%d)\n",
> +						np->full_name, ret);
> +		goto err0;
> +	}
> +	dmac_np = dma_spec.np;
> +
> +	/* check property format */
> +	nbcells = of_get_property(dmac_np, "#dma-cells", NULL);
> +	if (!nbcells) {
> +		pr_err("%s: #dma-cells property is required\n", np->full_name);
> +		ret = -EINVAL;
> +		goto err1;
> +	}
> +
> +	if (dma_spec.args_count != be32_to_cpup(nbcells)
> +			|| dma_spec.args_count != 1) {
> +		pr_err("%s: wrong #dma-cells for %s\n",
> +				np->full_name, dmac_np->full_name);
> +		ret = -EINVAL;
> +		goto err1;
> +	}
> +
> +	dmac_pdev = of_find_device_by_node(dmac_np);
> +	if (!dmac_pdev) {
> +		pr_err("%s: unable to find pdev from DMA controller\n",
> +				dmac_np->full_name);
> +		ret = -EINVAL;
> +		goto err1;
> +	}
> +
> +	atslave->dma_dev = &dmac_pdev->dev;
> +	atslave->cfg = dma_spec.args[0];
> +
> +err1:
> +	of_node_put(dma_spec.np);
> +err0:
> +	pr_debug("%s exited with status %d\n", __func__, ret);
> +	return ret;
> +}
> +
>  static int of_get_atmel_spi_data(struct device_node *np, struct atmel_spi *as)
>  {
>  	const __be32	*val;
> @@ -1540,7 +1591,9 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
>  		goto out_unmap_regs;
>  
>  	if (as->data.has_dma_support) {
> -		if (atmel_spi_configure_dma(as) == 0)
> +		if ((at91_spi_of_init(pdev->dev.of_node,
> +				&as->data.dma_slave) == 0)
> +				&& (atmel_spi_configure_dma(as) == 0))
>  			as->use_dma = true;
>  	} else if (as->data.has_pdc_support)
>  		as->use_pdc = true;
> 


-- 
Nicolas Ferre
