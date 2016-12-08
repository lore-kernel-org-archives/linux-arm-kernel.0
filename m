From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Dec 2016 11:20:43 +0000
Subject: [PATCH] arm64: Work around Falkor erratum 1009
In-Reply-To: <20161207200431.4587-1-cov@codeaurora.org>
References: <20161207200028.4420-1-cov@codeaurora.org>
 <20161207200431.4587-1-cov@codeaurora.org>
Message-ID: <20161208112042.GB706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 03:04:31PM -0500, Christopher Covington wrote:
> From: Shanker Donthineni <shankerd@codeaurora.org>
> 
> During a TLB invalidate sequence targeting the inner shareable
> domain, Falkor may prematurely complete the DSB before all loads
> and stores using the old translation are observed; instruction
> fetches are not subject to the conditions of this erratum.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  arch/arm64/Kconfig                | 10 +++++++++
>  arch/arm64/include/asm/cpucaps.h  |  3 ++-
>  arch/arm64/include/asm/tlbflush.h | 43 +++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/cpu_errata.c    |  7 +++++++
>  arch/arm64/kvm/hyp/tlb.c          | 39 ++++++++++++++++++++++++++++++-----
>  5 files changed, 96 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1004a3d..125440f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -485,6 +485,16 @@ config QCOM_FALKOR_ERRATUM_E1003
>  
>  	  If unsure, say Y.
>  
> +config QCOM_FALKOR_ERRATUM_E1009
> +	bool "Falkor E1009: Prematurely complete a DSB after a TLBI"
> +	default y
> +	help
> +	  Falkor CPU may prematurely complete a DSB following a TLBI xxIS
> +	  invalidate maintenance operations. Repeat the TLBI operation one
> +	  more time to fix the issue.
> +
> +	  If unsure, say Y.

Call me perverse, but I like this workaround. People often tend to screw
up TLBI and DVM sync, but the IPI-based workaround is horribly invasive
and fragile. Simply repeating the operation tends to be enough to make
the chance of failure small enough to be acceptable.

> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index cb6a8c2..5357d7f 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -35,7 +35,8 @@
>  #define ARM64_HYP_OFFSET_LOW			14
>  #define ARM64_MISMATCHED_CACHE_LINE_SIZE	15
>  #define ARM64_WORKAROUND_QCOM_FALKOR_E1003	16
> +#define ARM64_WORKAROUND_QCOM_FALKOR_E1009	17

Could you rename this to something like ARM64_WORKAROUND_REPEAT_TLBI, so
that it could potentially be used by others?

>  
> -#define ARM64_NCAPS				17
> +#define ARM64_NCAPS				18
>  
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index deab523..03bafc5 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -23,6 +23,7 @@
>  
>  #include <linux/sched.h>
>  #include <asm/cputype.h>
> +#include <asm/alternative.h>
>  
>  /*
>   * Raw TLBI operations.
> @@ -94,6 +95,13 @@ static inline void flush_tlb_all(void)
>  	dsb(ishst);
>  	__tlbi(vmalle1is);
>  	dsb(ish);
> +	asm volatile(ALTERNATIVE(
> +		     "nop \n"
> +		     "nop \n",
> +		     "tlbi vmalle1is \n"
> +		     "dsb ish \n",
> +		     ARM64_WORKAROUND_QCOM_FALKOR_E1009)
> +		     : :);

I'd much rather this was part of the __tlbi macro, which would hopefully
restrict this to one place in the code.

Will
