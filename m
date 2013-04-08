From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 08 Apr 2013 11:56:26 +0200
Subject: [PATCH v3] irqchip: renesas-intc-irqpin: DT binding for sense
 bitfield width
In-Reply-To: <Pine.LNX.4.64.1304081002190.29945@axis700.grange>
References: <Pine.LNX.4.64.1304081002190.29945@axis700.grange>
Message-ID: <1694336.shM2ct4pzX@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

Thanks for the patch.

On Monday 08 April 2013 10:08:40 Guennadi Liakhovetski wrote:
> Most Renesas irqpin controllers have 4-bit sense fields, however, some
> have different widths. This patch adds a DT binding to optionally
> specify such non-standard values.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
> 
> v3: move the code to a common location, where device configuration
> parameters are retrieved
> 
>  .../interrupt-controller/renesas,intc-irqpin.txt   |   13 +++++++++++++
>  drivers/irqchip/irq-renesas-intc-irqpin.c          |    4 ++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.
> txt
> 
> diff --git
> a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpi
> n.txt
> b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpi
> n.txt new file mode 100644
> index 0000000..c6f09b7
> --- /dev/null
> +++
> b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpi
> n.txt @@ -0,0 +1,13 @@
> +DT bindings for the R-/SH-Mobile irqpin controller
> +
> +Required properties:
> +
> +- compatible: has to be "renesas,intc-irqpin"
> +- #interrupt-cells: has to be <2>
> +
> +Optional properties:
> +
> +- any properties, listed in interrupts.txt in this directory, and any
> standard
> +  resource allocation properties
> +- sense-bitfield-width: width of a single sense bitfield in the SENSE
> register,
> +  if different from the default 4 bits

Wouldn't it be better to define per-SoC compatible strings, and infer the 
sense bitfield width from that ?

> diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c
> b/drivers/irqchip/irq-renesas-intc-irqpin.c index 5a68e5a..4aca1b2 100644
> --- a/drivers/irqchip/irq-renesas-intc-irqpin.c
> +++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
> @@ -18,6 +18,7 @@
>   */
> 
>  #include <linux/init.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/interrupt.h>
> @@ -349,6 +350,9 @@ static int intc_irqpin_probe(struct platform_device
> *pdev) /* deal with driver instance configuration */
>  	if (pdata)
>  		memcpy(&p->config, pdata, sizeof(*pdata));
> +	else
> +		of_property_read_u32(pdev->dev.of_node, "sense-bitfield-width",
> +				     &p->config.sense_bitfield_width);
>  	if (!p->config.sense_bitfield_width)
>  		p->config.sense_bitfield_width = 4; /* default to 4 bits */
-- 
Regards,

Laurent Pinchart
