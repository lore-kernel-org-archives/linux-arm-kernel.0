From: pprakash@codeaurora.org (Prakash, Prashanth)
Date: Tue, 14 Nov 2017 09:15:44 -0700
Subject: [PATCH v2 2/2] ARM64 / cpuidle: Use new cpuidle macro for
 entering retention state
In-Reply-To: <0b4b13d3-2415-33df-f02b-1c94df4331ea@arm.com>
References: <1510187922-8218-1-git-send-email-pprakash@codeaurora.org>
 <1510187922-8218-3-git-send-email-pprakash@codeaurora.org>
 <0b4b13d3-2415-33df-f02b-1c94df4331ea@arm.com>
Message-ID: <73f03603-5878-9f78-55b1-ad8d1267b302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/13/2017 5:33 AM, Sudeep Holla wrote:
>
> On 09/11/17 00:38, Prashanth Prakash wrote:
>> CPU_PM_CPU_IDLE_ENTER_RETENTION skips calling cpu_pm_enter() and
>> cpu_pm_exit(). By not calling cpu_pm functions in idle entry/exit
>> paths we can reduce the latency involved in entering and exiting
>> the low power idle state.
>>
>> On ARM64 based Qualcomm server platform we measured below overhead
>> for calling cpu_pm_enter and cpu_pm_exit for retention states.
>>
>> workload: stress --hdd #CPUs --hdd-bytes 32M  -t 30
>> 	Average overhead of cpu_pm_enter - 1.2us
>> 	Average overhead of cpu_pm_exit  - 3.1us
>>
>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>> ---
>>  arch/arm64/kernel/cpuidle.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
>> index fd69108..f2d1381 100644
>> --- a/arch/arm64/kernel/cpuidle.c
>> +++ b/arch/arm64/kernel/cpuidle.c
>> @@ -47,6 +47,8 @@ int arm_cpuidle_suspend(int index)
>>  
>>  #include <acpi/processor.h>
>>  
>> +#define ARM64_LPI_IS_RETENTION_STATE(arch_flags) (!(arch_flags))
>> +
> This is fine, but just to be safer, is it better to check for all
> flags to be set as we can't/don't support any partial retention modes.
I am not sure I completely understand.

If any bit is set in arch_flags, then we lose the context corresponding to that bit, so
a full retention state will have no bit set, so that's what we are checking for.
Or am i missing something?

Thanks,
Prashanth
