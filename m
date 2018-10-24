From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 24 Oct 2018 11:00:50 +0200
Subject: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
In-Reply-To: <153997220960.53599.2059896905852359614@swboyd.mtv.corp.google.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
 <153988282130.5275.17528969137837015544@swboyd.mtv.corp.google.com>
 <01d07c83-b17e-70b5-6e9b-8150ee3aedf2@amlogic.com>
 <153997220960.53599.2059896905852359614@swboyd.mtv.corp.google.com>
Message-ID: <9db735d01a0f9fc3f82be6d45c88c4b98362d062.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-10-19 at 11:03 -0700, Stephen Boyd wrote:
> Quoting Jianxin Pan (2018-10-19 09:12:53)
> > On 2018/10/19 1:13, Stephen Boyd wrote:
> > > Quoting Jianxin Pan (2018-10-17 22:07:25)
> > > > diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
> > > > index 305ee30..f96314d 100644
> > > > --- a/drivers/clk/meson/clk-regmap.c
> > > > +++ b/drivers/clk/meson/clk-regmap.c
> > > > @@ -113,8 +113,25 @@ static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
> > > >                                   clk_div_mask(div->width) << div->shift, val);
> > > >  };
> > > >  
> > > > -/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
> > > > +static void clk_regmap_div_init(struct clk_hw *hw)
> > > > +{
> > > > +       struct clk_regmap *clk = to_clk_regmap(hw);
> > > > +       struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> > > > +       unsigned int val;
> > > > +       int ret;
> > > > +
> > > > +       ret = regmap_read(clk->map, div->offset, &val);
> > > > +       if (ret)
> > > > +               return;
> > > >  
> > > > +       val &= (clk_div_mask(div->width) << div->shift);
> > > > +       if (!val)
> > > > +               regmap_update_bits(clk->map, div->offset,
> > > > +                                  clk_div_mask(div->width) << div->shift,
> > > > +                                  clk_div_mask(div->width));
> > > > +}
> > > > +
> > > > +/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
> > > 
> > > We should add a patch to rename the symbol for qcom, i.e.
> > > qcom_clk_regmap_div_ro_ops, and then any symbols in this directory
> > > should be meson_clk_regmap_div_ro_ops.
> > 
> > "/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */"
> > This comment is not introduced in this patch.
> > I followed the naming style in this file and add clk_regmap_divider_with_init_ops.
> > 
> > @Jerome? What's your suggestion about this?
> 
> Yes you don't need to fix anything in this series. Just saying that in
> the future we should work on cleaning this up.


Well, first, I wonder why such a change ends up in a patch that is supposed to
add a controller.

If such a change was really required to implement a generic div (which I doubt)
it would need to be in separate with clear explanation.

Stephen,
I agree at some point we should squash the different regmap implementations and
provide generic (enough) implementation. There is not only qcom and meson, some
other controllers are redefining regmap ops and I bet driver outside of
drivers/clk/* could use a generic implementation as well.
