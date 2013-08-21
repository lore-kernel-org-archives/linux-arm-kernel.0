From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Wed, 21 Aug 2013 18:42:40 +0530
Subject: [PATCH 12/16] clk: samsung: pll: Add support for rate
 configuration of PLL46xx
In-Reply-To: <14520108.LqsSBuPVXk@amdc1227>
References: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
 <1377019903-14614-13-git-send-email-t.figa@samsung.com>
 <CAKew6eU4ofumk64fwZSK-R-UUBQos6UU1TLDdVRDE-bvOrbitw@mail.gmail.com>
 <14520108.LqsSBuPVXk@amdc1227>
Message-ID: <CAKew6eUGOgUWzgU7SnCjAenSHxwaOgFUhPWHbav3C8z=tS+EpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> <snip>
>>
>> > --- a/drivers/clk/samsung/clk-pll.h
>> > +++ b/drivers/clk/samsung/clk-pll.h
>> > @@ -51,6 +51,28 @@ enum samsung_pll_type {
>> >
>> >                 .afc    =       (_afc),                         \
>> >
>> >         }
>> >
>> > +#define PLL_4600_RATE(_rate, _m, _p, _s, _k, _vsel)            \
>> > +       {                                                       \
>> > +               .rate   =       (_rate),                        \
>> > +               .mdiv   =       (_m),                           \
>> > +               .pdiv   =       (_p),                           \
>> > +               .sdiv   =       (_s),                           \
>> > +               .kdiv   =       (_k),                           \
>> > +               .vsel   =       (_vsel),                        \
>> > +       }
>> > +
>> > +#define PLL_4650_RATE(_rate, _m, _p, _s, _k, _mfr, _mrr, _vsel)
>> > \ +       {                                                       \ +
>> >              .rate   =       (_rate),                        \ +
>> >         .mdiv   =       (_m),                           \ +
>> >    .pdiv   =       (_p),                           \ +
>> > .sdiv   =       (_s),                           \ +
>> > .kdiv   =       (_k),                           \ +               .mfr
>> >    =       (_mfr),                         \ +               .mrr    =
>> >       (_mrr),                         \ +               .vsel   =
>> >  (_vsel),                        \ +       }
>> > +
>> >
>> >  /* NOTE: Rate table should be kept sorted in descending order. */
>> >
>> >  struct samsung_pll_rate_table {
>> >
>> > @@ -60,6 +82,9 @@ struct samsung_pll_rate_table {
>> >
>> >         unsigned int sdiv;
>> >         unsigned int kdiv;
>> >         unsigned int afc;
>> >
>> > +       unsigned int mfr;
>> > +       unsigned int mrr;
>> > +       unsigned int vsel;
>> >
>> >  };
>>
>> This struct seems to be expanding too much.
>
> I don't think it's a problem. How many bytes such tables can occupy in a
> system?
>

no doubt comparing with memory size its negligible..
but comparing only struct size and coding lines it seems costlier :) .

>> Can we re-think on options for using bit map same as register
>> definition? It can reduce code in set_rate also little bit.
>
> IMHO it is more clear what the code does when accessing a single
> coefficient at once.
>
> In addition you still would need to preserve bitfields that are not changed
> by the driver

Sorry, I can't see any such problem, it will OR only the required bits.

> and also unpack some of the coefficients anyway, like pdiv
> that is used to calculate lock time.

Agree, but cases of unpacking will always be less than cases of
shifting and packing.

Anyways, its only MHO :).

Regards,
Yadwinder
