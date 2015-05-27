From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue, 26 May 2015 20:26:55 -0700
Subject: [PATCH 0/3] GPIO support for BRCMSTB
In-Reply-To: <CACRpkdaTYAr-7K5_QZh1CyeyA1224obqEB2Sz8UHZmrWcfv+ow@mail.gmail.com>
References: <1430901477-10678-1-git-send-email-gregory.0xf0@gmail.com>
 <CACRpkda3EDa7YdzeT6FQ=cQw1RrDath7pQsCos-JeB2y4r18gw@mail.gmail.com>
 <CADtm3G45-u82Rp_0dHf2EfdMokf8E4FaQ84PHnocpvXxU+5_+g@mail.gmail.com>
 <CACRpkdaTYAr-7K5_QZh1CyeyA1224obqEB2Sz8UHZmrWcfv+ow@mail.gmail.com>
Message-ID: <CADtm3G4ao=3sHx2F1+V9rwS=jWf6ZdEQi4d24HxQ6MEc+CQ8CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, May 13, 2015 at 1:59 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, May 12, 2015 at 9:38 PM, Gregory Fong <gregory.0xf0@gmail.com> wrote:
>> On Tue, May 12, 2015 at 3:59 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Wed, May 6, 2015 at 10:37 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:
>>>
>>>> There is only one IRQ for each GIO IP block (i.e. several register banks share
>>>> an IRQ).  After briefly looking into the generic IRQ chip implementation, it
>>>> seemed like in this case that using it would result in the driver being more
>>>> complex than necessary because AFAICT it expects a 1:1 mapping of
>>>> irq_chip_generic to gpio_chip.  It seemed like less of a pain to have a single
>>>> irq_chip since we have a single IRQ for all register banks (multiple
>>>> gpio_chips).  I might be missing something, maybe using a shared IRQ across
>>>> multiple irq_chips is easier than I think?  Suggestions welcome.
>>>
>>> What is needed is a 1:1 mapping between GPIO offsets and IRQ
>>> offsets.
>>>
>>> If you just number your GPIOs 0...n and your IRQs 0...n
>>> it should work just fine with one irqchip for all banks.
>>>
>>> What screws things up is likely that the hardware supports
>>> 32 lines per bank and not all are used.
>>>
>>> I suggest you enable 32 line and 32 IRQs per bank,
>>> so that hwirq maps nicely 1:1 on the GPIO offsets,
>>> then just use the width thing to NACK operations on
>>> GPIO lines you are not using. This way you can also
>>> decode and warn on spurious IRQs on the unused lines.
>>
>> For having 32 lines per bank, the big problem here is the upper limit
>> of 256 GPIOs.
>
> Which arch is this?
> Usually this limit comes from
> arch/*/include/asm/gpio.h
>
> For ARM that was bumped to 512 a while back. It is also possible
> to define a custom value for your system by defining
> ARCH_NR_GPIOS
>
>> Anyway, I don't think I understand IRQ domains and irq_chip_generic
>> very well.  One possibility _might_ be to use multiple irq_chips.
>
> That is probably not possible if there is just one IRQ for all
> banks.
>
> The task of the irqdomain is a 1-to-1 translation from one
> hardware numberspace to the Linux IRQ number space.
>
> In your case the hardware IRQ (hwirq) numberspace
> should be:
>
> bank0: 0..31
> bank1: 32..63
> ....
> bankn: 32*n..32*n+31
>
> I think the gpiolib irqchip code can translate that properly
> as it is just a simple 0...x mapping, the irq handler need
> some magic to loop over all banks from 0..n though.

I've now actually attempted to use the gpiolib irqchip code.  This
driver can't directly use gpiochip_irqchip_add() because of the
multiple gpiochip : one irqchip map.  At first, I thought it might be
possible to simply add a new argument (or break things into a helper
function) to allow setting the associated IRQ domain, but then I can't
use the generic map and unmap functions which expect the irq_domain
host_data member to be struct gpiochip *, which makes no sense in this
case.  That puts me right back to implementing a special version of
the map and unmap function.

Since there doesn't appear to be any benefit to using the gpiolib
irqchip code for this case, I'm going to stick with my implementation
from patch 3 of this patchset.  I've also added to it to allow for
using the GPIOs as a wakeup source, and will submit that as well with
V2.

Thanks,
Gregory
