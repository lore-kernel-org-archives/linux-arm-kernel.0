From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 30 Nov 2017 17:06:48 +0000
Subject: [PATCH v2 14/18] arm64: erratum: Work around Falkor erratum
 #E1003 in trampoline code
In-Reply-To: <1512059986-21325-15-git-send-email-will.deacon@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <1512059986-21325-15-git-send-email-will.deacon@arm.com>
Message-ID: <2950815e-546f-9a3b-002f-e9895e90eb79@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 30/11/17 16:39, Will Deacon wrote:
> We rely on an atomic swizzling of TTBR1 when transitioning from the entry
> trampoline to the kernel proper on an exception. We can't rely on this
> atomicity in the face of Falkor erratum #E1003, so on affected cores we
> can issue a TLB invalidation to invalidate the walk cache prior to
> jumping into the kernel. There is still the possibility of a TLB conflict
> here due to conflicting walk cache entries prior to the invalidation, but
> this doesn't appear to be the case on these CPUs in practice.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/Kconfig        | 17 +++++------------
>   arch/arm64/kernel/entry.S | 10 ++++++++++
>   2 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a93339f5178f..fdcc7b9bb15d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -522,20 +522,13 @@ config CAVIUM_ERRATUM_30115
>   config QCOM_FALKOR_ERRATUM_1003
>   	bool "Falkor E1003: Incorrect translation due to ASID change"
>   	default y
> -	select ARM64_PAN if ARM64_SW_TTBR0_PAN
>   	help
>   	  On Falkor v1, an incorrect ASID may be cached in the TLB when ASID
> -	  and BADDR are changed together in TTBRx_EL1. The workaround for this
> -	  issue is to use a reserved ASID in cpu_do_switch_mm() before
> -	  switching to the new ASID. Saying Y here selects ARM64_PAN if
> -	  ARM64_SW_TTBR0_PAN is selected. This is done because implementing and
> -	  maintaining the E1003 workaround in the software PAN emulation code
> -	  would be an unnecessary complication. The affected Falkor v1 CPU
> -	  implements ARMv8.1 hardware PAN support and using hardware PAN
> -	  support versus software PAN emulation is mutually exclusive at
> -	  runtime.
> -
> -	  If unsure, say Y.
> +	  and BADDR are changed together in TTBRx_EL1. Since we keep the ASID
> +	  in TTBR1_EL1, this situation only occurs in the entry trampoline and
> +	  then only for entries in the walk cache, since the leaf translation
> +	  is unchanged. Work around the erratum by invalidating the walk cache
> +	  entries for the trampoline before entering the kernel proper.
>   
>   config QCOM_FALKOR_ERRATUM_1009
>   	bool "Falkor E1009: Prematurely complete a DSB after a TLBI"
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 99d105048663..a5ec6ab5c711 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -989,6 +989,16 @@ __ni_sys_trace:
>   	sub	\tmp, \tmp, #(SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
>   	bic	\tmp, \tmp, #USER_ASID_FLAG
>   	msr	ttbr1_el1, \tmp
> +#ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
> +alternative_if ARM64_WORKAROUND_QCOM_FALKOR_E1003
> +	movk	\tmp, #:abs_g2_nc:(TRAMP_VALIAS >> 12)
> +	movk	\tmp, #:abs_g1_nc:(TRAMP_VALIAS >> 12)
> +	movk	\tmp, #:abs_g0_nc:((TRAMP_VALIAS & (SZ_2M - 1)) >> 12)

What's the deal with effectively zeroing bits 27:22 of the TRAMP_VALIAS 
address here? Is this an attempt to round down to section granularity 
gone awry, or something else subtle which probably warrants documenting?

Robin.

> +	isb
> +	tlbi	vae1, \tmp
> +	dsb	nsh
> +alternative_else_nop_endif
> +#endif /* CONFIG_QCOM_FALKOR_ERRATUM_1003 */
>   	.endm
>   
>   	.macro tramp_unmap_kernel, tmp
> 
