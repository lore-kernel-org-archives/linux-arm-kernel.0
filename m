From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 19 Mar 2015 18:11:21 +0100
Subject: [PATCH V2 7/8] ARM: cpuidle: Register per cpuidle device
In-Reply-To: <20150319154247.GB589@linaro.org>
References: <1426704372-20406-1-git-send-email-daniel.lezcano@linaro.org>
 <1426704372-20406-8-git-send-email-daniel.lezcano@linaro.org>
 <20150319153112.GA589@linaro.org> <550AEC3C.5090200@linaro.org>
 <20150319154247.GB589@linaro.org>
Message-ID: <550B0339.6010609@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2015 04:42 PM, Lina Iyer wrote:
> On Thu, Mar 19 2015 at 09:33 -0600, Daniel Lezcano wrote:
>> On 03/19/2015 04:31 PM, Lina Iyer wrote:
>>> On Wed, Mar 18 2015 at 12:46 -0600, Daniel Lezcano wrote:
>>>> Some architectures have some cpus which does not support idle states.
>>>>
>>>> Let the underlying low level code to return -ENOSYS when it is not
>>>> possible to set an idle state.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>> drivers/cpuidle/cpuidle-arm.c | 45
>>>> +++++++++++++++++++++++++++++++++++++++++--
>>>> 1 file changed, 43 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/cpuidle/cpuidle-arm.c
>>>> b/drivers/cpuidle/cpuidle-arm.c
>>>> index 1c94b88..0682ed0 100644
>>>> --- a/drivers/cpuidle/cpuidle-arm.c
>>>> +++ b/drivers/cpuidle/cpuidle-arm.c
>>>> @@ -17,11 +17,14 @@
>>>> #include <linux/kernel.h>
>>>> #include <linux/module.h>
>>>> #include <linux/of.h>
>>>> +#include <linux/slab.h>
>>>>
>>>> #include <asm/cpuidle.h>
>>>>
>>>> #include "dt_idle_states.h"
>>>>
>>>> +static DEFINE_PER_CPU(struct cpuidle_device, *cpuidle_arm_dev);
>>>
>>> Is a per-cpu variable needed? There seems to be no per-cpu access, other
>>> than at init.
>>
>> :)
>>
>> Actually it is the cpuidle framework which is using the per cpu variable.
>>
>
> But this is static pointer, I can see that struct cpuidle_device * being
> used by cpuidle framework.
>
> It gets stored here?
>
> DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
>
> But we dont need to save it here, for in this file, there is no per-cpu
> access, other than when the registration fails.

Indeed, that is true. There is no need of these cpuidle variables. 
Furthermore, we can access the cpuidle_devices directly as they are 
exported in cpuidle.h.

I will fix it.

Thanks
   -- Daniel

>>>> +
>>>> /*
>>>> * arm_enter_idle_state - Programs CPU to enter the specified state
>>>> *
>>>> @@ -94,6 +97,7 @@ static int __init arm_idle_init(void)
>>>> {
>>>>    int cpu, ret;
>>>>    struct cpuidle_driver *drv = &arm_idle_driver;
>>>> +    struct cpuidle_device *dev;
>>>>
>>>>    /*
>>>>     * Initialize idle states data, starting at index 1.
>>>> @@ -105,18 +109,55 @@ static int __init arm_idle_init(void)
>>>>    if (ret <= 0)
>>>>        return ret ? : -ENODEV;
>>>>
>>>> +    ret = cpuidle_register_driver(drv);
>>>> +    if (ret) {
>>>> +        pr_err("Failed to register cpuidle driver\n");
>>>> +        return ret;
>>>> +    }
>>>> +
>>>>    /*
>>>>     * Call arch CPU operations in order to initialize
>>>>     * idle states suspend back-end specific data
>>>>     */
>>>>    for_each_possible_cpu(cpu) {
>>>>        ret = arm_cpuidle_init(cpu);
>>>> +
>>>> +        /* This cpu does not support any idle states */
>>>> +        if (ret == -ENOSYS)
>>>> +            continue;
>>>> +
>>>>        if (ret) {
>>>>            pr_err("CPU %d failed to init idle CPU ops\n", cpu);
>>>> -            return ret;
>>>> +            goto out_fail;
>>>> +        }
>>>> +
>>>> +        dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>>>> +        if (!dev) {
>>>> +            pr_err("Failed to allocate cpuidle device\n");
>>>> +            goto out_fail;
>>>> +        }
>>>> +
>>>> +        dev->cpu = cpu;
>>>> +        per_cpu(cpuidle_arm_dev, cpu) = dev;
>>>> +
>>>> +        ret = cpuidle_register_device(dev);
>>>> +        if (ret) {
>>>> +            pr_err("Failed to register cpuidle device for CPU %d\n",
>>>> +                   cpu);
>>>> +            kfree(dev);
>>>> +            goto out_fail;
>>>>        }
>>>>    }
>>>> +out:
>>>> +    return ret;
>>>>
>>>> -    return cpuidle_register(drv, NULL);
>>>> +out_fail:
>>>> +    for (cpu--; cpu <= 0; cpu--) {
>>>> +        dev = per_cpu(cpuidle_arm_dev, cpu);
>>>> +        cpuidle_unregister_device(dev);
>>>> +        kfree(dev);
>>>> +    }
>>>> +    cpuidle_unregister_driver(drv);
>>>> +    goto out;
>>>> }
>>>> device_initcall(arm_idle_init);
>>>> --
>>>> 1.9.1
>>>>
>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
