From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 13 Jun 2013 11:30:57 +0200
Subject: [PATCH V2 3/3] ARM: tegra114: cpuidle: add powered-down state
In-Reply-To: <1371089619.1681.21.camel@jlo-ubuntu-64.nvidia.com>
References: <1370342880-422-1-git-send-email-josephl@nvidia.com>
 <1370342880-422-4-git-send-email-josephl@nvidia.com>
 <51AE5EE3.3010607@linaro.org> <51B8B2C8.1090006@wwwdotorg.org>
 <1371089619.1681.21.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51B99151.5010107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2013 04:13 AM, Joseph Lo wrote:
> On Thu, 2013-06-13 at 01:41 +0800, Stephen Warren wrote:
>> On 06/04/2013 03:40 PM, Daniel Lezcano wrote:
>>> On 06/04/2013 12:48 PM, Joseph Lo wrote:
>>>> This supports CPU core power down on each CPU when CPU idle. When CPU go
>>>> into this state, it saves it's context and needs a proper configuration
>>>> in flow controller to power gate the CPU when CPU runs into WFI
>>>> instruction. And the CPU also needs to set the IRQ as CPU power down idle
>>>> wake up event in flow controller.
>>>>
>>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>>
>>> I would like to understand why there is a WARN with the
>>> CPUIDLE_FLAG_TIMER_STOP flag set before queuing this patch and ensure it
>>> is not the tree hiding the forest.
>>
>> Joseph, are you planning to post an updated series or respond to resolve
>> Daniel's question?
> 
> I need more time to investigate the detail about what caused the WARN
> when apply the flag. And what's the difference if we didn't enable
> CONFIG_CPU_IDLE_MULTIPLE_DRIVERS, then it only applies
> CLOCK_EVT_NOTIFY_BROADCAST_ON on CPU0.

I think I got it for this one. It is a bug in the cpuidle driver's code.

cpuidle_register_driver does get_cpu => CPU0

Then __cpuidle_register_driver(drv, <CPU0>)

 => __cpuidle_driver_init(drv, <CPU0>)

Hence, the timer broadcast is initialized only for cpu0.

That should have been fixed with:

commit 82467a5a885ddd9f80309682159da8db510e7832
Author: Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Fri Jun 7 21:53:09 2013 +0000

    cpuidle: simplify multiple driver support

    Commit bf4d1b5 (cpuidle: support multiple drivers) introduced support
    for using multiple cpuidle drivers at the same time.  It added a
    couple of new APIs to register the driver per CPU, but that led to
    some unnecessary code complexity related to the kernel config options
    deciding whether or not the multiple driver support is enabled.  The
    code has to work as it did before when the multiple driver support is
    not enabled and the multiple driver support has to be compatible with
    the previously existing API.

    Remove the new API, not used by any driver in the tree yet (but
    needed for the HMP cpuidle drivers that will be submitted soon), and
    add a new cpumask pointer to the cpuidle driver structure that will
    point to the mask of CPUs handled by the given driver.  That will
    allow the cpuidle_[un]register_driver() API to be used for the
    multiple driver support along with the cpuidle_[un]register()
    functions added recently.

    [rjw: Changelog]
    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> Why if I am moving the
> clockevent_notify of CLOCK_EVT_NOTIFY_BROADCAST_EXIT before
> "local_irq_enable" in the
> "cpuidle_enter_state" (drivers/cpuidle/cpuidle.c), then the warning
> message gone?

Is the warning coming immediately, at the first time
CLOCK_EVT_NOTIFY_BROADCAST_EXIT is invoked or can it occur at different
moment ?

> Daniel,
> 
> Because I need more time to figure it out, are you OK if I can post
> another patch to apply CPUIDLE_FLAG_TIMER_STOP flag for all Tegra CPU
> Idle drivers later? (Once we know what's the problem behind this)
> 
> Stephen,
> 
> I don't have an update of this series, if Daniel is OK if I can post
> another patch to apply TIMER_STOP flag for all Tegra idle drivers.
> 
> Thanks,
> Joseph
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
