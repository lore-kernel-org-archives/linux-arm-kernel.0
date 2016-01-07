From: robh@kernel.org (Rob Herring)
Date: Thu, 7 Jan 2016 07:53:55 -0600
Subject: [PATCH 2/2] ARM: versatile: fix MMC/SD interrupt assignment
In-Reply-To: <CACRpkdZc3tNnMUfkVBkJ6XctpuDQ1YHDeyxsLD4_u84P8=3nTQ@mail.gmail.com>
References: <1451984370-16932-1-git-send-email-linus.walleij@linaro.org>
 <CAL_Jsq+8JOSpUefSUMakAsESbjFgfGFpFsH=7utZWP_H6HPM6w@mail.gmail.com>
 <CACRpkdZc3tNnMUfkVBkJ6XctpuDQ1YHDeyxsLD4_u84P8=3nTQ@mail.gmail.com>
Message-ID: <CAL_JsqKajTbJc7Gm1h8c4GY=F8t5MoWtj4o3ipGswkn3QR993Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2016 at 3:58 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Jan 6, 2016 at 12:43 AM, Rob Herring <robh@kernel.org> wrote:
>> On Tue, Jan 5, 2016 at 2:59 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>>> diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
>>> index 01f40197ea13..3279bf1a17a1 100644
>>> --- a/arch/arm/boot/dts/versatile-ab.dts
>>> +++ b/arch/arm/boot/dts/versatile-ab.dts
>>> @@ -110,7 +110,11 @@
>>>                         interrupt-parent = <&vic>;
>>>                         interrupts = <31>; /* Cascaded to vic */
>>>                         clear-mask = <0xffffffff>;
>>> -                       valid-mask = <0xffc203f8>;
>>> +                       /*
>>> +                        * Valid interrupt lines mask according to
>>> +                        * table 4-36 page 4-50 of ARM DUI 0225D
>>> +                        */
>>> +                       valid-mask = <0x0760031b>;
>>
>> I never really liked valid-mask in the first place. Valid interrupts
>> are the ones specified by devices and we don't need this extra data.
>> If we do, then *every* interrupt controller needs this property.
>> Perhaps the driver should just ignore it. But you've already done the
>> work here, so this is okay too.
>
> It's a migrated feature from the boardfile days as it happens.

[...]

> I think it's because the Integrator will crash if you try to even
> clear a non-existing interrupt by writing a '1' in the wrong bit,
> and that is why we have the clear-mask. And valid-mask is
> to avoid even mapping one of these non-existing IRQs.
> The issue doesn't seem to exist on the Versatile (I tried
> with 0xffffffff and it worked) and probably not on Integrator
> QEMU either, but on the real hardware I've experienced it.
>
> So the FPGA interrupt controller is sensitive stuff ... and it
> seemed natural to preserve this overzealous code
> (and bindings).

Okay, well this is certainly a better reason than I had heard before.

Acked-by: Rob Herring <robh@kernel.org>

Rob
