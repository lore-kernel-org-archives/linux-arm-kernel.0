From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 11 Apr 2013 00:07:33 +0200
Subject: [PATCH 05/18] cpuidle: make a single register function for all
In-Reply-To: <20130410181817.GM13524@lunn.ch>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
 <20130410165509.GK13524@lunn.ch> <5165A9A6.70905@linaro.org>
 <20130410181817.GM13524@lunn.ch>
Message-ID: <5165E2A5.4040401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2013 08:18 PM, Andrew Lunn wrote:
> On Wed, Apr 10, 2013 at 08:04:22PM +0200, Daniel Lezcano wrote:
>> On 04/10/2013 06:55 PM, Andrew Lunn wrote:
>>>> +/**
>>>> + * cpuidle_register: registers the driver and the cpu devices with the
>>>> + * coupled_cpus passed as parameter. This function is used for all common
>>>> + * initialization pattern there are in the arch specific drivers. The
>>>> + * devices is globally defined in this file.
>>>> + *
>>>> + * @drv         : a valid pointer to a struct cpuidle_driver
>>>> + * @coupled_cpus: a cpumask for the coupled states
>>>> + *
>>>> + * Returns 0 on success, < 0 otherwise
>>>> + */
>>>> +int cpuidle_register(struct cpuidle_driver *drv,
>>>> +		     const struct cpumask *const coupled_cpus)
>>>> +{
>>>> +	int ret, cpu;
>>>> +	struct cpuidle_device *device;
>>>> +
>>>> +	ret = cpuidle_register_driver(drv);
>>>> +	if (ret) {
>>>> +		printk(KERN_ERR "failed to register cpuidle driver\n");
>>>
>>> pr_err()
>>
>> Ok.
>>
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	for_each_possible_cpu(cpu) {
>>>> +		device = &per_cpu(cpuidle_dev, cpu);
>>>> +		device->cpu = cpu;
>>>> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>>>> +		device->coupled_cpus = *coupled_cpus;
>>>> +#endif
>>>> +		ret = cpuidle_register_device(device);
>>>> +		if (!ret)
>>>> +			continue;
>>>> +
>>>> +		printk(KERN_ERR "Failed to register cpuidle "
>>>> +		       "device for cpu%d\n", cpu);
>>>
>>> pr_err() and don't split the message over two lines, it makes it
>>> harder for somebody to find with
>>>
>>> grep -r "Failed to register cpuidle device for cpu" *
>>
>> Ok if the line length is under 80 chars.
> 
> Take a closer look at the CodingStyle documents. This is one except to
> the rule. Such lines can be longer than 80 characters.

Oh, right !

"However, never break user-visible strings such as printk messages,
because that breaks the ability to grep for them."

Will fix it, thanks.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
