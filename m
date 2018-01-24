From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 24 Jan 2018 10:12:53 +0000
Subject: [PATCH] arm64: Fix TTBR + PAN + 52-bit PA logic in
 cpu_do_switch_mm
In-Reply-To: <20180124082708.29038-1-steve.capper@arm.com>
References: <20180124082708.29038-1-steve.capper@arm.com>
Message-ID: <5fc3f4ac-1f97-a2fb-b611-78f2869c77a1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/01/18 08:27, Steve Capper wrote:
> In cpu_do_switch_mm(.) with ARM64_SW_TTBR0_PAN=y we apply phys_to_ttbr
> to a value that already has an ASID inserted into the upper bits. For
> 52-bit PA configurations this then can give us TTBR0_EL1 registers that
> cause translation table walks to attempt to access non-zero PA[51:48]
> spuriously. Ultimately leading to a Synchronous External Abort on level
> 1 translation.
> 
> This patch re-arranges the logic in cpu_do_switch_mm(.) such that
> phys_to_ttbr is called before the ASID is inserted into the TTBR0 value.
> 
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> 
> ---
> 
> This applies to the arm64 for-next/core branch.
> ---
>   arch/arm64/mm/proc.S | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index c6a12073ef46..9f177aac6390 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -153,14 +153,14 @@ ENDPROC(cpu_do_resume)
>   ENTRY(cpu_do_switch_mm)
>   	mrs	x2, ttbr1_el1
>   	mmid	x1, x1				// get mm->context.id
> +	phys_to_ttbr x0, x3
>   #ifdef CONFIG_ARM64_SW_TTBR0_PAN
> -	bfi	x0, x1, #48, #16		// set the ASID field in TTBR0
> +	bfi	x3, x1, #48, #16		// set the ASID field in TTBR0
>   #endif
>   	bfi	x2, x1, #48, #16		// set the ASID
>   	msr	ttbr1_el1, x2			// in TTBR1 (since TCR.A1 is set)
>   	isb
> -	phys_to_ttbr x0, x2
> -	msr	ttbr0_el1, x2			// now update TTBR0
> +	msr	ttbr0_el1, x3			// now update TTBR0
>   	isb
>   	b	post_ttbr_update_workaround	// Back to C code...
>   ENDPROC(cpu_do_switch_mm)
> 

Steve,

Nice catch !

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
