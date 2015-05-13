From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 May 2015 10:52:17 +0200
Subject: [PATCH 2/3] gpio: Add GPIO support for Broadcom STB SoCs
In-Reply-To: <CADtm3G58RqWdbigVy52C6rzoiEAS41WnAJHHeGui+V-ypMec5w@mail.gmail.com>
References: <1430901477-10678-1-git-send-email-gregory.0xf0@gmail.com>
 <1430901477-10678-3-git-send-email-gregory.0xf0@gmail.com>
 <CACRpkdbzjdmtiou0gURKBRV2QEQqnbrdTA1523Q5ZkYxA-vpYw@mail.gmail.com>
 <CADtm3G58RqWdbigVy52C6rzoiEAS41WnAJHHeGui+V-ypMec5w@mail.gmail.com>
Message-ID: <CACRpkdbz=3xkU0ZELHs=11+OO=KARvS8MMe7_abGei1Egq+Ptw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 8:46 PM, Gregory Fong <gregory.0xf0@gmail.com> wrote:
> On Tue, May 12, 2015 at 3:55 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> Usually we don't like it when you hardcode gpio_base, and this
>> field should anyway be present inside the bgpio_chip.gc.base
>> isn't it?
>
> This was needed to deal with having a single irq_chip shared across
> all of the gpio_chips in a GIO block.  You mentioned that this might
> not be the Right Way to do this in your reply on the cover page so
> I'll try to explain the reasoning better there.
>
> FWIW: yes, this is inside the first bank's bgpio_chip, and it would be
> possible to extract that info.  However, since it is used in
> - brcmstb_gpio_to_irq
> - brcmstb_gpio_hwirq_to_offset
> - brcmstb_gpio_irq_bank_handler
> - brcmstb_gpio_of_xlate
>
> It seemed like it would be easier to follow if this were just stored
> this in the priv struct, even if it is duplication of information.

OK I see. Even if you go for the approach I suggest in the cover
letter it is indeed necessary to keep track of the base I
can see, since we span multiple gpio_chips So it's fine with a
local variable for this.

>>> +               gc->base = gpio_base;
>>
>> I strongly suggest that you try using -1 as base here instead
>> for dynamic assignment of GPIO numbers.
>
> That is what I did originally.  However, this results in a very
> unpleasant numbering scheme, at least as currently implemented.
>
> When -1 is base, as you know, numbering goes descending from 255
> (IIRC).  Right now I'm using the of_property_for_each_u32 loop over
> bank widths to go through the banks.  To keep the example
> straightforward, let's pretend our GIO block only has two banks.
> Here's how they're arranged:
>
> bank 0: starts at 0xf040a700, contains GPIOs 0-31
> bank 1: starts at 0xf040a720, contains GPIOs 32-63
>
> Right now, with -1 as base, calling gpiochip_add() inside of that loop
> will results in them getting this numbering:
>
> bank 0: linux GPIOs 224-255
> bank 1: linux GPIOs 192-223

Yeah I kind of think it's a feature because we don't want people
to rely on the static GPIO numbering ;)

Buy OK yeah I see the point. Let's keep the base static for
now.

> Looking at this now, I think I could just add another loop afterward
> to do the gpiochip_add()'s in reverse order, resulting in the
> numbering ascending with banks as expected.  Does this seem sensible?

No, that relies on the internal semantic structure of the
gpiolib. It's better to use .base as a hint then.

>> And this mask also mask the unused pins as GIO_MASK()
>> does not respect bank_width.
>
> I'll be getting rid of imask anyway as you suggested.

Awesome.

Yours,
Linus Walleij
