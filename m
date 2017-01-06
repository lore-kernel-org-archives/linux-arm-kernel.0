From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 6 Jan 2017 10:49:36 -0500
Subject: [PATCH v2 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <20170103155502.GA14183@leverpostej>
References: <20161229224335.13531-1-cov@codeaurora.org>
 <20161229224335.13531-2-cov@codeaurora.org>
 <20170103155502.GA14183@leverpostej>
Message-ID: <ae59aa20-5518-0e33-6b64-7622010fc541@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2017 10:55 AM, Mark Rutland wrote:
> Hi,
> 
> On Thu, Dec 29, 2016 at 05:43:32PM -0500, Christopher Covington wrote:
>> +config QCOM_FALKOR_E1003_RESERVED_ASID
>> +	int
>> +	default 1
>> +	depends on QCOM_FALKOR_ERRATUM_1003
>> +
> 
> I don't think this needs to be configurable, so let's drop this into a
> header, e.g. drop:
> 
> #define FALKOR_RESERVED_ASID	1
> 
> ... in <asm/mmu_context.h>, protecting the rest with an ifndef
> __ASSEMBLY__ guard.

Will do, thanks for the concrete suggestion.

> [...]
> 
>> +#ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
>> +alternative_if ARM64_WORKAROUND_QCOM_FALKOR_E1003
>> +	mrs     x2, ttbr0_el1                   // get cuurent TTBR0_EL1
>> +	mov     x3, #CONFIG_QCOM_FALKOR_ERRATUM_1003	// reserved ASID
> 
> Wrong macro? That's not the ASID.

Oops, thanks for spotting.

Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
