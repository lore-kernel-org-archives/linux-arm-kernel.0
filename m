From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 30 Jan 2018 15:06:56 +0000
Subject: [PATCH 05/16] arm64: Add flags to check the safety of a
 capability for late CPU
In-Reply-To: <20180130145636.GE5862@e103592.cambridge.arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-6-suzuki.poulose@arm.com>
 <20180126101020.GM5862@e103592.cambridge.arm.com>
 <6313a0f1-ed3c-b5b3-7bbd-5f98862a74c6@arm.com>
 <20180130145636.GE5862@e103592.cambridge.arm.com>
Message-ID: <50b0c175-0474-e3d7-cdd3-ed2349b4426a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/18 14:56, Dave Martin wrote:
> On Tue, Jan 30, 2018 at 11:17:38AM +0000, Suzuki K Poulose wrote:
>> On 26/01/18 10:10, Dave Martin wrote:
>>> On Tue, Jan 23, 2018 at 12:27:58PM +0000, Suzuki K Poulose wrote:
>>>> Add two different flags to indicate if the conflict of a capability
>>>> on a late CPU with the current system state
>>>>
>>>>   1) Can a CPU have a capability when the system doesn't have it ?
>>>>
>>>>      Most arm64 features could have this set. While erratum work arounds
>>>>      cannot have this, as we may miss work arounds.
>>>>
>>>>   2) Can a CPU miss a capability when the system has it ?
>>>>      This could be set for arm64 erratum work arounds as we don't
>>>>      care if a CPU doesn't need the work around. However it should
>>>>      be clear for features.
>>>>
>>>> These flags could be added to certain entries based on their nature.
>>>>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> ---
>>>>   arch/arm64/include/asm/cpufeature.h | 35 +++++++++++++++++++++++++++++++----
>>>>   1 file changed, 31 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>>>> index 4fd5de8ef33e..27d037bb0451 100644
>>>> --- a/arch/arm64/include/asm/cpufeature.h
>>>> +++ b/arch/arm64/include/asm/cpufeature.h
>>>> @@ -94,10 +94,25 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>>>   #define SCOPE_SYSTEM				ARM64_CPUCAP_SCOPE_SYSTEM
>>>>   #define SCOPE_LOCAL_CPU				ARM64_CPUCAP_SCOPE_LOCAL_CPU
>>>> -/* CPU errata detected at boot time based on feature of one or more CPUs */
>>>> -#define ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM	(ARM64_CPUCAP_SCOPE_LOCAL_CPU)
>>>> -/* CPU feature detected at boot time based on system-wide value of a feature */
>>>> -#define ARM64_CPUCAP_BOOT_SYSTEM_FEATURE	(ARM64_CPUCAP_SCOPE_SYSTEM)
>>>> +/* Is it safe for a late CPU to have this capability when system doesn't already have */
>>>> +#define ARM64_CPUCAP_LATE_CPU_SAFE_TO_HAVE	BIT(2)
>>>> +/* Is it safe for a late CPU to miss this capability when system has it */
>>>> +#define ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS	BIT(3)
>>>
>>> Maybe _OPTIONAL and _PERMITTED would be a bit less verbose?
>>>
>>> Alternatively,
>>> 	ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU
>>> 	ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU
>>
>> Sounds better than what I have. I have picked them up.
> 
> Cool, I had resigned myself to probably not winning that one ;)

Well, you have won almost all in this series :-)

Cheers
Suzuki
