From: bjorn@kryo.se (Bjorn Andersson)
Date: Wed, 9 Jul 2014 07:13:18 -0700
Subject: [PATCH 1/3] mfd: pm8921: Expose pm8xxx_read_irq_status
In-Reply-To: <CACRpkdaYRwSb2cd88KEjKHKN_3sRv5BvJTvNMmF3CZszu8c2HQ@mail.gmail.com>
References: <1404782785-1824-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1404782785-1824-2-git-send-email-bjorn.andersson@sonymobile.com>
 <CACRpkdaYRwSb2cd88KEjKHKN_3sRv5BvJTvNMmF3CZszu8c2HQ@mail.gmail.com>
Message-ID: <CAJAp7OgrHp9mKVkTAe8VdtbcDy=UMjLvTXBV2-gBZ3X4X4h_ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 9, 2014 at 12:59 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jul 8, 2014 at 3:26 AM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
>
>> Most status bits, e.g. for GPIO and MPP input, is retrieved by reading
>> the interrupt status registers, so this needs to be exposed to clients.
>>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>
> Hm do you mean you read the input *values* from the interrupt status
> registers?
>

Due to the limited address space (I presume), many of the status bits
on the pm8xxx are not exposed in any other place than through a banked
register in the interrupt "block". So we have to read the interrupt
status in order to get information related to things like gpio status
or if a battery is present for charging.

> What madness in that case.... :-)
>

Totally!

> Anyway, since the driver is based on regmap, can't the children just
> get a regmap * somehow and then just go read the same register
> instead of having to add a special function for it?
>

That we have, and we have access to that part of the ssbi address
space. Unfortunately, like everything else in these pmics, things are
banked. So we need first a bank selector and then a read; so it's racy
with the interrupt handler code doing the same thing.

> When I look at it it seems like it's doing regmap strangely or
> something, like it's one write then one read operation to get
> the register(s) and isn't that all supposed to be hidden behind
> regmap so you don't need the local lock chip->pm_irq_lock?
>

I guess one could have exposed a regmap that instead of exposing the
ssbi address space presented a logical view of the pm8xxx registers;
something like the bitplanes on Amiga. I prefer having a ssbi regmap
for simplicity (and sanity) but then we need to have this read in the
irq driver.

Regards,
Bjorn
