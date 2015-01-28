From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 28 Jan 2015 08:12:50 +0200
Subject: [PATCH v9 2/2] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <1422413261-17184-3-git-send-email-chunyan.zhang@spreadtrum.com>
References: <sc9836-serial-v9>
 <1422413261-17184-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1422413261-17184-3-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20150128061250.GQ2555@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chunyan Zhang,

On Wed, Jan 28, 2015 at 10:47:41AM +0800, Chunyan Zhang wrote:
[...]
> +static inline void sprd_rx(struct uart_port *port)
> +{
> +	struct tty_port *tty = &port->state->port;
> +	unsigned int ch, flag, lsr, max_count = SPRD_TIMEOUT;
> +
> +	while ((serial_in(port, SPRD_STS1) & 0x00ff) && max_count--) {
> +		lsr = serial_in(port, SPRD_LSR);
> +		ch = serial_in(port, SPRD_RXD);
> +		flag = TTY_NORMAL;
> +		port->icount.rx++;
> +
> +		if (lsr & (SPRD_LSR_BI | SPRD_LSR_PE |
> +			SPRD_LSR_FE | SPRD_LSR_OE))
> +			if (handle_lsr_errors(port, &lsr, &flag))
> +				continue;
> +		if (uart_handle_sysrq_char(port, ch))
> +			continue;

My comment[1] on a previous version of this patch still stands. 
uart_handle_sysrq_char is a NOP when SUPPORT_SYSRQ is not defined.

> +
> +		uart_insert_char(port, lsr, SPRD_LSR_OE, ch, flag);
> +	}
> +
> +	tty_flip_buffer_push(tty);
> +}

[...]

> +static void sprd_console_write(struct console *co, const char *s,
> +				      unsigned int count)
> +{
> +	struct uart_port *port = &sprd_port[co->index]->port;
> +	int locked = 1;
> +	unsigned long flags;
> +
> +	if (port->sysrq)
> +		locked = 0;

The sysrq field of struct uart_port is only defined when 
CONFIG_SERIAL_CORE_CONSOLE or SUPPORT_SYSRQ are defined. You should #ifdef 
this part accordingly to avoid build breakage.

> +	else if (oops_in_progress)
> +		locked = spin_trylock_irqsave(&port->lock, flags);
> +	else
> +		spin_lock_irqsave(&port->lock, flags);
> +
> +	uart_console_write(port, s, count, sprd_console_putchar);
> +
> +	/* wait for transmitter to become empty */
> +	wait_for_xmitr(port);
> +
> +	if (locked)
> +		spin_unlock_irqrestore(&port->lock, flags);
> +}

[1]
	http://article.gmane.org/gmane.linux.drivers.devicetree/106483

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
