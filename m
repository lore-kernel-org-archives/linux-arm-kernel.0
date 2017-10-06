From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 06 Oct 2017 14:19:37 +0200
Subject: [PATCH 03/16] serial: mvebu-uart: use driver name when requesting
 an interrupt
In-Reply-To: <20171006101344.15590-4-miquel.raynal@free-electrons.com> (Miquel
 Raynal's message of "Fri, 6 Oct 2017 12:13:31 +0200")
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
 <20171006101344.15590-4-miquel.raynal@free-electrons.com>
Message-ID: <87tvzcfoyu.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On ven., oct. 06 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> From: Yehuda Yitschak <yehuday@marvell.com>
>
> Use the driver name when requesting an interrupt for consistency.
>
> Avoids possible confusion with DW8250 driver interrupt names in
> /proc/interrupts.
>
> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> ---
>  drivers/tty/serial/mvebu-uart.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 45b57c294d13..7e0a3e9fee15 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -90,6 +90,7 @@
>  #define MVEBU_NR_UARTS		1
>  
>  #define MVEBU_UART_TYPE		"mvebu-uart"
> +#define DRIVER_NAME		"mvebu_serial"
>  
>  static struct uart_port mvebu_uart_ports[MVEBU_NR_UARTS];
>  
> @@ -287,8 +288,8 @@ static int mvebu_uart_startup(struct uart_port *port)
>  	udelay(1);
>  	writel(CTRL_RX_INT, port->membase + UART_CTRL);
>  
> -	ret = request_irq(port->irq, mvebu_uart_isr, port->irqflags, "serial",
> -			  port);
> +	ret = request_irq(port->irq, mvebu_uart_isr, port->irqflags,
> +			  DRIVER_NAME, port);
>  	if (ret) {
>  		dev_err(port->dev, "failed to request irq\n");
>  		return ret;
> @@ -538,7 +539,7 @@ console_initcall(mvebu_uart_console_init);
>  
>  static struct uart_driver mvebu_uart_driver = {
>  	.owner			= THIS_MODULE,
> -	.driver_name		= "mvebu_serial",
> +	.driver_name		= DRIVER_NAME,
>  	.dev_name		= "ttyMV",
>  	.nr			= MVEBU_NR_UARTS,
>  #ifdef CONFIG_SERIAL_MVEBU_CONSOLE
> -- 
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
