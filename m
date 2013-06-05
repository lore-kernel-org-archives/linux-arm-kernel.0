From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 05 Jun 2013 22:48:17 +0100
Subject: [PATCH 15/15] OF: remove #ifdef from linux/of_platform.h
In-Reply-To: <CAL_JsqLRJ1cEWBfAdHEyngJHQKauJ6XzWH2JwXh1qDusMkzUGA@mail.gmail.com>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <201306012257.02327.arnd@arndb.de>
 <CAL_JsqKMOy4CM=FXbsy7mQ1f0DLyK6n_cuZ92uhsSM2Mq-3B1g@mail.gmail.com>
 <201306041951.00447.arnd@arndb.de>
 <CAL_JsqLRJ1cEWBfAdHEyngJHQKauJ6XzWH2JwXh1qDusMkzUGA@mail.gmail.com>
Message-ID: <20130605214817.A46223E10E4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jun 2013 17:24:51 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Jun 4, 2013 at 12:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 04 June 2013, Rob Herring wrote:
> >> On Sat, Jun 1, 2013 at 3:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Saturday 01 June 2013, Rob Herring wrote:
> >> >> No, we still need empty functions. Here is what of_device.h looks like:
> >> >>
> >> >> http://tinyurl.com/l2azz5m
> >> >>
> >> >> BTW, it has your ack.
> >> >>
> >> >
> >> > Could you add a patch on top that only puts the function declarations
> >> > inside of #ifdef that don't have an inline wrapper?
> >>
> >> I'm confused. You mean that DO have an inline? Like this:
> >>
> >> void foo(void);
> >>
> >> #ifdef CONFIG_OF
> >> void bar(void);
> >> #else
> >> static inline void bar(void) {}
> >> #endif
> >
> > Yes, sorry. That's what I meant.
> >
> >> > It's really annoying to have to change the header file every time one
> >> > needs to call a function from a driver in the DT-only case.
> >>
> >> The functions without inlines are ones that drivers should not call
> >> and should only be called from OF enabled code. That's why we have not
> >> done a complete pass of adding inlines for everything.
> >
> > The problem is that it's a bad default. The convention in kernel code
> > is not to hide declarations in #ifdef, for multiple reasons:
> >
> > * It avoids unnecessary code rebuilds when the symbol changes between
> >   two 'make' runs.
> >
> > * It lets drivers and platform code call the function from dead code
> >   without causing a build error, thus improving compile coverage.
> >
> > * It's much nicer to read when can write your code like
> >
> > void __init exynos_init_io(struct map_desc *mach_desc, int size)
> > {
> >         if (IS_ENABLED_(CONFIG_OF) && initial_boot_params)
> >                 of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
> >         else
> >                 iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));
> >         ...
> > }
> >
> > instead of
> >
> > void __init exynos_init_io(struct map_desc *mach_desc, int size)
> > {
> > #ifdef CONFIG_OF
> >         if (initial_boot_params)
> >                 of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
> >         else
> > #endif
> >                 iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));
> >         ...
> > }

A big part of the reason for not having the headers was to discourage
code like the above; so instead of having a whole bunch of DT functions
inline in a drivers probe hook, they would be collected off in a DT
parse function that can all get compiled away as a block.

However, that's the first time I've thought about the code coverage
issue and it is a good point.

> >
> > The first one looks like actual C code, the second is really ugly,
> > and an inline wrapper wouldn't even do the right thing here.
> 
> Right. I get all that. You still have to go add inlines if you want to make:
> 
> if (IS_ENABLED(CONFIG_OF))
>     of_foo();
> 
> just be:
> 
> of_foo();
> 
> There are situations for both and only inlines cover both cases. I
> don't see a reason we would want to allow the first case and not allow
> the second case. I am tired of taking patches adding the inlines 1 by
> 1, so perhaps we need to refactor the OF headers to better separate
> core infrastructure includes vs. driver only includes if that is
> really a concern.

I'm fine with that. Attitudes have changed quite a bit in the last few
years about DT code in device drivers so it isn't as important to make a
hard distinction about when DT functions can be called.

g.
