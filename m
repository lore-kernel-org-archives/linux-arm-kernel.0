From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 17 Jan 2018 14:04:38 +0000
Subject: [PATCH] arm64: Run enable method for errata work arounds on late
 CPUs
In-Reply-To: <bfef2d82-c43b-2254-9e29-cf4c22e4581c@arm.com>
References: <20180117100556.29270-1-suzuki.poulose@arm.com>
 <20180117122548.GE22781@e103592.cambridge.arm.com>
 <29147833-b47f-3ad9-e2d8-295551c43900@arm.com>
 <bbc19683-340a-cc81-ded9-966d232248db@arm.com>
 <bfef2d82-c43b-2254-9e29-cf4c22e4581c@arm.com>
Message-ID: <5d51dd4a-d985-22e5-6583-bcc4bfdf8e6f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/01/18 13:43, Robin Murphy wrote:
> On 17/01/18 13:31, Suzuki K Poulose wrote:
>> On 17/01/18 13:20, Robin Murphy wrote:
>>> On 17/01/18 12:25, Dave Martin wrote:
>>>> On Wed, Jan 17, 2018 at 10:05:56AM +0000, Suzuki K Poulose wrote:
>>>>> When a CPU is brought up after we have finalised the system
>>>>> wide capabilities (i.e, features and errata), we make sure the
>>>>> new CPU doesn't need a new errata work around which has not been
>>>>> detected already. However we don't run enable() method on the new
>>>>> CPU for the errata work arounds already detected. This could
>>>>> cause the new CPU running without potential work arounds.
>>>>> It is upto the "enable()" method to decide if this CPU should
>>>>> do something about the errata.
>>>>>
>>>>> Fixes: commit 6a6efbb45b7d95c84 ("arm64: Verify CPU errata work arounds on hotplugged CPU")
>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>> Cc: Andre Przywara <andre.przywara@arm.com>
>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Cc: Dave Martin <dave.martin@arm.com>
>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>> ---
>>>>> ? arch/arm64/kernel/cpu_errata.c | 9 ++++++---
>>>>> ? 1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>>>>> index 90a9e465339c..54e41dfe41f6 100644
>>>>> --- a/arch/arm64/kernel/cpu_errata.c
>>>>> +++ b/arch/arm64/kernel/cpu_errata.c
>>>>> @@ -373,15 +373,18 @@ void verify_local_cpu_errata_workarounds(void)
>>>>> ? {
>>>>> ????? const struct arm64_cpu_capabilities *caps = arm64_errata;
>>>>> -??? for (; caps->matches; caps++)
>>>>> -??????? if (!cpus_have_cap(caps->capability) &&
>>>>> -??????????? caps->matches(caps, SCOPE_LOCAL_CPU)) {
>>>>> +??? for (; caps->matches; caps++) {
>>>>> +??????? if (cpus_have_cap(caps->capability)) {
>>>>> +??????????? if (caps->enable)
>>>>> +??????????????? caps->enable((void *)caps);
>>>>
>>>> Do we really need this cast?
>>>
>>> Seems to me like the prototype for .enable needs updating. If any existing callback was actually using the (non-const) void* for some purpose (thankfully nothing seems to be), then passing the capability pointer into that would be unlikely to end well anyway.
>>
>> I agree. This was initially written such that we could call it via on_each_cpu().
>> But then we later switched to stop_machine(). And we weren't using the argument until
>> very recently with the introduction of multiple entries for the same capability.
>>
>> I will try to clean this up in a separate series, which would involve cleaning up
>> all the enable(), quite invasive. I would like this to go in for 4.16, as it is>> needed for things like KPTI and some of the existing caps.

Correction, s/KPTI/bp hardening/

> 
> OK, sounds good. For the sake of the immediate fix, perhaps it's cleaner to just pass NULL here if the current callbacks ignore it?

As I said above, we have some users at the moment, so we cant do that.

Suzuki
