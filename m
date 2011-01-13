From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 13 Jan 2011 17:07:17 -0500 (EST)
Subject: [PATCH v2] ARM: Thumb-2: Fix out-of-range offset for Thumb-2 in
	proc-v7.S
In-Reply-To: <1294937485-7673-1-git-send-email-dave.martin@linaro.org>
References: <1294937485-7673-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1101131706160.11803@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jan 2011, Dave Martin wrote:

> Commit
> 
>        d30e45e (ARM: pgtable: switch order of Linux vs hardware page tables)
> 
> introduced a pre-increment addressing offset which is out of range for
> Thumb-2.  Thumb-2 only permits offsets <256.  So split the intruction in
> two for Thumb-2.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


> ---
> KernelVersion: next-20110112
> 
>  arch/arm/mm/proc-v7.S |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index b49fab2..0c1172b 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -159,7 +159,9 @@ ENTRY(cpu_v7_set_pte_ext)
>  	tstne	r1, #L_PTE_PRESENT
>  	moveq	r3, #0
>  
> -	str	r3, [r0, #2048]!
> + ARM(	str	r3, [r0, #2048]! )
> + THUMB(	add	r0, r0, #2048 )
> + THUMB(	str	r3, [r0] )
>  	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
>  #endif
>  	mov	pc, lr
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
