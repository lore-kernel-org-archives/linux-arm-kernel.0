From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Jan 2017 15:55:02 +0000
Subject: [PATCH v2 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <20161229224335.13531-2-cov@codeaurora.org>
References: <20161229224335.13531-1-cov@codeaurora.org>
 <20161229224335.13531-2-cov@codeaurora.org>
Message-ID: <20170103155502.GA14183@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 29, 2016 at 05:43:32PM -0500, Christopher Covington wrote:
> +config QCOM_FALKOR_E1003_RESERVED_ASID
> +	int
> +	default 1
> +	depends on QCOM_FALKOR_ERRATUM_1003
> +

I don't think this needs to be configurable, so let's drop this into a
header, e.g. drop:

#define FALKOR_RESERVED_ASID	1

... in <asm/mmu_context.h>, protecting the rest with an ifndef
__ASSEMBLY__ guard.

[...]

> +#ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
> +alternative_if ARM64_WORKAROUND_QCOM_FALKOR_E1003
> +	mrs     x2, ttbr0_el1                   // get cuurent TTBR0_EL1
> +	mov     x3, #CONFIG_QCOM_FALKOR_ERRATUM_1003	// reserved ASID

Wrong macro? That's not the ASID.

Thanks,
Mark.
