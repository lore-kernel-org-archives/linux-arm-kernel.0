From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 16 Feb 2016 13:38:09 +0000
Subject: [PATCH v3 05/10] serial: mps2-uart: add support for early console
In-Reply-To: <CAHp75Vf_4MgdWunQy5hBMH5GGei+OkktFPYY-ZprY0qOEnD=wA@mail.gmail.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>	<1455617295-23736-6-git-send-email-vladimir.murzin@arm.com>	<CAHp75VdugAq0WnzLHmd9CJHCjBOdBwPqCmC3ARSaVF5XMYGoMw@mail.gmail.com>	<56C31F9F.10000@arm.com>
 <CAHp75Vf_4MgdWunQy5hBMH5GGei+OkktFPYY-ZprY0qOEnD=wA@mail.gmail.com>
Message-ID: <56C32641.4020201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/02/16 13:13, Andy Shevchenko wrote:
> On Tue, Feb 16, 2016 at 3:09 PM, Vladimir Murzin
> <vladimir.murzin@arm.com> wrote:
>> On 16/02/16 10:36, Andy Shevchenko wrote:
>>> On Tue, Feb 16, 2016 at 12:08 PM, Vladimir Murzin
>>> <vladimir.murzin@arm.com> wrote:
>>>> This adds support early console for MPS2 UART which can be enabled via
>>>> earlycon=mps2,0x40004000
> 
>>>> +static void mps2_early_putchar(struct uart_port *port, int ch)
>>>> +{
>>>> +
>>>> +       while (readb(port->membase + UARTn_STATE) & UARTn_STATE_TX_FULL)
>>>> +               cpu_relax();
>>>
>>> Infinite busy loop?
>>
>> In case of broken hw, yes, but I'm quite unsure how we can help to fix
>> it. Do you have something in mind?
> 
> Set sane amount of loops like
> 
> int count = 100;
> ?
> while (? && --count)
> 
> Though I have no idea what to do if count == 0. Perhaps it's a TX overrun state.

I thought about counter too, like some of drivers do, but had no idea
what to do next after counter reaches zero. In case of TX overrun we
could get it either because of broken hw or because we entered Linux
with that state already set. In both cases, it looks handy to me to
attach a debugger and see that we are spinning in this putchar loop.

If you do insist to have a counter I'll add one, but if you are not
strong about it I'd prefer to leave it as is.

> 
> You may try to recover by flushing TX queue in HW (fifo and / or Tx
> shift register) if HW supports it.
> 

I'm afraid this is not supported.

Thanks
Vladimir
