From: alan@linux.intel.com (Alan Cox)
Date: Sun, 7 Nov 2010 23:08:01 +0000
Subject: [PATCH 2/6 v2] serial: Add support for UART on VIA VT8500 and
	compatibles
In-Reply-To: <1289147348-31969-2-git-send-email-alchark@gmail.com>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<1289147348-31969-2-git-send-email-alchark@gmail.com>
Message-ID: <20101107230801.5214f353@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> +static void handle_rx(struct uart_port *port)
> +{
> +	struct tty_struct *tty = port->state->port.tty;

What is your locking for this  versus a hangup ? - tty can go NULL ?

(use tty_port_tty_get/tty_kref_put)


> +static int vt8500_set_baud_rate(struct uart_port *port, unsigned int
> baud) +{
> +	unsigned long div;
> +
> +	div = vt8500_read(port, VT8500_URDIV) & ~(0x3ff);
> +
> +	if (unlikely((baud < 900) || (baud > 921600)))
> +		div |= 7;
> +	else
> +		div |= (921600 / baud) - 1;
> +
> +	while (vt8500_read(port, VT8500_URUSR) & (1 << 5))
> +		;

cpu_relax() and needs a timeout ideally ?


> +	lcr = vt8500_read(&vt8500_port->uart, VT8500_URLCR);
> +	lcr &= ~((1 << 5) | (1 << 4));
> +	if (termios->c_cflag & PARENB) {
> +		lcr |= (1 << 4);
> +		if (termios->c_cflag & PARODD)
> +			lcr |= (1 << 5);
> +	}
> +
> +	/* calculate bits per char */
> +	lcr &= ~(1 << 2);
> +	switch (termios->c_cflag & CSIZE) {
> +	case CS7:
> +		break;
> +	case CS8:
> +	default:
> +		lcr |= (1 << 2);
> +		break;

If you don't support other CS values then also do
	termios->c_flag &=~CSIZE;
	termios->c_cflag |= CS8;

here.. so the app knows,

likewise if you don't support mark/space (CMSPAR) then clear the CMSPAR
bit


> +	vt8500_write(&vt8500_port->uart, 0x88c, VT8500_URFCR);
> +	while (vt8500_read(&vt8500_port->uart, VT8500_URFCR) & 0xc)
> +		/* Wait for the reset to complete */;

cpu_relax/timeout


> +static struct console vt8500_console = {
> +	.name = "ttyS",

ttyS is the 8250 style devices

> +	.dev_name	= "ttyS",
> +	.major		= 4,
> +	.minor		= 64,

These major/minors belong to an existing device - use new ones, or in
fact unless they must be fixed use dynamic ones.

If they need fixed ones then we probably want to assign four from the
range for small ports.

);

> +
> +	if (unlikely(ret))
> +		uart_unregister_driver(&vt8500_uart_driver);
> +
> +	printk(KERN_INFO "vt8500_serial: driver initialized\n");

The world really doesn't need to know about each driver being loaded.
pr_debug() should be fine

Looks pretty good.
