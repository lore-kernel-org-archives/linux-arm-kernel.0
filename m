From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 19 Mar 2015 12:44:27 +0100
Subject: [PATCH V2 7/8] ARM: cpuidle: Register per cpuidle device
In-Reply-To: <20150319113824.GC4449@red-moon>
References: <1426704372-20406-1-git-send-email-daniel.lezcano@linaro.org>
 <1426704372-20406-8-git-send-email-daniel.lezcano@linaro.org>
 <20150319110806.GE24556@red-moon> <550AB298.6040907@linaro.org>
 <20150319113824.GC4449@red-moon>
Message-ID: <550AB69B.8000100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2015 12:38 PM, Lorenzo Pieralisi wrote:
> On Thu, Mar 19, 2015 at 11:27:20AM +0000, Daniel Lezcano wrote:
>
> [...]
>
>>>>    	for_each_possible_cpu(cpu) {
>>>>    		ret = arm_cpuidle_init(cpu);
>>>> +
>>>> +		/* This cpu does not support any idle states */
>>>> +		if (ret == -ENOSYS)
>>>> +			continue;
>>>> +
>>>>    		if (ret) {
>>>>    			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
>>>> -			return ret;
>>>> +			goto out_fail;
>>>> +		}
>>>> +
>>>> +		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>>>> +		if (!dev) {
>>>> +			pr_err("Failed to allocate cpuidle device\n");
>>>> +			goto out_fail;
>>>> +		}
>>>> +
>>>> +		dev->cpu = cpu;
>>>> +		per_cpu(cpuidle_arm_dev, cpu) = dev;
>>>> +
>>>> +		ret = cpuidle_register_device(dev);
>>>> +		if (ret) {
>>>> +			pr_err("Failed to register cpuidle device for CPU %d\n",
>>>> +			       cpu);
>>>> +			kfree(dev);
>>>> +			goto out_fail;
>>>>    		}
>>>>    	}
>>>> +out:
>>>> +	return ret;
>>>
>>> return 0;
>>>
>>>>
>>>> -	return cpuidle_register(drv, NULL);
>>>> +out_fail:
>>>> +	for (cpu--; cpu <= 0; cpu--) {
>>>
>>> This loop is wrong.
>>
>> Why is it wrong ? We have to initialize at cpu - 1 to unregister the
>> previous registered cpu, not the current one, no ?
>
> Yes, but on cpu>=0 not cpu<=0
>
> while (--cpu >= 0)

Ah, yes. Thanks for spotting this.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
