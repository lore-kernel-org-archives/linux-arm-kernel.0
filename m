From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Jan 2015 09:41:41 +0000
Subject: [PATCH 1/3] arm64: Track system support for mixed endian EL0
In-Reply-To: <54B93930.1090409@arm.com>
References: <1421325366-13263-1-git-send-email-suzuki.poulose@arm.com>
 <1421325366-13263-2-git-send-email-suzuki.poulose@arm.com>
 <20150116155322.GX7091@arm.com> <54B93930.1090409@arm.com>
Message-ID: <54BCD155.6060606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/15 16:15, Suzuki K. Poulose wrote:
> On 16/01/15 15:53, Will Deacon wrote:
>> On Thu, Jan 15, 2015 at 12:36:04PM +0000, Suzuki K. Poulose wrote:
>>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>>
>>> This patch keeps track of the mixed endian EL0 support across
>>> the system and provides helper functions to export it. The status
>>> is a boolean indicating whether all the CPUs on the system supports
>>> mixed endian at EL0.
>>>
>>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>>> ---
>>>    arch/arm64/include/asm/cpufeature.h |   10 ++++++++++
>>>    arch/arm64/kernel/cpuinfo.c         |   22 ++++++++++++++++++++++
>>>    2 files changed, 32 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>>> index 07547cc..c7f68d1 100644
>>> --- a/arch/arm64/include/asm/cpufeature.h
>>> +++ b/arch/arm64/include/asm/cpufeature.h
>>> @@ -26,6 +26,9 @@
>>>
>>>    #define ARM64_NCAPS				2
>>>
>>> +#define ID_AA64MMFR0_EL1_BigEndEL0	(0x1UL << 16)
>>> +#define ID_AA64MMFR0_EL1_BigEnd		(0x1UL << 8)
>>
>> I don't like the CaMeLcAsE. Also, perhaps these definitions should be
>> somewhere like cputype.h?
> Yeah, I tried to keep it aligned withe ARMv8 architecture definition of
> those bits. Will change it.
> Things are a bit messy w.r.t the definitions. We have cpu.h,
> cpufeature.h and cputype.h. I could move it to cputype.h, where we
> already have MIDR_ defintions.
>
>>
>>> +
>>>    #ifndef __ASSEMBLY__
>>>
>>>    extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>>> @@ -51,7 +54,14 @@ static inline void cpus_set_cap(unsigned int num)
>>>    		__set_bit(num, cpu_hwcaps);
>>>    }
>>>
>>> +static inline bool id_aa64mmfr0_mixed_endian_el0(unsigned long mmfr0)
>>> +{
>>> +	return !!(mmfr0 & (ID_AA64MMFR0_EL1_BigEndEL0 | ID_AA64MMFR0_EL1_BigEnd));
>>> +}
>>
>> These are 4-bit fields and I think you think you should be treating them
>> as such.
> OK
>
>>
>>> +
>>>    void check_local_cpu_errata(void);
>>> +bool system_supports_mixed_endian_el0(void);
>>> +bool cpu_supports_mixed_endian_el0(void);
>>>
>>>    #endif /* __ASSEMBLY__ */
>>>
>>> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
>>> index 07d435c..b6d1135 100644
>>> --- a/arch/arm64/kernel/cpuinfo.c
>>> +++ b/arch/arm64/kernel/cpuinfo.c
>>> @@ -35,6 +35,7 @@
>>>     */
>>>    DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
>>>    static struct cpuinfo_arm64 boot_cpu_data;
>>> +static bool mixed_endian_el0 = true;
>>>
>>>    static char *icache_policy_str[] = {
>>>    	[ICACHE_POLICY_RESERVED] = "RESERVED/UNKNOWN",
>>> @@ -68,6 +69,26 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
>>>    	pr_info("Detected %s I-cache on CPU%d\n", icache_policy_str[l1ip], cpu);
>>>    }
>>>
>>> +bool cpu_supports_mixed_endian_el0(void)
>>> +{
>>> +	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
>>> +}
>>
>> Can we not just define a mask/value pair and have code do the MMFR0 access
>> inline? It also feels a bit over-engineered like this.
> Sure, will change this.

On a second thought, we need the id_aa64mmfr0_mixed_endian_el0() for 
another code path. For a new CPU detected at boot time via 
cpuinfo_store_cpu(), where we get the 'filled' cpuinfo_arm64 which 
already has the id_aa64mmfr0. So we do:

+
+static void update_mixed_endian_el0_support(struct cpuinfo_arm64 *info)
+{
+	mixed_endian_el0 &= id_aa64mmfr0_mixed_endian_el0(info->reg_id_aa64mmfr0);
+}

So, having a helper to extract the support from the id_aa64mmfr0 makes 
it a bit more ordered.

But yes, we could switch to mask/value pair.

Thanks
Suzuki
>
> Thanks
> Suzuki
>>
>> Will
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
