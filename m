From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Sep 2011 17:27:19 -0700
Subject: [PATCH v2] OMAP3: powerdomains: Match silicon revision to
	select the correct "core_pwrdm" definition
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870370A4D985@dbde02.ent.ti.com>
References: <1310730250-10920-1-git-send-email-abhilash.kv@ti.com>
	<FCCFB4CDC6E5564B9182F639FC3560870370A4D985@dbde02.ent.ti.com>
Message-ID: <20110915002719.GB30941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Koyamangalath, Abhilash <abhilash.kv@ti.com> [110812 00:12]:
> Hi 
> 
> > @@ -58,6 +59,24 @@ static struct powerdomain *_pwrdm_lookup(const char *name)
> > 
> >         list_for_each_entry(temp_pwrdm, &pwrdm_list, node) {
> >                 if (!strcmp(name, temp_pwrdm->name)) {
> > +                       if (!strcmp(name, "core_pwrdm") && cpu_is_omap3630()) {
> > +                               if (omap_rev() > OMAP3630_REV_ES1_0) {
> > +                                       /*
> > +                                        * match omap_chip info for OMAP3630
> > +                                        * Rev ES1.1, ES1.2 or higher
> > +                                        */
> > +                                       if (!(temp_pwrdm->omap_chip.oc
> > +                                               & CHIP_GE_OMAP3630ES1_1))
> > +                                               continue;
> > +                               } else {
> > +                                       /* match omap_chip info for OMAP3630
> > +                                        * Rev ES1.0
> > +                                        */
> > +                                       if (!(temp_pwrdm->omap_chip.oc
> > +                                                & CHIP_IS_OMAP3630ES1))
> > +                                               continue;
> > +                               }
> > +                       }
> >                         pwrdm = temp_pwrdm;
> >                         break;
> >                 }
>
> Any comments ?

Can you please check if this is still needed after Paul's
CHIP_IS removal patches? You can find them at:

git://git.pwsan.com/linux-2.6 omap_chip_remove_cleanup_3.2

Regards,

Tony
