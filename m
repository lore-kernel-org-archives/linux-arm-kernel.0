From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Dec 2009 16:13:05 -0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <1260799481-29951-6-git-send-email-jamie.iles@picochip.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>	<1260799481-29951-3-git-send-email-jamie.iles@picochip.com>	<1260799481-29951-4-git-send-email-jamie.iles@picochip.com>	<1260799481-29951-5-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-6-git-send-email-jamie.iles@picochip.com>
Message-ID: <001001ca7cd8$517ce440$f476acc0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jamie Iles wrote:

> This patch implements support for ARMv6 performance counters in the
> Linux performance events subsystem. ARMv6 architectures that have the
> performance counters should enable HW_PERF_EVENTS and define the
> interrupts for the counters in arch/arm/kernel/perf_event.c
>
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 286a276..44ebf36 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
>  obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
>  obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
>  obj-$(CONFIG_CPU_HAS_PMU)	+= pmu.o
> +obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
>  AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
> 
>  ifneq ($(CONFIG_ARCH_EBSA110),y)

<snip>

> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index fc5c05b..89a26ea 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -791,3 +791,11 @@ config ARM_L1_CACHE_SHIFT
>  	int
>  	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
>  	default 5
> +
> +config HW_PERF_EVENTS
> +	bool "Enable hardware performance counter support for perf events"
> +	depends on PERF_EVENTS && CPU_HAS_PMU && CPU_V6
> +	default n
> +	help
> +	  Enable hardware performance counter support for perf events. If
> +	  disabled, perf events will use software events only.
> --
> 1.6.5.4

Why are you modifying mm/Kconfig? I think it would be better to change the
Makefile to use CONFIG_HAVE_PERF_EVENTS rather than define a new bool.

Will
