From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 09 Mar 2012 08:24:10 -0700
Subject: [PATCH v2 1/7] serial: pxa: add OF support
In-Reply-To: <1330950111-30797-2-git-send-email-haojian.zhuang@marvell.com>
References: <1330950111-30797-1-git-send-email-haojian.zhuang@marvell.com>
 <1330950111-30797-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20120309152410.4E59C3E0908@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  5 Mar 2012 20:21:45 +0800, Haojian Zhuang <haojian.zhuang@marvell.com> wrote:
> Parse uart device id from alias in DTS file.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/tty/serial/pxa.c |   65 +++++++++++++++++++++++++++++++++++++--------
>  1 files changed, 53 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index 5c8e3bb..a71855b 100644
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
> @@ -44,6 +45,8 @@
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  
> +#define PXA_NAME_LEN		8
> +
>  struct uart_pxa_port {
>  	struct uart_port        port;
>  	unsigned char           ier;
> @@ -781,6 +784,39 @@ static const struct dev_pm_ops serial_pxa_pm_ops = {
>  };
>  #endif
>  
> +static struct of_device_id serial_pxa_dt_ids[] = {
> +	{ .compatible = "mrvl,pxa-uart", },
> +	{ .compatible = "mrvl,mmp-uart", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, serial_pxa_dt_ids);
> +
> +#ifdef CONFIG_OF
> +static int serial_pxa_probe_dt(struct platform_device *pdev,
> +			       struct uart_pxa_port *sport)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	int ret;
> +
> +	if (!np)
> +		return 1;
> +
> +	ret = of_alias_get_id(np, "serial");
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> +		return ret;
> +	}
> +	sport->port.line = ret;
> +	return 0;
> +}
> +#else
> +static int serial_pxa_probe_dt(struct platform_device *pdev,
> +			       struct uart_pxa_port *sport)
> +{
> +	return 1;
> +}
> +#endif

Returning 1 on success is rather odd... see comment below.

> +
>  static int serial_pxa_probe(struct platform_device *dev)
>  {
>  	struct uart_pxa_port *sport;
> @@ -808,34 +844,37 @@ static int serial_pxa_probe(struct platform_device *dev)
>  	sport->port.irq = irqres->start;
>  	sport->port.fifosize = 64;
>  	sport->port.ops = &serial_pxa_pops;
> -	sport->port.line = dev->id;
>  	sport->port.dev = &dev->dev;
>  	sport->port.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
>  	sport->port.uartclk = clk_get_rate(sport->clk);
> -
> -	switch (dev->id) {
> -	case 0: sport->name = "FFUART"; break;
> -	case 1: sport->name = "BTUART"; break;
> -	case 2: sport->name = "STUART"; break;
> -	case 3: sport->name = "HWUART"; break;
> -	default:
> -		sport->name = "???";
> -		break;
> +	sport->name = kzalloc(PXA_NAME_LEN, GFP_KERNEL);

devm_kzalloc().  Then you don't need to unwind the allocation on failure.

> +	if (!sport->name) {
> +		ret = -ENOMEM;
> +		goto err_clk;
>  	}
>  
> +	ret = serial_pxa_probe_dt(dev, sport);
> +	if (ret > 0)
> +		sport->port.line = dev->id;
> +	else if (ret < 0)
> +		goto err_clk;
> +	snprintf(sport->name, PXA_NAME_LEN - 1, "UART%d", sport->port.line + 1);

returning a -/0/+ value from serial_pxa_probe_dt() is rather odd.  It's easier
to follow code which sticks to the convention of <0 for error, 0 for success.
I would do:

	sport->port.line = dev->id;
	ret = serial_pxa_probe_dt(dev, sport);
	if (ret < 0)
		goto err_clk;

Then serial_pxa_probe_dt() can return an error code on failure, or 0 on
success or no-devicetree.


> +
>  	sport->port.membase = ioremap(mmres->start, resource_size(mmres));
>  	if (!sport->port.membase) {
>  		ret = -ENOMEM;
> -		goto err_clk;
> +		goto err_name;
>  	}
>  
> -	serial_pxa_ports[dev->id] = sport;
> +	serial_pxa_ports[sport->port.line] = sport;
>  
>  	uart_add_one_port(&serial_pxa_reg, &sport->port);
>  	platform_set_drvdata(dev, sport);
>  
>  	return 0;
>  
> + err_name:
> +	kfree(sport->name);
>   err_clk:
>  	clk_put(sport->clk);
>   err_free:
> @@ -850,6 +889,7 @@ static int serial_pxa_remove(struct platform_device *dev)
>  	platform_set_drvdata(dev, NULL);
>  
>  	uart_remove_one_port(&serial_pxa_reg, &sport->port);
> +	kfree(sport->name);
>  	clk_put(sport->clk);
>  	kfree(sport);
>  
> @@ -866,6 +906,7 @@ static struct platform_driver serial_pxa_driver = {
>  #ifdef CONFIG_PM
>  		.pm	= &serial_pxa_pm_ops,
>  #endif
> +		.of_match_table = serial_pxa_dt_ids,

	.of_match_table = of_match_ptr(serial_pxa_dt_ids),

Otherwise looks great to me.

g.
