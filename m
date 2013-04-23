From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 23 Apr 2013 18:02:23 +0530
Subject: [V4 patch 03/15] cpuidle: make a single register function for all
In-Reply-To: <1366707285-12179-4-git-send-email-daniel.lezcano@linaro.org>
References: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
 <1366707285-12179-4-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <51767F57.7060809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 April 2013 02:24 PM, Daniel Lezcano wrote:
> The usual scheme to initialize a cpuidle driver on a SMP is:
> 
> 	cpuidle_register_driver(drv);
> 	for_each_possible_cpu(cpu) {
> 		device = &per_cpu(cpuidle_dev, cpu);
> 		cpuidle_register_device(device);
> 	}
> 
> This code is duplicated in each cpuidle driver.
> 
> On UP systems, it is done this way:
> 
> 	cpuidle_register_driver(drv);
> 	device = &per_cpu(cpuidle_dev, cpu);
> 	cpuidle_register_device(device);
> 
> On UP, the macro 'for_each_cpu' does one iteration:
> 
> #define for_each_cpu(cpu, mask)                 \
>         for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
> 
> Hence, the initialization loop is the same for UP than SMP.
> 
> Beside, we saw different bugs / mis-initialization / return code unchecked in
> the different drivers, the code is duplicated including bugs. After fixing all
> these ones, it appears the initialization pattern is the same for everyone.
> 
> Please note, some drivers are doing dev->state_count = drv->state_count. This is
> not necessary because it is done by the cpuidle_enable_device function in the
> cpuidle framework. This is true, until you have the same states for all your
> devices. Otherwise, the 'low level' API should be used instead with the specific
> initialization for the driver.
> 
> Let's add a wrapper function doing this initialization with a cpumask parameter
> for the coupled idle states and use it for all the drivers.
> 
> That will save a lot of LOC, consolidate the code, and the modifications in the
> future could be done in a single place. Another benefit is the consolidation of
> the cpuidle_device variable which is now in the cpuidle framework and no longer
> spread accross the different arch specific drivers.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

I don't see you have addressed the comment on V3 [1] i gave for the subject patch
Any reason ?

Regards,
Santosh

[1] https://patchwork.kernel.org/patch/2435281/
