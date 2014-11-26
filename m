From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Wed, 26 Nov 2014 12:33:13 +0000
Subject: [PATCH v3 5/5] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <1416917818-10506-6-git-send-email-chunyan.zhang@spreadtrum.com>
References: <Sharkl64-v3>
 <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1416917818-10506-6-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20141126123313.520ac83f@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +		 213 = /dev/ttySPX0		SPRD serial port 0
> +		    ...
> +		 216 = /dev/ttySPX3		SPRD serial port 3

Please use dynamic allocation or give a very very good reason why you
can't

> +config SERIAL_SPRD_NR
> +        int "Maximum number of sprd serial ports"
> +        depends on SERIAL_SPRD
> +        default "4"

If you are doing dynamic allocation this should pretty much go away


> +static int sprd_startup(struct uart_port *port)
> +{
> +	int ret = 0;
> +	unsigned int ien, ctrl1;
> +	struct sprd_uart_port *sp;
> +
> +	serial_out(port, SPRD_CTL2, ((THLD_TX_EMPTY << 8) | THLD_RX_FULL));
> +
> +	/* clear rx fifo */
> +	while (serial_in(port, SPRD_STS1) & 0x00ff)
> +		serial_in(port, SPRD_RXD);
> +
> +	/* clear tx fifo */
> +	while (serial_in(port, SPRD_STS1) & 0xff00)
> +		;

Missing a cpu_relax and I would have thought a timeout on both of these.


> +static void sprd_set_termios(struct uart_port *port,
> +				    struct ktermios *termios,
> +				    struct ktermios *old)
> +{
> +	unsigned int baud, quot;

> +	/* calculate parity */
> +	lcr &= ~SPRD_LCR_PARITY;
> +	if (termios->c_cflag & PARENB) {
> +		lcr |= SPRD_LCR_PARITY_EN;
> +		if (termios->c_cflag & PARODD)
> +			lcr |= SPRD_LCR_ODD_PAR;
> +		else
> +			lcr |= SPRD_LCR_EVEN_PAR;
> +	}

If you don't support mark/space parity then also clear CMSPAR in
termios->c_cflag. If you do then it ought to be handled above.

> +
> +	/* clock divider bit16~bit20 */
> +	serial_out(port, SPRD_CLKD1, (quot & 0x1f0000) >> 16);
> +	serial_out(port, SPRD_LCR, lcr);
> +	fc |= 0x3e00 | THLD_RX_FULL;
> +	serial_out(port, SPRD_CTL1, fc);

Also set the resulting baud back into the termios (see the 8250 termios
for an example)


> +static int __init sprd_console_setup(struct console *co, char *options)
> +{
> +	struct uart_port *port;
> +	int baud = 115200;
> +	int bits = 8;
> +	int parity = 'n';
> +	int flow = 'n';
> +
> +	if (unlikely(co->index >= UART_NR_MAX || co->index < 0))
> +		co->index = 0;
> +
> +	port = (struct uart_port *)sprd_port[co->index];
> +	if (port == NULL) {
> +		pr_info("srial port %d not yet initialized\n", co->index);

Typo

Looks basically sound to me

Alan
