From: horms@verge.net.au (Simon Horman)
Date: Mon, 17 Jun 2013 16:15:24 +0900
Subject: [PATCH v4] irqchip: renesas-intc-irqpin: DT binding for sense
 bitfield width
In-Reply-To: <Pine.LNX.4.64.1306131121230.31976@axis700.grange>
References: <Pine.LNX.4.64.1306131121230.31976@axis700.grange>
Message-ID: <20130617071524.GC22175@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 11:23:38AM +0200, Guennadi Liakhovetski wrote:
> Most Renesas irqpin controllers have 4-bit sense fields, however, some
> have different widths. This patch adds a DT binding to optionally
> specify such non-standard values.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Arnd, are you happy with this version?

> ---
> 
> v4: as suggested by Arnd, add a description for #interrupt-cells
> 
>  .../interrupt-controller/renesas,intc-irqpin.txt   |   14 ++++++++++++++
>  drivers/irqchip/irq-renesas-intc-irqpin.c          |    4 ++++
>  2 files changed, 18 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
> new file mode 100644
> index 0000000..66fcaf5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
> @@ -0,0 +1,14 @@
> +DT bindings for the R-/SH-Mobile irqpin controller
> +
> +Required properties:
> +
> +- compatible: has to be "renesas,intc-irqpin"
> +- #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
> +  interrupts.txt in this directory
> +
> +Optional properties:
> +
> +- any properties, listed in interrupts.txt, and any standard resource allocation
> +  properties
> +- sense-bitfield-width: width of a single sense bitfield in the SENSE register,
> +  if different from the default 4 bits
> diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
> index 5a68e5a..4aca1b2 100644
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
> @@ -349,6 +350,9 @@ static int intc_irqpin_probe(struct platform_device *pdev)
>  	/* deal with driver instance configuration */
>  	if (pdata)
>  		memcpy(&p->config, pdata, sizeof(*pdata));
> +	else
> +		of_property_read_u32(pdev->dev.of_node, "sense-bitfield-width",
> +				     &p->config.sense_bitfield_width);
>  	if (!p->config.sense_bitfield_width)
>  		p->config.sense_bitfield_width = 4; /* default to 4 bits */
>  
> -- 
> 1.7.2.5
> 
