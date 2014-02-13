From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 13 Feb 2014 15:42:47 -0500 (EST)
Subject: [PATCH RESEND] ARM: mcpm: Make all mcpm functions notrace
In-Reply-To: <1392279975.3469.4.camel@linaro1.home>
References: <1392279975.3469.4.camel@linaro1.home>
Message-ID: <alpine.LFD.2.11.1402131542120.17677@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Feb 2014, Jon Medhurst (Tixy) wrote:

> From: Dave Martin <dave.martin@linaro.org>
> 
> The functions in mcpm_entry.c are mostly intended for use during
> scary cache and coherency disabling sequences, or do other things
> which confuse trace ...  like powering a CPU down and not
> returning.  Similarly for the backend code.
> 
> For simplicity, this patch just makes whole files notrace.
> There should be more than enough traceable points on the paths to
> these functions, but we can be more fine-grained later if there is
> a need for it.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> Also added spc.o to the list of files as it contains functions used by
> MCPM code which have comments comments like: "might be used in code
> paths where normal cacheable locks are not working"
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>

Please send to RMK's patch system.


> ---
>  arch/arm/common/Makefile        |    1 +
>  arch/arm/mach-vexpress/Makefile |    3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index 4bdc416..70b1eff 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
>  obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
>  obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
>  obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
> +CFLAGS_REMOVE_mcpm_entry.o	= -pg
>  AFLAGS_mcpm_head.o		:= -march=armv7-a
>  AFLAGS_vlock.o			:= -march=armv7-a
>  obj-$(CONFIG_TI_PRIV_EDMA)	+= edma.o
> diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
> index 0997e0b..fc649bc 100644
> --- a/arch/arm/mach-vexpress/Makefile
> +++ b/arch/arm/mach-vexpress/Makefile
> @@ -8,8 +8,11 @@ obj-y					:= v2m.o
>  obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
>  obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
>  CFLAGS_dcscb.o				+= -march=armv7-a
> +CFLAGS_REMOVE_dcscb.o			= -pg
>  obj-$(CONFIG_ARCH_VEXPRESS_SPC)		+= spc.o
> +CFLAGS_REMOVE_spc.o			= -pg
>  obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o
>  CFLAGS_tc2_pm.o				+= -march=armv7-a
> +CFLAGS_REMOVE_tc2_pm.o			= -pg
>  obj-$(CONFIG_SMP)			+= platsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
> -- 
> 1.7.10.4
> 
> 
> 
