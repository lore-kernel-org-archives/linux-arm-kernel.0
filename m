From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Jun 2013 10:12:12 +0100
Subject: [PATCH 18/33] clk: ux500: Add a 2-cell Device Tree parser for
 obtaining PRCC clocks
In-Reply-To: <CAPDyKFqN-cYeEG0CtAnqGNTudJ9F3cPbs5Hoq0quTL1DhAN72w@mail.gmail.com>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-19-git-send-email-lee.jones@linaro.org>
 <CAPDyKFqN-cYeEG0CtAnqGNTudJ9F3cPbs5Hoq0quTL1DhAN72w@mail.gmail.com>
Message-ID: <20130611091212.GB9216@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jun 2013, Ulf Hansson wrote:

> On 6 June 2013 14:17, Lee Jones <lee.jones@linaro.org> wrote:
> > PRCC (peripheral and kernel) clocks are specified using a property tuple
> > <&phandle base bit>, where 'base' is the peripheral (1, 2, 3, 5 or 6),
> > and bit is read-in value into that peripheral stipulated by the hardware
> > specification.
> >
> > Cc: Mike Turquette <mturquette@linaro.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/clk/ux500/u8500_clk.c |   19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
> > index ef948ff..3a7040b 100644
> > --- a/drivers/clk/ux500/u8500_clk.c
> > +++ b/drivers/clk/ux500/u8500_clk.c
> > @@ -15,6 +15,25 @@
> >  #include <linux/platform_data/clk-ux500.h>
> >  #include "clk.h"
> >
> > +struct clk *ux500_twocell_get(struct of_phandle_args *clkspec, void *data)
> > +{
> > +       struct clk **clk_data = data;
> > +       unsigned int base, bit;
> > +
> > +       if (clkspec->args_count != 2)
> > +               return  ERR_PTR(-EINVAL);
> > +
> > +       base = clkspec->args[0];
> > +       bit = clkspec->args[1];
> > +
> > +       if (base != 1 && base != 2 && base != 3 && base != 5 && base != 6) {
> > +               pr_err("%s: invalid PRCC base %d\n", __func__, base);
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       return PRCC_SHOW(clk_data, base, bit);
> 
> Where did this macro come from?

You're right, there is an ordering issue here, I'll fixup, thanks.

> > +}
> > +
> >  const static struct of_device_id u8500_clk_of_match[] = {
> >         { .compatible = "stericsson,u8500-clks", },
> >         { },
> >

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
