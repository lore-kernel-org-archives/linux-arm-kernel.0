From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 8 Feb 2017 15:09:00 -0500
Subject: [PATCH v6] arm64: Work around Falkor erratum 1003
In-Reply-To: <20170208163441.GC32756@e104818-lin.cambridge.arm.com>
References: <20170208003516.9519-1-cov@codeaurora.org>
 <20170208163441.GC32756@e104818-lin.cambridge.arm.com>
Message-ID: <e33075cc-ca0c-039b-4f5e-87a2d7c696ea@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2017 11:34 AM, Catalin Marinas wrote:
> On Tue, Feb 07, 2017 at 07:35:16PM -0500, Christopher Covington wrote:
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -480,6 +480,18 @@ config CAVIUM_ERRATUM_27456
>>  
>>  	  If unsure, say Y.
>>  
>> +config QCOM_FALKOR_ERRATUM_1003
>> +	bool "Falkor E1003: Incorrect translation due to ASID change"
>> +	default y
>> +	select ARM64_PAN if ARM64_SW_TTBR0_PAN
>> +	help
>> +	  On Falkor v1, an incorrect ASID may be cached in the TLB when ASID
>> +	  and BADDR are changed together in TTBRx_EL1. The workaround for this
>> +	  issue is to use a reserved ASID in cpu_do_switch_mm() before
>> +	  switching to the new ASID.
>> +
>> +	  If unsure, say Y.
> 
> It would be good to have a comment here on why PAN is selected.
> 
>> --- a/arch/arm64/mm/context.c
>> +++ b/arch/arm64/mm/context.c
>> @@ -79,6 +79,13 @@ void verify_cpu_asid_bits(void)
>>  	}
>>  }
>>  
>> +static void set_reserved_asid_bits(void)
>> +{
>> +	if (IS_ENABLED(CONFIG_QCOM_FALKOR_ERRATUM_1003) &&
>> +	    cpus_have_cap(ARM64_WORKAROUND_QCOM_FALKOR_E1003))
>> +		__set_bit(FALKOR_RESERVED_ASID, asid_map);
>> +}
> 
> You should use cpus_have_const_cap() as it would be optimised using jump
> labels.

Thanks Catalin. Done in v7.

Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
