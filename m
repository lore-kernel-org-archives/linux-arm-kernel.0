From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 25 Jan 2012 15:52:21 +0100
Subject: [PATCH v3 1/7] cpuidle: Add common init interface and idle
 functionality
In-Reply-To: <CAMXH7KGzMfBXKCnpj2xrJrDLA9UAC4QGvg2PgGd_AG2Ax0X1sQ@mail.gmail.com>
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
 <1327379854-12403-2-git-send-email-rob.lee@linaro.org>
 <4F1F4383.60304@linaro.org>
 <CAMXH7KGzMfBXKCnpj2xrJrDLA9UAC4QGvg2PgGd_AG2Ax0X1sQ@mail.gmail.com>
Message-ID: <4F201725.5030902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2012 03:38 AM, Rob Lee wrote:
> Daniel, thanks for your review.  I think you and Mike timed sending
> your responses :)  Comments below.

[ ... ]

>>> +       for_each_possible_cpu(cpu_id) {
>>> +               dev = per_cpu_ptr(common_cpuidle_devices, cpu_id);
>>> +               cpuidle_unregister_device(dev);
>>> +       }
>>> +
>>> +       free_percpu(common_cpuidle_devices);
>>> +}
>>
>>
>> If the registering sequence aborts, won't cpuidle_unregister_device leads to
>> a kernel warning as it could be specified with a cpu which has *not* been
>> registered yet ?
>>
>
> I think you may have been looking at cpuidle_unregister_driver.  Here
> is cpuidle_unregister_device which seems to handle a device not yet
> registered ok:
>
> void cpuidle_unregister_device(struct cpuidle_device *dev)
> {
> 	struct device *cpu_dev = get_cpu_device((unsigned long)dev->cpu);
> 	struct cpuidle_driver *cpuidle_driver = cpuidle_get_driver();
>
> 	if (dev->registered == 0)
> 		return;
> ...


Ok, it is harmless. I could have looked at that ... :)

>>> +
>>> +       drv = kmalloc(sizeof(struct cpuidle_driver), GFP_KERNEL);
>>> +       if (!drv) {
>>> +               pr_err("%s: no memory for cpuidle driver\n", __func__);
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>> +       *drv = *pdrv;

[ ... ]

>> Rob can you explain why is needed to copy this structure ?
>>
>
> I made the original platform cpuidle_driver objects __initdata so I
> need to copy over to the dynamically allocated structure.

Yes, but why declare a static object to be freed and allocate a new one 
and copy it ? Why don't just use the pdrv parameter of the function ?

>> Maybe kmemdup is more adequate here.
>>
>> drv = kmemdup(pdrv, sizeof(*drv), GFP_KERNEL);
>>
>
> Is this preferred by the community over direct structure copies?  Or
> is there some other advantage?

It does kmalloc + memcpy. And *drv = *pdrv is converted to a memcpy by 
the compiler. So using kmemdup generates the same code as kmalloc + 
memcpy, or kmalloc + *drv = *pdrv

>>> +
>>> +       for (i = 0; simple&&    (i<    drv->state_count); i++) {
>>>
>>> +               do_idle[i] = drv->states[i].enter;
>>> +               drv->states[i].enter = simple_enter;
>>> +       }
>>
>>
>> Do we really need a 'simple' parameter ? Is there an idle enter function
>> which does not correspond to the 'simple' scheme except omap3/4 ?
>>
>> Maybe I am wrong but that looks a bit hacky because we are trying to
>> override the functions the driver had previously defined and in order to
>> prevent to modify the cpuidle.c core and more code.
>>
>> I am wondering if it is possible to move the usual:
>>
>> [ local_irq_disable(), getnstimeofday(before), myidle,
>> getnstimeofday(after), local_irq_enable(), dev->last_residency =
>> after-before, return index ]
>>
>> to cpuidle.c/cpuidle_idle_call and wrap the
>>         entered_state = target_state->enter(dev, drv, next_state)
>> with these simple scheme.
>>
>
> Yes, I considered the same thing and originally made a version of this
> patch with direct changes to cpuidle_idle_call.  But I concluded that
> since this common code's main purpose is just to consolidate code
> duplication on *some* (but not all) cpuidle implementations, it was
> better to create the extra simple_enter wrapper than to add additional
> code in cpuidle_idle_call that other platforms don't need.  I'd be
> happy to submit a version of this patch with cpuidle_idle_call changes
> though and let the community decide.  If anyone else thinks this is a
> good or bad idea, please give your input.

[1]

>> Also I am not sure local_irq_disable is needed because AFAICT the idle
>> function is called with the local_irq_disable. For example, the intel_idle
>> driver does not do that and assume the enter_idle function is called with
>> the local irq disabled.
>>
>> Looking at the code :
>>
>> arch/arm/kernel/process.c : pm_idle is wrapped with local_irq_disable /
>> local_irq_enable.
>>
>> arch/x86/kernel/process_32/64.c : pm_idle is called with local_irq_disable
>> but assumes the function will enable local irq
>>
>> arch/ia64/kernel/process.c : the code assumes the idle function will
>> disable/enable the local irq.
>>
>> etc ...
>>
>
> Agree.  I considered this as well but ultimately decided to leave it
> in.  I can remove it for the next patch version though.

IMHO, we should wait for what inputs we have in [1]

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
