From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 May 2015 22:26:33 +0200
Subject: [PATCH] ARM: uniphier: only select TWD for SMP
In-Reply-To: <CAK7LNATdibWyVuMMyw2h5MMVJFdEu4TWrDoGpGC9cPj068FXiQ@mail.gmail.com>
References: <2227073.rylFc5jIqu@wuerfel>
 <CAK7LNATdibWyVuMMyw2h5MMVJFdEu4TWrDoGpGC9cPj068FXiQ@mail.gmail.com>
Message-ID: <2076486.2f0MnouCnx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 02:18:53 Masahiro Yamada wrote:
> Hi Arnd,
> 
> 2015-05-19 0:55 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> > This makes uniphier behave like all the other platforms that
> > support TWD, and only select this driver when SMP is enabled.
> > Without this, we get a compile error on UP builds:
> >
> > arch/arm/kernel/smp_twd.c: In function 'twd_local_timer_of_register':
> > arch/arm/kernel/smp_twd.c:391:20: error: 'setup_max_cpus' undeclared (first use in this function)
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > I'd like to apply this directly to the next/soc branch
> >
> > diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
> > index a017b1dd9c78..b640458fd757 100644
> > --- a/arch/arm/mach-uniphier/Kconfig
> > +++ b/arch/arm/mach-uniphier/Kconfig
> > @@ -5,7 +5,7 @@ config ARCH_UNIPHIER
> >         select ARM_GLOBAL_TIMER
> >         select ARM_GIC
> >         select HAVE_ARM_SCU
> > -       select HAVE_ARM_TWD
> > +       select HAVE_ARM_TWD if SMP
> >         help
> >           Support for UniPhier SoC family developed by Socionext Inc.
> >           (formerly, System LSI Business Division of Panasonic Corporation)
> 
> 
> 
> I am not familiar with smp_twd.c, but I think
> the local timer and watchdog still exist in the ARM mpcore
> even if it is a uni-processor implementation.
> 
> That is why I simply selected HAVE_ARM_TWD.
> Am I doing something wrong?

I was wondering about this too. Everybody else has the 'if SMP' dependency
here, and if I leave it out, I get the build error. We could probably
fix that build error easily, but I don't know what the exact reason is
we can't have use the code when there is only one CPU.

This was introduced as part of 904464b91eca8 ("ARM: 7655/1: smp_twd: make
twd_local_timer_of_register() no-op for nosmp"), before that, we would
just try to use the driver, but fail in one of these calls:

        twd_evt = alloc_percpu(struct clock_event_device);
        err = request_percpu_irq(twd_ppi, twd_handler, "twd", twd_evt);
        err = register_cpu_notifier(&twd_timer_cpu_nb);

which in turn causes a run-time warning. If we could fix that code
to just work on non-SMP, we can probably use that driver on all
machines that have the hardware.

> Is it reasonable to have something depends on HAVE_ARM_TWD?
> 
> 
> config SMP_ARM_TWD
>       depends on SMP && HAVE_ARM_TWD
> 
> 
> 
> obj-$(SMP_ARM_TWD)       +=   smp_twd.o
> 
> 
> 
> I am not sure...

This would probably work, but I'd like to understand the problem
more thoroughly before we change the behavior.

[adding Russell and Will to Cc, maybe they remember better why we
do things the way we do here]

	Arnd
