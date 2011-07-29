From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 29 Jul 2011 10:45:39 -0600
Subject: [PATCH v2 4/7] tty: serial: support device tree in pxa
In-Reply-To: <1311835293-18125-5-git-send-email-haojian.zhuang@marvell.com>
References: <1311835293-18125-1-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-2-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-3-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-4-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110729164539.GM11164@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2011 at 02:41:30PM +0800, Haojian Zhuang wrote:
> Support both normal platform driver and device tree driver in serial pxa.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/tty/serial/pxa.c |   51 ++++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 45 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index 4302e6e..dadd201 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -36,6 +36,7 @@
>  #include <linux/circ_buf.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
> @@ -54,6 +55,8 @@ struct uart_pxa_port {
>  	char			*name;
>  };
>  
> +#define PXA_SERIAL_NR		4
> +
>  static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
>  {
>  	offset <<= 2;
> @@ -593,7 +596,7 @@ serial_pxa_type(struct uart_port *port)
>  	return up->name;
>  }
>  
> -static struct uart_pxa_port *serial_pxa_ports[4];
> +static struct uart_pxa_port *serial_pxa_ports[PXA_SERIAL_NR];
>  static struct uart_driver serial_pxa_reg;
>  
>  #ifdef CONFIG_SERIAL_PXA_CONSOLE
> @@ -765,7 +768,10 @@ static int serial_pxa_probe(struct platform_device *dev)
>  {
>  	struct uart_pxa_port *sport;
>  	struct resource *mmres, *irqres;
> -	int ret;
> +	struct device_node *np = dev->dev.of_node;
> +	char name[32];
> +	unsigned int clk = 0, spd = 0;
> +	int ret, i;
>  
>  	mmres = platform_get_resource(dev, IORESOURCE_MEM, 0);
>  	irqres = platform_get_resource(dev, IORESOURCE_IRQ, 0);
> @@ -776,11 +782,39 @@ static int serial_pxa_probe(struct platform_device *dev)
>  	if (!sport)
>  		return -ENOMEM;
>  
> +#ifdef CONFIG_OF
> +	for (i = 0; i < PXA_SERIAL_NR; i++) {
> +		if (serial_pxa_ports[i] == NULL)
> +			break;
> +	}
> +	if (i >= PXA_SERIAL_NR) {
> +		pr_warn("can't find pxa serial port\n");
> +		return -ENODEV;
> +	}
> +
> +	if (of_property_read_u32(np, "clock-frequency", &clk)) {
> +		pr_warn("no clock-frequency property set\n");
> +		return -ENODEV;
> +	}
> +	if (of_property_read_u32(np, "current-speed", &spd) == 0)
> +		sport->port.custom_divisor = clk / (16 * spd);
> +
> +	sprintf(name, "pxa2xx-uart.%d", i);
> +	sport->clk = clk_get_sys(name, NULL);
> +	if (IS_ERR(sport->clk)) {
> +		ret = PTR_ERR(sport->clk);
> +		goto err_free;
> +	}
> +	sport->port.uartclk = clk;
> +#else
> +	i = dev->id;
>  	sport->clk = clk_get(&dev->dev, NULL);
>  	if (IS_ERR(sport->clk)) {
>  		ret = PTR_ERR(sport->clk);
>  		goto err_free;
>  	}
> +	sport->port.uartclk = clk_get_rate(sport->clk);
> +#endif

This means a kernel build can either support DT or non-DT, but not
both.  DT & non-DT booting are full supported with the same kernel
image, so don't do it this way.

Instead, check for the presence of an of_node.  If it is there, do the
DT parsing.  If now, still support the old method.

>  
>  	sport->port.type = PORT_PXA;
>  	sport->port.iotype = UPIO_MEM;
> @@ -788,12 +822,11 @@ static int serial_pxa_probe(struct platform_device *dev)
>  	sport->port.irq = irqres->start;
>  	sport->port.fifosize = 64;
>  	sport->port.ops = &serial_pxa_pops;
> -	sport->port.line = dev->id;
> +	sport->port.line = i;
>  	sport->port.dev = &dev->dev;
>  	sport->port.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
> -	sport->port.uartclk = clk_get_rate(sport->clk);
>  
> -	switch (dev->id) {
> +	switch (i) {
>  	case 0: sport->name = "FFUART"; break;
>  	case 1: sport->name = "BTUART"; break;
>  	case 2: sport->name = "STUART"; break;
> @@ -809,7 +842,7 @@ static int serial_pxa_probe(struct platform_device *dev)
>  		goto err_clk;
>  	}
>  
> -	serial_pxa_ports[dev->id] = sport;
> +	serial_pxa_ports[i] = sport;
>  
>  	uart_add_one_port(&serial_pxa_reg, &sport->port);
>  	platform_set_drvdata(dev, sport);
> @@ -836,6 +869,11 @@ static int serial_pxa_remove(struct platform_device *dev)
>  	return 0;
>  }
>  
> +static struct of_device_id __devinitdata of_serial_pxa_table[] = {
> +	{ .compatible = "mrvl,pxa270-serial", .data = (void *)PORT_PXA, },
> +	{},
> +};
> +
>  static struct platform_driver serial_pxa_driver = {
>          .probe          = serial_pxa_probe,
>          .remove         = serial_pxa_remove,
> @@ -843,6 +881,7 @@ static struct platform_driver serial_pxa_driver = {
>  	.driver		= {
>  	        .name	= "pxa2xx-uart",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_serial_pxa_table,
>  #ifdef CONFIG_PM
>  		.pm	= &serial_pxa_pm_ops,
>  #endif
> -- 
> 1.5.6.5
> 
