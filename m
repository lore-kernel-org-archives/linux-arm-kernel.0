From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Nov 2015 11:38:53 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20151124085349.GQ19156@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <20151124001306.GI19156@codeaurora.org>
 <20151124085349.GQ19156@codeaurora.org>
Message-ID: <4485320.CGMJdfZLya@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 November 2015 00:53:49 Stephen Boyd wrote:
> On 11/23, Stephen Boyd wrote:
> > On 11/23, Arnd Bergmann wrote:
> > > 
> > > Ok, thanks for the confirmation.
> > > 
> > > Summarizing what we've found, I think we can get away with just
> > > introducing two Kconfig symbols ARCH_MULTI_V7VE and CPU_V7VE.
> > > Most CPUs fall clearly into one category or the other, and then
> > > we can allow LPAE to be selected for V7VE-only build but not
> > > for plain V7, and we can unconditionally build the kernel with
> > > 
> > > arch-$(CONFIG_CPU_32v7VE)  = -D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7ve,-march=armv7-a -mcpu=cortex-a15)
> > > 
> > 
> > This causes compiler spew for me:
> > 
> >   warning: switch -mcpu=cortex-a15 conflicts with -march=armv7-a switch
> > 
> > Removing -march=armv7-a from there makes it quiet.
> > 
> > Also, it's sort of feels wrong to have -mcpu in a place where
> > we're exclusively doing -march. Perhaps the fallback should be
> > bog standard -march=armv7-a? (or the fallback for that one
> > "-march=armv5t -Wa$(comma)-march=armv7-a")?

I suggested using -mcpu=cortex-a15 because there are old gcc versions
that don't know about -march=armv7ve or -march=armv7-a+idiv yet, but
that do understand -mcpu=cortex-a15. I might be misremembering the
exact options we want though, and we could now just decided that if
your gcc is too old, you get no idiv even if it supports that on
Cortex-A15.

> And adding CPU_V7VE causes a cascade of changes to wherever
> CPU_V7 is being used today. Here's the patch I currently have,
> without the platform changes:

Thanks a lot for looking into this. I think we can simplify a couple
of them, as long as we also fix all the platforms to have the correct
dependencies:

> @@ -1069,7 +1075,7 @@ config ARM_ERRATA_411920
>  
>  config ARM_ERRATA_430973
>  	bool "ARM errata: Stale prediction on replaced interworking branch"
> -	depends on CPU_V7
> +	depends on CPU_V7 || CPU_V7VE
>  	help
>  	  This option enables the workaround for the 430973 Cortex-A8
>  	  r1p* erratum. If a code sequence containing an ARM/Thumb

If it's a Cortex-A8 erratum, we don't need the "|| CPU_V7VE". Same for
a lot of the following errata.

> @@ -1246,7 +1252,7 @@ config ARM_ERRATA_775420
>  
>  config ARM_ERRATA_798181
>  	bool "ARM errata: TLBI/DSB failure on Cortex-A15"
> -	depends on CPU_V7 && SMP
> +	depends on (CPU_V7 || CPU_V7VE) && SMP
>  	help
>  	  On Cortex-A15 (r0p0..r3p2) the TLBI*IS/DSB operations are not
>  	  adequately shooting down all use of the old entries. This
> @@ -1256,7 +1262,7 @@ config ARM_ERRATA_798181
>  
>  config ARM_ERRATA_773022
>  	bool "ARM errata: incorrect instructions may be executed from loop buffer"
> -	depends on CPU_V7
> +	depends on CPU_V7 || CPU_V7VE
>  	help
>  	  This option enables the workaround for the 773022 Cortex-A15
>  	  (up to r0p4) erratum. In certain rare sequences of code, the

And conversely, these will only need to depend on CPU_V7VE.

> @@ -1373,7 +1379,7 @@ config SMP_ON_UP
>  
>  config ARM_CPU_TOPOLOGY
>  	bool "Support cpu topology definition"
> -	depends on SMP && CPU_V7
> +	depends on SMP && (CPU_V7 || CPU_V7VE)
>  	default y
>  	help
>  	  Support ARM cpu topology definition. The MPIDR register defines

Does topology make sense with Cortex-A5/A9 or Scorpion?
Otherwise it can also be V7VE-only.

> @@ -1417,7 +1423,7 @@ config HAVE_ARM_TWD
>  
>  config MCPM
>  	bool "Multi-Cluster Power Management"
> -	depends on CPU_V7 && SMP
> +	depends on (CPU_V7 || CPU_V7VE) && SMP
>  	help
>  	  This option provides the common power management infrastructure
>  	  for (multi-)cluster based systems, such as big.LITTLE based
> @@ -1434,7 +1440,7 @@ config MCPM_QUAD_CLUSTER
>  
>  config BIG_LITTLE
>  	bool "big.LITTLE support (Experimental)"
> -	depends on CPU_V7 && SMP
> +	depends on (CPU_V7 || CPU_V7VE) && SMP
>  	select MCPM
>  	help
>  	  This option enables support selections for the big.LITTLE

multi-cluster and big.little are also V7VE-only by definition,
as pre-VE ARMv7 cores are all limited to one cluster.


> @@ -1642,7 +1648,7 @@ config AEABI
>  
>  config ARM_PATCH_UIDIV
>  	bool "Runtime patch calls to __aeabi_{u}idiv() with udiv/sdiv"
> -	depends on CPU_V7 && !XIP_KERNEL && AEABI
> +	depends on CPU_32v7 && !XIP_KERNEL && AEABI
>  	help
>  	  Some v7 CPUs have support for the udiv and sdiv instructions
>  	  that can be used in place of calls to __aeabi_uidiv and __aeabi_idiv

How about making this 

	depends on (CPU_V6 || CPU_V6K || CPU_V7) && CPU_V7VE

> @@ -1843,7 +1849,7 @@ config XEN_DOM0
>  config XEN
>  	bool "Xen guest support on ARM"
>  	depends on ARM && AEABI && OF
> -	depends on CPU_V7 && !CPU_V6
> +	depends on (CPU_V7 || CPU_V7VE) && !CPU_V6
>  	depends on !GENERIC_ATOMIC64
>  	depends on MMU
>  	select ARCH_DMA_ADDR_T_64BIT

This is also V7VE-only. The !CPU_V6 check is there to avoid a compile-time
bug with some instructions that are V7-only. I think this should
be

	depends on CPU_V7VE && !CPU_V6

> diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
> index aed66d5df7f1..aa04be6b29b9 100644
> --- a/arch/arm/Kconfig-nommu
> +++ b/arch/arm/Kconfig-nommu
> @@ -53,7 +53,7 @@ config REMAP_VECTORS_TO_RAM
>  
>  config ARM_MPU
>         bool 'Use the ARM v7 PMSA Compliant MPU'
> -       depends on CPU_V7
> +       depends on CPU_V7 || CPU_V7VE
>         default y
>         help
>           Some ARM systems without an MMU have instead a Memory Protection

Not sure about this one. It's strictly speaking for V7-R, and we don't have
a Kconfig option for that at all.

> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index 95a000515e43..ea62ada144b1 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -5,7 +5,7 @@
>  source "virt/kvm/Kconfig"
>  
>  menuconfig VIRTUALIZATION
> -	bool "Virtualization"
> +	bool "Virtualization" if CPU_V7VE
>  	---help---
>  	  Say Y here to get to see options for using your Linux host to run
>  	  other operating systems inside virtual machines (guests).

We already have 'depends on ARM_VIRT_EXT' here. I guess we should instead
add the dependency on CPU_V7VE there.

 
> @@ -626,8 +644,7 @@ comment "Processor Features"
>  
>  config ARM_LPAE
>  	bool "Support for the Large Physical Address Extension"
> -	depends on MMU && CPU_32v7 && !CPU_32v6 && !CPU_32v5 && \
> -		!CPU_32v4 && !CPU_32v3
> +	depends on MMU && CPU_32v7VE

This looks wrong, we have to ensure at least that CPU_32v6 and CPU_32v7
are not set, though we can get rid of the v5/v4/v3 checks.

> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 0ebca8ba7bc4..33fa47dc03a8 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -17,7 +17,7 @@ config ARM_CCI400_COMMON
>  
>  config ARM_CCI400_PMU
>  	bool "ARM CCI400 PMU support"
> -	depends on (ARM && CPU_V7) || ARM64
> +	depends on (ARM && (CPU_V7 || CPU_V7VE)) || ARM64
>  	depends on PERF_EVENTS
>  	select ARM_CCI400_COMMON
>  	select ARM_CCI_PMU
> @@ -28,7 +28,7 @@ config ARM_CCI400_PMU
>  
>  config ARM_CCI400_PORT_CTRL
>  	bool
> -	depends on ARM && OF && CPU_V7
> +	depends on ARM && OF && (CPU_V7 || CPU_V7VE)
>  	select ARM_CCI400_COMMON
>  	help
>  	  Low level power management driver for CCI400 cache coherent
> @@ -36,7 +36,7 @@ config ARM_CCI400_PORT_CTRL
>  
>  config ARM_CCI500_PMU
>  	bool "ARM CCI500 PMU support"
> -	depends on (ARM && CPU_V7) || ARM64
> +	depends on (ARM && (CPU_V7 || CPU_V7VE)) || ARM64
>  	depends on PERF_EVENTS
>  	select ARM_CCI_PMU
>  	help

Pretty sure that these only work with ARMv7VE capable cores, the older ones only
have one cluster.

	Arnd
