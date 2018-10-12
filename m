From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 12 Oct 2018 15:08:17 -0700
Subject: [PATCH v13 3/8] clk: Use devm_ in the register fixed factor clock
In-Reply-To: <CAHYQr0rR=mcV-SxZFW+5M4CTUaTv_f_bruyq91HiGP6sqUZ3Yw@mail.gmail.com>
References: <20180614215358.11264-1-ilia.lin@gmail.com>
 <20180614215358.11264-4-ilia.lin@gmail.com>
 <CAHYQr0rR=mcV-SxZFW+5M4CTUaTv_f_bruyq91HiGP6sqUZ3Yw@mail.gmail.com>
Message-ID: <153938209728.5275.8811599608746761178@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ricardo Salveti (2018-09-14 11:53:02)
> On Thu, Jun 14, 2018 at 6:55 PM <ilia.lin@gmail.com> wrote:
> >
> > From: Ilia Lin <ilialin@codeaurora.org>
> >
> > Use devm_clk_hw_register instead of clk_hw_register
> > to simplify the usage of this API. This way drivers that call
> > the clk_hw_register_fixed_factor won't need to maintain
> > a data structure for further cleanup.
> >
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/clk/clk-fixed-factor.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> > index a5d402de5584..8e39bda8e596 100644
> > --- a/drivers/clk/clk-fixed-factor.c
> > +++ b/drivers/clk/clk-fixed-factor.c
> > @@ -94,7 +94,7 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
> >         init.num_parents = 1;
> >
> >         hw = &fix->hw;
> > -       ret = clk_hw_register(dev, hw);
> > +       ret = devm_clk_hw_register(dev, hw);
> 
> Not sure what is the current state of this patch-set, but this change
> breaks drivers calling clk_hw_register_fixed_factor with a NULL dev
> (e.g. imx_clk_fixed_factor), as devm_clk_hw_register needs a valid dev
> for devres_add to work.
> 

Yep. Probably better to just have a driver register the clk_hw structure
itself with the clk framework vs. trying to get it right here in the
generic type registration function.
