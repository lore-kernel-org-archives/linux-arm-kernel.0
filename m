From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 04 Jun 2013 14:40:45 +0200
Subject: [PATCH] ARM: zynq: wfi exit on same cpu is valid
In-Reply-To: <51AD9765.3000406@monstr.eu>
References: <1369997066-10585-1-git-send-email-sanjay.rawat@linaro.org>
 <51AC5060.80806@linaro.org> <51AC672A.5050501@monstr.eu>
 <51AC8F74.2060302@linaro.org> <51AD9765.3000406@monstr.eu>
Message-ID: <51ADE04D.2090901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2013 09:29 AM, Michal Simek wrote:
> On 06/03/2013 02:43 PM, Daniel Lezcano wrote:
>> On 06/03/2013 11:51 AM, Michal Simek wrote:
>>> Hi,
>>>
>>> On 06/03/2013 10:14 AM, Daniel Lezcano wrote:
>>>> On 05/31/2013 12:44 PM, Sanjay Singh Rawat wrote:
>>>>> The current code considers every wakeup as spurious, which is not
>>>>> correct. Handle the same way as other arm platforms are doing.
>>>>>
>>>>> Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
>>>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>
>>>>
>>>>> ---
>>>>>  arch/arm/mach-zynq/hotplug.c |    7 +++++++
>>>>>  1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/mach-zynq/hotplug.c b/arch/arm/mach-zynq/hotplug.c
>>>>> index c89672b..a1ab22c 100644
>>>>> --- a/arch/arm/mach-zynq/hotplug.c
>>>>> +++ b/arch/arm/mach-zynq/hotplug.c
>>>>> @@ -67,6 +67,13 @@ static inline void zynq_platform_do_lowpower(unsigned int cpu, int *spurious)
>>>>>  		dsb();
>>>>>  		wfi();
>>>>>  
>>>>> +		if (pen_release == cpu_logical_map(cpu)) {
>>>>> +			/*
>>>>> +			 * OK, proper wakeup, we're done
>>>>> +			 */
>>>>> +			break;
>>>>> +		}
>>>>> +
>>> what pen_release stands for?
>>> I have looked at it and others platform are also using it in platsmp
>>> code which is not zynq case.
>>> How is it supposed to work and how this variable should be used?
>>
>> This variable is used to serialize the secondary cpus boot process.
>>
>> When the processors boot, all the processors except the CPU0 are in WFI.
>>
>> Then it is up to CPU0 to wake up the secondary processors:
>> 1. it writes the cpu id of the secondary processor in the pen_release
>> variable
>> 2. it sends a IPI to the secondary cpu in order to make it exiting the
>> WFI mode
>> 2.1 the secondary processor boots and, when finished, writes the value
>> '-1' in the pen_release variable
>> 3. meanwhile CPU0 waits for the pen_release to be '-1' before continuing
>> to boot the other secondary processors
>>
>> In the case of the routine "zynq_platform_do_lowpower", the same
>> sequence occurs with 'cpu_up', that means you are at the beginning of
>> the boot up sequence. So the pen_release value is the cpu id value when
>> exiting from WFI (remember it sets to -1 when finished).
>>
>> If the cpu exits the lopower mode but the pen_release is not the cpu id,
>> that means there is something wrong because the cpu exited the WFI mode
>> without being in the booting process (the cpu shouldn't receive an hw
>> interrupt because they should have been migrated, but just a wake up
>> IPI). This is why there's "spurious".
>>
>> The pen_release contains the hardware id of the CPU, this is why
>> cpu_logical_map is used.
>>
>> I hope that helps
> 
> Thanks for explanation.
> I have added this patch to zynq/cleanup branch.

Actually, I noticed in the boot secondary cpu the pen_release is not
initialized at all. The patch is correct but with undefined behavior.

Normally, the secondary cpu are powered on and stays in WFI or whatever
more power efficient but the algorithm is to initialize the pen_release
with the cpu id physical id, send an IPI and wait for the pen_release to
be equal to -1.

There is a good example in mach-ux500/platform.c

And a good explanation in the "Cortex -A Series programmer's guide" page
23-10.

Regards
  -- Daniel






-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
