From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 13 Oct 2011 21:45:26 +0800
Subject: [PATCH] UART: add CSR SiRFprimaII SoC on-chip uart drivers
In-Reply-To: <20111013105556.09d64d4d@bob.linux.org.uk>
References: <1318487293-6963-1-git-send-email-Barry.Song@csr.com>
	<20111013105556.09d64d4d@bob.linux.org.uk>
Message-ID: <CAGsJ_4zvc=HaVURyARV0k6m7btfMjQo1frqmJa-OtE--eyCsFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,
Thanks for your quick feedback.

2011/10/13 Alan Cox <alan@linux.intel.com>:
> Looks basically ok but somewhat outdated for the tty layer. In
> particular it needs to be aware of the refcounting on tty objects and
> of the fact we allow arbitary baud rate handling
>
>> +static struct sirfsoc_baudrate_to_regv baudrate_to_regv[] = {
>
> const

agree

>
>> +static unsigned int
>> +sirfsoc_uart_pio_rx_chars(struct uart_port *port, unsigned int
>> max_rx_count) +{
>> + ? ? unsigned int ch, rx_count = 0;
>> + ? ? int temp;
>> + ? ? struct tty_struct *tty = port->state->port.tty;
>
> tty = tty_port_tty_get(&port->state->port);
>
> [the newer tty code is refcounting, also tty can be NULL here and needs
> h handling accordingly]

agree

>
>> + ? ? while (!(rd_regl(port, SIRFUART_RX_FIFO_STATUS) &
>> +
>> SIRFUART_FIFOEMPTY_MASK(port))) {
>> + ? ? ? ? ? ? temp =
>> tty_buffer_request_room(port->state->port.tty, 1);
>> + ? ? ? ? ? ? if (unlikely(temp == 0)) {
>> + ? ? ? ? ? ? ? ? ? ? port->icount.buf_overrun++;
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? }
>
> You don't need to do this - just uart_insert_char. If we run out of mid
> layer buffering it's not a port overrun as such (ie a fifo exceeded)
> it's a system wide memory crunch and something pretty serious and
> bigger is going on.
>
>> + ? ? port->icount.rx += rx_count;
>> + ? ? tty_flip_buffer_push(tty);
>
> [Do these only if tty != NULL obviously)
>
> and
> ? ? ? ?tty_kref_put(tty);
>
agree

>
>
>> +static void sirfsoc_uart_set_termios(struct uart_port *port,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct ktermios *termios,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct ktermios *old)
>> +{
>
> If you don't support CMSPAR then clear the bit in the passed termios.

actually it is supported if you read codes again.

>
>> + ? ? for (ic = 0; ic < SIRFUART_BAUD_RATE_SUPPORT_NR; ic++)
>> + ? ? ? ? ? ? if (baud_rate == baudrate_to_regv[ic].baud_rate)
>> + ? ? ? ? ? ? ? ? ? ? clk_div_reg = baudrate_to_regv[ic].reg_val;
>> + ? ? if (clk_div_reg == 0)
>> + ? ? ? ? ? ? pr_err("SiRF UART: Cannot set Baud Rate (9600 ~
>> 4000000).\n");
>
> The baud rate is not guaranteed to be one the Bxxxxx values, you should
> be computing it not using a table.

Rong has changed it to contain both Bxxx table and non-Bxxx
calculation. For Bxxx values, get set from table.
otherwise, calculate.

> Also the pr_err means any user can fill the logs with junk.
>
> The correct behaviour here is
>
> ? ? ? ?compute the best timing for the baud rate requested
> ? ? ? ?compute the actual baud rate obtained
>
> then report it back to the caller
>
> ? ? ? ?if (tty_termios_baud_rate(termios))
> ? ? ? ? ? ? ? ?tty_termios_encode_baud_rate(termios, baud. baud);

agree

>
> The above assuming you set the same input and output rate
>
>
>
>> +static struct console sirfsoc_uart_console = {
>> + ? ? .name ? ? ? ? ? = "ttyS",
>
> ttyS is 8250 devces. Pick a new name for your own.

ok. most devices have names like ttySQ, ttySA, ttySG... since our SoC
is named SiRFprimaII, i'd like to have ttySI?

>
>>
>> + ? ? .dev_name ? ? ? = SIRFSOC_UART_NAME,
>> + ? ? .major ? ? ? ? ?= SIRFSOC_UART_MAJOR,
>> + ? ? .minor ? ? ? ? ?= SIRFSOC_UART_MINOR,
>
> Use dynamic allocations
>
>
>> +#define SIRFSOC_UART_NAME ? ? ? ? ? ? ? ? ? ?"ttyS"
>> +#define SIRFSOC_UART_MAJOR ? ? ? ? ? ? ? ? ? TTY_MAJOR
>> +#define SIRFSOC_UART_MINOR ? ? ? ? ? ? ? ? ? 64
>
> These values belong to an existing inerface, don't reuse the names like
> that, and please use dynamic allocation for the numbers

agree

>
>> +#define uart_tx_port_tty_invalid(port) ? \
>> + ? ? (((port)->state == NULL) || ((port)->state->port.tty ==
>> NULL))
>
> This has no locking so little meaning - what guarantees it doesn't
> change ?under or after the call. I suspect you want to be checking and
> referencing the tty in one shot as in the example I gave above for the
> rx fix.

agree.

-barry
