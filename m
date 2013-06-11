From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Jun 2013 12:10:50 +0100
Subject: [PATCH 19/33] clk: ux500: Add Device Tree support for the PRCMU
 clock
In-Reply-To: <CAPDyKFozMRxcpeEfaqKQrZ1_xxr=UMLw2EybdKiRM2zWcppikw@mail.gmail.com>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-20-git-send-email-lee.jones@linaro.org>
 <CAPDyKFozMRxcpeEfaqKQrZ1_xxr=UMLw2EybdKiRM2zWcppikw@mail.gmail.com>
Message-ID: <20130611111050.GC3330@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jun 2013, Ulf Hansson wrote:

> On 6 June 2013 14:17, Lee Jones <lee.jones@linaro.org> wrote:
> > This patch enables clocks to be specified from Device Tree via phandles
> > to the "prcmu-clock" node.
> >
> > Cc: Mike Turquette <mturquette@linaro.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/clk/ux500/u8500_clk.c |   50 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 48 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
> > index 3a7040b..4f5ad4c 100644
> > --- a/drivers/clk/ux500/u8500_clk.c
> > +++ b/drivers/clk/ux500/u8500_clk.c
> > @@ -15,6 +15,8 @@
> >  #include <linux/platform_data/clk-ux500.h>
> >  #include "clk.h"
> >
> > +static struct clk *prcmu_clk[PRCMU_NUM_CLKS];
> > +
> >  struct clk *ux500_twocell_get(struct of_phandle_args *clkspec, void *data)
> 
> Actually I thought ux500_twocell_get was going to be used in this
> patch, since the previous one was adding this helper function, but it
> isn't?

Yes it is:

> >         for_each_child_of_node(np, child) {
> > -               /* Place holder for supported nodes. */
> > +               static struct clk_onecell_data clk_data;
> > +
> > +               if (!of_node_cmp(child->name, "prcmu-clock")) {
> > +                       clk_data.clks = prcmu_clk;
> > +                       clk_data.clk_num = ARRAY_SIZE(prcmu_clk);
> > +                       of_clk_add_provider(child, of_clk_src_onecell_get, &clk_data);

Here.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
