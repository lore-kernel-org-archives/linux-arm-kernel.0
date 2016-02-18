From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 17 Feb 2016 16:07:47 -0800
Subject: [PATCH] clk: fix clk-gpio.c with optional clock= DT property
In-Reply-To: <20160217230529.GM19428@n2100.arm.linux.org.uk>
References: <E1aFJ0A-00086Z-0I@rmk-PC.arm.linux.org.uk>
 <20160217230529.GM19428@n2100.arm.linux.org.uk>
Message-ID: <20160218000747.2278.46405@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Russell King - ARM Linux (2016-02-17 15:05:29)
> On Sat, Jan 02, 2016 at 10:01:34AM +0000, Russell King wrote:
> > When the clock DT property is not given, of_clk_get_parent_count()
> > returns -ENOENT, which then tries to allocate -2 x 4 bytes of memory,
> > which of course fails, causing the whole driver to fail to create
> > the clock.
> > 
> > This causes the SolidRun platforms to fail probing the SDHCI1 interface
> > which is connected to the WiFi.
> > 
> > Fix this by detecting errno codes, skipping the allocation, and fixing
> > of_clk_gpio_gate_delayed_register_get() to handle a NULL parent_names
> > array.
> > 
> > Fixes: 80eeb1f0f757 ("clk: add gpio controlled clock multiplexer")
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> > This goes all the way back to 80eeb1f0f757 ("clk: add gpio controlled
> > clock multiplexer") introduced in June in v4.3-rc2 - which raises the
> > question why _development_ work in clk is being merged outside of the
> > merge window.
> > 
> > A rewrite of this patch will be necessary to apply to v4.3 kernels.
> > 
> > This applies on top of v4.4-rc6.
> > 
> >  drivers/clk/clk-gpio.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
> > index 335322dc403f..05cca9298f44 100644
> > --- a/drivers/clk/clk-gpio.c
> > +++ b/drivers/clk/clk-gpio.c
> > @@ -264,8 +264,8 @@ static struct clk *of_clk_gpio_gate_delayed_register_get(const char *name,
> >               const char * const *parent_names, u8 num_parents,
> >               unsigned gpio, bool active_low)
> >  {
> > -     return clk_register_gpio_gate(NULL, name, parent_names[0],
> > -                     gpio, active_low, 0);
> > +     return clk_register_gpio_gate(NULL, name, parent_names ?
> > +                     parent_names[0] : NULL, gpio, active_low, 0);
> >  }
> >  
> >  static struct clk *of_clk_gpio_mux_delayed_register_get(const char *name,
> > @@ -292,13 +292,18 @@ static void __init of_gpio_clk_setup(struct device_node *node,
> >               return;
> >  
> >       num_parents = of_clk_get_parent_count(node);
> > -
> > -     parent_names = kcalloc(num_parents, sizeof(char *), GFP_KERNEL);
> > -     if (!parent_names)
> > -             return;
> > -
> > -     for (i = 0; i < num_parents; i++)
> > -             parent_names[i] = of_clk_get_parent_name(node, i);
> > +     if (num_parents > 0) {
> > +             parent_names = kcalloc(num_parents, sizeof(char *), GFP_KERNEL);
> > +             if (!parent_names) {
> > +                     kfree(data);
> > +                     return;
> > +             }
> > +
> > +             for (i = 0; i < num_parents; i++)
> > +                     parent_names[i] = of_clk_get_parent_name(node, i);
> > +     } else {
> > +             parent_names = NULL;
> > +     }
> >  
> >       data->num_parents = num_parents;
> >       data->parent_names = parent_names;
> > -- 
> > 2.1.0
> 
> Yes, indeed, my patch above which fixed clk-gpio.c as can be seen above
> does not have the problem that I'm currently seeing...

Hi Russell,

I must be missing something. After merging your patch on top of Brian's,
the code looks like:

        ...
        int i, num_parents;

        num_parents = of_clk_get_parent_count(node);
        if (num_parents < 0)
                return;

        data = kzalloc(sizeof(*data), GFP_KERNEL);
        if (!data)
                return;

        if (num_parents) {
                parent_names = kcalloc(num_parents, sizeof(char *), GFP_KERNEL);
                if (!parent_names) {
                        kfree(data);
                        return;
                }

                for (i = 0; i < num_parents; i++)
                        parent_names[i] = of_clk_get_parent_name(node, i);
        } else {
                parent_names = NULL;
        }

Brian's if (num_parents < 0) check, followed by the if (num_parent)
check appear equivalent to your original patch. Not sure why I merged it
as if (num_parents) instead of if (num_parents > 0) as your original
patch uses, but thanks to the extra check that predates your patch it
should be equivalent.

Let me know if I've lost the plot.

Regards,
Mike

> 
> -- 
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
