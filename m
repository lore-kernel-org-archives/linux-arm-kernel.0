From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 30 Nov 2016 11:41:00 +0000
Subject: [PATCH 9/9] arm64: Documentation - Expose CPU feature registers
In-Reply-To: <20161124184436.GG7452@e104818-lin.cambridge.arm.com>
References: <1479994809-9081-1-git-send-email-suzuki.poulose@arm.com>
 <1479994809-9081-10-git-send-email-suzuki.poulose@arm.com>
 <20161124184436.GG7452@e104818-lin.cambridge.arm.com>
Message-ID: <f0dfe659-2487-3afb-eeb3-d5219d09332c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/16 18:44, Catalin Marinas wrote:
> Hi Suzuki,
>
> On Thu, Nov 24, 2016 at 01:40:09PM +0000, Suzuki K. Poulose wrote:
>> --- /dev/null
>> +++ b/Documentation/arm64/cpu-feature-registers.txt
>> @@ -0,0 +1,198 @@
>> +		ARM64 CPU Feature Registers
>> +		===========================
>> +
>> +Author: Suzuki K Poulose <suzuki.poulose@arm.com>
>> +
>> +
>> +This file describes the API for exporting the AArch64 CPU ID/feature
>> +registers to userspace. The availability of this API is advertised
>> +via the HWCAP_CPUID in HWCAPs.
>
> s/API/ABI/ maybe?

Sure

>
>> +
>> +1. Motivation
>> +---------------
>> +
>> +The ARM architecture defines a set of feature registers, which describe
>> +the capabilities of the CPU/system. Access to these system registers is
>> +restricted from EL0 and there is no reliable way for an application to
>> +extract this information to make better decisions at runtime. There is
>> +limited information available to the application via HWCAPs, however
>> +there are some issues with their usage.
>> +
>> + a) Any change to the HWCAPs requires an update to userspace (e.g libc)
>> +    to detect the new changes, which can take a long time to appear in
>> +    distributions. Exposing the registers allows applications to get the
>> +    information without requiring updates to the toolchains.
>> +
>> + b) Access to HWCAPs is sometimes limited (e.g prior to libc, or
>> +    when ld is initialised at startup time).
>> +
>> + c) HWCAPs cannot represent non-boolean information effectively. The
>> +    architecture defines a canonical format for representing features
>> +    in the ID registers; this is well defined and is capable of
>> +    representing all valid architecture variations. Exposing the ID
>> +    registers avoids having to come up with HWCAP representations and
>> +    parsing code.
>
> For point (c) above, we don't (yet?) have an actual case on AArch64
> where HWCAP needs more than a boolean value.
>
> And just to clarify my position: I consider that we should continue to
> expose HWCAP for new features (e.g. SVE) in parallel with the CPUID
> access emulation. There are different use-cases for them (i.e. dynamic
> loader uses HWCAP for the ifunc resolver).

Ok. So would you like to have the point (c) removed ? Or should I just add,
that we don't have such a feature yet.

>
>> +3. Implementation
>> +--------------------
>> +
>> +The infrastructure is built on the emulation of the 'MRS' instruction.
>> +Accessing a restricted system register from an application generates an
>> +exception and ends up in SIGILL being delivered to the process.
>> +The infrastructure hooks into the exception handler and emulates the
>> +operation if the source belongs to the supported system register space.
>> +
>> +The infrastructure emulates only the following system register space:
>> +	Op0=3, Op1=0, CRn=0
>> +
>> +(See Table C5-6 'System instruction encodings for non-Debug System
>> +register accesses' in ARMv8 ARM DDI 0487A.h, for the list of
>> +registers).
>> +
>> +
>> +The following rules are applied to the value returned by the
>> +infrastructure:
>> +
>> + a) The value of an 'IMPLEMENTATION DEFINED' field is set to 0.
>> + b) The value of a reserved field is populated with the reserved
>> +    value as defined by the architecture.
>> + c) The value of a field marked as not 'visible', is set to indicate
>> +    the feature is missing (as defined by the architecture).
>
> I don't understand point (c) above. If it is marked as not 'visible', it
> is always reported to user as 0. The above could be misinterpreted as
> reporting missing architecture features.
>

Part of the reason is that, 0 may be unsafe or undefined by architecture for some fields.
e.g, ID_AA64PFR0_EL1: EL1/EL0 : 0 is undefined. We choose 0x1, which indicates
EL1/EL0 both only have AArch64.

So, we always fall back to the safe value for that particular feature,
which happens to be 0 for most, but not all.


> [...]
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 94c188f..fb331de 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -81,6 +81,10 @@ static bool __maybe_unused
>>  cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused);
>>
>>
>> +/*
>> + * NOTE: Any changes to the visibility of features should be kept in
>> + * sync with the documentation of the CPU feature register API.
>
> s/API/ABI/
>

Sure, will make changes everywhere.

Thanks
Suzuki
