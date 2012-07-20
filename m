From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Jul 2012 16:46:57 +0800
Subject: [PATCH 2/3] PM / OPP: Initialize OPP table from device tree
In-Reply-To: <CAOMWX4fq8aWpRgtBj+5FgqhMus=zJL3Ubqe9pwiz-Y3a6V3svg@mail.gmail.com>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-3-git-send-email-shawn.guo@linaro.org>
 <CAOMWX4fq8aWpRgtBj+5FgqhMus=zJL3Ubqe9pwiz-Y3a6V3svg@mail.gmail.com>
Message-ID: <20120720084655.GB31866@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for reviewing it, Nishanth.

On Fri, Jul 20, 2012 at 01:00:26AM -0500, Menon, Nishanth wrote:
> > +cpu at 0 {
> > +       compatible = "arm,cortex-a9";
> I am not sure how this works - would an example of OMAP4430, 60, 70
> help? they have completely different OPP entries.
> 
Basically, patch #3 is a user of this and shows how this works.

> > +       reg = <0>;
> > +       next-level-cache = <&L2>;
> > +       operating-points = <
> > +               /* kHz    uV    en */
> > +               1200000 1275000 0
> > +               996000  1225000 1
> > +               792000  1100000 1
> > +               672000  1100000 0
> > +               396000  950000  1
> > +               198000  850000  1
> 
> Just my 2cents, If we change en to be a flag:
> 0 - add, but disable
> 1 - add (enabled)
> we could extend this further if the definition is a flag, for example:
> 2 - add and disable IF any of notifier chain return failure
> 3- add but dont call notifier chain (e.g. OPPs that are present for All SoC)
> 
> in addition, SoC might have additional properties associated with each
> OPP such a flag
> could be split up to mean lower 16 bits as OPP library flag and higher
> 16 bit to mean SoC custom flag
> 
> Example - On certain SoC a specific type of power technique is
> supposed to be used per OPP, such a flag
> passed on via notifiers to SoC handler might be capable of
> centralizing the OPP information into the DT.
> 
I do not follow on the idea of having the third tuple being a flag.
The binding is only meant to represent the aspects of operating-points,
while operating-points are all about frequency and voltage, nothing
else.  No Linux implementation details should be encoded here.  I'm
even a little unhappy about having enabling/availability in the third
tuple.  If anyone complains about that,  I will remove it from the
binding without a hesitation.

> > +       >;
> > +};
> > diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> > index ac993ea..2d750f9 100644
> > --- a/drivers/base/power/opp.c
> > +++ b/drivers/base/power/opp.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/rculist.h>
> >  #include <linux/rcupdate.h>
> >  #include <linux/opp.h>
> > +#include <linux/of.h>
> >
> >  /*
> >   * Internal data structure organization with the OPP layer library is as
> > @@ -674,3 +675,68 @@ struct srcu_notifier_head *opp_get_notifier(struct device *dev)
> >
> >         return &dev_opp->head;
> >  }
> > +
> > +#ifdef CONFIG_OF
> > +/**
> > + * of_init_opp_table() - Initialize opp table from device tree
> > + * @dev:       device pointer used to lookup device OPPs.
> > + *
> > + * Register the initial OPP table with the OPP library for given device.
> > + */
> > +int of_init_opp_table(struct device *dev)
> > +{
> > +       struct device_node *np = dev->of_node;
> > +       const char *propname = "operating-points";
> > +       const struct property *pp;
> > +       u32 *opp;
> > +       int ret, i, nr;
> > +
> > +       pp = of_find_property(np, propname, NULL);
> > +       if (!pp) {
> > +               dev_err(dev, "%s: Unable to find property", __func__);
> > +               return -ENODEV;
> > +       }
> > +
> > +       opp = kzalloc(pp->length, GFP_KERNEL);
> > +       if (!opp) {
> > +               dev_err(dev, "%s: Unable to allocate array\n", __func__);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       nr = pp->length / sizeof(u32);
> error warn if the pp->length is not multiple of u32?

The DT core ensures that any integer encoded there will an u32.

> we also expect
> later on to be a multiple of 3(f,v,disable
> 
Yes, I thought about checking that, but I chose to simply ignore those
suspicious tuples at the end of the list.  I will add the check for
that, since you commented here.

> > +       ret = of_property_read_u32_array(np, propname, opp, nr);
> > +       if (ret) {
> > +               dev_err(dev, "%s: Unable to read OPPs\n", __func__);
> > +               goto out;
> > +       }
> > +
> > +       nr /= 3;
> > +       for (i = 0; i < nr; i++) {
> > +               /*
> > +                * Each OPP is a set of tuples consisting of frequency,
> > +                * voltage and availability like <freq-kHz vol-uV enable>.
> > +                */
> > +               u32 *val = opp + i * 3;
> > +
> > +               val[0] *= 1000;
> > +               ret = opp_add(dev, val[0], val[1]);
> > +               if (ret) {
> > +                       dev_warn(dev, "%s: Failed to add OPP %d: %d\n",
> > +                                __func__, val[0], ret);
> > +                       continue;
> > +               }
> > +
> > +               if (!val[2]) {
> > +                       ret = opp_disable(dev, val[0]);
> Since we are updating the table out of context of the SoC users,
> consider what might happen if someone where to operate on the OPP
> after opp_add, but before opp_disable?

I would take this as another comment reminding me to remove the
enabling/availability tuple from the binding.  Will do it in the
next version.

> instead of having the pain of adding an OPP and then disabling it,
> since the code will now move to core OPP
> library itself, wont it be better to hold dev_opp_list_lock and update
> the full table with a proper list walk - yes
> the current opp_add and opp_disable apis would need refactoring to be
> reusable. It will also save on
> synchronize_rcu calls on multiple iterations of the list.
> 
> 
> > +                       if (ret)
> > +                               dev_warn(dev, "%s: Failed to disable OPP %d: %d\n",
> > +                                        __func__, val[0], ret);
> 
> umm... but we override the return with 0? OPP add failure might
> indicate the table is invalid/corrupted - or no memory.
> What is the point in populating a bad table up? having a singular
> function with direct access to internal structures
> might save us these un-necessary dilemma.
> 
The return overriding only happens when opp_add or opp_disable call
fails on particular entry.  That does not necessarily mean the whole
OPP table is completely invalid/corrupted.  A warn message is enough,
IMO.

> 
> > +               }
> > +       }
> > +
> > +       ret = 0;
> > +out:
> > +       kfree(opp);
> > +       return ret;
> > +}
> > +#endif
> > diff --git a/include/linux/opp.h b/include/linux/opp.h
> > index 2a4e5fa..fd165ad 100644
> > --- a/include/linux/opp.h
> > +++ b/include/linux/opp.h
> > @@ -48,6 +48,10 @@ int opp_disable(struct device *dev, unsigned long freq);
> >
> >  struct srcu_notifier_head *opp_get_notifier(struct device *dev);
> >
> > +#ifdef CONFIG_OF
> > +int of_init_opp_table(struct device *dev);
> 
> #else
> static inline int of_init_opp_table(struct device *dev) { return -EINVAL; }
> ?
> 
Sounds good.

Regards,
Shawn

> > +#endif
> > +
> >  #else
> >  static inline unsigned long opp_get_voltage(struct opp *opp)
> >  {
> 
> 
> Regards,
> Nishanth Menon
