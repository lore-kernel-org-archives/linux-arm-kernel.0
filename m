From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 16 Feb 2016 15:13:50 +0200
Subject: [PATCH v3 05/10] serial: mps2-uart: add support for early console
In-Reply-To: <56C31F9F.10000@arm.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
 <1455617295-23736-6-git-send-email-vladimir.murzin@arm.com>
 <CAHp75VdugAq0WnzLHmd9CJHCjBOdBwPqCmC3ARSaVF5XMYGoMw@mail.gmail.com>
 <56C31F9F.10000@arm.com>
Message-ID: <CAHp75Vf_4MgdWunQy5hBMH5GGei+OkktFPYY-ZprY0qOEnD=wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 3:09 PM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> On 16/02/16 10:36, Andy Shevchenko wrote:
>> On Tue, Feb 16, 2016 at 12:08 PM, Vladimir Murzin
>> <vladimir.murzin@arm.com> wrote:
>>> This adds support early console for MPS2 UART which can be enabled via
>>> earlycon=mps2,0x40004000

>>> +static void mps2_early_putchar(struct uart_port *port, int ch)
>>> +{
>>> +
>>> +       while (readb(port->membase + UARTn_STATE) & UARTn_STATE_TX_FULL)
>>> +               cpu_relax();
>>
>> Infinite busy loop?
>
> In case of broken hw, yes, but I'm quite unsure how we can help to fix
> it. Do you have something in mind?

Set sane amount of loops like

int count = 100;
?
while (? && --count)

Though I have no idea what to do if count == 0. Perhaps it's a TX overrun state.

You may try to recover by flushing TX queue in HW (fifo and / or Tx
shift register) if HW supports it.

-- 
With Best Regards,
Andy Shevchenko
