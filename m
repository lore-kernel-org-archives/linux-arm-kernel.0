From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 May 2011 10:53:18 +0100
Subject: [PATCH] ARM: fix mistaken dependency for CPU_HAS_PMU
In-Reply-To: <BANLkTinkZZwPG6S2goLYhuNV8JcVB-xsFw@mail.gmail.com>
References: <1305686080-13182-1-git-send-email-tom.leiming@gmail.com>	<4785097973995347565@unknownmsgid>
	<BANLkTinkZZwPG6S2goLYhuNV8JcVB-xsFw@mail.gmail.com>
Message-ID: <000201cc1541$6a5f26a0$3f1d73e0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> From: Ming Lei <tom.leiming@gmail.com>
> >>
> >> Obviously it is mistake for CPU_HAS_PMU to depend on
> >> (!ARCH_OMAP3 || OMAP3_EMU).
> >
> > It's not that obvious!
> 
> No, on ubuntu 11.04, default config options enables ARCH_OMAP3
> and ARCH_OMAP4, and disable OMAP3_EMU, so cause pmu.o
> can't be built in kernel.
> 
> pmu.o is just a platform driver for pmu device, so we should always
> allow it to be built into kernel no matter there are pmu devices or
> not, so we can support multiple boards with one same image.

CPU_HAS_PMU is also used as a condition for enabling HW_PERF_EVENTS.
I don't think we should set that for configurations where the platform
doesn't provide working hardware counters.

On top of that, pmu.o provides a reservation mechanism for the PMU
which is used by tools such as perf and LTTng. If CPU_HAS_PMU is not
set then you will get back -ENODEV, which I think is better than providing
access to a PMU that's not working.
 
> In fact, we should keep arch/arm/Kconfig or arch/arm/kernel/pmu.c more generic,
> and avoid to make arm core code depend on machines options as far as possible.
> 
> For the pmu issue on omap3, below fix should be better than what
> 8954bb0d did, shouldn't it?
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 7b85585..c20a3a3 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -410,9 +410,12 @@ static void omap_init_pmu(void)
>  {
>  	if (cpu_is_omap24xx())
>  		omap_pmu_device.resource = &omap2_pmu_resource;
> -	else if (cpu_is_omap34xx())
> +	else if (cpu_is_omap34xx()) {
>  		omap_pmu_device.resource = &omap3_pmu_resource;
> -	else
> +#ifndef  CONFIG_OMAP3_EMU
> +		return;
> +#endif
> +	} else
>  		return;
> 
>  	platform_device_register(&omap_pmu_device);

The problem with this is that it still allows users to build kernels
where perf is enabled but doesn't work. Since we know this is the case
at build time, we have chance to stop them doing it then (or at least
not let them select HW_PERF_EVENTS).
 
> > Is there a problem building the etm support for Omap4?
> 
> Of course,  there is the problem I described above.

What I mean is, why can't you just select OMAP3_EMU in your Omap3/4 combined
kernel config? Then everything should work.

Will
