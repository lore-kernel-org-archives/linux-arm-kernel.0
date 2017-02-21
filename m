From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 21 Feb 2017 13:02:21 +0200
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <20170221112641.6276c001@bbrezillon>
References: <1487593718-20752-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487593718-20752-2-git-send-email-boris.brezillon@free-electrons.com>
 <CAHp75VdwQGP-qa0c0KQwrdpZmCGc3RuEsJ-E-XLbBzQSn4Yxcg@mail.gmail.com>
 <20170220213803.7ba5591e@bbrezillon> <20170220215009.0ecbf5a1@bbrezillon>
 <CAHp75VczsC9WdZWR9iCRh2JoNLFZyOtodrsDRYQoyaN7nkyf=A@mail.gmail.com>
 <CAHp75Vc_q-bEzA2-hVpHyR0GZ8mXxwJ8-UjECe31T04mb67q4w@mail.gmail.com>
 <20170221090610.6d531b94@bbrezillon>
 <CAHp75VfZfj-8ih3vg63w_dAq8xXE2Whu1bANXRcXS1_EGNq43A@mail.gmail.com>
 <20170221112641.6276c001@bbrezillon>
Message-ID: <CAHp75Vcb9gtzF7LvH74JwL4dTUyQvKmg=dnTXKfjhVHuyK3WXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 12:26 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> On Tue, 21 Feb 2017 12:03:45 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

>> 1. For example,
>>
>> #define ATMEL_NFC_CMD(pos, cmd)                        ((cmd) <<
>> (((pos) * 8) + 2))
>
> Well, I like to explicitly put parenthesis even when operator
> precedence guarantees the order of the calculation ('*' is preceding
> '+').

That's my point. I'm not a LISP programmer.
Personally I think it makes readability worse.

> For the parenthesis around (cmd) and (pos), they are required to
> guarantee that things like ATMEL_NFC_CMD(x + y, cmd) are working
> correctly.

I know that.

>> >> Most important part I have noticed is a GPIO request.
>> >> I didn't get why you almost repeat gpiod_get() in case of platform data?
>> >> Shouldn't we have GPIO look up table?
>> >> Can we use builtin device properties (for GPIO and/or overall)?
>> >
>> > Sorry but I don't get it. Can give an example of what you'd like me to
>> > do?
>> >
>>
>> 4. First of all, why do you need this function in the first place?
>>
>> +struct gpio_desc *
>> +atmel_nand_pdata_get_gpio(struct atmel_nand_controller *nc, int gpioid,
>> +                         const char *name, bool active_low,
>> +                         enum gpiod_flags flags)
>
> Because I don't want to duplicate the code done in
> atmel_nand_pdata_get_gpio() each time I have to convert a GPIO number
> into a GPIO descriptor, and that is needed to support platforms that
> haven't moved to DT yet

They should use GPIO lookup tables.

We don't encourage people to use platform data anymore.

We have unified device properties for something like "timeout-us", we
have look up tables when you need specifics like pwm, gpio, pinctrl,
...

Abusing platform data with pointers is also not welcome.

> (in this case, avr32).

It's dead de facto.

When last time did you compile kernel for it? What was the version of kernel?
Did it get successfully?

When are we going to remove avr32 support from kernel completely?

>> 5. BIT() macro:

> We could probably use BIT() in a few places.

There are more places including data structures assignments.

> Again, this has been copied from the old driver. I'll have a closer
> look.

Exactly. You overlooked due to enormous LOC in the one change. See my
point below.

>> 7. Question to all that distribution or whatever functions, don't you
>> have a common helper? Or each vendor requires different logic behind
>> it?
>
> What are you talking about? nand_chip hooks?

That long arithmetic with some data.

>> 8. Have you checked what kernel library provides?
>
> I think so, but again, this is really vague, what kind of
> open-coded functions do you think could be replaced with core libraries
> helpers?

I dunno, I'm asking you. Usually if I see a pattern I got a clue to
check lib/ and similar places. From time to time I discover something
new and interesting there.

>> And I believe there are still issues like those. After, who is on
>> topic, might even find some logical and other issues...
>>
>> P.S. TBH, so big change is unreviewable in meaningful time. To have a
>> comprehensive review I, for example, spend ~1h/250LOC, and
>> ~2.5h/1000LOC, I would estimate ~4h/2000LOC. Imagine one to spend one
>> day for this. Any volunteer? Not me.
>
> I'm not asking you to review the whole driver, but you started to
> comment on the code without pointing clearly to the things you wanted
> me to address.

Yes, because my point is *split* this to be reviewable.

-- 
With Best Regards,
Andy Shevchenko
