From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 12 Jan 2011 09:14:46 +0100
Subject: [PATCH] ARM: Thumb-2: Fix out-of-range offset for Thumb-2 in
	proc-v7.S
In-Reply-To: <1294790613-17101-1-git-send-email-dave.martin@linaro.org>
References: <1294790613-17101-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20110112081446.GB24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 06:03:33PM -0600, Dave Martin wrote:
> The following patch introduces a pre-increment addressing
> offset which is out of range for Thumb-2:
>     ARM: pgtable: switch order of Linux vs hardware page tables
a commit id would be nice here

Uwe
> 
> 162:	str	r3, [r0, #2048]!
> 
> Thumb-2 only permits offsets <256 for pre-increment addressing.
> 
> This patch replaces the store instruction with a suitable add-str
> pair for the Thumb-2 case.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
> KernelVersion: v2.6.37
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

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
