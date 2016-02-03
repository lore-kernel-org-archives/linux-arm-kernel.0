From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 03 Feb 2016 17:43:59 +0100
Subject: [PATCH 01/10] serial: mvebu-uart: initial support for Armada-3700
 serial port
In-Reply-To: <CAPv3WKfGX2dVDu2zWG4gdEMf0vO-X+NMerh9PzNDjzLBDSQcUA@mail.gmail.com>
 (Marcin Wojtas's message of "Wed, 3 Feb 2016 09:05:55 +0100")
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
 <CAPv3WKfGX2dVDu2zWG4gdEMf0vO-X+NMerh9PzNDjzLBDSQcUA@mail.gmail.com>
Message-ID: <87io254ucw.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,
 
 On mer., f?vr. 03 2016, Marcin Wojtas <mw@semihalf.com> wrote:

> Hi Gregory
>
>> +
>> +static int mvebu_uart_startup(struct uart_port *port)
>> +{
>> +       int ret;
>> +
>> +       writel(CTRL_TXFIFO_RST | CTRL_RXFIFO_RST,
>> +              port->membase + UART_CTRL);
>> +       udelay(1);
>> +       writel(CTRL_RX_INT, port->membase + UART_CTRL);
>> +
>> +       ret = request_irq(port->irq, mvebu_uart_isr, port->irqflags, "serial",
>> +                         port);
>> +       if (ret) {
>> +               dev_err(port->dev, "failed to request irq\n");
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>
>> +static int mvebu_uart_probe(struct platform_device *pdev)
>> +{
>> +       struct resource *reg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> +       struct uart_port *port;
>> +       struct mvebu_uart_data *data;
>> +       int ret;
>> +
>> +       if (!reg || !irq) {
>> +               dev_err(&pdev->dev, "no registers/irq defined\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       port = &mvebu_uart_ports[0];
>> +
>> +       spin_lock_init(&port->lock);
>> +
>> +       port->dev        = &pdev->dev;
>> +       port->type       = PORT_MVEBU;
>> +       port->ops        = &mvebu_uart_ops;
>> +       port->regshift   = 0;
>> +
>> +       port->fifosize   = 32;
>> +       port->iotype     = UPIO_MEM32;
>> +       port->flags      = UPF_FIXED_PORT;
>> +       port->line       = 0; /* single port: force line number to  0 */
>> +
>> +       port->irq        = irq->start;
>> +       port->irqflags   = 0;
>
> Please use port->irqflags = IRQF_SHARED;
> As ubuntu opens multiple consoles A3700 can't boot to it (only to
> buildroot with single console).

But this irq is not shared, this looks like a hack hidding the real
issue.

Gregory

>
> Best regards,
> Marcin

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
