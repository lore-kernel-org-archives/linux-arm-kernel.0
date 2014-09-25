From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 13:34:04 +0200
Subject: [PATCH v5 2/2] bcma: get IRQ numbers from dt
In-Reply-To: <1411597048-25470-2-git-send-email-hauke@hauke-m.de>
References: <1411597048-25470-1-git-send-email-hauke@hauke-m.de>
 <1411597048-25470-2-git-send-email-hauke@hauke-m.de>
Message-ID: <2791240.uYg7Zkz6J1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 September 2014 00:17:28 Hauke Mehrtens wrote:
> It is not possible to auto detect the irq numbers used by the cores on
> an arm SoC. If bcma was registered with device tree it will search for
> some device tree nodes with the irq number and add it to the core
> configuration.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Some more explanation for how this can be improved according to my earlier
reply:

>  
> @@ -17,4 +21,24 @@ Example:
>  		ranges = <0x00000000 0x18000000 0x00100000>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> +
> +		#interrupt-cells = <0>;

	<1>

> +		interrupt-map-mask = <0x000fffff>;
> +		interrupt-map =
> +			/* Ethernet Controller 0 */
> +			<0x00024000 &gic GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +
> +			/* Ethernet Controller 1 */
> +			<0x00025000 &gic GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;

Add 0 here after the address for the first interrupt of a device,
or a consecutive number for additional interrupts.

But check first if the register that is used on MIPS to access the
interrupts has any function. If it does, put the bit position in here
instead.

> +		pcie at 12000 {
> +			interrupt-parent = <&gic>;
> +			reg = <0x00012000 0x1000>;
> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
> +		};

so this can go away.

> +static int bcma_of_irq_parse(struct platform_device *parent,
> +			     struct bcma_device *core,
> +			     struct of_phandle_args *out_irq)
> +{
> +	__be32 laddr[1];
> +	int rc;
> +
> +	if (core->dev.of_node) {
> +		rc = of_irq_parse_one(core->dev.of_node, 0, out_irq);
> +		if (!rc)
> +			return rc;
> +	}
> +
> +	out_irq->np = parent->dev.of_node;
> +	out_irq->args_count = 0;
> +
> +	laddr[0] = cpu_to_be32(core->addr);
> +	return of_irq_parse_raw(laddr, out_irq);
> +}

You probably don't need a separate function here, just move the code into
bcma_of_get_irq.

> +static int bcma_of_get_irq(struct platform_device *parent,
> +			   struct bcma_device *core)

Make this function take the interrupt number as an argument

> +
>  static void bcma_of_fill_device(struct platform_device *parent,
>  				struct bcma_device *core)
>  {
> @@ -161,6 +201,8 @@ static void bcma_of_fill_device(struct platform_device *parent,
>  	node = bcma_of_find_child_device(parent, core);
>  	if (node)
>  		core->dev.of_node = node;
> +
> +	core->irq = bcma_of_get_irq(parent, core);
>  }

It's probably a good idea to still put the first interrupt number in here,
but drivers should not rely on the interrupt numbers being consecutive.
If a driver needs more than one irq, it should call bcma_of_get_irq() or
another API function that calls it internally and that also works on MIPS.

	Arnd
