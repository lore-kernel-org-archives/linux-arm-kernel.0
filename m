From: olof@lixom.net (Olof Johansson)
Date: Fri, 24 Aug 2012 14:27:19 -0700
Subject: [RFC PATCH] ARM: initial multiplatform support
In-Reply-To: <1345837852-10277-1-git-send-email-robherring2@gmail.com>
References: <1345837852-10277-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120824212719.GA16828@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A few comments below.

On Fri, Aug 24, 2012 at 02:50:52PM -0500, Rob Herring wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This lets us build a multiplatform kernel for experimental purposes.
> However, it will not be useful for any real work, because it relies
> on a number of useful things to be disabled for now:
> 
> * SMP support is turned off because of conflicting symbols.
>   Marc Zyngier has proposed a solution by adding a new SOC
>   operations structure to hold indirect function pointers
>   for these, but that work is currently stalled

On what? Review? or something else? It'd be nice to get some movement
going on it again. I guess we'll bring it up next week.

> * We turn on SPARSE_IRQ unconditionally, which is not supported
>   on most platforms. Each of them is currently in a different
>   state, but most are being worked on.
> 
> * A common clock framework is in place since v3.4 but not yet
>   being used. Work on this is on its way.
> 
> * DEBUG_LL for early debugging is currently disabled.

Being able to turn it on for one platform just to debug a boot issue is
still very useful. It's how powerpc handles it -- even if you can do a
multiplatform kernel, for the low level debug console you have to pick
one static entry.  Still useful during development.

> * THUMB2_KERNEL does not work with allyesconfig because the
>   kernel gets too big

Ironic, but understandable.

> ---
>  arch/arm/Kconfig                              |  107 +++++++++++++++----------
>  arch/arm/Makefile                             |   16 ++--
>  arch/arm/mach-multi/Kconfig                   |   42 ++++++++++
>  arch/arm/mach-multi/Makefile                  |    1 +
>  arch/arm/mach-multi/include/mach/gpio.h       |    1 +
>  arch/arm/mach-multi/include/mach/timex.h      |    3 +
>  arch/arm/mach-multi/include/mach/uncompress.h |   10 +++
>  arch/arm/mach-vexpress/Makefile               |    1 +
>  arch/arm/plat-versatile/Makefile              |    2 +
>  9 files changed, 136 insertions(+), 47 deletions(-)
>  create mode 100644 arch/arm/mach-multi/Kconfig
>  create mode 100644 arch/arm/mach-multi/Makefile
>  create mode 100644 arch/arm/mach-multi/include/mach/gpio.h
>  create mode 100644 arch/arm/mach-multi/include/mach/timex.h
>  create mode 100644 arch/arm/mach-multi/include/mach/uncompress.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e91c7cd..e841262 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -255,22 +255,18 @@ choice
>  	prompt "ARM system type"
>  	default ARCH_VERSATILE
>  
> -config ARCH_SOCFPGA
> -	bool "Altera SOCFPGA family"
> -	select ARCH_WANT_OPTIONAL_GPIOLIB
> -	select ARM_AMBA
> -	select ARM_GIC
> -	select CACHE_L2X0
> -	select CLKDEV_LOOKUP
> +config ARCH_MULTIPLATFORM
> +	bool "Allow multiple platforms to be selected"
> +	select USE_OF

Should this be a toplevel config option and the choice menu disabled if it's
set, instead of a meta-platform?

> @@ -1028,6 +999,58 @@ config ARCH_ZYNQ
>  	  Support for Xilinx Zynq ARM Cortex A9 Platform
>  endchoice
>  
> +source "arch/arm/mach-multi/Kconfig"
> +
> +config ARCH_SOCFPGA
> +	bool "Altera SOCFPGA family" if ARCH_MULTI_V7
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select ARM_AMBA
> +	select ARM_GIC
> +	select CACHE_L2X0
> +	select CLKDEV_LOOKUP
> +	select COMMON_CLK
> +	select CPU_V7
> +	select DW_APB_TIMER
> +	select DW_APB_TIMER_OF
> +	select GENERIC_CLOCKEVENTS
> +	select GPIO_PL061 if GPIOLIB
> +	select HAVE_ARM_SCU
> +	select SPARSE_IRQ
> +	select USE_OF

There's no need to keep these in the common arm/Kconfig now, is there? Might as
well push them out to the respective mach-*/Kconfig, that will cause less churn
on the common file and in general scale better.

> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 30eae87..c113e53 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -133,6 +133,9 @@ textofs-$(CONFIG_ARCH_MSM7X30) := 0x00208000
>  textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
>  textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
>  
> +# multiplatform directory must be first
> +machine-$(CONFIG_ARCH_MULTIPLATFORM)	:= multi
> +
>  # Machine directory name.  This list is sorted alphanumerically
>  # by CONFIG_* macro name.
>  machine-$(CONFIG_ARCH_AT91)		:= at91
> @@ -145,7 +148,7 @@ machine-$(CONFIG_ARCH_EBSA110)		:= ebsa110
>  machine-$(CONFIG_ARCH_EP93XX)		:= ep93xx
>  machine-$(CONFIG_ARCH_GEMINI)		:= gemini
>  machine-$(CONFIG_ARCH_H720X)		:= h720x
> -machine-$(CONFIG_ARCH_HIGHBANK)		:= highbank
> +machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
>  machine-$(CONFIG_ARCH_INTEGRATOR)	:= integrator
>  machine-$(CONFIG_ARCH_IOP13XX)		:= iop13xx
>  machine-$(CONFIG_ARCH_IOP32X)		:= iop32x
> @@ -186,11 +189,11 @@ machine-$(CONFIG_ARCH_TEGRA)		:= tegra
>  machine-$(CONFIG_ARCH_U300)		:= u300
>  machine-$(CONFIG_ARCH_U8500)		:= ux500
>  machine-$(CONFIG_ARCH_VERSATILE)	:= versatile
> -machine-$(CONFIG_ARCH_VEXPRESS)		:= vexpress
> +machine-$(CONFIG_ARCH_VEXPRESS)		+= vexpress
>  machine-$(CONFIG_ARCH_VT8500)		:= vt8500
>  machine-$(CONFIG_ARCH_W90X900)		:= w90x900
>  machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
> -machine-$(CONFIG_ARCH_SOCFPGA)		:= socfpga
> +machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
>  machine-$(CONFIG_MACH_SPEAR1310)	:= spear13xx
>  machine-$(CONFIG_MACH_SPEAR1340)	:= spear13xx
>  machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
> @@ -230,14 +233,17 @@ MACHINE  := arch/arm/mach-$(word 1,$(machine-y))/
>  else
>  MACHINE  :=
>  endif
> +ifeq ($(CONFIG_ARCH_MULTIPLATFORM),y)
> +MACHINE  :=
> +endif
>  
>  machdirs := $(patsubst %,arch/arm/mach-%/,$(machine-y))
>  platdirs := $(patsubst %,arch/arm/plat-%/,$(plat-y))
>  
>  ifeq ($(KBUILD_SRC),)
> -KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(machdirs) $(platdirs))
> +KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(word 1,$(machdirs) $(platdirs)))
>  else
> -KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs) $(platdirs))
> +KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(word 1,$(machdirs) $(platdirs)))
>  endif

Since the only purpose of mach-multi is to provide a few dummy header files,
how about adding those under arch/arm/include/ instead and do away with the
mach directory? They could then be prepended in front of these so the search
path would be in the right order.

> diff --git a/arch/arm/mach-multi/Kconfig b/arch/arm/mach-multi/Kconfig
> new file mode 100644
> index 0000000..0a6369f
> --- /dev/null
> +++ b/arch/arm/mach-multi/Kconfig
> @@ -0,0 +1,42 @@
> +menu "Multiple platform selection"
> +	depends on ARCH_MULTIPLATFORM
> +
> +comment "CPU Core family selection"
> +
> +config ARCH_MULTI_V4
> +	bool "ARMv4 based platforms (FA526, StrongARM)"
> +	select ARCH_MULTI_V4_V5
> +	depends on !ARCH_MULTI_V6_V7
> +
> +config ARCH_MULTI_V4T
> +	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
> +	select ARCH_MULTI_V4_V5
> +	depends on !ARCH_MULTI_V6_V7
> +
> +config ARCH_MULTI_V5
> +	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
> +	select ARCH_MULTI_V4_V5
> +	depends on !ARCH_MULTI_V6_V7
> +
> +config ARCH_MULTI_V4_V5
> +	bool
> +
> +config ARCH_MULTI_V6
> +	bool "ARMv6 based platforms (ARM11, Scorpion, ...)"
> +	select ARCH_MULTI_V6_V7

Does it make sense to add these before any platforms are ready? I'd argue no,
but I don't feel strongly about it.

> +config ARCH_MULTI_V7
> +	bool "ARMv7 based platforms (Cortex-A, PJ4, Krait)"
> +	default y
> +	select ARCH_MULTI_V6_V7
> +
> +config ARCH_MULTI_V6_V7
> +	bool
> +
> +config ARCH_MULTI_CPU_AUTO
> +	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
> +	select ARCH_MULTI_V5
> +
> +endmenu
> +
> +comment "SoC family selection"
> diff --git a/arch/arm/mach-multi/Makefile b/arch/arm/mach-multi/Makefile
> new file mode 100644
> index 0000000..1bb8bf6
> --- /dev/null
> +++ b/arch/arm/mach-multi/Makefile
> @@ -0,0 +1 @@
> +# empty
> diff --git a/arch/arm/mach-multi/include/mach/gpio.h b/arch/arm/mach-multi/include/mach/gpio.h
> new file mode 100644
> index 0000000..40a8c17
> --- /dev/null
> +++ b/arch/arm/mach-multi/include/mach/gpio.h
> @@ -0,0 +1 @@
> +/* empty */
> diff --git a/arch/arm/mach-multi/include/mach/timex.h b/arch/arm/mach-multi/include/mach/timex.h
> new file mode 100644
> index 0000000..929b4c4
> --- /dev/null
> +++ b/arch/arm/mach-multi/include/mach/timex.h
> @@ -0,0 +1,3 @@
> +#ifndef CLOCK_TICK_RATE
> +#define CLOCK_TICK_RATE 1000000
> +#endif
> diff --git a/arch/arm/mach-multi/include/mach/uncompress.h b/arch/arm/mach-multi/include/mach/uncompress.h
> new file mode 100644
> index 0000000..a4dec68
> --- /dev/null
> +++ b/arch/arm/mach-multi/include/mach/uncompress.h
> @@ -0,0 +1,10 @@
> +#ifndef __MACH_UNCOMPRESS_H
> +#define __MACH_UNCOMPRESS_H
> +
> +/* no-op dummies for the uncompress debugging for multiplatform kernels */
> +
> +static inline void putc(int c) {}
> +static inline void flush(void) {}
> +static inline void arch_decomp_setup(void) {}
> +
> +#endif
> diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
> index 90551b9..1666f6e 100644
> --- a/arch/arm/mach-vexpress/Makefile
> +++ b/arch/arm/mach-vexpress/Makefile
> @@ -1,6 +1,7 @@
>  #
>  # Makefile for the linux kernel.
>  #
> +ccflags-y := -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-versatile/include

cc-flags-$(CONFIG_ARCH_MULTIPLATFORM) here and for versatile?


-Olof
