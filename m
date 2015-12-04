From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 4 Dec 2015 15:20:21 -0500 (EST)
Subject: [PATCH] ARM: need to save/restore arm register(r11) when it is
 corrupted
In-Reply-To: <1449223996-2858-1-git-send-email-Anson.Huang@freescale.com>
References: <1449223996-2858-1-git-send-email-Anson.Huang@freescale.com>
Message-ID: <alpine.LFD.2.20.1512041504420.7560@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Dec 2015, Anson Huang wrote:

> In cpu_v7_do_suspend routine, r11 is used while it is NOT
> saved/restored, different compiler may have different usage
> of ARM general registers, so it may cause issues during
> calling cpu_v7_do_suspend.
> 
> We meet kernel fault occurs when using GCC 4.8.3, r11 contains
> valid value before calling into cpu_v7_do_suspend, but when returned
> from this routine, r11 is corrupted and lead to kernel fault.
> Doing save/restore for those corrupted registers is a must in
> assemble code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@freescale.com>

Clearly, this is a nasty bug that has been there unnoticed for the last 
4 years.  The culprit is commit 1b6ba46b7e.

You may add the following tags:

Reviewed-by: Nicolas Pitre <nico@linaro.org>
Cc: <stable@vger.kernel.org> # v3.3+

> ---
>  arch/arm/mm/proc-v7.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index de2b246..8e1ea43 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -95,7 +95,7 @@ ENDPROC(cpu_v7_dcache_clean_area)
>  .equ	cpu_v7_suspend_size, 4 * 9
>  #ifdef CONFIG_ARM_CPU_SUSPEND
>  ENTRY(cpu_v7_do_suspend)
> -	stmfd	sp!, {r4 - r10, lr}
> +	stmfd	sp!, {r4 - r11, lr}
>  	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
>  	mrc	p15, 0, r5, c13, c0, 3	@ User r/o thread ID
>  	stmia	r0!, {r4 - r5}
> @@ -112,7 +112,7 @@ ENTRY(cpu_v7_do_suspend)
>  	mrc	p15, 0, r9, c1, c0, 1	@ Auxiliary control register
>  	mrc	p15, 0, r10, c1, c0, 2	@ Co-processor access control
>  	stmia	r0, {r5 - r11}
> -	ldmfd	sp!, {r4 - r10, pc}
> +	ldmfd	sp!, {r4 - r11, pc}
>  ENDPROC(cpu_v7_do_suspend)
>  
>  ENTRY(cpu_v7_do_resume)
> -- 
> 1.9.1
> 
> 
