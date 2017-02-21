From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 21 Feb 2017 17:55:15 +0200
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <20170221122050.421dae48@bbrezillon>
References: <1487593718-20752-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487593718-20752-2-git-send-email-boris.brezillon@free-electrons.com>
 <CAHp75VdwQGP-qa0c0KQwrdpZmCGc3RuEsJ-E-XLbBzQSn4Yxcg@mail.gmail.com>
 <20170220213803.7ba5591e@bbrezillon> <20170220215009.0ecbf5a1@bbrezillon>
 <CAHp75VczsC9WdZWR9iCRh2JoNLFZyOtodrsDRYQoyaN7nkyf=A@mail.gmail.com>
 <CAHp75Vc_q-bEzA2-hVpHyR0GZ8mXxwJ8-UjECe31T04mb67q4w@mail.gmail.com>
 <20170221090610.6d531b94@bbrezillon>
 <CAHp75VfZfj-8ih3vg63w_dAq8xXE2Whu1bANXRcXS1_EGNq43A@mail.gmail.com>
 <20170221112641.6276c001@bbrezillon>
 <CAHp75Vcb9gtzF7LvH74JwL4dTUyQvKmg=dnTXKfjhVHuyK3WXg@mail.gmail.com>
 <20170221122050.421dae48@bbrezillon>
Message-ID: <CAHp75VfHf9qN+sRd6cymr9ziO9Xi7gw+O-yOp+1zEAduxEMfJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 1:20 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> On Tue, 21 Feb 2017 13:02:21 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Tue, Feb 21, 2017 at 12:26 PM, Boris Brezillon
>> <boris.brezillon@free-electrons.com> wrote:
>> > On Tue, 21 Feb 2017 12:03:45 +0200
>> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> So, it's a matter of taste.

Yes, and I'm not objecting this.

>> >> 4. First of all, why do you need this function in the first place?
>> >>
>> >> +struct gpio_desc *
>> >> +atmel_nand_pdata_get_gpio(struct atmel_nand_controller *nc, int gpioid,
>> >> +                         const char *name, bool active_low,
>> >> +                         enum gpiod_flags flags)
>> >
>> > Because I don't want to duplicate the code done in
>> > atmel_nand_pdata_get_gpio() each time I have to convert a GPIO number
>> > into a GPIO descriptor, and that is needed to support platforms that
>> > haven't moved to DT yet
>>
>> They should use GPIO lookup tables.
>>
>> We don't encourage people to use platform data anymore.
>>
>> We have unified device properties for something like "timeout-us", we
>> have look up tables when you need specifics like pwm, gpio, pinctrl,
>> ...
>>
>> Abusing platform data with pointers is also not welcome.
>>
>> > (in this case, avr32).
>>
>> It's dead de facto.
>>
>> When last time did you compile kernel for it? What was the version of kernel?
>> Did it get successfully?
>>
>> When are we going to remove avr32 support from kernel completely?
>
> I'll let Nicolas answer that one.

In any case it's discouraging to use platform data for GPIOs and plain
GPIO pin numbering.

> Note that I sometime prefer to keep (1 << X).
>
> Example:
>
> #define PMECC_CFG_READ_OP                       (0 << 12)
> #define PMECC_CFG_WRITE_OP                      (1 << 12)

I understand that.

> Okay, so the code in pmecc.c. See, it's hard to follow a review when
> you don't comment inline.

It's hard to review (n+1) thousands of LOC.

>> >> 8. Have you checked what kernel library provides?
>> >
>> > I think so, but again, this is really vague, what kind of
>> > open-coded functions do you think could be replaced with core libraries
>> > helpers?
>>
>> I dunno, I'm asking you. Usually if I see a pattern I got a clue to
>> check lib/ and similar places. From time to time I discover something
>> new and interesting there.
>
> If you're talking about the code in pmecc.c, yes, I already mentioned
> in the header that it should be reworked to use some helpers from
> lib/bch.c, but that's not the point of this series, and is left as
> future improvements.

OK.

>> Yes, because my point is *split* this to be reviewable.

> And how do you do with new drivers?

To be more pedantic the new drivers do not have "minus" thousands LOC.

> Do you ask people to split their
> submissions in micro changes?

To logical ones.

> I'm regularly reviewing drivers that are
> several thousands LOC, and I don't ask people to split things just
> because it's too long. When I ask them to split in different commits,
> it's because they are doing several unrelated changes at once.

What did prevent you to:
1. Introduce new driver
2. Switch to new driver
3. Remove old one.

...if you are not splitting it in the first place?

> Note that I considered refactoring the existing driver in smaller
> steps, but it's almost impossible, because the code is too messy and I
> would end up with a huge series of patches that is not easier to review.

I can object this, but it will be no point except waste of time to
this discussion.

It's good that you considered several options. I suppose someone who
is on topic can do comprehensive review.

-- 
With Best Regards,
Andy Shevchenko
