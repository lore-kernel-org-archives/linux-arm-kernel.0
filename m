From: horms@verge.net.au (Simon Horman)
Date: Thu, 22 Aug 2013 15:34:26 +0900
Subject: [PATCH 01/02] ARM: shmobile: Add r8a73a4 SMP support using APMU
 code
In-Reply-To: <20130822054834.GG5151@quad.lixom.net>
References: <20130807225531.9856.18974.sendpatchset@w520>
 <20130807225540.9856.67383.sendpatchset@w520>
 <CANqRtoQmoOWwTyed4-KnWPJfWV8rLMHLCSiN1a5v6=4Bmj7Z6A@mail.gmail.com>
 <20130821085714.GH20014@verge.net.au>
 <20130822054834.GG5151@quad.lixom.net>
Message-ID: <20130822063426.GA20703@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 10:48:34PM -0700, Olof Johansson wrote:
> [+khilman]
> 
> Hi,
> 
> On Wed, Aug 21, 2013 at 05:57:15PM +0900, Simon Horman wrote:
> > On Thu, Aug 08, 2013 at 02:52:32PM +0900, Magnus Damm wrote:
> > > Hi Arnd and Olof,
> > > 
> > > On Thu, Aug 8, 2013 at 7:55 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > > > From: Magnus Damm <damm@opensource.se>
> > > >
> > > > Add r8a73a4 SMP support using the shared APMU code. To enable
> > > > SMP the r8a73a4 specific DTS needs to be updated to include
> > > > CPU cores, and this is happening in a separate patch.
> > > >
> > > > Signed-off-by: Magnus Damm <damm@opensource.se>
> > > > ---
> > > >
> > > >  arch/arm/mach-shmobile/Makefile               |    1
> > > >  arch/arm/mach-shmobile/include/mach/r8a73a4.h |    1
> > > >  arch/arm/mach-shmobile/setup-r8a73a4.c        |    3 +
> > > >  arch/arm/mach-shmobile/smp-r8a73a4.c          |   75 +++++++++++++++++++++++++
> > > >  4 files changed, 80 insertions(+)
> > > >
> > > > --- 0001/arch/arm/mach-shmobile/Makefile
> > > > +++ work/arch/arm/mach-shmobile/Makefile        2013-08-07 20:07:31.000000000 +0900
> > > > @@ -33,6 +33,7 @@ endif
> > > >  # SMP objects
> > > >  smp-y                          := platsmp.o headsmp.o
> > > >  smp-$(CONFIG_ARCH_SH73A0)      += smp-sh73a0.o headsmp-scu.o platsmp-scu.o
> > > > +smp-$(CONFIG_ARCH_R8A73A4)     += smp-r8a73a4.o platsmp-apmu.o
> > > >  smp-$(CONFIG_ARCH_R8A7779)     += smp-r8a7779.o headsmp-scu.o platsmp-scu.o
> > > >  smp-$(CONFIG_ARCH_EMEV2)       += smp-emev2.o headsmp-scu.o platsmp-scu.o
> > > >
> > > > --- 0008/arch/arm/mach-shmobile/include/mach/r8a73a4.h
> > > > +++ work/arch/arm/mach-shmobile/include/mach/r8a73a4.h  2013-08-07 20:08:02.000000000 +0900
> > > > @@ -6,5 +6,6 @@ void r8a73a4_add_dt_devices(void);
> > > >  void r8a73a4_clock_init(void);
> > > >  void r8a73a4_pinmux_init(void);
> > > >  void r8a73a4_init_early(void);
> > > > +extern struct smp_operations r8a73a4_smp_ops;
> > > >
> > > >  #endif /* __ASM_R8A73A4_H__ */
> > > > --- 0008/arch/arm/mach-shmobile/setup-r8a73a4.c
> > > > +++ work/arch/arm/mach-shmobile/setup-r8a73a4.c 2013-08-07 20:07:48.000000000 +0900
> > > > @@ -212,6 +212,9 @@ void __init r8a73a4_init_early(void)
> > > >  #ifndef CONFIG_ARM_ARCH_TIMER
> > > >         shmobile_setup_delay(1500, 2, 4); /* Cortex-A15 @ 1500MHz */
> > > >  #endif
> > > > +#ifdef CONFIG_SMP
> > > > +       smp_set_ops(&r8a73a4_smp_ops);
> > > > +#endif
> > > >  }
> > > 
> > > Arnd or Olof, may I ask for your advice here?
> > > 
> > > I think it's quite nice to use smp_set_ops() in ->init_early() to
> > > install the per-SoC SMP operations. I prefer that over using the
> > > smp_ops directly in the per-board DT_MACHINE_START. Which way do you
> > > prefer?
> > 
> > Olof, Arnd, Ping.
> 
> 
> Sorry, missed the original question when it was posted.
> 
> I guess I don't see the benefit of doing it in code vs smp_init? You
> already have a DT_MACHINE section for r8a73a4 in this case.
> 
> If you use .smp_init = smp_init_ops(r8a73a4_smp_ops) then there's no
> ifdef needed down in the DT_MACHINE section either.

Magnus, would you care to respin this series and the corresponding
r8a7790 series accordingly?
