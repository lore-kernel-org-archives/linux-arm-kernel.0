From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 22 Apr 2013 08:57:17 +0200
Subject: [PATCH 05/18] cpuidle: make a single register function for all
In-Reply-To: <51657E61.9010701@gmail.com>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
 <51657E61.9010701@gmail.com>
Message-ID: <5174DF4D.5020701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2013 04:59 PM, Rob Herring wrote:
> On 04/10/2013 09:22 AM, Daniel Lezcano wrote:
>> The usual scheme to initialize a cpuidle driver on a SMP is:
>>
>> 	cpuidle_register_driver(drv);
>> 	for_each_possible_cpu(cpu) {
>> 		device = &per_cpu(cpuidle_dev, cpu);
>> 		cpuidle_register_device(device);
>> 	}
>>
>> This code is duplicated in each cpuidle driver.
>>
>> On UP systems, it is done this way:
>>
>> 	cpuidle_register_driver(drv);
>> 	device = &per_cpu(cpuidle_dev, cpu);
>> 	cpuidle_register_device(device);
>>
>> On UP, the macro 'for_each_cpu' does one iteration:
>>
>> #define for_each_cpu(cpu, mask)                 \
>>         for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
>>
>> Hence, the initialization loop is the same for UP than SMP.
>>
>> Beside, we saw different bugs / mis-initialization / return code unchecked in
>> the different drivers, the code is duplicated including bugs. After fixing all
>> these ones, it appears the initialization pattern is the same for everyone.
>>
>> Let's add a wrapper function doing this initialization with a cpumask parameter
>> for the coupled idle states and use it for all the drivers.
>>
>> That will save a lot of LOC, consolidate the code, and the modifications in the
>> future could be done in a single place. Another benefit is the consolidation of
>> the cpuidle_device variable which is now in the cpuidle framework and no longer
>> spread accross the different arch specific drivers.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
> Perhaps my ack was too quick...

Hi Rob,

now that I have fixed the routine in V3, shall I consider the patch is
acked ?

Thanks
-- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
