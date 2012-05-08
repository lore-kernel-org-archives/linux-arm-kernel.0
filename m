From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 May 2012 19:35:53 +0000
Subject: [PATCH 01/02] mach-shmobile: Emma Mobile EV2 SoC base support
In-Reply-To: <CANqRtoRqiFQEH+xaC9WtHy3v2rAHOZBNPTffOVQoDNuPb9H4-A@mail.gmail.com>
References: <20120503144645.6390.62303.sendpatchset@w520>
 <201205041307.46080.arnd@arndb.de>
 <CANqRtoRqiFQEH+xaC9WtHy3v2rAHOZBNPTffOVQoDNuPb9H4-A@mail.gmail.com>
Message-ID: <201205081935.54082.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 May 2012, Magnus Damm wrote:
> >> +void __init emev2_clock_init(void)
> >> +{
> >> +     int k, ret = 0;
> >> +
> >> +     /* setup STI timer to run on 37.768 kHz and deassert reset */
> >> +     __raw_writel(0, STI_CLKSEL);
> >> +     __raw_writel(1, STI_RSTCTRL);
> >> +
> >> +     /* deassert reset for UART0->UART3 */
> >> +     __raw_writel(2, USIAU0_RSTCTRL);
> >> +     __raw_writel(2, USIBU1_RSTCTRL);
> >> +     __raw_writel(2, USIBU2_RSTCTRL);
> >> +     __raw_writel(2, USIBU3_RSTCTRL);
> >
> > Better use iowrite32 or writel or writel_relaxed here, but not __raw_*.
> 
> Ok. Would you like us to convert exiting code for other SoCs as well?

In the long run yes, but there is no need to hurry. I just want to stop
more of this from getting added because at some point we might have to
change it all.

> >> --- 0003/arch/arm/mach-shmobile/include/mach/common.h
> >> +++ work/arch/arm/mach-shmobile/include/mach/common.h 2012-05-03 20:45:56.000000000 +0900
> >> @@ -85,4 +85,10 @@ extern void r8a7779_secondary_init(unsig
> >>  extern int r8a7779_boot_secondary(unsigned int cpu);
> >>  extern void r8a7779_smp_prepare_cpus(void);
> >>
> >> +extern void emev2_init_irq(void);
> >> +extern void emev2_map_io(void);
> >> +extern void emev2_add_early_devices(void);
> >> +extern void emev2_add_standard_devices(void);
> >> +extern void emev2_clock_init(void);
> >> +
> >>  #endif /* __ARCH_MACH_COMMON_H */
> >
> > I would feel more comfortable with a separate header for this than putting
> > it into the same file as everything else, but it's not important to me.
> 
> I've been thinking about something along those lines myself too.
> 
> Perhaps I can also move the existing soc symbols in common.h into
> separate per-soc header files, like for instance moving the sh7372
> symbols to sh7372.h. Not sure if we have enough time for the upcoming
> merge window though, when do you need the code?

Hard to say. Depends on whether there will be an -rc7. Sooner is better,
but again I care more about the new stuff here than about changing the
existing bits.

> >> +static struct map_desc emev2_io_desc[] __initdata = {
> >> +     /* 128K entity map for 0xe0020000 (GIC) */
> >> +     {
> >> +             .virtual        = 0xe0020000,
> >> +             .pfn            = __phys_to_pfn(0xe0020000),
> >> +             .length         = SZ_128K,
> >> +             .type           = MT_UNCACHED
> >> +     },
> >> +     /* 128K entity map for 0xe0100000 (SMU) */
> >> +     {
> >> +             .virtual        = 0xe0100000,
> >> +             .pfn            = __phys_to_pfn(0xe0100000),
> >> +             .length         = SZ_128K,
> >> +             .type           = MT_DEVICE
> >> +     },
> >> +};
> >> +
> >> +void __init emev2_map_io(void)
> >> +{
> >> +     iotable_init(emev2_io_desc, ARRAY_SIZE(emev2_io_desc));
> >> +}
> 
> As you said, this iotable can most likely go away too. The only valid
> use case I can think of (which is not included above) is our early
> platform driver based console. Basically, it's the 8250_em driver
> being probed as early as possible. This allows us to get console
> output at MACHINE->init_early() timing. To get that working we rely on
> having entity mappings in our iotable so ioremap() can give us those
> early on. Something does however seem busted with the early ioremap()
> - but I need to spend more time to investigate that. And this is
> totally untested with DT, so it needs more work in general.

Do you actually need to do anything at init_early() or map_io() time
that needs debugging these days?
We already have too many different ways of doing early console output,
but if you cannot use the drivers/tty/serial/8250/8250_early.c code,
maybe it makes sense to just move the map_io() call for your 8250
port into that driver.

> I intend to post some SMP support patch together with some DT support
> tomorrow. I also have some GPIO code and some board-level network
> support. Ideally I'd like to go DT-only, but I'm a bit unsure how to
> tie in the SMP bits in a DT-only scenario. And we still have the
> clocks.

Don't worry about SMP and clocks for now for moving to DT, just do
the easy bits that are directly connected to the SoC and that have
existing bindings or those that can be trivially added.

	Arnd
