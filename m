From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Aug 2013 00:02:39 +0200
Subject: [PATCH] RFC: interrupt consistency check for OF GPIO IRQs
In-Reply-To: <344239800.bDEkDg48ZQ@avalon>
References: <1375101368-17645-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6uNJNMdZ1HYGgCtLM2t2TWGCR6btjOHVmP=vDXXvvFfRg@mail.gmail.com>
 <CACRpkdYjJL6FZwEbB7XLnb9QtjB=3LeE9Ny6KQ4PkM3zpdNqqg@mail.gmail.com>
 <344239800.bDEkDg48ZQ@avalon>
Message-ID: <CACRpkdavR=fv+y1RCNfdgQypPuRbO6isOSwGsABDrYiGeMdyZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 12:04 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 31 July 2013 01:44:53 Linus Walleij wrote:

>> I don't see how sharing works here, or how another user, i.e. another one
>> than the user wanting to recieve the IRQ, can validly request such a line?
>> What would the usecase for that valid request be?
>
> When the GPIO is wired to a status signal (such as an MMC card detect signal)
> the driver might want to read the state of the signal independently of the
> interrupt handler.

That is true. But for such a complex usecase I think it's reasonable that
we only specify the GPIO in the device tree, and the driver utilizing the
IRQ need to take that and perform gpio_to_irq() on it, and then it still
works to use it both ways.

>> Basically I believe these two things need to be exclusive in the DT world:
>>
>> A: request_irq(a resource passed from "interrupts");
>>      -> core implicitly performs gpio_request()
>>          gpio_direction_input()
>>
>> B: gpio_request(a resource passed from "gpios");
>>      gpio_direction_input()
>>      request_irq(gpio_to_irq())
>>
>> Never both. And IIUC that was what happened in the OMAP case.
>
> Isn't the core issue that we can translate a GPIO number to an IRQ number, but
> not the other way around ? If that could be done, we could request the GPIO
> and configure it as an input when the IRQ is requested.

That is true. It would be easier if all GPIO drivers has an irqchip and
and irqdomain, then we could implement irq_to_gpio() properly in gpiolib
and this would not be a problem. Alas, not all do.

But I also think that the DT contains (as demonstrated by the patch)
all information about what interrupts and GPIOs may conflict, so I
also see this as something of a consistency check, but it could go
in either way.

Yours,
Linus Walleij
