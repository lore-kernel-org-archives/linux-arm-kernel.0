From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Dec 2016 11:31:43 +0000
Subject: [PATCH 2/3] arm64: Work around Falkor erratum 1003
In-Reply-To: <20161207200028.4420-2-cov@codeaurora.org>
References: <20161207200028.4420-1-cov@codeaurora.org>
 <20161207200028.4420-2-cov@codeaurora.org>
Message-ID: <20161208113143.GB9768@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 03:00:26PM -0500, Christopher Covington wrote:
> From: Shanker Donthineni <shankerd@codeaurora.org>
> 
> On the Qualcomm Datacenter Technologies Falkor v1 CPU, memory accesses may
> allocate TLB entries using an incorrect ASID when TTBRx_EL1 is being
> updated. Changing the TTBRx_EL1[ASID] and TTBRx_EL1[BADDR] fields
> separately using a reserved ASID will ensure that there are no TLB entries
> with incorrect ASID after changing the the ASID.
> 
> Pseudo code:
>   write TTBRx_EL1[ASID] to a reserved value
>   ISB
>   write TTBRx_EL1[BADDR] to a desired value
>   ISB
>   write TTBRx_EL1[ASID] to a desired value
>   ISB
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  arch/arm64/Kconfig               | 11 +++++++++++
>  arch/arm64/include/asm/cpucaps.h |  3 ++-
>  arch/arm64/kernel/cpu_errata.c   |  7 +++++++
>  arch/arm64/mm/context.c          | 10 ++++++++++
>  arch/arm64/mm/proc.S             | 21 +++++++++++++++++++++
>  5 files changed, 51 insertions(+), 1 deletion(-)

This needs an update to Documentation/arm64/silicon-errata.txt.

> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index efcf1f7..f8d94ff 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -87,6 +87,11 @@ static void flush_context(unsigned int cpu)
>  	/* Update the list of reserved ASIDs and the ASID bitmap. */
>  	bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
>  
> +	/* Reserve ASID '1' for Falkor erratum E1003 */
> +	if (IS_ENABLED(CONFIG_QCOM_FALKOR_ERRATUM_E1003) &&
> +	    cpus_have_cap(ARM64_WORKAROUND_QCOM_FALKOR_E1003))
> +		__set_bit(1, asid_map);
> +
>  	/*
>  	 * Ensure the generation bump is observed before we xchg the
>  	 * active_asids.
> @@ -239,6 +244,11 @@ static int asids_init(void)
>  		panic("Failed to allocate bitmap for %lu ASIDs\n",
>  		      NUM_USER_ASIDS);
>  
> +	/* Reserve ASID '1' for Falkor erratum E1003 */
> +	if (IS_ENABLED(CONFIG_QCOM_FALKOR_ERRATUM_E1003) &&
> +	    cpus_have_cap(ARM64_WORKAROUND_QCOM_FALKOR_E1003))
> +		__set_bit(1, asid_map);
> +
>  	pr_info("ASID allocator initialised with %lu entries\n", NUM_USER_ASIDS);
>  	return 0;
>  }
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 352c73b..b4d6508 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -134,6 +134,27 @@ ENDPROC(cpu_do_resume)
>  ENTRY(cpu_do_switch_mm)
>  	mmid	x1, x1				// get mm->context.id
>  	bfi	x0, x1, #48, #16		// set the ASID
> +#ifdef CONFIG_QCOM_FALKOR_ERRATUM_E1003
> +alternative_if_not ARM64_WORKAROUND_QCOM_FALKOR_E1003
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +alternative_else
> +	mrs     x2, ttbr0_el1                   // get cuurent TTBR0_EL1
> +	mov     x3, #1                          // reserved ASID

It might be best to define a FALCOR_E1003_RESERVED_ASID constant
somewhere, rather than using 1 directly here and in the ASID allocator.

> +	bfi     x2, x3, #48, #16                // set the reserved ASID + old BADDR
> +	msr     ttbr0_el1, x2                   // update TTBR0_EL1
> +	isb
> +	bfi     x2, x0, #0, #48                 // set the desired BADDR + reserved ASID
> +	msr     ttbr0_el1, x2                   // update TTBR0_EL1
> +	isb
> +alternative_endif

Please use alternative_if and alternative_else_nop_endif.

As Catalin noted, there are issues with stale and/or conflicting TLB
entries allocated with the reserved ASID, so we likely have to
invalidate that after the final switch.

Thanks,
Mark.
