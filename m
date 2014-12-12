From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 12 Dec 2014 13:35:38 -0800
Subject: [PATCH v2] sun9i: clk: Fix compile error caused by "clk: sunxi:
 Give sunxi_factors_register a registers parameter"
In-Reply-To: <20141212200003.20398.13200@quantum>
References: <1418397529-1188-1-git-send-email-hdegoede@redhat.com>
 <20141212200003.20398.13200@quantum>
Message-ID: <20141212213538.20398.29885@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mike Turquette (2014-12-12 12:00:03)
> Quoting Hans de Goede (2014-12-12 07:18:49)
> > My "clk: sunxi: Give sunxi_factors_register a registers parameter" patch did
> > not adjust the sunxi_factors_clock register calls in the new clk-sun9i-core.c
> > clock code, causing compilation errors. This fixes this.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Applied.

Oops, spoke to soon. I don't have "clk: sunxi: Give
sunxi_factors_register a registers parameter" in my tree yet. I was just
trying to get this fix in quickly before sending out my PR. Please
disregard the noise.

Regards,
Mike

> 
> Regards,
> Mike
> 
> > ---
> >  drivers/clk/sunxi/clk-sun9i-core.c | 27 ++++++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
> > index 3cb9036..110197a 100644
> > --- a/drivers/clk/sunxi/clk-sun9i-core.c
> > +++ b/drivers/clk/sunxi/clk-sun9i-core.c
> > @@ -22,6 +22,21 @@
> >  
> >  #include "clk-factors.h"
> >  
> > +static struct clk *sun9i_factors_register(struct device_node *node,
> > +                                         const struct factors_data *data,
> > +                                         spinlock_t *lock)
> > +{
> > +       void __iomem *reg;
> > +
> > +       reg = of_iomap(node, 0);
> > +       if (!reg) {
> > +               pr_err("Could not get registers for factors-clk: %s\n",
> > +                      node->name);
> > +               return NULL;
> > +       }
> > +
> > +       return sunxi_factors_register(node, data, lock, reg);
> > +}
> >  
> >  /**
> >   * sun9i_a80_get_pll4_factors() - calculates n, p, m factors for PLL1
> > @@ -89,7 +104,7 @@ static DEFINE_SPINLOCK(sun9i_a80_pll4_lock);
> >  
> >  static void __init sun9i_a80_pll4_setup(struct device_node *node)
> >  {
> > -       sunxi_factors_register(node, &sun9i_a80_pll4_data, &sun9i_a80_pll4_lock);
> > +       sun9i_factors_register(node, &sun9i_a80_pll4_data, &sun9i_a80_pll4_lock);
> >  }
> >  CLK_OF_DECLARE(sun9i_a80_pll4, "allwinner,sun9i-a80-pll4-clk", sun9i_a80_pll4_setup);
> >  
> > @@ -139,8 +154,10 @@ static DEFINE_SPINLOCK(sun9i_a80_gt_lock);
> >  
> >  static void __init sun9i_a80_gt_setup(struct device_node *node)
> >  {
> > -       struct clk *gt = sunxi_factors_register(node, &sun9i_a80_gt_data,
> > +       struct clk *gt = sun9i_factors_register(node, &sun9i_a80_gt_data,
> >                                                 &sun9i_a80_gt_lock);
> > +       if (!gt)
> > +               return;
> >  
> >         /* The GT bus clock needs to be always enabled */
> >         __clk_get(gt);
> > @@ -194,7 +211,7 @@ static DEFINE_SPINLOCK(sun9i_a80_ahb_lock);
> >  
> >  static void __init sun9i_a80_ahb_setup(struct device_node *node)
> >  {
> > -       sunxi_factors_register(node, &sun9i_a80_ahb_data, &sun9i_a80_ahb_lock);
> > +       sun9i_factors_register(node, &sun9i_a80_ahb_data, &sun9i_a80_ahb_lock);
> >  }
> >  CLK_OF_DECLARE(sun9i_a80_ahb, "allwinner,sun9i-a80-ahb-clk", sun9i_a80_ahb_setup);
> >  
> > @@ -210,7 +227,7 @@ static DEFINE_SPINLOCK(sun9i_a80_apb0_lock);
> >  
> >  static void __init sun9i_a80_apb0_setup(struct device_node *node)
> >  {
> > -       sunxi_factors_register(node, &sun9i_a80_apb0_data, &sun9i_a80_apb0_lock);
> > +       sun9i_factors_register(node, &sun9i_a80_apb0_data, &sun9i_a80_apb0_lock);
> >  }
> >  CLK_OF_DECLARE(sun9i_a80_apb0, "allwinner,sun9i-a80-apb0-clk", sun9i_a80_apb0_setup);
> >  
> > @@ -266,6 +283,6 @@ static DEFINE_SPINLOCK(sun9i_a80_apb1_lock);
> >  
> >  static void __init sun9i_a80_apb1_setup(struct device_node *node)
> >  {
> > -       sunxi_factors_register(node, &sun9i_a80_apb1_data, &sun9i_a80_apb1_lock);
> > +       sun9i_factors_register(node, &sun9i_a80_apb1_data, &sun9i_a80_apb1_lock);
> >  }
> >  CLK_OF_DECLARE(sun9i_a80_apb1, "allwinner,sun9i-a80-apb1-clk", sun9i_a80_apb1_setup);
> > -- 
> > 2.1.0
> > 
