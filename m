From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 17 Dec 2015 11:27:17 -0500 (EST)
Subject: [PATCH] ARM: PJ4: make coprocessor access sequences buildable
 in Thumb2 mode
In-Reply-To: <1450365912-3834-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1450365912-3834-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.20.1512171126350.3603@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Dec 2015, Ard Biesheuvel wrote:

> The PJ4 inline asm sequence to write to cp15 cannot be built in Thumb-2
> mode, due to the way it performs arithmetic on the program counter, so it
> is built in ARM mode instead. However, building C files in ARM mode under
> CONFIG_THUMB2_KERNEL is problematic, since the instrumentation performed
> by subsystems like ftrace does not expect having to deal with interworking
> branches.
> 
> Since the sequence in question is simply a poor man's ISB instruction,
> let's use a straight 'isb' instead. Unlike Xscale, where this code
> originated, PJ4 is strictly ARMv7 so this should always be supported.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>



> ---
>  arch/arm/kernel/Makefile  |  1 -
>  arch/arm/kernel/pj4-cp0.c | 10 +++-------
>  2 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index af9e59bf3831..3c789496297f 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -73,7 +73,6 @@ obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o perf_callchain.o
>  obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_xscale.o perf_event_v6.o \
>  				   perf_event_v7.o
> -CFLAGS_pj4-cp0.o		:= -marm
>  AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
>  obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
>  obj-$(CONFIG_VDSO)		+= vdso.o
> diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
> index 8153e36b2491..a311977d795d 100644
> --- a/arch/arm/kernel/pj4-cp0.c
> +++ b/arch/arm/kernel/pj4-cp0.c
> @@ -62,14 +62,10 @@ static u32 __init pj4_cp_access_read(void)
>  
>  static void __init pj4_cp_access_write(u32 value)
>  {
> -	u32 temp;
> -
>  	__asm__ __volatile__ (
> -		"mcr	p15, 0, %1, c1, c0, 2\n\t"
> -		"mrc	p15, 0, %0, c1, c0, 2\n\t"
> -		"mov	%0, %0\n\t"
> -		"sub	pc, pc, #4\n\t"
> -		: "=r" (temp) : "r" (value));
> +		"mcr	p15, 0, %0, c1, c0, 2\n\t"
> +		"isb\n\t"
> +		: : "r" (value));
>  }
>  
>  static int __init pj4_get_iwmmxt_version(void)
> -- 
> 2.5.0
> 
> 
