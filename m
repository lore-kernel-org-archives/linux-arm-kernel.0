From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 25 Oct 2018 09:31:32 -0500
Subject: [PATCH v3 1/3] of/fdt: Absorb ARM64's
 __early_init_dt_declare_initrd()
In-Reply-To: <20181025140636.GA30658@n2100.armlinux.org.uk>
References: <20181025001742.6510-1-f.fainelli@gmail.com>
 <20181025001742.6510-2-f.fainelli@gmail.com>
 <CAL_JsqK-bSu520fx-dWMyHsooOU9=24DEf6fZSudQ-QKDkXbGA@mail.gmail.com>
 <20181025140636.GA30658@n2100.armlinux.org.uk>
Message-ID: <CAL_JsqJU67p+Qck-38uaV81MWfGshPem96cAKcz3W7--dzyzoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 9:06 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 25, 2018 at 08:25:04AM -0500, Rob Herring wrote:
> > On Wed, Oct 24, 2018 at 7:17 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >
> > > ARM64 is the only architecture that requires a re-definition of
> > > __early_init_dt_declare_initrd(), absorb its custom implemention in
> > > drivers/of/fdt.c.
> > >
> > > Suggested-by: Rob Herring <robh@kernel.org.
> >
> > You forgot a shift key. :)
> >
> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > ---
> > >  drivers/of/fdt.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index 800ad252cf9c..7d316f008f22 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -896,9 +896,14 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
> > >  static void __early_init_dt_declare_initrd(unsigned long start,
> > >                                            unsigned long end)
> > >  {
> > > +#if IS_ENABLED(CONFIG_ARM64)
> >
> > C code, not preprocessor please.
> >
> > > +       initrd_start = start;
> > > +       initrd_end = end;
> >
> > Thinking some more about this, perhaps it is better to just add the
> > *_phys variants now along side the VA variants and set them here. Then
> > the arm64 code can override the initrd_start, initrd_end, and
> > initrd_below_start_ok values.
>
> Please, let's not make the age old mistake of inventing new symbols
> for stuff that already exists:
>
> $ grep phys_initrd_start arch/ -rl
> arch/arm/mm/init.c
> arch/nds32/mm/init.c
> arch/unicore32/mm/init.c
> $ grep initrd_start_phys arch/ -rl
> $
>
> Please use the "phys_initrd_start" and "phys_initrd_end" naming,

Yes, of course. That is what I intended. I assumed Florian would be
aware of it from your other email.

> which already exist on some architectures rather than inventing a new
> set of symbols for the same thing and then forcing arches to change.
> We could then get rid of:
>
>         /* FDT scan will populate initrd_start */
>         if (initrd_start && !phys_initrd_size) {
>                 phys_initrd_start = __virt_to_phys(initrd_start);
>                 phys_initrd_size = initrd_end - initrd_start;
>         }
>
>         initrd_start = initrd_end = 0;
>
> in ARM, which exists purely to cope with DT.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
