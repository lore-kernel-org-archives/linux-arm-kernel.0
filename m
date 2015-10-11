From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Sun, 11 Oct 2015 20:15:01 +0100
Subject: [PATCH 2/3] hwrng: stm32 - add support for STM32 HW RNG
In-Reply-To: <CAMTL27G9j8tR4WKQgj6HbVCTd-5Xx0HYs40Rij91GgT4D8PevA@mail.gmail.com>
References: <1443904519-24012-1-git-send-email-daniel.thompson@linaro.org>
 <1443904519-24012-3-git-send-email-daniel.thompson@linaro.org>
 <CACRpkdaCBUnFMYMSdjF4bHwQH3zxu2ou7b54E4FzgH9UbNQEHw@mail.gmail.com>
 <CAMTL27G9j8tR4WKQgj6HbVCTd-5Xx0HYs40Rij91GgT4D8PevA@mail.gmail.com>
Message-ID: <CAMTL27HvK3H64O2qA4hhjHOmgkJfQZO95-BnmJL7tyd+TKhz0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2015 at 10:22, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> On 4 October 2015 at 11:32, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sat, Oct 3, 2015 at 10:35 PM, Daniel Thompson
>> 3. I took out the datasheet for Nomadik STn8820 and it seems that
>> the hardware is very similar to what this driver is trying to drive.
>> CR, SR and DR are in the same place, can you check if you also even
>> have the PrimeCell magic in the words at offset 0xfe0 thru 0xffc?
>
> The register window for the STM32 RNG is only 0x400 (and I'll fix the
> DT for v2 ;-) ) so the STM32 version isn't primecell-like.
>
>
>> In any case it seems likely that this driver should supercede and replace
>> drivers/char/hw_random/nomadik-rng.c
>> still using the PrimeCell bus, and if it doesn't have the PrimeCell
>> IDs in hardware, this can be specified in the device tree using
>> arm,primecell-periphid = <0x000805e1>; in the node if need be.
>> The in-tree driver is dangerously simple and assume too much IMO.
>
> Not sure about this, but I'll take a closer look. There is a certain
> family resemblance in the register set but there are significant
> differences in data transfer between the Nomadik and STM32 hardware.

Having looked at this I don't really think we would gain very much
from combining these drivers. The cells have different (albeit
slightly similar) register layouts, different ways to transfer data
(16- versus 32-bit) and different ways to report test/report incorrect
clocking. In the case of the RNG the differences therefore span the
entire of its feature set.

I think combining them just results in two drivers that happen to
share a file and I dislike having to add "fake" information to the
devicetree to make it hang together.

Is that convincing for you?


Daniel.
