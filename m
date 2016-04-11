From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Apr 2016 10:19:13 +0100
Subject: [RFC PATCH 1/2] ARM/ARM64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1460341353-15619-2-git-send-email-oss@buserror.net>
References: <1460341353-15619-1-git-send-email-oss@buserror.net>
 <1460341353-15619-2-git-send-email-oss@buserror.net>
Message-ID: <20160411091913.GC15729@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 10, 2016 at 09:22:32PM -0500, Scott Wood wrote:
> Erratum A-008585 says that the ARM generic timer "has the potential to
> contain an erroneous value for a small number of core clock cycles
> every time the timer value changes" and that the workaround is to
> reread TVAL and count registers until successive reads return the same
> value.
> 
> This erratum can be found on LS1021A (32-bit), LS1043A (64-bit), and
> LS2080A (64-bit).
> 
> This patch is loosely based on work by Priyanka Jain and Bhupesh
> Sharma.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> ---
>  .../devicetree/bindings/arm/arch_timer.txt         |  4 ++
>  arch/arm/boot/dts/ls1021a.dtsi                     |  1 +
>  arch/arm/include/asm/arch_timer.h                  | 71 +++++++++++++++++++---
>  arch/arm/include/asm/vdso_datapage.h               |  1 +
>  arch/arm/kernel/vdso.c                             |  1 +
>  arch/arm/vdso/vgettimeofday.c                      |  2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  1 +
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  1 +
>  arch/arm64/include/asm/arch_timer.h                | 35 ++++++++---
>  arch/arm64/include/asm/vdso_datapage.h             |  1 +
>  arch/arm64/kernel/asm-offsets.c                    |  1 +
>  arch/arm64/kernel/vdso.c                           |  2 +
>  arch/arm64/kernel/vdso/gettimeofday.S              | 14 ++++-
>  drivers/clocksource/arm_arch_timer.c               |  5 ++
>  14 files changed, 121 insertions(+), 19 deletions(-)

[...]

> diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
> index efa79e8..2e6008d 100644
> --- a/arch/arm64/kernel/vdso/gettimeofday.S
> +++ b/arch/arm64/kernel/vdso/gettimeofday.S
> @@ -207,7 +207,7 @@ ENDPROC(__kernel_clock_getres)
>  /*
>   * Read the current time from the architected counter.
>   * Expects vdso_data to be initialised.
> - * Clobbers the temporary registers (x9 - x15).
> + * Clobbers the temporary registers (x9 - x17).
>   * Returns:
>   *  - w9		= vDSO sequence counter
>   *  - (x10, x11)	= (ts->tv_sec, shifted ts->tv_nsec)
> @@ -217,6 +217,7 @@ ENTRY(__do_get_tspec)
>  	.cfi_startproc
>  
>  	/* Read from the vDSO data page. */
> +	ldr	w17, [vdso_data, #VDSO_TIMER_REREAD]
>  	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
>  	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
>  	ldp	w11, w12, [vdso_data, #VDSO_CS_MULT]
> @@ -225,6 +226,17 @@ ENTRY(__do_get_tspec)
>  	/* Read the virtual counter. */
>  	isb
>  	mrs	x15, cntvct_el0
> +	/*
> +	 * Erratum A-008585 requires back-to-back reads to be identical
> +	 * in order to avoid glitches.
> +	 */
> +	cmp	w17, #0
> +	b.eq	2f
> +1:	mrs	x15, cntvct_el0
> +	mrs	x16, cntvct_el0
> +	cmp	x16, x15
> +	b.ne	1b
> +2:

I'm not at all keen on having this in the vdso. Can you just force
use_syscall=1 instead, please?

Documentation/arm64/silicon-errata.txt needs updating too.

Will
