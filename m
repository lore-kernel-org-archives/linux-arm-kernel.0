From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 11 Sep 2013 17:30:25 +0200
Subject: [PATCH] RFC: interrupt consistency check for OF GPIO IRQs
In-Reply-To: <CACRpkdavR=fv+y1RCNfdgQypPuRbO6isOSwGsABDrYiGeMdyZw@mail.gmail.com>
References: <1375101368-17645-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6uNJNMdZ1HYGgCtLM2t2TWGCR6btjOHVmP=vDXXvvFfRg@mail.gmail.com>
 <CACRpkdYjJL6FZwEbB7XLnb9QtjB=3LeE9Ny6KQ4PkM3zpdNqqg@mail.gmail.com>
 <344239800.bDEkDg48ZQ@avalon>
 <CACRpkdavR=fv+y1RCNfdgQypPuRbO6isOSwGsABDrYiGeMdyZw@mail.gmail.com>
Message-ID: <52308C91.2000105@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.08.2013 00:02, schrieb Linus Walleij:
> On Tue, Aug 20, 2013 at 12:04 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> On Wednesday 31 July 2013 01:44:53 Linus Walleij wrote:
> 
>>> I don't see how sharing works here, or how another user, i.e. another one
>>> than the user wanting to recieve the IRQ, can validly request such a line?
>>> What would the usecase for that valid request be?
>>
>> When the GPIO is wired to a status signal (such as an MMC card detect signal)
>> the driver might want to read the state of the signal independently of the
>> interrupt handler.
> 
> That is true. But for such a complex usecase I think it's reasonable that
> we only specify the GPIO in the device tree, and the driver utilizing the
> IRQ need to take that and perform gpio_to_irq() on it, and then it still
> works to use it both ways.

Hmm, the problem is that DT is seen as fixed. So if someone marks a GPIO
as an IRQ, it can never be used otherwise. So if you really go this way,
you should make this pretty clear in the documentation.

Looking from the other side, why do you want to mark GPIOs as IRQs in
the DT at all? And how will this be done? I found the way it was done in
the reverted patch very confusing because it needed an IRQ number. That
IRQ number depends on the mapping and isn't hw specific (and currently
just human doable because of the simple mapping).

Regards,

Alexander Holler
