From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 19 Mar 2015 12:27:20 +0100
Subject: [PATCH V2 7/8] ARM: cpuidle: Register per cpuidle device
In-Reply-To: <20150319110806.GE24556@red-moon>
References: <1426704372-20406-1-git-send-email-daniel.lezcano@linaro.org>
 <1426704372-20406-8-git-send-email-daniel.lezcano@linaro.org>
 <20150319110806.GE24556@red-moon>
Message-ID: <550AB298.6040907@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2015 12:08 PM, Lorenzo Pieralisi wrote:
> On Wed, Mar 18, 2015 at 06:46:11PM +0000, Daniel Lezcano wrote:
>> Some architectures have some cpus which does not support idle states.
>>
>> Let the underlying low level code to return -ENOSYS when it is not
>> possible to set an idle state.
>
> http://www.spinics.net/lists/linux-acpi/msg55550.html
>
> -ENXIO ?

Ack, it makes more sense.

>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/cpuidle/cpuidle-arm.c | 45 +++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
>> index 1c94b88..0682ed0 100644
>> --- a/drivers/cpuidle/cpuidle-arm.c
>> +++ b/drivers/cpuidle/cpuidle-arm.c
>> @@ -17,11 +17,14 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/slab.h>
>>
>>   #include <asm/cpuidle.h>
>>
>>   #include "dt_idle_states.h"
>>
>> +static DEFINE_PER_CPU(struct cpuidle_device, *cpuidle_arm_dev);
>> +
>>   /*
>>    * arm_enter_idle_state - Programs CPU to enter the specified state
>>    *
>> @@ -94,6 +97,7 @@ static int __init arm_idle_init(void)
>>   {
>>   	int cpu, ret;
>>   	struct cpuidle_driver *drv = &arm_idle_driver;
>> +	struct cpuidle_device *dev;
>>
>>   	/*
>>   	 * Initialize idle states data, starting at index 1.
>> @@ -105,18 +109,55 @@ static int __init arm_idle_init(void)
>>   	if (ret <= 0)
>>   		return ret ? : -ENODEV;
>>
>> +	ret = cpuidle_register_driver(drv);
>> +	if (ret) {
>> +		pr_err("Failed to register cpuidle driver\n");
>> +		return ret;
>> +	}
>> +
>>   	/*
>>   	 * Call arch CPU operations in order to initialize
>>   	 * idle states suspend back-end specific data
>>   	 */
>>   	for_each_possible_cpu(cpu) {
>>   		ret = arm_cpuidle_init(cpu);
>> +
>> +		/* This cpu does not support any idle states */
>> +		if (ret == -ENOSYS)
>> +			continue;
>> +
>>   		if (ret) {
>>   			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
>> -			return ret;
>> +			goto out_fail;
>> +		}
>> +
>> +		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>> +		if (!dev) {
>> +			pr_err("Failed to allocate cpuidle device\n");
>> +			goto out_fail;
>> +		}
>> +
>> +		dev->cpu = cpu;
>> +		per_cpu(cpuidle_arm_dev, cpu) = dev;
>> +
>> +		ret = cpuidle_register_device(dev);
>> +		if (ret) {
>> +			pr_err("Failed to register cpuidle device for CPU %d\n",
>> +			       cpu);
>> +			kfree(dev);
>> +			goto out_fail;
>>   		}
>>   	}
>> +out:
>> +	return ret;
>
> return 0;
>
>>
>> -	return cpuidle_register(drv, NULL);
>> +out_fail:
>> +	for (cpu--; cpu <= 0; cpu--) {
>
> This loop is wrong.

Why is it wrong ? We have to initialize at cpu - 1 to unregister the 
previous registered cpu, not the current one, no ?

>> +		dev = per_cpu(cpuidle_arm_dev, cpu);
>> +		cpuidle_unregister_device(dev);
>> +		kfree(dev);
>> +	}
>> +	cpuidle_unregister_driver(drv);
>> +	goto out;
>
> You just:
>
> return ret;
>
> little point in jumping around to just return.

Ok.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
