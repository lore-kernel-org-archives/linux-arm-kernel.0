From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 25 Oct 2018 22:58:30 +0200
Subject: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
In-Reply-To: <f4d239df2f1333b005680f9bfdd2eba93e7f86e5.camel@baylibre.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
 <a8d359208edfdc75cb5c6de378796f76e0572a0f.camel@baylibre.com>
 <eda2faf2-cf06-902d-36ff-48ceafcb4a4b@amlogic.com>
 <f4d239df2f1333b005680f9bfdd2eba93e7f86e5.camel@baylibre.com>
Message-ID: <CAFBinCCuqUmVNdwUm7WbkHy1eWvOA5oQ5FcOuytbYNbgGcXnRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

On Thu, Oct 25, 2018 at 2:54 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
[snip]
> > > > +static void clk_regmap_div_init(struct clk_hw *hw)
> > > > +{
> > > > + struct clk_regmap *clk = to_clk_regmap(hw);
> > > > + struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> > > > + unsigned int val;
> > > > + int ret;
> > > > +
> > > > + ret = regmap_read(clk->map, div->offset, &val);
> > > > + if (ret)
> > > > +         return;
> > > >
> > > > + val &= (clk_div_mask(div->width) << div->shift);
> > > > + if (!val)
> > > > +         regmap_update_bits(clk->map, div->offset,
> > > > +                            clk_div_mask(div->width) << div->shift,
> > > > +                            clk_div_mask(div->width));
> > >
> > > This is wrong for several reasons:
> > > * You should hard code the initial value in the driver.
> > > * If shift is not 0, I doubt this will give the expected result.
> >
> > The value 0x00 of divider means nand clock off then read/write nand register is forbidden.
>
> That is not entirely true, you can access the clock register or you'd be in a
> chicken and egg situation.
>
> > Should we set the initial value in nand driver, or in sub emmc clk driver?
>
> In the nand driver, which is the consumer of the clock. see my previous comments
> about it.
an old version of this series had the code still in the NAND driver
(by writing to the registers directly instead of using the clk API).
this looks pretty much like a "sclk-div" to me (as I commented in v3
of this series: [0]):
- value 0 means disabled
- positive divider values
- (probably no duty control, but that's optional as far as I
understand sclk-div)
- uses max divider value when enabling the clock

if switching to sclk-div works then we can get rid of some duplicate code


Regards
Martin


[0] https://patchwork.kernel.org/patch/10607157/#22238243
