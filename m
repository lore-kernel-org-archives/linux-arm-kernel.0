From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 19 Jul 2013 12:52:34 +0200
Subject: [PATCH] ARM: tegra: cpuidle: use CPUIDLE_FLAG_TIMER_STOP flag
In-Reply-To: <1374218064.24607.1.camel@jlo-ubuntu-64.nvidia.com>
References: <1372152228-16199-1-git-send-email-josephl@nvidia.com>
 <51E439BC.9030608@wwwdotorg.org>
 <1373973447.8538.80.camel@jlo-ubuntu-64.nvidia.com>
 <51E5A438.10004@wwwdotorg.org>
 <1374056130.10997.16.camel@jlo-ubuntu-64.nvidia.com>
 <51E6FF0B.5000708@wwwdotorg.org>
 <1374145726.5610.73.camel@jlo-ubuntu-64.nvidia.com>
 <51E7E27B.9090605@linaro.org>
 <1374218064.24607.1.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51E91A72.6070708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2013 09:14 AM, Joseph Lo wrote:
> On Thu, 2013-07-18 at 20:41 +0800, Daniel Lezcano wrote:
>> On 07/18/2013 01:08 PM, Joseph Lo wrote:
>>> On Thu, 2013-07-18 at 04:31 +0800, Stephen Warren wrote:
>>>> On 07/17/2013 04:15 AM, Joseph Lo wrote:
>>>>> On Wed, 2013-07-17 at 03:51 +0800, Stephen Warren wrote:
>>>>>> On 07/16/2013 05:17 AM, Joseph Lo wrote:
>>>>>>> On Tue, 2013-07-16 at 02:04 +0800, Stephen Warren wrote:
>>>>>>>> On 06/25/2013 03:23 AM, Joseph Lo wrote:
>>>>>>>>> Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
>>>>>>>>> to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
>>>>>>>>> this state.
>>>> ... [ discussion of issues with Joesph's patches applied]
>>>>>
>>>>> OK. I did more stress tests last night and today. I found it cause by
>>>>> the patch "ARM: tegra: cpuidle: use CPUIDLE_FLAG_TIMER_STOP flag" and
>>>>> only impact the Tegra20 platform. The hot plug regression seems due to
>>>>> this patch. After dropping this patch on top of v3.11-rc1, the Tegra20
>>>>> can back to normal.
>>>>>
>>>>> And the hop plug and suspend stress test can pass on Tegra30/114 too.
>>>>>
>>>>> Can the other two patch series for Tegra114 to support CPU idle power
>>>>> down mode and system suspend still moving forward, not be blocked by
>>>>> this patch?
>>>>>
>>>>> Looks the CPUIDLE_FLAG_TIMER_STOP flag still cause some other issue for
>>>>> hot plug on Tegra20, I will continue to check this. You can just drop
>>>>> this patch.
>>>>
>>>> OK, if I drop that patch, then everything on Tegra20 and Tegra30 seems
>>>> fine again.
>>>>
>>>> However, I've found some new and exciting issue on Tegra114!
>>>>
>>>> With unmodified v3.11-rc1, I can do the following without issue:
>>>>
>>>> * Unplug/replug CPUs, so that I had all combinations of CPU 1, 2, 3
>>>> plugged/unpplugged (with CPU 0 always plugged).
>>>>
>>>> * Unplug/replug CPUs, so that I had all combinations of CPU 0, 1, 2, 3
>>>> plugged/unpplugged (with the obvious exception of never having all CPUs
>>>> unplugged).
>>>>
>>>> However, if I try this with your Tegra114 cpuidle and suspend patches
>>>> applied, I see the following issues:
>>>>
>>>> 1) If I boot, unplug CPU 0, then replug CPU 0, the system immediately
>>>> hard-hangs.
>>>>
>>> Sorry, I didn't apply the hotplug stress test on CPU0 too much. Because
>>> all of our use cases and stress tests are focused on secondary CPUs
>>> only.
>>>
>>> After doing some tests, here is my summary. This issue happens after we
>>> support CPU idle power-down mode and relates to PMC or flow controller I
>>> believe.
>>>
>>> i) on top of v3.11-rc1 (only support WFI in CPU idle)
>>> When hot unplug CPU0, the PMC can power gate and put it into reset
>>> state. This is what I expect and also true on all the other secondary
>>> CPUs. The flow controller can maintain the CPU power state machine as
>>> what we want.
>>>
>>> ii) on top of v3.11-rc1 + CPU idle power down mode support
>>> a) I saw most of the time the CPU0,1,2,3 were in power down and reset
>>> status. That means the idle power down mode works fine.
>>>
>>> b) Testing with the CPU hotplug stress test with the secondary CPUs (not
>>> include CPU0), the result is good too.
>>>
>>> c) Testing hot plug on CPU0 with CPUIDLE_FLAG_TIMER_STOP apply or not
>>> apply (Note 1), the result shows not good to me. The CPU0 have already
>>> gone into WFI and the flow controller is set as WAITFOREVENT mode. But
>>> the PMC always can't power gate CPU0 and sometimes can put it into
>>> reset, but sometimes can't. That's why you can see it hanging after
>>> unplug CPU0 sometimes.
>>
>> Are sure coupled idle state support hotplug and especially the cpu0
>> hotplug ?
> 
> Tegra114 didn't use coupled idle framework.

Ok, so the problem occurs with the CPUIDLE_FLAG_TIMER_STOP flag only on
tegra114, right ?

Sorry, I am a bit lost :)


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
