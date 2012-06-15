From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 15 Jun 2012 21:10:08 +0800
Subject: [PATCH v2 2/3] serial: mxs-auart: Allow device tree probing
In-Reply-To: <1339759950-5507-2-git-send-email-festevam@gmail.com>
References: <1339759950-5507-1-git-send-email-festevam@gmail.com>
 <1339759950-5507-2-git-send-email-festevam@gmail.com>
Message-ID: <20120615131006.GK31565@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2012 at 08:32:29AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Allow device tree probing.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: <linux-serial@vger.kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Merged patches 3 and 5 from v1 into this one
>  .../bindings/tty/serial/fsl-mxs-auart.txt          |   13 +++++
>  drivers/tty/serial/mxs-auart.c                     |   55 +++++++++++++++++++-
>  2 files changed, 67 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
> 
> diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
> new file mode 100644
> index 0000000..1b28b1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
> @@ -0,0 +1,13 @@
> +* Freescale MXS Application UART (AUART)
> +
> +Required properties:
> +- compatible : Should be "fsl,mxs-uart"

The compatible property is to specify the compatibility between
different versions of the hardware block.  One general way to do that
is using SoC name to specific the version.  We know the auart block
works for both imx23 and imx28 without any tweaking in the driver,
so we should have something like the following to tell that the auart
block used on imx28 is completely compatible with the one on imx23.

static struct of_device_id mxs_auart_dt_ids[] = {
	{ .compatible = "fsl,imx23-auart", },
	{ /* sentinel */ }
};

imx23.dtsi:

auart0: serial at 8006a000 {
	compatible = "fsl,imx23-auart";
	...
};

imx28.dtsi:

auart0: serial at 8006a000 {
	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
	...
};

> +- reg : Address and length of the register set for the device
> +- interrupts : Should contain the auart interrupt

The binding relies on alias to work with the driver, so we may need to
note it here.  See Documentation/devicetree/bindings/gpio/gpio-mxs.txt
for example.

> +
> +Example:
> +auart0: serial at 8006a000 {
> +	compatible = "fsl,mxs-auart";
> +	reg = <0x8006a000 0x2000>;
> +	interrupts = <112 70 71>;
> +};
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index ec56d83..21e2ce7 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -33,6 +33,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/of_device.h>
>  
>  #include <asm/cacheflush.h>
>  
> @@ -675,6 +676,44 @@ static struct uart_driver auart_driver = {
>  #endif
>  };
>  
> +#ifdef CONFIG_OF
> +/*
> + * This function returns 1 if pdev isn't a device instatiated by dt, 0 if it
> + * could successfully get all information from dt or a negative errno.
> + */
> +static int serial_mxs_probe_dt(struct mxs_auart_port *s,
> +		struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	int ret;
> +
> +	if (!np)
> +		/* no device tree device */
> +		return 1;
> +
> +	ret = of_alias_get_id(np, "serial");
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get alias id: %d\n", ret);
> +		return ret;
> +	}
> +	s->port.line = ret;
> +
> +	return 0;
> +}
> +#else
> +static inline int serial_mxs_probe_dt(struct mxs_auart_port *s,
> +		struct platform_device *pdev)
> +{
> +	return 1;
> +}
> +#endif
> +
> +static void mxs_auart_probe_pdev(struct mxs_auart_port *s,
> +		struct platform_device *pdev)
> +{
> +	s->port.line = pdev->id < 0 ? 0 : pdev->id;
> +}
> +
Do we really need such a simple function?

>  static int __devinit mxs_auart_probe(struct platform_device *pdev)
>  {
>  	struct mxs_auart_port *s;
> @@ -689,6 +728,14 @@ static int __devinit mxs_auart_probe(struct platform_device *pdev)
>  		goto out;
>  	}
>  
> +	ret = serial_mxs_probe_dt(s, pdev);
> +	if (ret > 0)
> +		mxs_auart_probe_pdev(s, pdev);
> +	else if (ret < 0) {
> +		ret = -EINVAL;

Why changing the error code here?

> +		goto out_free;
> +	}
> +
>  	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>  	if (IS_ERR(pinctrl)) {
>  		ret = PTR_ERR(pinctrl);
> @@ -711,7 +758,6 @@ static int __devinit mxs_auart_probe(struct platform_device *pdev)
>  	s->port.membase = ioremap(r->start, resource_size(r));
>  	s->port.ops = &mxs_auart_ops;
>  	s->port.iotype = UPIO_MEM;
> -	s->port.line = pdev->id < 0 ? 0 : pdev->id;
>  	s->port.fifosize = 16;
>  	s->port.uartclk = clk_get_rate(s->clk);
>  	s->port.type = PORT_IMX;
> @@ -769,12 +815,19 @@ static int __devexit mxs_auart_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static struct of_device_id mxs_auart_dt_ids[] = {
> +	{.compatible = "fsl,mxs-auart", },

Nit: put a space after "{".

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mxs_auart_dt_ids);
> +
>  static struct platform_driver mxs_auart_driver = {
>  	.probe = mxs_auart_probe,
>  	.remove = __devexit_p(mxs_auart_remove),
>  	.driver = {
>  		.name = "mxs-auart",
>  		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(mxs_auart_dt_ids),

As Marek already pointed out, we have ARCH_MXS select USE_OF to have
CONFIG_OF always enabled, the of_match_ptr wrapper is not really needed
here.

>  	},
>  };
>  
> -- 
> 1.7.1
> 

-- 
Regards,
Shawn
