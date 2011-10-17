From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Oct 2011 22:17:25 +0200
Subject: [PATCH] imx: add polled io uart methods
In-Reply-To: <1318821721-11965-2-git-send-email-compnerd@compnerd.org>
References: <CAOMZO5CdVqCu8VvaYmxhDW-anG2NQt8Hn3CnM_a48g9V0q9bmA@mail.gmail.com>
	<1318821721-11965-1-git-send-email-compnerd@compnerd.org>
	<1318821721-11965-2-git-send-email-compnerd@compnerd.org>
Message-ID: <20111017201725.GG18141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 16, 2011 at 08:22:01PM -0700, Saleem Abdulrasool wrote:
> These methods are invoked if the iMX uart is used in conjuction with kgdb during
> early boot.  In order to access the UART without the interrupts, the kernel uses
> the basic polling methods for IO with the device.  With these methods
> implemented, it is now possible to enable kgdb during early boot over serial.
> 
> Signed-off-by: Saleem Abdulrasool <compnerd@compnerd.org>
> ---
>  drivers/tty/serial/imx.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 77 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 7e91b3d..4fcf9ca 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -102,6 +102,7 @@
>  #define  UCR2_STPB       (1<<6)	 /* Stop */
>  #define  UCR2_WS         (1<<5)	 /* Word size */
>  #define  UCR2_RTSEN      (1<<4)	 /* Request to send interrupt enable */
> +#define  UCR2_ATEN       (1<<3)  /* Aging Timer Enable */
>  #define  UCR2_TXEN       (1<<2)	 /* Transmitter enabled */
>  #define  UCR2_RXEN       (1<<1)	 /* Receiver enabled */
>  #define  UCR2_SRST 	 (1<<0)	 /* SW reset */
> @@ -1075,6 +1076,77 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
>  	return ret;
>  }
>  
> +
> +#if defined(CONFIG_CONSOLE_POLL)
> +static int imx_poll_get_char(struct uart_port *port)
> +{
> +	volatile unsigned int status;
> +	unsigned int cr1, cr2, cr3;
> +	unsigned char c;
> +
> +	/* save control registers */
> +	cr1 = readl(port->membase + UCR1);
> +	cr2 = readl(port->membase + UCR2);
> +	cr3 = readl(port->membase + UCR3);
> +
> +	/* disable interrupts */
> +	writel(UCR1_UARTEN, port->membase + UCR1);
> +	writel(cr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
> +	       port->membase + UCR2);
> +	writel(cr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN), port->membase + UCR3);
> +
> +	/* poll */
> +	do {
> +		status = readl(port->membase + USR2);
> +	} while (~status & USR2_RDR);
> +
> +	/* read */
> +	c = readl(port->membase + URXD0);
> +
> +	/* restore control registers */
> +	writel(cr1, port->membase + UCR1);
> +	writel(cr2, port->membase + UCR2);
> +	writel(cr3, port->membase + UCR3);
> +
> +	return (c & 0xff);
> +}
> +
> +static void imx_poll_put_char(struct uart_port *port, unsigned char c)
> +{
> +	volatile unsigned int status;
> +	unsigned int cr1, cr2, cr3;
> +
> +	/* save control registers */
> +	cr1 = readl(port->membase + UCR1);
> +	cr2 = readl(port->membase + UCR2);
> +	cr3 = readl(port->membase + UCR3);
> +
> +	/* disable interrupts */
> +	writel(UCR1_UARTEN, port->membase + UCR1);
> +	writel(cr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
> +	       port->membase + UCR2);
> +	writel(cr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN), port->membase + UCR3);
> +
> +	/* drain */
> +	do {
> +		status = readl(port->membase + USR1);
> +	} while (~status & USR1_TRDY);
> +
> +	/* write */
> +	writel(c, port->membase + URTX0);
> +
> +	/* flush */
> +	do {
> +		status = readl(port->membase + USR2);
> +	} while (~status & USR2_TXDC);
> +
> +	/* restore control registers */
> +	writel(cr1, port->membase + UCR1);
> +	writel(cr2, port->membase + UCR2);
> +	writel(cr3, port->membase + UCR3);
> +}

We should factor out the uart save/restore functionality instead of
having the same code three times in the driver. I'm thinking about:

imx_console_mode(struct uart_port *port, u32 *ucr1, u32 *ucr2, u32 *ucr2);
imx_console_restore(struct uart_port *port, u32 ucr1, u32 ucr2, u32 ucr3);

These functions could correctly handle ucr3 (which is missing in
mainline) and i.MX1 (which is missing in your patch).

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
