From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Jun 2013 19:51:00 +0200
Subject: [PATCH 15/15] OF: remove #ifdef from linux/of_platform.h
In-Reply-To: <CAL_JsqKMOy4CM=FXbsy7mQ1f0DLyK6n_cuZ92uhsSM2Mq-3B1g@mail.gmail.com>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <201306012257.02327.arnd@arndb.de>
 <CAL_JsqKMOy4CM=FXbsy7mQ1f0DLyK6n_cuZ92uhsSM2Mq-3B1g@mail.gmail.com>
Message-ID: <201306041951.00447.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 June 2013, Rob Herring wrote:
> On Sat, Jun 1, 2013 at 3:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Saturday 01 June 2013, Rob Herring wrote:
> >> No, we still need empty functions. Here is what of_device.h looks like:
> >>
> >> http://tinyurl.com/l2azz5m
> >>
> >> BTW, it has your ack.
> >>
> >
> > Could you add a patch on top that only puts the function declarations
> > inside of #ifdef that don't have an inline wrapper?
> 
> I'm confused. You mean that DO have an inline? Like this:
> 
> void foo(void);
> 
> #ifdef CONFIG_OF
> void bar(void);
> #else
> static inline void bar(void) {}
> #endif

Yes, sorry. That's what I meant.

> > It's really annoying to have to change the header file every time one
> > needs to call a function from a driver in the DT-only case.
> 
> The functions without inlines are ones that drivers should not call
> and should only be called from OF enabled code. That's why we have not
> done a complete pass of adding inlines for everything.

The problem is that it's a bad default. The convention in kernel code
is not to hide declarations in #ifdef, for multiple reasons:

* It avoids unnecessary code rebuilds when the symbol changes between 
  two 'make' runs.

* It lets drivers and platform code call the function from dead code
  without causing a build error, thus improving compile coverage.

* It's much nicer to read when can write your code like

void __init exynos_init_io(struct map_desc *mach_desc, int size)
{
        if (IS_ENABLED_(CONFIG_OF) && initial_boot_params)
                of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
        else
                iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));
	...
}

instead of

void __init exynos_init_io(struct map_desc *mach_desc, int size)
{
#ifdef CONFIG_OF
        if (initial_boot_params)
                of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
        else
#endif
                iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));
	...
}

The first one looks like actual C code, the second is really ugly,
and an inline wrapper wouldn't even do the right thing here.

	Arnd
