From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jan 2017 15:07:23 +0000
Subject: [PATCH v4 4/4] arm64: Work around Falkor erratum 1009
In-Reply-To: <20170125155232.10277-4-cov@codeaurora.org>
References: <20170125155232.10277-1-cov@codeaurora.org>
 <20170125155232.10277-4-cov@codeaurora.org>
Message-ID: <20170127150722.GN21144@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 10:52:32AM -0500, Christopher Covington wrote:
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
> ---
>  Documentation/arm64/silicon-errata.txt |  1 +
>  arch/arm64/Kconfig                     | 10 ++++++++++
>  arch/arm64/include/asm/cpucaps.h       |  3 ++-
>  arch/arm64/include/asm/tlbflush.h      | 18 +++++++++++++++---
>  arch/arm64/kernel/cpu_errata.c         |  7 +++++++
>  5 files changed, 35 insertions(+), 4 deletions(-)

Thanks, this one looks good to me. It doesn't apply without the other
erratum workaround (due to conflicts), so I'll have to wait for the
discussion with Mark to each a conclusion before I can queue it.

One minor comment inline...

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

I don't think you need to make these volatile.

Will
