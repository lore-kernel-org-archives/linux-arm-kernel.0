From: govindraj.ti@gmail.com (Govindraj)
Date: Thu, 23 Sep 2010 16:42:47 +0530
Subject: [PATCH 11/13 v2] serial: Add OMAP high-speed UART driver
In-Reply-To: <A24693684029E5489D1D202277BE894472767DA6@dlee02.ent.ti.com>
References: <37596.172.24.137.131.1285168477.squirrel@dbdmail.itg.ti.com>
	<A24693684029E5489D1D202277BE894472767DA6@dlee02.ent.ti.com>
Message-ID: <AANLkTimi=Sqz2xNheXu2-3xD9MPN6+TdwhEM=TF6XN3B@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergio,

Thanks for the review.
Reply inlined.

<SNIP>

>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +
>> +#ifndef __OMAP_SERIAL_H__
>> +#define __OMAP_SERIAL_H__
>> +
>> +#include <linux/serial_core.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <plat/control.h>
>> +#include <plat/mux.h>
>> +
>> +#define DRIVER_NAME ?"omap-hsuart"
>
> Is there a reason why you keep 2 names in the driver?
>
> You use this for the platform_driver struct "serial_omap_driver",
> Meanwhile you send a driver name of "OMAP-SERIAL" to uart_driver struct...
>
> Also IMHO, if you're just going to use this once, then it makes no sense to
> have this macro.


One is the driver name other one the device name
Driver name passed to platform registration the other to tty
interface for tty interface creation.

Driver_name will be shared between two layers one for platform_device_add
and platform device_register as name parameter requires this.
Thus defined a macro to share between two files.
omap-serial.c and */mach-omap2/serial.c
as far as device name is concerned i find it readable with
macro as done in other serial drivers.

>
>> +
>> +/*
>> + * Use tty device name as ttyO, [O -> OMAP]
>> + * in bootargs we specify as console=ttyO0 if uart1
>> + * is used as console uart.
>> + */
>> +#define OMAP_SERIAL_NAME ? ? "ttyO"
>> +
>> +#define OMAP_MDR1_DISABLE ? ?0x07
>> +#define OMAP_MDR1_MODE13X ? ?0x03
>>
>>

<SNIP>

#include <linux/serial_core.h>
>> +
>> +#include <asm/irq.h>
>
> Shouldn't this be:
>
> #include <linux/irq.h>
>
> ?

Yes.

<SNIP>

>> +
>> +/**
>> + * serial_omap_get_divisor() - calculate divisor value
>
> I heard sometime back a suggestion that kernel doc type comments aren't
> required for static private functions, as nobody is supposed to care about
> this driver internals.
>
> Also, the parenthesis after the function name shouldn't be there.

OK.


>> +
>> +static void serial_omap_enable_ms(struct uart_port *port)
>> +{
>> + ? ? struct uart_omap_port *up = (struct uart_omap_port *)port;
>
> Isn't this a bit error prone?
>
> I mean, How would you ensure that the uart_port and uart_omap_port structs
> Will remain compatible?
>

We register with serial core layer with our structure and serial core layer is
the one thats does an call to this func with the parameters.
So the data is available from serial core layer this its aligned with
the serial layer
All the serial driver do in this manner to get driver specific port
data from serial
port data.

>> +
>> + ? ? dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up->pdev->id);
>> + ? ? up->ier |= UART_IER_MSI;
>> + ? ? serial_out(up, UART_IER, up->ier);
>> +}
>> +
>> +static void serial_omap_stop_tx(struct uart_port *port)
>> +{
>> + ? ? struct uart_omap_port *up = (struct uart_omap_port *)port;
>
> Same here and below functions that does the same.

As replied above.

<SNIP>

>> + ? ? ? ? ? ? ? ? ? ? ch = serial_in(up, UART_RX);
>>  ? ? ? ? ? ? ? ? } else if (lsr & UART_LSR_PE)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? up->port.icount.parity++;
>> + ? ? ? ? ? ? ? ? ? ? else if (lsr & UART_LSR_FE)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? up->port.icount.frame++;
>
> AFAIK, Above 2 if conditions require brackets aswell, to keep consistency
> And ease of reading the whole 3 cases as part of a single chain of
> comparisons.
>
> Also, add a space here, as below if condition doesn't seem to be related.

OK.

>
>> + ? ? ? ? ? ? ? ? ? ? if (lsr & UART_LSR_OE)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? up->port.icount.overrun++;
>> +
>> + ? ? ? ? ? ? ? ? ? ? /*
>> + ? ? ? ? ? ? ? ? ? ? ?* Mask off conditions which should be ignored.
>> + ? ? ? ? ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? ? ? ? ? lsr &= up->port.read_status_mask;
>> +
>> +#ifdef CONFIG_SERIAL_OMAP_CONSOLE
>> + ? ? ? ? ? ? ? ? ? ? if (up->port.line == up->port.cons->index) {
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? /* Recover the break flag from console xmit */
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? lsr |= up->lsr_break_flag;
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? up->lsr_break_flag = 0;
>> + ? ? ? ? ? ? ? ? ? ? }
>> +#endif
>> + ? ? ? ? ? ? ? ? ? ? if (lsr & UART_LSR_BI)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? flag = TTY_BREAK;
>> + ? ? ? ? ? ? ? ? ? ? else if (lsr & UART_LSR_PE)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? flag = TTY_PARITY;
>> + ? ? ? ? ? ? ? ? ? ? else if (lsr & UART_LSR_FE)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? flag = TTY_FRAME;
>> + ? ? ? ? ? ? }
>> +
>> + ? ? ? ? ? ? if (uart_handle_sysrq_char(&up->port, ch))
>> + ? ? ? ? ? ? ? ? ? ? goto ignore_char;
>> + ? ? ? ? ? ? uart_insert_char(&up->port, lsr, UART_LSR_OE, ch, flag);
>> +ignore_char:
>> + ? ? ? ? ? ? lsr = serial_in(up, UART_LSR);
>> + ? ? } while ((lsr & (UART_LSR_DR | UART_LSR_BI)) && (max_count-- > 0));
>> + ? ? spin_unlock(&up->port.lock);
>> + ? ? tty_flip_buffer_push(tty);
>> + ? ? spin_lock(&up->port.lock);
>
> This is very odd... So you unlock a spinlock, and then lock it back?
>
> Have you activated spinlock debug in menuconfig to test locking?

Again as said earlier.
This lock is maintained by the serial core layer.
We do not maintain it or initialize it.

It comes from the interface registration and needs to be used as said by the
serial layer.
Common across serial drivers.
Reference 8250.c serial driver as this driver is derived from 8250
as said below the licensing in driver file.

>
>> +}
>> +
>> +static void transmit_chars(struct uart_omap_port *up)
>> +{
>> + ? ? struct circ_buf *xmit = &up->port.state->xmit;
>> + ? ? int count;
>> +
>> + ? ? if (up->port.x_char) {
>> + ? ? ? ? ? ? serial_out(up, UART_TX, up->port.x_char);
>> + ? ? ? ? ? ? up->port.icount.tx++;
>> + ? ? ? ? ? ? up->port.x_char = 0;
>> + ? ? ? ? ? ? return;
>> + ? ? }
>> + ? ? if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
>> + ? ? ? ? ? ? serial_omap_stop_tx(&up->port);
>> + ? ? ? ? ? ? return;
>> + ? ? }
>> + ? ? count = up->port.fifosize / 4;
>> + ? ? do {
>> + ? ? ? ? ? ? serial_out(up, UART_TX, xmit->buf[xmit->tail]);
>> + ? ? ? ? ? ? xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>> + ? ? ? ? ? ? up->port.icount.tx++;
>> + ? ? ? ? ? ? if (uart_circ_empty(xmit))
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? } while (--count > 0);
>> +
>> + ? ? if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>> + ? ? ? ? ? ? uart_write_wakeup(&up->port);
>> +
>> + ? ? if (uart_circ_empty(xmit))
>> + ? ? ? ? ? ? serial_omap_stop_tx(&up->port);
>> +}
>> +
>> +static inline void serial_omap_enable_ier_thri(struct uart_omap_port *up)
>> +{
>> + ? ? if (!(up->ier & UART_IER_THRI)) {
>> + ? ? ? ? ? ? up->ier |= UART_IER_THRI;
>> + ? ? ? ? ? ? serial_out(up, UART_IER, up->ier);
>> + ? ? }
>> +}
>> +
>> +static void serial_omap_start_tx(struct uart_port *port)
>> +{
>> + ? ? struct uart_omap_port *up = (struct uart_omap_port *)port;
>> + ? ? struct circ_buf *xmit;
>> + ? ? unsigned int start;
>> + ? ? int ret = 0;
>
> This var is useless.
>
>> +
>> + ? ? if (!up->use_dma) {
>> + ? ? ? ? ? ? serial_omap_enable_ier_thri(up);
>> + ? ? ? ? ? ? return;
>> + ? ? }
>> +
>> + ? ? if (up->uart_dma.tx_dma_used)
>> + ? ? ? ? ? ? return;
>> +
>> + ? ? xmit = &up->port.state->xmit;
>> +
>> + ? ? if (up->uart_dma.tx_dma_channel == OMAP_UART_DMA_CH_FREE) {
>> + ? ? ? ? ? ? ret = omap_request_dma(up->uart_dma.uart_dma_tx,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? "UART Tx DMA",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? (void *)uart_tx_dma_callback, up,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? &(up->uart_dma.tx_dma_channel));
>> +
>> + ? ? ? ? ? ? if (ret < 0) {
>
> As you're not using the return value anywhere, why not doing this instead?

Yes can be done,

IMHO its looks simpler with ret value populated then do a comparison
than having multi line statements for a comparison.


>
> ? ? ? ? ? ? ? ?if (omap_request_dma(up->uart_dma.uart_dma_tx,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"UART Tx DMA",
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(void *)uart_tx_dma_callback, up,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&(up->uart_dma.tx_dma_channel)) < 0) {
>
>> + ? ? ? ? ? ? ? ? ? ? serial_omap_enable_ier_thri(up);
>> + ? ? ? ? ? ? ? ? ? ? return;
>> + ? ? ? ? ? ? }
>> + ? ? }
<SNIP>

>a_channel);
>> +}
>> +
>> +static unsigned int check_modem_status(struct uart_omap_port *up)
>> +{
>> + ? ? int status;
>
> This should be unsigned int.

Yes.

>
> Also, space here.

OK.

>
>> + ? ? status = serial_in(up, UART_MSR);
>> +
>> + ? ? status |= up->msr_saved_flags;
>> + ? ? up->msr_saved_flags = 0;
>> +
>> + ? ? if ((status & UART_MSR_ANY_DELTA) == 0)
>> + ? ? ? ? ? ? return status;
>
> Space here too.

OK.

>
>> + ? ? if (status & UART_MSR_ANY_DELTA && up->ier & UART_IER_MSI &&
>> +}
>> +
>> +/**
>> + * serial_omap_irq() - This handles the interrupt from one port
>> + * @irq: uart port irq number
>> + * @dev_id: uart port info
>> + */
>> +static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
>> +{
>> + ? ? struct uart_omap_port *up = dev_id;
>> + ? ? unsigned int iir, lsr;
>> + ? ? unsigned long flags;
>> +
>> + ? ? iir = serial_in(up, UART_IIR);
>> + ? ? if (iir & UART_IIR_NO_INT)
>> + ? ? ? ? ? ? return IRQ_NONE;
>> +
>> + ? ? spin_lock_irqsave(&up->port.lock, flags);
>
> You're in interrupt context already, why do you need to disable interrupts?

Transmit and receive operations do port specific operations
hence need to do this, all this comes straight from the way
done 8250 with port handle func.

>
>> + ? ? lsr = serial_in(up, UART_LSR);
>> + ? ? if (iir & UART_IIR_RLSI) {
>> + ? ? ? ? ? ? if (!up->use_dma) {
>> + ? ? ? ? ? ? ? ? ? ? if (lsr & UART_LSR_DR)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? receive_chars(up, &lsr);
>> + ? ? ? ? ? ? } else {
>> + ? ? ? ? ? ? ? ? ? ? up->ier &= ~(UART_IER_RDI | UART_IER_RLSI);
>> + ? ? ? ? ? ? ? ? ? ? serial_out(up, UART_IER, up->ier);
>> + ? ? ? ? ? ? ? ? ? ? if (serial_omap_start_rxdma(up) != 0)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? if (lsr & UART_LSR_DR)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? receive_chars(up, &lsr);
>
> Shouldn't be simpler to just do:
>
> ? ? ? ? ? ? ? ? ? ? ? ?if ((serial_omap_start_rxdma(up) != 0) &&
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(lsr & UART_LSR_DR))
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?receive_chars(up, &lsr);
>
> ?

Yes fine can adapt to this.

>
>> + ? ? ? ? ? ? }
>> + ? ? }
>> +
>
>> +

<SNIP>

>> + ? ? serial_omap_clear_fifos(up);
>> + ? ? /* For Hardware flow control */
>> + ? ? serial_out(up, UART_MCR, UART_MCR_RTS);
>> +
>> + ? ? /*
>> + ? ? ?* Clear the interrupt registers.
>> + ? ? ?*/
>> + ? ? (void) serial_in(up, UART_LSR);
>> + ? ? if (serial_in(up, UART_LSR) & UART_LSR_DR)
>> + ? ? ? ? ? ? (void) serial_in(up, UART_RX);
>> + ? ? (void) serial_in(up, UART_IIR);
>> + ? ? (void) serial_in(up, UART_MSR);
>
> Why the void typecasting?
>

To ignore read return value.
as we are not interested in return value here.

>> +
>> + ? ? /*
>> + ? ? ?* Now, initialize the UART
>> + ? ? ?*/
>> + ? ? serial_out(up, UART_LCR, UART_LCR_WLEN8);
>> + ? ? spin_lock_irqsave(&up->port.lock, flags);
>> + ? ? /*

<SNIP>

>> +
>> +static int
>> +serial_omap_verify_port(struct uart_port *port, struct serial_struct
>> *ser)
>> +{
>> + ? ? /* we don't want the core code to modify any port params */
>> + ? ? dev_dbg(port->dev, "serial_omap_verify_port+\n");
>> + ? ? return -EINVAL;
>
> Is this some sort of hack?
>
> If so, it should be marked as such.
>

This can be used to probe the individual port status
if we need so, but we do not have any such functionality
from controller specific stuff that can be added here.
Its one the interface that needs to be passed to serial core.

>> +}
>> +
>> +static const char *
>> +serial_omap_type(struct uart_port *port)
>> +{
>> + ? ? struct uart_omap_port *up = (struct uart_omap_port *)port;
>> +
>> + ? ? dev_dbg(up->port.dev, "serial_omap_type+%d\n", up->pdev->id);
>> + ? ? return up->name;
>> +}
>> +
>> +#ifdef CONFIG_SERIAL_OMAP_CONSOLE
>> +
>> +static struct uart_omap_port *serial_omap_console_ports[4];
>> +
>> +static struct uart_driver serial_omap_reg;
>> +
>> +#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
>> +
>> +static inline void wait_for_xmitr(struct uart_omap_port *up)
>> +{
>> + ? ? unsigned int status, tmout = 10000;
>> +
>> + ? ? /* Wait up to 10ms for the character(s) to be sent. */
>> + ? ? do {
>> + ? ? ? ? ? ? status = serial_in(up, UART_LSR);
>> +
>> + ? ? ? ? ? ? if (status & UART_LSR_BI)
>> + ? ? ? ? ? ? ? ? ? ? up->lsr_break_flag = UART_LSR_BI;
>> +
>> + ? ? ? ? ? ? if (--tmout == 0)
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? udelay(1);
>> + ? ? } while ((status & BOTH_EMPTY) != BOTH_EMPTY);
>> +
>> + ? ? /* Wait up to 1s for flow control if necessary */
>> + ? ? if (up->port.flags & UPF_CONS_FLOW) {
>> + ? ? ? ? ? ? tmout = 1000000;
>> + ? ? ? ? ? ? for (tmout = 1000000; tmout; tmout--) {
>> + ? ? ? ? ? ? ? ? ? ? unsigned int msr = serial_in(up, UART_MSR);
>
> Space here.

OK.

>
>> + ? ? ? ? ? ? ? ? ? ? up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;
>> + ? ? ? ? ? ? ? ? ? ? if (msr & UART_MSR_CTS)
<SNIP>

>> + ? ? if (options)
>> + ? ? ? ? ? ? uart_parse_options(options, &baud, &parity, &bits, &flow);
>> +
>> + ? ? r = uart_set_options(&up->port, co, baud, parity, bits, flow);
>> +
>> + ? ? return r;
>
>
> You could just do:
>
> ? ? ? ?return uart_set_options(&up->port, co, baud, parity, bits, flow);
>
> And get rid of var "r".


OK.

>
>> +}

<SNIP>

>> + ? ? up->port.irqflags = omap_up_info->irqflags;
>> + ? ? up->port.uartclk = omap_up_info->uartclk;
>
> Where is up->port.lock being initialized?

As said earlier port lock comes from serial core
needs to used for port specific operation as said by
the interface we do not initialize or maintain it
we only use it in driver.

For further reference on serial driver ops and usage:
/Documentation/serial/driver

---
Thanks,
Govindraj.R
