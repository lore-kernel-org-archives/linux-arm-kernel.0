From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Jun 2010 09:52:31 +0100
Subject: [PATCH] pxa168 and pxa930 build fix - plat-pxa/pmu.c dependent on
	ARCH_PXA for IRQ_PMU
In-Reply-To: <AANLkTinm5ZU1tLR8CYwU4K8FPbCdLTdAyrfXq54nYkl_@mail.gmail.com>
References: <1275932959-474-1-git-send-email-jic23@cam.ac.uk>
	<AANLkTilXErDZHWf71e7pwUbt1i66MVrfP_lPisgoBZ0G@mail.gmail.com>
	<AANLkTinm5ZU1tLR8CYwU4K8FPbCdLTdAyrfXq54nYkl_@mail.gmail.com>
Message-ID: <003001cb06e7$ee5aa100$cb0fe300$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> We have different ways to handle this:
> 
> 1. register different platform devices with different IRQs for pxa[23]xx, pxa168
> 2. modify the IRQ at run-time to a correct one
> 3. move the platform device registration back into arch/arm/mach-pxa/<soc>.c
> (or arch/arm/mach-pxa/common.c) and arch/arm/mach-mmp/<soc>.c

For the RealView boards, we take approach number (1). This is largely for two
reasons:

1.) The PMU IRQ doesn't have a consistent naming scheme
2.) SMP RealView platforms need to have an extra resource in the
    platform_device for each CPU.

However, looking at the PXA168 description and the perf-events code,
I don't think we support the PMU anyway [see init_hw_perf_events in
arch/arm/kernel/perf_event.c]. If the PMU present is accessible in the
same way as one of the other supported PMUs, then it would be easy to
add it to the perf-events code. Otherwise, a new PMU driver will need
to be written if people want to use it.

Without access to a TRM, I can't tell whether or not supporting the PMU
is trivial, so I guess we go with option (3) for the time being.

> We need to figure out if there are some other differences between these
> PMUs (or in the future), which will make solution 3) stand out.

In the future I reckon PMU devices will be memory-mapped and live inside
components other than the CPU. PMU registration will then be highly SoC-specific.
Perf events doesn't yet support any of this, so it depends how future-proof you
want to be!

Will

> >>  arch/arm/plat-pxa/Makefile |    3 ++-
> >>  1 files changed, 2 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
> >> index 6187edf..a17cc0c 100644
> >> --- a/arch/arm/plat-pxa/Makefile
> >> +++ b/arch/arm/plat-pxa/Makefile
> >> @@ -2,8 +2,9 @@
> >>  # Makefile for code common across different PXA processor families
> >>  #
> >>
> >> -obj-y  := dma.o pmu.o
> >> +obj-y  := dma.o
> >>
> >> +obj-$(CONFIG_ARCH_PXA)         += pmu.o
> >>  obj-$(CONFIG_GENERIC_GPIO)     += gpio.o
> >>  obj-$(CONFIG_PXA3xx)           += mfp.o
> >>  obj-$(CONFIG_ARCH_MMP)         += mfp.o
> >> --
> >> 1.6.4.4
