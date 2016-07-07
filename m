From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 7 Jul 2016 16:48:10 +0100
Subject: [PATCH v7 4/6] cpuidle: introduce HAVE_GENERIC_CPUIDLE_ENTER for
 ARM{32,64} platforms
In-Reply-To: <3343646.556h6ef0ix@vostro.rjw.lan>
References: <1467122152-5604-1-git-send-email-sudeep.holla@arm.com>
 <1675585.udvKUofiJK@vostro.rjw.lan> <577E5A6C.9020007@arm.com>
 <3343646.556h6ef0ix@vostro.rjw.lan>
Message-ID: <577E79BA.6000706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/07/16 15:49, Rafael J. Wysocki wrote:
> On Thursday, July 07, 2016 02:34:36 PM Sudeep Holla wrote:
>>
>> On 07/07/16 14:21, Rafael J. Wysocki wrote:
>>> On Tuesday, June 28, 2016 02:55:50 PM Sudeep Holla wrote:
>>>> The function arm_enter_idle_state is exactly the same in both generic
>>>> ARM{32,64} CPUIdle driver and will be the same even on ARM64 backend
>>>> for ACPI processor idle driver. So we can unify it and move it as
>>>> generic_cpuidle_enter by introducing HAVE_GENERIC_CPUIDLE_ENTER and
>>>> enabling the same on both ARM{32,64}.
>>>>
>>>> This is in preparation of reuse of the generic cpuidle entry function
>>>> for ACPI LPI support on ARM64.
>>>>
>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>> ---
>>>>    arch/arm/Kconfig              |  1 +
>>>>    arch/arm/kernel/cpuidle.c     |  4 ++--
>>>>    arch/arm64/Kconfig            |  1 +
>>>>    arch/arm64/kernel/cpuidle.c   |  6 +++---
>>>>    drivers/cpuidle/Kconfig       |  3 +++
>>>>    drivers/cpuidle/cpuidle-arm.c | 21 +--------------------
>>>>    drivers/cpuidle/cpuidle.c     | 35 +++++++++++++++++++++++++++++++++++
>>>>    include/linux/cpuidle.h       |  8 ++++++++
>>>>    8 files changed, 54 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>> index 90542db1220d..52b3dca0381c 100644
>>>> --- a/arch/arm/Kconfig
>>>> +++ b/arch/arm/Kconfig
>>>> @@ -54,6 +54,7 @@ config ARM
>>>>    	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
>>>>    	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
>>>>    	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
>>>> +	select HAVE_GENERIC_CPUIDLE_ENTER
>>>
>>> That "generic" part in the name concerns me a bit, because the thing is not
>>> really generic.  It is "common on ARM" rather.
>>>
>>
>> I agree and that's exactly what I told Daniel. It's rather just
>> *ARM Generic*. Any preference on the name ? I had it header file under
>> include/linu/cpuidle-arm.h in the previous version. Do you prefer that ?
>
> Well, I got confused by these names which probably means that they really
> are confusing. :-)
>

I know and I am all for getting rid of that.

> So the underlying observation is that ->enter() callbacks in some ARM code
> tend to do the same thing, ie. wrap the cpu_pm_enter()/exit() pair around
> the actual "low-level enter" routine, so the idea is to move the wrapping
> to the core and add the symbol plus standard header for the "low-level enter"
> thing.
>
> But then ->enter has to point to the wrapper and that just invokes a static
> function defined somewhere.
>
> So in fact what you want is to avoid code duplication in the source, but not
> in the binary.
>
> For that, I'd use a macro like this:
>
> #define CPU_IDLE_ENTER_WRAPPED(low_level_idle_enter, idx)	\
> ({								\
> 	int __ret;						\
> 								\
> 	if (!idx) {						\
> 		cpu_do_idle();					\
> 		return idx;					\
> 	}							\
> 								\
> 	__ret = cpu_pm_enter();					\
> 	if (!__ret) {						\
> 		__ret = low_level_idle_enter(idx);		\
> 		cpu_pm_exit();					\
> 	}							\
> 								\
> 	__ret ? -1 : idx;					\
> })
>
> and then, whoever want's to generate a "wrapped" callback, will need to
> define the low_level_idle_enter thing, say my_low_level_idle_enter() and
> then do
>
> int idle_enter(int idx)
> {
> 	return CPU_IDLE_ENTER_WRAPPED(my_low_level_idle_enter, idx);
> }
>
> and point the ->enter callback to idle_enter().
>
> No need for extra symbols, confusing function names and similar.
>
> And the macro can go into cpuidle.h if you want.
>

Sounds good. Thanks for the suggestion. I will respin the series with
this change then.

-- 
Regards,
Sudeep
