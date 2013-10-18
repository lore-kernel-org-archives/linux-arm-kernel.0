From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Oct 2013 11:19:16 -0500
Subject: [PATCH] serial: omap: Add support for optional wake-up interrupt
In-Reply-To: <20131017232820.GG15154@atomide.com>
References: <20131017232820.GG15154@atomide.com>
Message-ID: <20131018161916.GF18921@gimli>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 17, 2013 at 04:28:20PM -0700, Tony Lindgren wrote:
> With the recent pinctrl-single changes, omaps can treat
> wake-up events from deeper idle states as interrupts.
> 
> There's a separate "io chain" controller on most omaps
> that stays enabled when the device hits off-idle and the
> regular interrupt controller is powered off.
> 
> Let's add support for the optional second interrupt for
> wake-up events. And then serial-omap can manage the
> wake-up interrupt from it's runtime PM calls to avoid
> spurious interrupts during runtime.
> 
> Note that the wake interrupt is board specific as it
> uses the UART RX pin, and for omap3, there are six pin
> options for UART3 RX pin.
> 
> Also Note that the legacy platform based booting handles
> the wake-ups in the legacy mux driver and does not need to
> pass the wake-up interrupt to the driver.
> 
> And finally, to pass the wake-up interrupt in the dts file,
> either interrupt-map or the pending interrupts-extended
> property needs to be passed. It's probably best to use
> interrupts-extended when it's available.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

looks good, minor nits below

> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -39,6 +39,7 @@
>  #include <linux/irq.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/gpio.h>
>  #include <linux/of_gpio.h>
>  #include <linux/platform_data/serial-omap.h>
> @@ -134,7 +135,7 @@ struct uart_omap_port {
>  	struct uart_port	port;
>  	struct uart_omap_dma	uart_dma;
>  	struct device		*dev;
> -
> +	int			irqs[2];
>  	unsigned char		ier;
>  	unsigned char		lcr;
>  	unsigned char		mcr;
> @@ -176,6 +177,8 @@ struct uart_omap_port {
>  };
>  
>  #define to_uart_omap_port(p)	((container_of((p), struct uart_omap_port, port)))
> +#define omap_uartirq		(up->irqs[0])
> +#define omap_wakeirq		(up->irqs[1])
>  
>  static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>  
> @@ -214,10 +217,23 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
>  	return pdata->get_context_loss_count(up->dev);
>  }
>  
> +static inline void serial_omap_enable_wakeirq(struct uart_omap_port *up,
> +				       bool enable)
> +{
> +	if (!omap_wakeirq)
> +		return;

can we drop the pointless obfuscation ?

> @@ -689,15 +705,25 @@ static int serial_omap_startup(struct uart_port *port)
>  {
>  	struct uart_omap_port *up = to_uart_omap_port(port);
>  	unsigned long flags = 0;
> -	int retval;
> +	int i, retval;
>  
>  	/*
> -	 * Allocate the IRQ
> +	 * Allocate the IRQs, the second IRQ is the optional wakeirq
>  	 */
> -	retval = request_irq(up->port.irq, serial_omap_irq, up->port.irqflags,
> -				up->name, up);
> -	if (retval)
> -		return retval;
> +	for (i = 0; i < ARRAY_SIZE(up->irqs); i++) {
> +		if (i == 1 && !omap_wakeirq) {
> +			dev_info(up->port.dev, "no wakeirq for uart%d\n",
> +				 up->port.line);
> +			break;
> +		}
> +		retval = devm_request_irq(up->port.dev, up->irqs[i],
> +					  serial_omap_irq, up->port.irqflags,
> +					  up->name, up);

conversion to devm_* should be done as another patch, it seems.

> @@ -786,7 +813,10 @@ static void serial_omap_shutdown(struct uart_port *port)
>  
>  	pm_runtime_mark_last_busy(up->dev);
>  	pm_runtime_put_autosuspend(up->dev);
> -	free_irq(up->port.irq, up);
> +
> +	for (i = 0; i < ARRAY_SIZE(up->irqs); i++)
> +		if (up->irqs[i])
> +			devm_free_irq(up->port.dev, up->irqs[i], up);

do you need this at all if you're using devm_* ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/f6a8e99a/attachment-0001.sig>
