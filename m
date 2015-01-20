From: peter@hurleysoftware.com (Peter Hurley)
Date: Tue, 20 Jan 2015 08:39:25 -0500
Subject: [PATCH v5 5/5] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <54BE45EA.3030308@gmail.com>
References: <sc9836-v5>
 <1421402411-3479-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1421402411-3479-6-git-send-email-chunyan.zhang@spreadtrum.com>
 <54B92C4F.8020009@hurleysoftware.com> <54BE45EA.3030308@gmail.com>
Message-ID: <54BE5A8D.6090303@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2015 07:11 AM, Orson Zhai wrote:
> Hi, Peter,
> 
> Thank you for reviewing our code!
> Some discussion below.
> 
> On 2015?01?16? 23:20, Peter Hurley wrote:
>> On 01/16/2015 05:00 AM, Chunyan Zhang wrote:
>>> Add a full sc9836-uart driver for SC9836 SoC which is based on the
>>> spreadtrum sharkl64 platform.
>>> This driver also support earlycon.
>>> This patch also replaced the spaces between the macros and their
>>> values with the tabs in serial_core.h
>> The locking doesn't look correct. Specific notations below.

>>> +static inline void sprd_tx(int irq, void *dev_id)
>>> +{
>>> +    struct uart_port *port = dev_id;
>>> +    struct circ_buf *xmit = &port->state->xmit;
>>> +    int count;
>>> +
>>> +    if (port->x_char) {
>>> +        serial_out(port, SPRD_TXD, port->x_char);
>>> +        port->icount.tx++;
>>> +        port->x_char = 0;
>>> +        return;
>>> +    }
>>> +
>>> +    if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
>>> +        sprd_stop_tx(port);
>>> +        return;
>>> +    }
>>> +
>>> +    count = THLD_TX_EMPTY;
>>> +    do {
>>> +        serial_out(port, SPRD_TXD, xmit->buf[xmit->tail]);
>>> +        xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>>> +        port->icount.tx++;
>>> +        if (uart_circ_empty(xmit))
>>> +            break;
>>> +    } while (--count > 0);
>>> +
>>> +    if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>>> +        uart_write_wakeup(port);
>>> +
>>> +    if (uart_circ_empty(xmit))
>>> +        sprd_stop_tx(port);
>>> +}
>>> +
>>> +/* this handles the interrupt from one port */
>>> +static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
>>> +{
>>> +    struct uart_port *port = (struct uart_port *)dev_id;
>>> +    unsigned int ims;
>> Why does your isr not have to take port->lock ?
> 
> The original consideration is the registers are accessed by isr only.
> Interrupt will not be nested because of gic chip driver protection.
> So there is not other thread will race on it.
> Does this make sense?

The xmit->buf[] and its indexes could be accessed concurrently.
For example,

CPU 0                                      | CPU 1
                                           |
sprd_handle_irq                            | uart_flush_buffer
  sprd_tx                                  |   spin_lock_irqsave
    ...                                    |
    count = 64                             |
    do {                                   |     xmit->tail = 0
      serial_out(xmit->buf[xmit->tail])    |

      whoops - what byte did this just output?

I'm sure there's many more possible races, perhaps with worse
outcomes than just 1 bad byte output.


>>
>>> +    ims = serial_in(port, SPRD_IMSR);
>>> +
>>> +    if (!ims)
>>> +        return IRQ_NONE;
>>> +
>>> +    serial_out(port, SPRD_ICLR, ~0);
>>> +
>>> +    if (ims & (SPRD_IMSR_RX_FIFO_FULL |
>>> +        SPRD_IMSR_BREAK_DETECT | SPRD_IMSR_TIMEOUT))
>>> +        sprd_rx(irq, port);
>>> +
>>> +    if (ims & SPRD_IMSR_TX_FIFO_EMPTY)
>>> +        sprd_tx(irq, port);
>>> +
>>> +    return IRQ_HANDLED;
>>> +}

[...]

>>> +static void sprd_console_putchar(struct uart_port *port, int ch)
>>> +{
>>> +    wait_for_xmitr(port);
>>> +    serial_out(port, SPRD_TXD, ch);
>>> +}
>>> +
>>> +static void sprd_console_write(struct console *co, const char *s,
>>> +                      unsigned int count)
>>> +{
>>> +    struct uart_port *port = &sprd_port[co->index]->port;
>>> +    int ien;
>>> +    int locked = 1;
>>> +
>>> +    if (oops_in_progress)
>>> +        locked = spin_trylock(&port->lock);
>>> +    else
>>> +        spin_lock(&port->lock);
>> If you do need to take the port->lock in your isr, then you need to
>> disable local irq here.
> 
> You mean to use spin_lock_irqsave()?
> 
> We do disable irq below....

But not before an irq could happen with the spin_lock already taken.

printk
  ...
  sprd_console_write
    spin_lock
       <IRQ>
       sprd_handle_irq
         spin_lock

    ** DEADLOCK **

[
  Note: some drivers assume that console->write() will always be
  called with local interrupts disabled. This is a bad idea and I
  have warned those driver authors when this has come up before.
]

Also, since you handle sysrq in your isr the above needs to check
for non-zero port->sysrq and _not_ attempt the spinlock because
the isr will already have it; for example,

<IRQ>
sprd_handle_irq
  spin_lock
    sprd_rx
      ...
      uart_handle_syrq_char
        handle_sysrq
          __handle_sysrq
            printk
              ...
              sprd_console_write
                spin_lock

    ** DEADLOCK **

Regards,
Peter Hurley

>>
>>> +    /* save the IEN then disable the interrupts */
>>> +    ien = serial_in(port, SPRD_IEN);
>>> +    serial_out(port, SPRD_IEN, 0x0);
> 
> Here, we disable port IEN register.
> 
>>> +
>>> +    uart_console_write(port, s, count, sprd_console_putchar);
>>> +
>>> +    /* wait for transmitter to become empty and restore the IEN */
>>> +    wait_for_xmitr(port);
>>> +    serial_out(port, SPRD_IEN, ien);
>>> +    if (locked)
>>> +        spin_unlock(&port->lock);
>>> +}
