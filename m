From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 20 Apr 2016 13:35:27 +0100
Subject: [PATCH v2 1/5] arm64: cpufeature: Add scope for capability check
In-Reply-To: <20160420112800.GC2514@arm.com>
References: <1460997334-26232-1-git-send-email-suzuki.poulose@arm.com>
 <1460997334-26232-2-git-send-email-suzuki.poulose@arm.com>
 <20160420112800.GC2514@arm.com>
Message-ID: <5717778F.5020702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/04/16 12:28, Will Deacon wrote:
> On Mon, Apr 18, 2016 at 05:35:30PM +0100, Suzuki K Poulose wrote:
>> Add scope parameter to the arm64_cpu_capabilities::matches(), so that
>> this can be reused for checking the capability on a given CPU vs the
>> system wide. The system uses the default scope associated with the
>> capability for initialising the CPU_HWCAPs and ELF_HWCAPs.

>> +/* scope of capability check */
>> +enum {
>> +	SCOPE_SYSTEM,
>> +	SCOPE_CPU,
>> +};
>
> I think I actually prefer the GLOBAL/LOCAL naming, since SYSTEM is going
> to be the scope you want when talking about all CPUs. Or maybe just
> rename SCOPE_CPU to SCOPE_LOCAL_CPU.

OK

>
> We might want a preemptible() check when probing SCOPE_CPU properties,
> too.

Good point. The current users are all calling them from the CPU init phase,
where it is not preemptible. But it would be good to add a check to make sure
nobody violates this condition. Also, will add a comment for
"this_cpu_has_cap()" API to call it under !preemptible() state.
  

>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 8c46621..db392c5 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -71,7 +71,9 @@ DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>>
>>   /* meta feature for alternatives */
>>   static bool __maybe_unused
>> -cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry);
>> +cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused);
>> +
>> +static u64 __raw_read_system_reg(u32 sys_id);
>
> Can we not reorder the functions in this file to avoid the internal forward
> declarations?

We can. I had that in my initial version, but the patch looked a bit more complicated
with the code movement. I will bring it back and get rid of the declaration.


Cheers
Suzuki
