From: horms@verge.net.au (Simon Horman)
Date: Sat, 25 May 2013 09:39:50 +0900
Subject: [PATCH 1/2] ARM: shmobile: irqpin: add a DT property to enable
 masking on parent
In-Reply-To: <Pine.LNX.4.64.1305241109530.1090@axis700.grange>
References: <Pine.LNX.4.64.1305241109530.1090@axis700.grange>
Message-ID: <20130525003950.GA4476@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 11:13:03AM +0200, Guennadi Liakhovetski wrote:
> To disable spurious interrupts, that get triggered on certain hardware, the
> irqpin driver masks them on the parent interrupt controller. To specify
> such broken devices a .control_parent parameter can be provided in the
> platform data. In the DT case we need a property, to do the same.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> These two patches simply split the earlier "ARM: shmobile: irqpin: fix 
> handling of spurious interrupts in DT case" patch into two parts. 
> Otherwise no change.

Magnus,

could you please review this series?

> 
>  .../interrupt-controller/renesas,intc-irqpin.txt   |    2 ++
>  drivers/irqchip/irq-renesas-intc-irqpin.c          |    7 +++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
> index c6f09b7..152b10a 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
> @@ -11,3 +11,5 @@ Optional properties:
>    resource allocation properties
>  - sense-bitfield-width: width of a single sense bitfield in the SENSE register,
>    if different from the default 4 bits
> +- control-parent: disable and enable interrupts on the parent interrupt
> +  controller, needed for some broken implementations
> diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
> index 4aca1b2..82cec63 100644
> --- a/drivers/irqchip/irq-renesas-intc-irqpin.c
> +++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
> @@ -348,11 +348,14 @@ static int intc_irqpin_probe(struct platform_device *pdev)
>  	}
>  
>  	/* deal with driver instance configuration */
> -	if (pdata)
> +	if (pdata) {
>  		memcpy(&p->config, pdata, sizeof(*pdata));
> -	else
> +	} else {
>  		of_property_read_u32(pdev->dev.of_node, "sense-bitfield-width",
>  				     &p->config.sense_bitfield_width);
> +		p->config.control_parent = of_property_read_bool(pdev->dev.of_node,
> +								 "control-parent");
> +	}
>  	if (!p->config.sense_bitfield_width)
>  		p->config.sense_bitfield_width = 4; /* default to 4 bits */
>  
> -- 
> 1.7.2.5
> 
