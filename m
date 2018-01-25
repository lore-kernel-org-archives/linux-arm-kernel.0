From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 25 Jan 2018 17:56:02 +0000
Subject: [PATCH 04/16] arm64: capabilities: Prepare for fine grained
 capabilities
In-Reply-To: <20180125173307.GJ5862@e103592.cambridge.arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-5-suzuki.poulose@arm.com>
 <20180125173307.GJ5862@e103592.cambridge.arm.com>
Message-ID: <1c8b0c18-1b18-30b3-6df0-ff4bd876cbbc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/01/18 17:33, Dave Martin wrote:
> On Tue, Jan 23, 2018 at 12:27:57PM +0000, Suzuki K Poulose wrote:
>> We use arm64_cpu_capabilities to represent CPU ELF HWCAPs exposed
>> to the userspace and the CPU hwcaps used by the kernel, which
>> include cpu features and CPU errata work arounds.
>>
>> At the moment we have the following restricions:
>>
>>   a) CPU feature hwcaps (arm64_features) and ELF HWCAPs (arm64_elf_hwcap)
>>     - Detected mostly on system wide CPU feature register. But
>>       there are some which really uses a local CPU's value to
>>       decide the availability (e.g, availability of hardware
>>       prefetch). So, we run the check only once, after all the
>>       boot-time active CPUs are turned on.
> 
> [ARM64_HAS_NO_HW_PREFETCH is kinda broken, but we also get away with it
> presumably because the only systems to which it applies are homogeneous,
> and anyway it's only an optimisation IIUC.
> 
> This could be a separate category, but as a one-off that may be a bit
> pointless.
I understand and was planning to fix this back when it was introduced.
But then it was pointless at that time, given that it was always
guaranteed to be a homogeneous system. We do something about it in
Patch 9.

> 
> .def_scope == SCOPE_SYSTEM appears anomalous there, but it's also
> unused in that case.]
> 
>>     - Any late CPU which doesn't posses all the established features
>>       is killed.
> 
> Does "established feature" above ...
> 
>>     - Any late CPU which possess a feature *not* already available
>>       is allowed to boot.
> 
> mean the same as "feature already available" here?

Yes, its the same. I should have been more consistent.

> 
>>
>>   b) CPU Errata work arounds (arm64_errata)
>>     - Detected mostly based on a local CPU's feature register.
>>       The checks are run on each boot time activated CPUs.
>>     - Any late CPU which doesn't have any of the established errata
>>       work around capabilities is ignored and is allowed to boot.
>>     - Any late CPU which has an errata work around not already available
>>       is killed.
>>
>> However there are some exceptions to the cases above.
>>
>> 1) KPTI is a feature that we need to enable when at least one CPU needs it.
>>     And any late CPU that has this "feature" should be killed.
> 
> Should that be "If KPTI is not enabled during system boot, then any late
> CPU that has this "feature" should be killed."

Yes.

> 
>> 2) Hardware DBM feature is a non-conflicting capability which could be
>>     enabled on CPUs which has it without any issues, even if the CPU is
> 
> have
> 

>>     brought up late.
>>
>> So this calls for a lot more fine grained behavior for each capability.
>> And if we define all the attributes to control their behavior properly,
>> we may be able to use a single table for the CPU hwcaps (not the
>> ELF HWCAPs, which cover errata and features). This is a prepartory step
>> to get there. We define type for a capability, which for now encodes the
>> scope of the check. i.e, whether it should be checked system wide or on
>> each local CPU. We define two types :
>>
>>    1) ARM64_CPUCAP_BOOT_SYSTEM_FEATURE - Implies (a) as described above.
>>    1) ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM - Implies (b) as described above.
> 
> 2)
> 
>> As such there is no change in how the capabilities are treated.
> 
> OK, I think I finally have my head around this, more or less.
> 
> Mechanism (operations on architectural feature regs) and policy (kernel
> runtime configuration) seem to be rather mixed together.  This works
> fairly naturally for things like deriving the sanitised feature regs
> seen by userspace and determining the ELF hwcaps; but not so naturally
> for errata workarounds and other anomalous things like
> ARM64_HAS_NO_HW_PREFETCH.

Right. We are stuck with "cpu_hwcaps" for both erratum and features,
based on which we make some decisions to change the kernel behavior,
as it is tied to alternative patching.

> 
> I'm not sure that there is a better approach though -- anyway, that
> would be out of scope for this series.
> 
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/cpufeature.h | 24 +++++++++++++++++------
>>   arch/arm64/kernel/cpu_errata.c      |  8 ++++----
>>   arch/arm64/kernel/cpufeature.c      | 38 ++++++++++++++++++-------------------
>>   3 files changed, 41 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index a23c0d4f27e9..4fd5de8ef33e 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -86,16 +86,23 @@ struct arm64_ftr_reg {
>>   
>>   extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>   
>> -/* scope of capability check */
>> -enum {
>> -	SCOPE_SYSTEM,
>> -	SCOPE_LOCAL_CPU,
>> -};
>> +
>> +/* Decide how the capability is detected. On a local CPU vs System wide */
>> +#define ARM64_CPUCAP_SCOPE_MASK			0x3
>> +#define ARM64_CPUCAP_SCOPE_LOCAL_CPU		BIT(0)
>> +#define ARM64_CPUCAP_SCOPE_SYSTEM		BIT(1)
>> +#define SCOPE_SYSTEM				ARM64_CPUCAP_SCOPE_SYSTEM
>> +#define SCOPE_LOCAL_CPU				ARM64_CPUCAP_SCOPE_LOCAL_CPU
> 
> Are these really orthogonal?  What would be meant by (LOCAL_CPU | SYSTEM)?

It is an unsupported configuration.

> 
> Otherwise, perhaps they should be 0 and 1, not BIT(0), BIT(1).
> 

It is a bit tricky. I chose separate bits to allow filter an entry in a table
of capabilities based on the bits. e.g, we want to

1) Process only the local scope (e.g detecting CPU local capabilities, where
we are not yet ready to run the system wide checks)

2) Process all the entries including local/system. (e.g, verifying all the
capabilities for a late CPU).

Things get further complicated by the addition of "EARLY", where we want to
filter entries based on "EARLY" bit. So, we need to pass on a mask of bits
to the helpers, which are not just the binary scope. See Patch 7 for more
info.

>> +
>> +/* CPU errata detected at boot time based on feature of one or more CPUs */
>> +#define ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM	(ARM64_CPUCAP_SCOPE_LOCAL_CPU)
> 
>> +/* CPU feature detected at boot time based on system-wide value of a feature */
> 
> I'm still not overly keen on these names, but I do at least see where
> they come from now.
> 
> Nit: redundant () in these two #defines btw.

Ok.

Suzuki
