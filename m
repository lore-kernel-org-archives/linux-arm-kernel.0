From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Jan 2017 12:42:23 +0000
Subject: [PATCH v5 2/2] arm64: Work around Falkor erratum 1009
In-Reply-To: <20170130230818.9848-2-cov@codeaurora.org>
References: <20170130230818.9848-1-cov@codeaurora.org>
 <20170130230818.9848-2-cov@codeaurora.org>
Message-ID: <20170131124223.GE11191@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 06:08:17PM -0500, Christopher Covington wrote:
> During a TLB invalidate sequence targeting the inner shareable domain,
> Falkor may prematurely complete the DSB before all loads and stores using
> the old translation are observed. Instruction fetches are not subject to
> the conditions of this erratum. If the original code sequence includes
> multiple TLB invalidate instructions followed by a single DSB, onle one of
> the TLB instructions needs to be repeated to work around this erratum.
> While the erratum only applies to cases in which the TLBI specifies the
> inner-shareable domain (*IS form of TLBI) and the DSB is ISH form or
> stronger (OSH, SYS), this changes applies the workaround overabundantly--
> to local TLBI, DSB NSH sequences as well--for simplicity.
> 
> Based on work by Shanker Donthineni <shankerd@codeaurora.org>
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>

This looks simple, self-contained, and correct, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Catalin/Will, since we may see a documentation conflict against a timer
erratum, would you be hapyp to pick up [1] first, fixing up this patch
as necessary?

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/484594.html

Thanks,
Mark.

> ---
> Based on https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=for-next/core
> ---
>  Documentation/arm64/silicon-errata.txt |  1 +
>  arch/arm64/Kconfig                     | 10 ++++++++++
>  arch/arm64/include/asm/cpucaps.h       |  3 ++-
>  arch/arm64/include/asm/tlbflush.h      | 18 +++++++++++++++---
>  arch/arm64/kernel/cpu_errata.c         |  9 +++++++++
>  5 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 06a516af5103..50da8391e9dd 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -64,3 +64,4 @@ stable kernels.
>  |                |                 |                 |                         |
>  | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
>  | Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003|
> +| Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009|
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 33a8b16ba864..b5284a79bada 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -491,6 +491,16 @@ config QCOM_FALKOR_ERRATUM_1003
>  
>  	  If unsure, say Y.
>  
> +config QCOM_FALKOR_ERRATUM_1009
> +	bool "Falkor E1009: Prematurely complete a DSB after a TLBI"
> +	default y
> +	help
> +	  On Falkor v1, the CPU may prematurely complete a DSB following a
> +	  TLBI xxIS invalidate maintenance operation. Repeat the TLBI operation
> +	  one more time to fix the issue.
> +
> +	  If unsure, say Y.
> +
>  endmenu
>  
>  
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index 5aaf7eede432..55bcd02e4a3f 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -36,7 +36,8 @@
>  #define ARM64_MISMATCHED_CACHE_LINE_SIZE	15
>  #define ARM64_HAS_NO_FPSIMD			16
>  #define ARM64_WORKAROUND_QCOM_FALKOR_E1003	17
> +#define ARM64_WORKAROUND_REPEAT_TLBI		18
>  
> -#define ARM64_NCAPS				18
> +#define ARM64_NCAPS				19
>  
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index deab52374119..fc434f421c7b 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -36,9 +36,21 @@
>   * not. The macros handles invoking the asm with or without the
>   * register argument as appropriate.
>   */
> -#define __TLBI_0(op, arg)		asm ("tlbi " #op)
> -#define __TLBI_1(op, arg)		asm ("tlbi " #op ", %0" : : "r" (arg))
> -#define __TLBI_N(op, arg, n, ...)	__TLBI_##n(op, arg)
> +#define __TLBI_0(op, arg) asm volatile ("tlbi " #op "\n"		       \
> +			    ALTERNATIVE("nop\n		nop",		       \
> +					"dsb ish\n	tlbi " #op,	       \
> +					ARM64_WORKAROUND_REPEAT_TLBI,	       \
> +					CONFIG_QCOM_FALKOR_ERRATUM_1009)       \
> +			    : : )
> +
> +#define __TLBI_1(op, arg) asm volatile ("tlbi " #op ", %0\n"		       \
> +			    ALTERNATIVE("nop\n		nop",		       \
> +					"dsb ish\n	tlbi " #op ", %0",     \
> +					ARM64_WORKAROUND_REPEAT_TLBI,	       \
> +					CONFIG_QCOM_FALKOR_ERRATUM_1009)       \
> +			    : : "r" (arg))
> +
> +#define __TLBI_N(op, arg, n, ...) __TLBI_##n(op, arg)
>  
>  #define __tlbi(op, ...)		__TLBI_N(op, ##__VA_ARGS__, 1, 0)
>  
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 502a79f211b0..f6cc67e7626e 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -142,6 +142,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  			   MIDR_CPU_VAR_REV(0, 0)),
>  	},
>  #endif
> +#ifdef CONFIG_QCOM_FALKOR_ERRATUM_1009
> +	{
> +		.desc = "Qualcomm Technologies Falkor erratum 1009",
> +		.capability = ARM64_WORKAROUND_REPEAT_TLBI,
> +		MIDR_RANGE(MIDR_QCOM_FALKOR_V1,
> +			   MIDR_CPU_VAR_REV(0, 0),
> +			   MIDR_CPU_VAR_REV(0, 0)),
> +	},
> +#endif
>  	{
>  	}
>  };
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora
> Forum, a Linux Foundation Collaborative Project.
> 
