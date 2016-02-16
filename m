From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 16 Feb 2016 14:25:47 +0000
Subject: [PATCH v3 04/10] serial: mps2-uart: add MPS2 UART driver
In-Reply-To: <CAHp75Vcx_xAY2A4XNgQ1ea_U5mUnD1+6=2FxCM3KzsRSpxgRuw@mail.gmail.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>	<1455617295-23736-5-git-send-email-vladimir.murzin@arm.com>
 <CAHp75Vcx_xAY2A4XNgQ1ea_U5mUnD1+6=2FxCM3KzsRSpxgRuw@mail.gmail.com>
Message-ID: <56C3316B.10205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/02/16 10:48, Andy Shevchenko wrote:
> On Tue, Feb 16, 2016 at 12:08 PM, Vladimir Murzin
> <vladimir.murzin@arm.com> wrote:
>> This driver adds support to the UART controller found on ARM MPS2
>> platform.
> 
> 
>> +static irqreturn_t mps2_uart_oerrirq(int irq, void *data)
>> +{
>> +       irqreturn_t handled = IRQ_NONE;
>> +       struct uart_port *port = data;
>> +       u8 irqflag = mps2_uart_read8(port, UARTn_INT);
>> +
>> +       spin_lock(&port->lock);
>> +
>> +       if (irqflag & UARTn_INT_RX_OVERRUN) {
>> +               struct tty_port *tport = &port->state->port;
>> +
>> +               mps2_uart_write8(port, UARTn_INT_RX_OVERRUN, UARTn_INT);
>> +               tty_insert_flip_char(tport, 0, TTY_OVERRUN);
>> +               port->icount.overrun++;
>> +               handled = IRQ_HANDLED;
>> +       }
>> +
>> +       /*
>> +        * It's never been seen in practice and it never *should* happen since
>> +        * we check if there is enough room in TX buffer before sending data.
>> +        * So we keep this check in case something suspicious has happened.
>> +        */
>> +       if (irqflag & UARTn_INT_TX_OVERRUN) {
>> +               mps2_uart_write8(port, UARTn_INT_TX_OVERRUN, UARTn_INT);
> 
>> +               dev_warn(port->dev, "unexpected overrun interrupt\n");
> 
> I'm not sure there is no dead lock if this happens on the same port
> which is used as console.

Right, doesn't look like a good idea...

> 
>> +               handled = IRQ_HANDLED;
>> +       }
>> +
>> +       spin_unlock(&port->lock);
>> +
>> +       return handled;
>> +}
>> +
>> +static int mps2_uart_startup(struct uart_port *port)
>> +{
>> +       struct mps2_uart_port *mps_port = to_mps2_port(port);
>> +       u8 control = mps2_uart_read8(port, UARTn_CTRL);
>> +       int ret;
>> +
>> +       control &= ~(UARTn_CTRL_RX_GRP | UARTn_CTRL_TX_GRP);
>> +
>> +       mps2_uart_write8(port, control, UARTn_CTRL);
>> +
>> +       ret = request_irq(mps_port->rx_irq, mps2_uart_rxirq, 0,
>> +                         MAKE_NAME(-rx), mps_port);
>> +       if (ret) {
>> +               dev_err(port->dev, "failed to register rxirq (%d)\n", ret);
>> +               goto err_no_rxirq;
> 
> It should be below, here just a plain return.
> 
>> +       }
>> +
>> +       ret = request_irq(mps_port->tx_irq, mps2_uart_txirq, 0,
>> +                         MAKE_NAME(-tx), mps_port);
>> +       if (ret) {
>> +               dev_err(port->dev, "failed to register txirq (%d)\n", ret);
>> +               goto err_no_txirq;
> 
> goto err_free_rxirq;
> 
>> +       }
>> +
>> +       ret = request_irq(port->irq, mps2_uart_oerrirq, IRQF_SHARED,
>> +                         MAKE_NAME(-overrun), mps_port);
>> +
>> +       if (ret) {
>> +               dev_err(port->dev, "failed to register oerrirq (%d)\n", ret);
> 
> Why not goto pattern here as well?
> 
> goto err_free_txirq;
> 
>> +       } else {
> 
> ?and remove this else.
> 
>> +               control |= UARTn_CTRL_RX_GRP | UARTn_CTRL_TX_GRP;
>> +
>> +               mps2_uart_write8(port, control, UARTn_CTRL);
>> +
>> +               return 0;
>> +       }
>> +
>> +       free_irq(mps_port->tx_irq, mps_port);
>> +err_no_txirq:
>> +       free_irq(mps_port->rx_irq, mps_port);
>> +err_no_rxirq:
>> +       return ret;
>> +}
> 

Ok. Will rework that.

> 
>> +static struct mps2_uart_port mps2_uart_ports[MPS2_MAX_PORTS];
>> +
>> +#ifdef CONFIG_SERIAL_MPS2_UART_CONSOLE
>> +static void mps2_uart_console_putchar(struct uart_port *port, int ch)
>> +{
>> +       while (mps2_uart_read8(port, UARTn_STATE) & UARTn_STATE_TX_FULL)
>> +               cpu_relax();
> 
> Infinite?
> 

The same as for [5/10].

>> +
>> +       mps2_uart_write8(port, ch, UARTn_DATA);
>> +}
> 
>> +static int mps2_init_port(struct mps2_uart_port *mps_port,
>> +                       struct platform_device *pdev)
>> +{
>> +       int ret;
>> +       struct resource *res;
> 
> Maybe:
>        struct resource *res;
>        int ret;
> ?
> 

Matter of taste :) Will change it since I need to update the patch anyway.

Thanks
Vladimir
