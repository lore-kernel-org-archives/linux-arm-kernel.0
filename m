From: dianders@chromium.org (Doug Anderson)
Date: Thu, 30 May 2013 08:55:10 -0700
Subject: [PATCH v2 2/5] clk: samsung: Add support to register rate_table
 for PLL3xxx
In-Reply-To: <CAKew6eVGnHNN7Fk=sqzE1iV+SFtJ1z4k1freeWdbGaYPXqpUvQ@mail.gmail.com>
References: <1369834677-20312-1-git-send-email-vikas.sajjan@linaro.org>
 <1369834677-20312-3-git-send-email-vikas.sajjan@linaro.org>
 <CAD=FV=VDi+SfebiFnPNp8qR__9L=o9TJ+WSPRfRQLX+p+TMmJw@mail.gmail.com>
 <CAKew6eVGnHNN7Fk=sqzE1iV+SFtJ1z4k1freeWdbGaYPXqpUvQ@mail.gmail.com>
Message-ID: <CAD=FV=VEUTimNVqQvVZAkU7Qa9yy4R99E+WHA-aOzn61JBH_fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yadwinder and Vikas,

On Wed, May 29, 2013 at 11:55 PM, Yadwinder Singh Brar
<yadi.brar01@gmail.com> wrote:
>> Also: you can include rate here if you need a convenient place to
>> store it (which sadly means that this structure can't be const).
>> ...but I do like Tomasz's idea of actually calculating it.  You can't
>> know it at compile time since the parent rate comes from the device
>> tree.
>>
>> compatible = "samsung,clock-xxti";
>> clock-frequency = <24000000>;
>>
>
> Actually this table should contain the recommended values
> and if we see the user manual, the input(parent) rate is also a part
> of recommended
> table of different output rate for a particular PLL for that SoC.

That's a reasonable point.  It's not clear to me whether the
recommended PMSK values would be the same or different if the input
wasn't 24MHz.  You're assuming that they would be different and that
seems fair given my (limited) understanding of the electrical
characteristics of PLLs.

...so if a given SoC needed to support multiple different parent clock
frequencies the presumably it would have multiple tables and pick the
right one to pass in.


> So as Tomasz said input(parent) rate may change with board,
> then, do those corresponding recommended p, m, s, k will be valid?
>
> In case, input(parent) rate changes then we may need different set of p, m ,s, k
> values recommended for new input rate to get required(recommended to
> use) output rate.
>
> So, we think its better that the p, m, s and k along with the parent
> is known at the compile time ( or DT ?),
> as these p, m, s, k values are very much coupled with the parent rate
> to achieve the
>  required(recommended to use) output rate.

Having the rate in the table definitely makes it easier to understand,
too.  We just have to hope someone doesn't mess up in their
calculation.  Worst case we could put some error checking somewhere.


> Also, since the sorted table is required (sorted based on "rate"),
> its better to have the rate in a const rate table.

You _could_ still sort the table based on eventually rate even if the
actual rate wasn't in the table.  ...but I agree that it's harder to
look at and figure out.


> And the whole set of recommended values should come from same place(DT
> or static table),
> to keep the things simple and consistent.

Agree that it's a little weird now that some bits of the clock code is
in the device tree and some bits are just static tables in code.
...but I think that's OK for now.

Perhaps a reasonable compromise is to include "24mhz" in the name of
the tables (in later patches) and then give a WARN_ON if the xxti
clock isn't 24MHz.  Then you've effectively documented the plan of
action should someone eventually need a different xxti clock.


> Moreover, practically for a particular SoC , we use the recommended
> input(parent) rate only for a PLL.
> So we should keep the things simple here presently.

>From what I've seen so far I could totally believe Samsung releasing a
new user manual in the future that provides instructions for using a
non-24MHz xxti clock.  ...but with all of the above I think we've got
a reasonable story so I think we're good.


>>> +       unsigned int pdiv;
>>> +       unsigned int mdiv;
>>> +       unsigned int sdiv;
>>> +       unsigned int kdiv;
>>
>> I think kdiv is signed.
>>
>
> No, as these values should be the recommended values to be written in
> corresponding  register bits. So it should remain unsigned.
>
> K value should be considered as negative only while recalculating rate.
>
> As per exynos5250 user manual's section 7.3.2 :
> " K value description "Postive value (Negative value)":
> Postive values is that you should write EPLLCON/VPLLCON register.
> Negative value is that you can calculate PLL output frequency with it."

OK, fair point.  We can keep it unsigned in this table.


To summarize where I think we are in this series, I'm hoping for one
more version that:
* Adds a comment about the rate table being sorted (and which direction)
* Adds "24mhz" to the variable name for the PLL tables in future patch series
* Adds a WARN_ON if the xxti clock isn't 24MHz


Does that sound like a plan?  Tomasz: any thoughts on the above?


-Doug
