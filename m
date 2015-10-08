From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 8 Oct 2015 16:57:56 +0100
Subject: [PATCH v2 16/22] arm64/debug: Make use of the system wide safe
 value
In-Reply-To: <20151008150819.GL17192@e104818-lin.cambridge.arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-17-git-send-email-suzuki.poulose@arm.com>
 <20151008111128.GH17192@e104818-lin.cambridge.arm.com>
 <561659EC.7030508@arm.com>
 <20151008150819.GL17192@e104818-lin.cambridge.arm.com>
Message-ID: <56169284.5070706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/15 16:08, Catalin Marinas wrote:
> On Thu, Oct 08, 2015 at 12:56:28PM +0100, Suzuki K. Poulose wrote:
>> On 08/10/15 12:11, Catalin Marinas wrote:
>>> On Mon, Oct 05, 2015 at 06:02:05PM +0100, Suzuki K. Poulose wrote:
>>>> @@ -137,13 +138,17 @@ extern struct pmu perf_ops_bp;
>>>>   /* Determine number of BRP registers available. */
>>>>   static inline int get_num_brps(void)
>>>>   {
>>>> -	return ((read_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
>>>> +	return 1 +
>>>> +		cpuid_feature_extract_field(read_system_reg(SYS_ID_AA64DFR0_EL1),
>>>> +						ID_AA64DFR0_BRPS_SHIFT);
>>>>   }
>>>
>>> cpuid_feature_extract_field() is fine but we should we bother with
>>> read_system_reg vs just read_cpuid?
>>> Similar question for patch 17/22.
>>
>> Well, we would have already TAINTed the kernel, if these fields are different.
>> It is just the matter of, whether we want to provide the safer value on a tainted
>> kernel or not. I am open to suggestions.
>
> Ah, sorry, I mixed read_system_reg() with read_cpu_sysreg(). I think we

Oh, ok. I think we should rename it as you suggest below to avoid the
confusion.

> need to rename the latter as it gets confusing. Maybe something like
> read_native_sys_reg() or __raw_read_system_reg().
>


Thanks
Suzuki
