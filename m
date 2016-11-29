From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 29 Nov 2016 12:25:43 -0600
Subject: [PATCH V10 2/6] arm: arm64: Add routine to determine cpuid of
 other cpus
In-Reply-To: <20161129104617.GV14217@n2100.armlinux.org.uk>
References: <1478734793-6341-1-git-send-email-jeremy.linton@arm.com>
 <1478734793-6341-3-git-send-email-jeremy.linton@arm.com>
 <20161129103112.GC30283@arm.com>
 <20161129104617.GV14217@n2100.armlinux.org.uk>
Message-ID: <67b08fa0-cff4-4d74-b72c-fa66e927f201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/29/2016 04:46 AM, Russell King - ARM Linux wrote:
> On Tue, Nov 29, 2016 at 10:31:12AM +0000, Will Deacon wrote:
>> [adding Russell]
>>
>> On Wed, Nov 09, 2016 at 05:39:49PM -0600, Jeremy Linton wrote:
>>> It is helpful if we can read the cpuid/midr of other CPUs
>>> in the system independent of arm/arm64.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>  arch/arm/include/asm/cputype.h   | 2 ++
>>>  arch/arm64/include/asm/cputype.h | 3 +++
>>>  2 files changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
>>> index 522b5fe..31fb273 100644
>>> --- a/arch/arm/include/asm/cputype.h
>>> +++ b/arch/arm/include/asm/cputype.h
>>> @@ -235,6 +235,8 @@ static inline unsigned int __attribute_const__ read_cpuid_mpidr(void)
>>>  #define cpu_is_sa1100() (read_cpuid_part() == ARM_CPU_PART_SA1100)
>>>  #define cpu_is_sa1110() (read_cpuid_part() == ARM_CPU_PART_SA1110)
>>>
>>> +#define read_specific_cpuid(cpu_num) per_cpu_ptr(&cpu_data, cpu_num)->cpuid
>>> +
>>>  /*
>>>   * Intel's XScale3 core supports some v6 features (supersections, L2)
>>>   * but advertises itself as v5 as it does not support the v6 ISA.  For
>>
>> Russell -- are you ok with adding this macro to arch/arm/? It will get used
>> by the CPU PMU driver, which needs a portable (i.e. between arm and arm64)
>> way to convert a logical CPU ID into the MIDR register for that CPU.
>
> No, because we don't set the cpuid member in uniprocessor configurations,
> so it's going to be a fragile macro - it'll return zero for kernels
> configured without SMP support.

By itself is easy enough to fix, it could be tweaked to do the same 
thing as c_show()

#define read_specific_cpuid(cpu_num) is_smp() ? per_cpu(&cpu_data, 
cpu_num)->cpuid : read_cpuid_id()

c_show could then be updated to use read_specific_cpuid().

>
> I'd ideally like cpuid for the boot CPU to be set early, so that we can
> get rid of many ifdefs in this area, but haven't convinced myself that
> it's safe to do so in all configurations with the percpu stuff not being
> up and running in setup_arch().

As the above change is a little ugly... It seems something like 
smp_prepare_boot_cpu() call would be perfect if it were available for 
!SMP. Although this is getting a little off base for the PMU changes.

The alternative to all this, is yet another #ifdef in the pmu code, 
which is IMHO the worse choice.

Suggestions?
