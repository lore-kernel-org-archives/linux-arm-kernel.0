From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 31 Jan 2017 11:17:03 -0500
Subject: [PATCH v5 2/2] arm64: Work around Falkor erratum 1009
In-Reply-To: <20170131143843.GD22283@arm.com>
References: <20170130230818.9848-1-cov@codeaurora.org>
 <20170130230818.9848-2-cov@codeaurora.org> <20170131143843.GD22283@arm.com>
Message-ID: <b18c8e22-2de5-6cc9-08d2-6586dea4a4d3@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2017 09:38 AM, Will Deacon wrote:
> On Mon, Jan 30, 2017 at 06:08:17PM -0500, Christopher Covington wrote:
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index deab52374119..fc434f421c7b 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -36,9 +36,21 @@
>>   * not. The macros handles invoking the asm with or without the
>>   * register argument as appropriate.
>>   */
>> -#define __TLBI_0(op, arg)		asm ("tlbi " #op)
>> -#define __TLBI_1(op, arg)		asm ("tlbi " #op ", %0" : : "r" (arg))
>> -#define __TLBI_N(op, arg, n, ...)	__TLBI_##n(op, arg)
>> +#define __TLBI_0(op, arg) asm volatile ("tlbi " #op "\n"		       \
>> +			    ALTERNATIVE("nop\n		nop",		       \
>> +					"dsb ish\n	tlbi " #op,	       \
>> +					ARM64_WORKAROUND_REPEAT_TLBI,	       \
>> +					CONFIG_QCOM_FALKOR_ERRATUM_1009)       \
>> +			    : : )
>> +
>> +#define __TLBI_1(op, arg) asm volatile ("tlbi " #op ", %0\n"		       \
>> +			    ALTERNATIVE("nop\n		nop",		       \
>> +					"dsb ish\n	tlbi " #op ", %0",     \
>> +					ARM64_WORKAROUND_REPEAT_TLBI,	       \
>> +					CONFIG_QCOM_FALKOR_ERRATUM_1009)       \
>> +			    : : "r" (arg))
>> +
> 
> Why are these now volatile? I asked the same question on the previous
> version but didn't get a response:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/483579.html

D'oh! Will fix in v6. Sorry about that.

Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
