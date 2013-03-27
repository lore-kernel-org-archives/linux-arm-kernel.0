From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 27 Mar 2013 10:37:30 +0000
Subject: [PATCH v9 3/3] ARM: ARMv7-M: Allow the building of new kernel port
In-Reply-To: <1363901310-9474-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1363901310-9474-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1363901310-9474-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <5152CBEA.1070209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Just a few comments below,

On 21/03/13 21:28, Uwe Kleine-K?nig wrote:
> This patch modifies the required Kconfig and Makefile files to allow the
> building of kernel for Cortex-M3.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>   arch/arm/Kconfig         |  4 ++--
>   arch/arm/Kconfig-nommu   |  2 +-
>   arch/arm/Makefile        |  1 +
>   arch/arm/kernel/Makefile |  8 +++++++-
>   arch/arm/mm/Kconfig      | 22 +++++++++++++++++++++-
>   arch/arm/mm/Makefile     |  2 ++
>   6 files changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index dedf02b..7c8c607 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -9,7 +9,7 @@ config ARM
>   	select BUILDTIME_EXTABLE_SORT if MMU
>   	select CPU_PM if (SUSPEND || CPU_IDLE)
>   	select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && !CPU_BIG_ENDIAN && MMU
> -	select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
> +	select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
>   	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>   	select GENERIC_IRQ_PROBE
>   	select GENERIC_IRQ_SHOW
> @@ -1685,7 +1685,7 @@ config SCHED_HRTICK
>
>   config THUMB2_KERNEL
>   	bool "Compile the kernel in Thumb-2 mode" if !CPU_THUMBONLY
> -	depends on CPU_V7 && !CPU_V6 && !CPU_V6K
> +	depends on (CPU_V7 || CPU_V7M) && !CPU_V6 && !CPU_V6K
>   	default y if CPU_THUMBONLY
>   	select AEABI
>   	select ARM_ASM_UNIFIED
> diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
> index 2cef8e1..c859495 100644
> --- a/arch/arm/Kconfig-nommu
> +++ b/arch/arm/Kconfig-nommu
> @@ -28,7 +28,7 @@ config FLASH_SIZE
>   config PROCESSOR_ID
>   	hex 'Hard wire the processor ID'
>   	default 0x00007700
> -	depends on !CPU_CP15
> +	depends on !(CPU_CP15 || CPU_V7M)
>   	help
>   	  If processor has no CP15 register, this processor ID is
>   	  used instead of the auto-probing which utilizes the register.
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index ee4605f..f11b8da 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -59,6 +59,7 @@ comma = ,
>   # Note that GCC does not numerically define an architecture version
>   # macro, but instead defines a whole series of macros which makes
>   # testing for a specific architecture or later rather impossible.
> +arch-$(CONFIG_CPU_32v7M)	:=-D__LINUX_ARM_ARCH__=7 -march=armv7-m -Wa,-march=armv7-m
>   arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7-a,-march=armv5t -Wa$(comma)-march=armv7-a)
>   arch-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6,-march=armv5t -Wa$(comma)-march=armv6)
>   # Only override the compiler option if ARMv6. The ARMv6K extensions are
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 5f3338e..00d703c 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -15,7 +15,7 @@ CFLAGS_REMOVE_return_address.o = -pg
>
>   # Object file lists.
>
> -obj-y		:= elf.o entry-armv.o entry-common.o irq.o opcodes.o \
> +obj-y		:= elf.o entry-common.o irq.o opcodes.o \
>   		   process.o ptrace.o return_address.o sched_clock.o \
>   		   setup.o signal.o stacktrace.o sys_arm.o time.o traps.o
>
> @@ -23,6 +23,12 @@ obj-$(CONFIG_ATAGS)		+= atags_parse.o
>   obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
>   obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += atags_compat.o
>
> +ifeq ($(CONFIG_CPU_V7M),y)
> +obj-y		+= entry-v7m.o
> +else
> +obj-y		+= entry-armv.o
> +endif
> +
>   obj-$(CONFIG_OC_ETM)		+= etm.o
>   obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
>   obj-$(CONFIG_ISA_DMA_API)	+= dma.o
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index cb812a1..9c3eac4 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -397,6 +397,16 @@ config CPU_V7
>   	select CPU_PABRT_V7
>   	select CPU_TLB_V7 if MMU
>
> +# ARMv7M
> +config CPU_V7M
> +	bool
> +	select CPU_32v7M
> +	select CPU_ABRT_NOMMU
> +	select CPU_CACHE_NOP
> +	select CPU_CACHE_VIPT

What's the deal with VIPT here? I presume something left over?

> +	select CPU_PABRT_LEGACY
> +	select CPU_THUMBONLY
> +
>   config CPU_THUMBONLY
>   	bool
>   	# There are no CPUs available with MMU that don't implement an ARM ISA:
> @@ -441,6 +451,9 @@ config CPU_32v6K
>   config CPU_32v7
>   	bool
>
> +config CPU_32v7M
> +	bool
> +

What is this config option for?

>   # The abort model
>   config CPU_ABRT_NOMMU
>   	bool
> @@ -494,6 +507,9 @@ config CPU_CACHE_V6
>   config CPU_CACHE_V7
>   	bool
>
> +config CPU_CACHE_NOP
> +	bool
> +
>   config CPU_CACHE_VIVT
>   	bool
>
> @@ -616,7 +632,11 @@ config ARCH_DMA_ADDR_T_64BIT
>
>   config ARM_THUMB
>   	bool "Support Thumb user binaries" if !CPU_THUMBONLY
> -	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || CPU_V7 || CPU_FEROCEON
> +	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || \
> +		CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || \
> +		CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
> +		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || \
> +		CPU_V7 || CPU_FEROCEON || CPU_V7M

It looks like there has been a rough attempt to order this list...

Can V7M go before FEROCEON please?

>   	default y
>   	help
>   	  Say Y if you want to include kernel support for running user space
> diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
> index 4e333fa..317b575 100644
> --- a/arch/arm/mm/Makefile
> +++ b/arch/arm/mm/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_CPU_CACHE_V4WB)	+= cache-v4wb.o
>   obj-$(CONFIG_CPU_CACHE_V6)	+= cache-v6.o
>   obj-$(CONFIG_CPU_CACHE_V7)	+= cache-v7.o
>   obj-$(CONFIG_CPU_CACHE_FA)	+= cache-fa.o
> +obj-$(CONFIG_CPU_CACHE_NOP)	+= cache-nop.o
>
>   AFLAGS_cache-v6.o	:=-Wa,-march=armv6
>   AFLAGS_cache-v7.o	:=-Wa,-march=armv7-a
> @@ -88,6 +89,7 @@ obj-$(CONFIG_CPU_FEROCEON)	+= proc-feroceon.o
>   obj-$(CONFIG_CPU_V6)		+= proc-v6.o
>   obj-$(CONFIG_CPU_V6K)		+= proc-v6.o
>   obj-$(CONFIG_CPU_V7)		+= proc-v7.o
> +obj-$(CONFIG_CPU_V7M)		+= proc-v7m.o
>
>   AFLAGS_proc-v6.o	:=-Wa,-march=armv6
>   AFLAGS_proc-v7.o	:=-Wa,-march=armv7-a
>

Thanks!

Jonny
