From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2015 10:39:48 +0000
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20151124085349.GQ19156@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <133921941.Qfq59EaTOs@wuerfel>
 <20151123213206.GG19156@codeaurora.org>
 <6359949.bhCrxaQvmL@wuerfel>
 <20151124001306.GI19156@codeaurora.org>
 <20151124085349.GQ19156@codeaurora.org>
Message-ID: <20151124103948.GZ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 12:53:49AM -0800, Stephen Boyd wrote:
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
> > 
> 
> And adding CPU_V7VE causes a cascade of changes to wherever
> CPU_V7 is being used today. Here's the patch I currently have,
> without the platform changes:
> 
> ---8<----
>  arch/arm/Kconfig                   | 68 +++++++++++++++++++++-----------------
>  arch/arm/Kconfig-nommu             |  2 +-
>  arch/arm/Makefile                  |  1 +
>  arch/arm/boot/compressed/head.S    |  2 +-
>  arch/arm/boot/compressed/misc.c    |  2 +-
>  arch/arm/include/asm/cacheflush.h  |  2 +-
>  arch/arm/include/asm/glue-cache.h  |  2 +-
>  arch/arm/include/asm/glue-proc.h   |  2 +-
>  arch/arm/include/asm/switch_to.h   |  2 +-
>  arch/arm/include/debug/icedcc.S    |  2 +-
>  arch/arm/kernel/entry-armv.S       |  6 ++--
>  arch/arm/kernel/perf_event_v7.c    |  4 +--
>  arch/arm/kvm/Kconfig               |  2 +-
>  arch/arm/mm/Kconfig                | 41 ++++++++++++++++-------
>  arch/arm/mm/Makefile               |  1 +
>  arch/arm/probes/kprobes/test-arm.c |  2 +-
>  drivers/bus/Kconfig                |  6 ++--
>  17 files changed, 86 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9e2d2adcc85b..ccd0d5553d38 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -32,7 +32,7 @@ config ARM
>  	select HANDLE_DOMAIN_IRQ
>  	select HARDIRQS_SW_RESEND
>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
> -	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> +	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7 || CPU_32_v7VE) && !CPU_32v6
>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32
>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32
>  	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
> @@ -46,12 +46,12 @@ config ARM
>  	select HAVE_DMA_ATTRS
>  	select HAVE_DMA_CONTIGUOUS if MMU
>  	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32
> -	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
> +	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7VE) && MMU
>  	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
>  	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
>  	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
>  	select HAVE_GENERIC_DMA_COHERENT
> -	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
> +	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7VE))
>  	select HAVE_IDE if PCI || ISA || PCMCIA
>  	select HAVE_IRQ_TIME_ACCOUNTING
>  	select HAVE_KERNEL_GZIP
> @@ -805,6 +805,12 @@ config ARCH_MULTI_V7
>  	select CPU_V7
>  	select HAVE_SMP
>  
> +config ARCH_MULTI_V7VE
> +	bool "ARMv7 w/ virtualization extensions based platforms (Cortex-A, PJ4-MP, Krait)"
> +	select ARCH_MULTI_V6_V7
> +	select CPU_V7VE
> +	select HAVE_SMP
> +
>  config ARCH_MULTI_V6_V7
>  	bool
>  	select MIGHT_HAVE_CACHE_L2X0
> @@ -1069,7 +1075,7 @@ config ARM_ERRATA_411920
>  
>  config ARM_ERRATA_430973
>  	bool "ARM errata: Stale prediction on replaced interworking branch"
> -	depends on CPU_V7
> +	depends on CPU_V7 || CPU_V7VE

NAK on all this.  The fact that you're having to add CPU_V7VE at all
sites which have CPU_V7 shows that this is a totally broken way of
approaching this.

Make CPU_V7VE be an _add-on_ to CPU_V7.  In other words, when CPU_V7VE
is enabled, CPU_V7 should also be enabled, just like we do for CPU_V6K.

Note that v7M is different because that's not an add-on feature, it's
a different CPU class from (what should be) v7A.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
