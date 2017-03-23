From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Mar 2017 11:36:52 +0100
Subject: [PATCH 4/6] pinctrl: aramda-37xx: Add irqchip support
In-Reply-To: <87zigdeczh.fsf@free-electrons.com>
References: <20161222172501.16121-1-gregory.clement@free-electrons.com>
 <20161222172501.16121-5-gregory.clement@free-electrons.com>
 <CACRpkdbR-WRT0rJp2CuN6CkZF=J35JUgGHjW7beyaimipz0ehw@mail.gmail.com>
 <87zigdeczh.fsf@free-electrons.com>
Message-ID: <CACRpkdaVDQMoPXmT++vJ4v9mUejYSy28Ybwb0v2519OeCSPvXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 1:02 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
>  On ven., d?c. 30 2016, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> On Thu, Dec 22, 2016 at 6:24 PM, Gregory CLEMENT
>> <gregory.clement@free-electrons.com> wrote:
>>
>>> The Armada 37xx SoCs can handle interrupt through GPIO. However it can
>>> only manage the edge ones.
>>>
>>> The way the interrupt are managed are classical so we can use the generic
>>> interrupt chip model.
>>>
>>> The only unusual "feature" is that many interrupts are connected to the
>>> parent interrupt controller. But we do not take advantage of this and use
>>> the chained irq with all of them.
>>>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
>> So this is very simple and should use GPIOLIB_IRQCHIP.
>>
>> Begin with select GPIOLIB_IRQCHIP in your Kconfig and then look
>> at conversions such as commit 85ae9e512f437cd09bf61564bdba29ab88bab3e3
>> ("pinctrl: bcm2835: switch to GPIOLIB_IRQCHIP")
>> for inspiration.
>
> I switched to the use of GPIOLIB_IRQCHIP however it didn't really simplify
> my code, during the development on the v2 I did a commit only for this
> change and here it is the diffstat:
> 110     72      drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
>
> In my first version I used the generic irqchip so I was able to benefit
> of this framework, by switching to GPIOLIB_IRQCHIP I had to implement
> again some of the functions such as .mask, .unmask an ack.

I still think this is better, so thanks.

If you have ideas of how we could combine generic irqchip with
GPIOLIB_IRQCHIP in an efficient manner, I'd be happy to hear
about it? I want gpiolib core to be involved setting things like
the .irq_request/release_resources() for example, so if you
would proceed with this solution, I would have had you add those
duplicating the gpiolib helpers instead.

Yours,
Linus Walleij
