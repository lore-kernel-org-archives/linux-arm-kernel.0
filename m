From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 19 Jul 2011 13:40:10 -0600
Subject: [PATCH 4/7] tty: serial: support device tree in pxa
In-Reply-To: <1311042290-20253-5-git-send-email-haojian.zhuang@marvell.com>
References: <2011071901>
	<1311042290-20253-1-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-2-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-3-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-4-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110719194010.GI6848@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 10:24:47AM +0800, Haojian Zhuang wrote:
> Support both normal platform driver and device tree driver in serial pxa.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/tty/serial/Kconfig     |    4 +-
>  drivers/tty/serial/of_serial.c |   12 +++++
>  drivers/tty/serial/pxa.c       |   93 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/serial_pxa.h     |   17 +++++++
>  4 files changed, 122 insertions(+), 4 deletions(-)
>  create mode 100644 include/linux/serial_pxa.h
> 

serial_pxa is already a platform_driver.  Instead of modifying
of_serial, an of_match_table should be added to this driver and it
should decode the DT data inside the existing probe hook.

No need to create all of this extra infrastructure.

g.

> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 636144c..3f75e0d 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -663,6 +663,8 @@ config SERIAL_MPSC_CONSOLE
>  config SERIAL_PXA
>  	bool "PXA serial port support"
>  	depends on ARCH_PXA || ARCH_MMP
> +	select SERIAL_OF_PLATFORM
> +	select SERIAL_CORE_CONSOLE
>  	select SERIAL_CORE
>  	help
>  	  If you have a machine based on an Intel XScale PXA2xx CPU you
> @@ -1340,7 +1342,7 @@ config SERIAL_NETX_CONSOLE
>  config SERIAL_OF_PLATFORM
>  	tristate "Serial port on Open Firmware platform bus"
>  	depends on OF
> -	depends on SERIAL_8250 || SERIAL_OF_PLATFORM_NWPSERIAL
> +	depends on SERIAL_8250 || SERIAL_OF_PLATFORM_NWPSERIAL || SERIAL_PXA
>  	help
>  	  If you have a PowerPC based system that has serial ports
>  	  on a platform specific bus, you should enable this option.
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
> index e65f1e8..83e07fb 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/serial_core.h>
>  #include <linux/serial_8250.h>
> +#include <linux/serial_pxa.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> @@ -126,6 +127,11 @@ static int __devinit of_platform_serial_probe(struct platform_device *ofdev)
>  		ret = nwpserial_register_port(&port);
>  		break;
>  #endif
> +#ifdef CONFIG_SERIAL_PXA
> +	case PORT_PXA:
> +		ret = serial_pxa_register_port(&port);
> +		break;
> +#endif
>  	default:
>  		/* need to add code for these */
>  	case PORT_UNKNOWN:
> @@ -163,6 +169,11 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
>  		nwpserial_unregister_port(info->line);
>  		break;
>  #endif
> +#ifdef CONFIG_SERIAL_PXA
> +	case PORT_PXA:
> +		serial_pxa_unregister_port(info->line);
> +		break;
> +#endif
>  	default:
>  		/* need to add code for these */
>  		break;
> @@ -186,6 +197,7 @@ static struct of_device_id __devinitdata of_platform_serial_table[] = {
>  	{ .compatible = "ibm,qpace-nwp-serial",
>  		.data = (void *)PORT_NWPSERIAL, },
>  #endif
> +	{ .compatible = "mrvl,pxa270-serial", .data = (void *)PORT_PXA, },
>  	{ .type = "serial",         .data = (void *)PORT_UNKNOWN, },
>  	{ /* end of list */ },
>  };
> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index 4302e6e..8f4d538 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -36,10 +36,12 @@
>  #include <linux/circ_buf.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
>  #include <linux/serial_core.h>
> +#include <linux/serial_pxa.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> @@ -54,6 +56,10 @@ struct uart_pxa_port {
>  	char			*name;
>  };
>  
> +#define PXA_SERIAL_NR		4
> +
> +static DEFINE_MUTEX(serial_pxa_mutex);
> +
>  static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
>  {
>  	offset <<= 2;
> @@ -346,8 +352,6 @@ static int serial_pxa_startup(struct uart_port *port)
>  	else
>  		up->mcr = 0;
>  
> -	up->port.uartclk = clk_get_rate(up->clk);
> -
>  	/*
>  	 * Allocate the IRQ
>  	 */
> @@ -593,7 +597,7 @@ serial_pxa_type(struct uart_port *port)
>  	return up->name;
>  }
>  
> -static struct uart_pxa_port *serial_pxa_ports[4];
> +static struct uart_pxa_port *serial_pxa_ports[PXA_SERIAL_NR];
>  static struct uart_driver serial_pxa_reg;
>  
>  #ifdef CONFIG_SERIAL_PXA_CONSOLE
> @@ -761,6 +765,89 @@ static const struct dev_pm_ops serial_pxa_pm_ops = {
>  };
>  #endif
>  
> +static int serial_pxa_port_size(struct uart_pxa_port *sport)
> +{
> +	return 8 << sport->port.regshift;
> +}
> +
> +int serial_pxa_register_port(struct uart_port *port)
> +{
> +	struct uart_pxa_port *sport = NULL;
> +	char name[32];
> +	int i, ret;
> +
> +	mutex_lock(&serial_pxa_mutex);
> +	for (i = 0; i < PXA_SERIAL_NR; i++) {
> +		if (serial_pxa_ports[i] != NULL)
> +			continue;
> +		sport = kzalloc(sizeof(struct uart_pxa_port), GFP_KERNEL);
> +		if (!sport) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		switch (i) {
> +		case 0: sport->name = "FFUART"; break;
> +		case 1: sport->name = "BTUART"; break;
> +		case 2: sport->name = "STUART"; break;
> +		case 3: sport->name = "HWUART"; break;
> +		default:
> +			sport->name = "???";
> +			break;
> +		}
> +		break;
> +	}
> +	if (i >= PXA_SERIAL_NR) {
> +		pr_warn("can't find pxa serial port\n");
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	sprintf(name, "pxa2xx-uart.%d", i);
> +	sport->clk = clk_get_sys(name, NULL);
> +	if (IS_ERR(sport->clk)) {
> +		ret = PTR_ERR(sport->clk);
> +		goto out_clk;
> +	}
> +	memcpy(&sport->port, port, sizeof(struct uart_port));
> +	sport->port.line = i;
> +	sport->port.fifosize = 64;
> +	sport->port.ops = &serial_pxa_pops;
> +
> +	sport->port.membase = ioremap(sport->port.mapbase,
> +				serial_pxa_port_size(sport));
> +	if (!sport->port.membase) {
> +		ret = -ENOMEM;
> +		goto out_membase;
> +	}
> +
> +	serial_pxa_ports[i] = sport;
> +
> +	uart_add_one_port(&serial_pxa_reg, &sport->port);
> +	mutex_unlock(&serial_pxa_mutex);
> +
> +	return sport->port.line;
> +
> +out_membase:
> +	clk_put(sport->clk);
> +out_clk:
> +	kfree(sport);
> +out:
> +	mutex_unlock(&serial_pxa_mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL(serial_pxa_register_port);
> +
> +void serial_pxa_unregister_port(int line)
> +{
> +	struct uart_pxa_port *sport = serial_pxa_ports[line];
> +
> +	mutex_lock(&serial_pxa_mutex);
> +	uart_remove_one_port(&serial_pxa_reg, &sport->port);
> +	sport->port.type = PORT_UNKNOWN;
> +	clk_put(sport->clk);
> +	mutex_unlock(&serial_pxa_mutex);
> +}
> +
>  static int serial_pxa_probe(struct platform_device *dev)
>  {
>  	struct uart_pxa_port *sport;
