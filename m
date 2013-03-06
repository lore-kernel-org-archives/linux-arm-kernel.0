From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 06 Mar 2013 13:10:55 +0100
Subject: [PATCH v6 1/3] serial: sh-sci: Add OF support
In-Reply-To: <1362569437-11133-1-git-send-email-hechtb+renesas@gmail.com>
References: <1362569437-11133-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <9335181.JoypQftkI4@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bastian,

Thanks for the patch.

On Wednesday 06 March 2013 12:30:35 Bastian Hecht wrote:
> We add the capabilty to probe Renesas SCI devices using Device Tree setup.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> Reviewed-by: Paul Mundt <lethal@linux-sh.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v6:
> putting it all together: I posted v5 as an incremental patch - here
> the full version based on Simon Horman's tree topic/intc-of.
> 
> I will post another incremental version as well.
> 
> - rename sci at xxxxxxxx to serial at xxxxxxxx
> - stick to scbrr-algorithm
> 
>  .../bindings/tty/serial/renesas,sci-serial.txt     |   47 +++++++
>  drivers/tty/serial/sh-sci.c                        |  146
> +++++++++++++++++++- include/linux/serial_sci.h                         |  
>  4 +
>  3 files changed, 193 insertions(+), 4 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
> 
> diff --git
> a/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
> b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt new
> file mode 100644
> index 0000000..d80039e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
> @@ -0,0 +1,47 @@
> +* Renesas SH-Mobile Serial Communication Interface
> +
> +Required properties:
> +- compatible : Should be "renesas,sci-<port type>-uart", where <port type>
> is +  "sci", "scif", "irda", "scifa", "scifb"
> +  or for legacy devices
> +  "sh2_scif_fifodata", "sh3_scif", "sh4_scif", "sh4_scif_no_scsptr",
> +  "sh4_scif_fifodata", "sh7705_scif".
> +- reg : Address and length of the register set for the device
> +- interrupts : Should contain the following IRQs in this order:
> +	ERI: receive-error interrupt
> +	RXI: receive-FIFO-data-full interrupt
> +	TXI: transmit-FIFO-data-empty interrupt
> +	BRI: break reception interrupt
> +- interrupt-names: The IRQ names "eri", "rxi", "txi" and "bri".
> +- cell-index : The device id.
> +- renesas,scscr : Should contain a bitfield used by the Serial Control
> Register.
> +  b7 = SCSCR_TIE
> +  b6 = SCSCR_RIE
> +  b5 = SCSCR_TE
> +  b4 = SCSCR_RE
> +  b3 = SCSCR_REIE
> +  b2 = SCSCR_TOIE
> +  b1 = SCSCR_CKE1
> +  b0 = SCSCR_CKE0

What is that for exactly ?

> +- renesas,scbrr-algorithm : Choose an algorithm ID for the baud rate
> generator.
> +  1 = SCBRR_ALGO_1 ((clk + 16 * bps) / (16 * bps) - 1)
> +  2 = SCBRR_ALGO_2 ((clk + 16 * bps) / (32 * bps) - 1)
> +  3 = SCBRR_ALGO_3 (((clk * 2) + 16 * bps) / (16 * bps) - 1)
> +  4 = SCBRR_ALGO_4 (((clk * 2) + 16 * bps) / (32 * bps) - 1)
> +  5 = SCBRR_ALGO_5 (((clk * 1000 / 32) / bps) - 1)

Isn't it a property specific to our implementation of the driver instead of a 
hardware property ? How is one supposed to select the right algorithm ?

> +Optional properties:
> +- renesas,autoconf : Set if device is capable of auto configuration.
> +
> +Example:
> +	serial at e6c50000 {
> +		compatible = "renesas,sci-scifa-uart";
> +		interrupt-parent = <&intca>;
> +		reg = <0xe6c50000 0x100>;
> +		interrupts = <0x0c20>, <0x0c20>, <0x0c20>, <0x0c20>;
> +		interrupt-names = "eri", "rxi", "txi", "bri";
> +		cell-index = <1>;
> +		renesas,scscr = <0x30>;
> +		renesas,scbrr-algorithm = <4>;
> +		renesas,autoconf;
> +	};
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 6147756..03bb740 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -52,6 +52,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/gpio.h>
> +#include <linux/of.h>
> 
>  #ifdef CONFIG_SUPERH
>  #include <asm/sh_bios.h>
> @@ -2353,6 +2354,131 @@ static int sci_remove(struct platform_device *dev)
>  	return 0;
>  }
> 
> +static const struct of_device_id of_sci_match[] = {
> +	{ .compatible = "renesas,sci-sci-uart",
> +		.data = (void *)SCIx_SCI_REGTYPE },
> +	{ .compatible = "renesas,sci-scif-uart",
> +		.data = (void *)SCIx_SH4_SCIF_REGTYPE, },
> +	{ .compatible = "renesas,sci-irda-uart",
> +		.data = (void *)SCIx_IRDA_REGTYPE },
> +	{ .compatible = "renesas,sci-scifa-uart",
> +		.data = (void *)SCIx_SCIFA_REGTYPE },
> +	{ .compatible = "renesas,sci-scifb-uart",
> +		.data = (void *)SCIx_SCIFB_REGTYPE },
> +	{ .compatible = "renesas,sci-sh2_scif_fifodata-uart",
> +		.data = (void *)SCIx_SH2_SCIF_FIFODATA_REGTYPE },
> +	{ .compatible = "renesas,sci-sh3_scif-uart",
> +		.data = (void *)SCIx_SH3_SCIF_REGTYPE },
> +	{ .compatible = "renesas,sci-sh4_scif-uart",
> +		.data = (void *)SCIx_SH4_SCIF_REGTYPE },
> +	{ .compatible = "renesas,sci-sh4_scif_no_scsptr-uart",
> +		.data = (void *)SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE },
> +	{ .compatible = "renesas,sci-sh4_scif_fifodata-uart",
> +		.data = (void *)SCIx_SH4_SCIF_FIFODATA_REGTYPE },
> +	{ .compatible = "renesas,sci-sh7705_scif-uart",
> +		.data = (void *)SCIx_SH7705_SCIF_REGTYPE },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_sci_match);
> +
> +static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
> +								int *dev_id)
> +{
> +	struct plat_sci_port *p;
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *match;
> +	struct resource *res;
> +	const __be32 *prop;
> +	int i, irq, val;
> +
> +	if (!IS_ENABLED(CONFIG_OF) || !np)
> +		return NULL;
> +
> +	match = of_match_node(of_sci_match, pdev->dev.of_node);
> +	if (!match || !match->data) {
> +		dev_err(&pdev->dev, "OF match error\n");
> +		return NULL;
> +	}
> +
> +	p = devm_kzalloc(&pdev->dev, sizeof(struct plat_sci_port), GFP_KERNEL);
> +	if (!p) {
> +		dev_err(&pdev->dev, "failed to allocate DT config data\n");
> +		return NULL;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "failed to get I/O memory\n");
> +		return NULL;
> +	}
> +	p->mapbase = res->start;
> +
> +	for (i = 0; i < SCIx_NR_IRQS; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0) {
> +			dev_err(&pdev->dev, "failed to get irq data %d\n", i);
> +			return NULL;
> +		}
> +		p->irqs[i] = irq;
> +	}
> +
> +	prop = of_get_property(np, "cell-index", NULL);
> +	if (!prop) {
> +		dev_err(&pdev->dev, "required DT prop cell-index missing\n");
> +		return NULL;
> +	}
> +	*dev_id = be32_to_cpup(prop);
> +
> +	prop = of_get_property(np, "renesas,scscr", NULL);
> +	if (!prop) {
> +		dev_err(&pdev->dev, "required DT prop scscr missing\n");
> +		return NULL;
> +	}
> +	p->scscr = be32_to_cpup(prop);
> +
> +	prop = of_get_property(np, "renesas,scbrr-algorithm", NULL);
> +	if (!prop) {
> +		dev_err(&pdev->dev, "required DT prop scbrr-algorithm missing\n");
> +		return NULL;
> +	}
> +	val = be32_to_cpup(prop);
> +	if (val <= SCBRR_ALGO_INVALID || val >= SCBRR_NR_ALGOS) {
> +		dev_err(&pdev->dev, "DT prop clock-algorithm out of range\n");
> +		return NULL;
> +	}
> +	p->scbrr_algo_id = val;
> +
> +	p->flags = UPF_IOREMAP;
> +	if (of_get_property(np, "renesas,autoconf", NULL))
> +		p->flags |= UPF_BOOT_AUTOCONF;
> +
> +	p->regtype = (unsigned int)match->data;
> +
> +	switch (p->regtype) {
> +	case SCIx_SCI_REGTYPE:
> +		p->type = PORT_SCI;
> +		break;
> +	case SCIx_SH4_SCIF_REGTYPE:
> +		p->type = PORT_SCIF;
> +		break;
> +	case SCIx_IRDA_REGTYPE:
> +		p->type = PORT_IRDA;
> +		break;
> +	case SCIx_SCIFA_REGTYPE:
> +		p->type = PORT_SCIFA;
> +		break;
> +	case SCIx_SCIFB_REGTYPE:
> +		p->type = PORT_SCIFB;
> +		break;
> +	default:
> +		/* legacy register sets default to PORT_SCIF */
> +		p->type = PORT_SCIF;
> +		break;
> +	}
> +
> +	return p;
> +}
> +
>  static int sci_probe_single(struct platform_device *dev,
>  				      unsigned int index,
>  				      struct plat_sci_port *p,
> @@ -2385,9 +2511,9 @@ static int sci_probe_single(struct platform_device
> *dev,
> 
>  static int sci_probe(struct platform_device *dev)
>  {
> -	struct plat_sci_port *p = dev->dev.platform_data;
> -	struct sci_port *sp = &sci_ports[dev->id];
> -	int ret;
> +	struct plat_sci_port *p;
> +	struct sci_port *sp;
> +	int ret, dev_id = dev->id;
> 
>  	/*
>  	 * If we've come here via earlyprintk initialization, head off to
> @@ -2397,9 +2523,20 @@ static int sci_probe(struct platform_device *dev)
>  	if (is_early_platform_device(dev))
>  		return sci_probe_earlyprintk(dev);
> 
> +	if (dev->dev.of_node)
> +		p = sci_parse_dt(dev, &dev_id);
> +	else
> +		p = dev->dev.platform_data;
> +
> +	if (!p) {
> +		dev_err(&dev->dev, "no setup data supplied\n");
> +		return -EINVAL;
> +	}
> +
> +	sp = &sci_ports[dev_id];
>  	platform_set_drvdata(dev, sp);
> 
> -	ret = sci_probe_single(dev, dev->id, p, sp);
> +	ret = sci_probe_single(dev, dev_id, p, sp);
>  	if (ret)
>  		return ret;
> 
> @@ -2451,6 +2588,7 @@ static struct platform_driver sci_driver = {
>  		.name	= "sh-sci",
>  		.owner	= THIS_MODULE,
>  		.pm	= &sci_dev_pm_ops,
> +		.of_match_table = of_match_ptr(of_sci_match),
>  	},
>  };
> 
> diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
> index eb763ad..857eec4 100644
> --- a/include/linux/serial_sci.h
> +++ b/include/linux/serial_sci.h
> @@ -11,11 +11,15 @@
>  #define SCIx_NOT_SUPPORTED	(-1)
> 
>  enum {
> +	SCBRR_ALGO_INVALID,
> +
>  	SCBRR_ALGO_1,		/* ((clk + 16 * bps) / (16 * bps) - 1) */
>  	SCBRR_ALGO_2,		/* ((clk + 16 * bps) / (32 * bps) - 1) */
>  	SCBRR_ALGO_3,		/* (((clk * 2) + 16 * bps) / (16 * bps) - 1) */
>  	SCBRR_ALGO_4,		/* (((clk * 2) + 16 * bps) / (32 * bps) - 1) */
>  	SCBRR_ALGO_5,		/* (((clk * 1000 / 32) / bps) - 1) */
> +
> +	SCBRR_NR_ALGOS,
>  };
> 
>  #define SCSCR_TIE	(1 << 7)
-- 
Regards,

Laurent Pinchart
