From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 23 Apr 2013 15:43:45 +0200
Subject: [V3 patch 06/19] cpuidle: make a single register function for all
In-Reply-To: <516FB35D.7000303@ti.com>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-7-git-send-email-daniel.lezcano@linaro.org>
 <516FB35D.7000303@ti.com>
Message-ID: <51769011.7030608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2013 10:48 AM, Santosh Shilimkar wrote:
> On Friday 12 April 2013 06:05 PM, Daniel Lezcano wrote:
>> The usual scheme to initialize a cpuidle driver on a SMP is:
>>
>> 	cpuidle_register_driver(drv);
>> 	for_each_possible_cpu(cpu) {
>> 		device = &per_cpu(cpuidle_dev, cpu);
>> 		cpuidle_register_device(device);
>> 	}
>>
> Not exactly related to $subject patch but the driver should
> be registered after all devices has been registered to avoid
> devices start using the idle state data as soon as it is
> registered. In multi CPU system, this race can easily happen.

Could you elaborate what problems the system will be facing if a cpu
starts using the idle state data as soon as it is registered ?

Is there a bug related to this ?

> Current CPUIDLE core layer is also written with the assumption
> that driver will be registered first and then the devices which
> is not mandatory as per typical drive/device model.

Yes, that's true. The framework assumes cpuidle_register_driver is
called before cpuidle_register_device.

> May be you can fix that part while you are creating this common
> wrapper.

Personally, as that will modify the cpuidle core layer and the changes
are not obvious (because of the design of the code) I prefer to do that
in a separate patchset if it is worth to do it - if there is a bug
related to it, then there is no discussion, we have to do it :)

[ ... ]

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
