From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 8 Oct 2015 11:01:48 +0200
Subject: [PATCH] serial: atmel: fix compiler warning on address cast
In-Reply-To: <1444064452-12285-1-git-send-email-andre.przywara@arm.com>
References: <1444064452-12285-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20151008090148.GE3485@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2015 at 18:00:52 +0100, Andre Przywara wrote :
> Turning on KVM and LPAE support on top of a multi_v7_defconfig will
> produce a compiler warning in the Atmel serial driver:
> drivers/tty/serial/atmel_serial.c: In function 'atmel_verify_port':
> drivers/tty/serial/atmel_serial.c:2299:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   if ((void *)port->mapbase != ser->iomem_base)
>       ^
> 
> Fix that by using the cast on the right hand side instead, as similar
> code already does in other drivers.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/tty/serial/atmel_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index cd30a45..28039ce 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2296,7 +2296,7 @@ static int atmel_verify_port(struct uart_port *port, struct serial_struct *ser)
>  		ret = -EINVAL;
>  	if (port->uartclk / 16 != ser->baud_base)
>  		ret = -EINVAL;
> -	if ((void *)port->mapbase != ser->iomem_base)
> +	if (port->mapbase != (unsigned long)ser->iomem_base)
>  		ret = -EINVAL;
>  	if (port->iobase != ser->port)
>  		ret = -EINVAL;
> -- 
> 2.5.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
