From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 16 Feb 2016 13:09:51 +0000
Subject: [PATCH v3 05/10] serial: mps2-uart: add support for early console
In-Reply-To: <CAHp75VdugAq0WnzLHmd9CJHCjBOdBwPqCmC3ARSaVF5XMYGoMw@mail.gmail.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>	<1455617295-23736-6-git-send-email-vladimir.murzin@arm.com>
 <CAHp75VdugAq0WnzLHmd9CJHCjBOdBwPqCmC3ARSaVF5XMYGoMw@mail.gmail.com>
Message-ID: <56C31F9F.10000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/02/16 10:36, Andy Shevchenko wrote:
> On Tue, Feb 16, 2016 at 12:08 PM, Vladimir Murzin
> <vladimir.murzin@arm.com> wrote:
>> This adds support early console for MPS2 UART which can be enabled via
>> earlycon=mps2,0x40004000
> 
> 
>> --- a/drivers/tty/serial/mps2-uart.c
>> +++ b/drivers/tty/serial/mps2-uart.c
>> @@ -435,6 +435,36 @@ static struct console mps2_uart_console = {
>>
>>  #define MPS2_SERIAL_CONSOLE (&mps2_uart_console)
>>
>> +static void mps2_early_putchar(struct uart_port *port, int ch)
>> +{
>> +
>> +       while (readb(port->membase + UARTn_STATE) & UARTn_STATE_TX_FULL)
>> +               cpu_relax();
> 
> Infinite busy loop?

In case of broken hw, yes, but I'm quite unsure how we can help to fix
it. Do you have something in mind?

> 
>> +
>> +       writeb((unsigned char)ch, port->membase + UARTn_DATA);
>> +}
>> +
>> +
>> +static void mps2_early_write(struct console *con, const char *s, unsigned n)
>> +{
>> +       struct earlycon_device *dev = con->data;
>> +
>> +       uart_console_write(&dev->port, s, n, mps2_early_putchar);
>> +}
>> +
>> +static int __init mps2_early_console_setup(struct earlycon_device *device,
>> +                                          const char *opt)
>> +{
>> +       if (!device->port.membase)
>> +               return -ENODEV;
>> +
>> +       device->con->write = mps2_early_write;
>> +
>> +       return 0;
>> +}
>> +EARLYCON_DECLARE(mps2, mps2_early_console_setup);
>> +OF_EARLYCON_DECLARE(mps2, "arm,mps2-uart", mps2_early_console_setup);
> 
> IIRC Peter Hurley mentioned you don't need to put both anymore, OF_
> one is enough.
> 

I've just tried with OF_ only and seems it works fine. Thanks for
pointing at it!

Cheers
Vladimir
