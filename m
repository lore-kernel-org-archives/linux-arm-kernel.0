From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 25 Jan 2012 00:49:23 +0100
Subject: [PATCH v3 1/7] cpuidle: Add common init interface and idle
 functionality
In-Reply-To: <1327379854-12403-2-git-send-email-rob.lee@linaro.org>
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
 <1327379854-12403-2-git-send-email-rob.lee@linaro.org>
Message-ID: <4F1F4383.60304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2012 05:37 AM, Robert Lee wrote:
> The patch adds some cpuidle initialization functionality commonly
> duplicated by many platforms.
>
> Signed-off-by: Robert Lee<rob.lee@linaro.org>
> ---

Hi Rob,

nice work. The result is interesting. I have a few comments below.


>   drivers/cpuidle/Makefile |    2 +-
>   drivers/cpuidle/common.c |  152 ++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/cpuidle.h  |   24 +++++++
>   3 files changed, 177 insertions(+), 1 deletions(-)
>   create mode 100644 drivers/cpuidle/common.c
>
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 5634f88..2928d93 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -2,4 +2,4 @@
>   # Makefile for cpuidle.
>   #
>
> -obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
> +obj-y += cpuidle.o driver.o governor.o sysfs.o common.o governors/
> diff --git a/drivers/cpuidle/common.c b/drivers/cpuidle/common.c
> new file mode 100644
> index 0000000..dafa758
> --- /dev/null
> +++ b/drivers/cpuidle/common.c
> @@ -0,0 +1,152 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/*
> + * This code performs provides some commonly used cpuidle setup functionality
> + * used by many ARM SoC platforms.  Providing this functionality here
> + * reduces the duplication of this code for each ARM platform that uses it.
> + */
> +
> +#include<linux/kernel.h>
> +#include<linux/io.h>
> +#include<linux/cpuidle.h>
> +#include<linux/hrtimer.h>
> +#include<linux/err.h>
> +#include<linux/slab.h>
> +#include<asm/proc-fns.h>
> +
> +static struct cpuidle_device __percpu * common_cpuidle_devices;
> +
> +static int (*do_idle[CPUIDLE_STATE_MAX])(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv, int index);
> +
> +int cpuidle_def_idle(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv, int index)
> +{
> +	cpu_do_idle();
> +	return index;
> +}
> +
> +static int simple_enter(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv, int index)
> +{
> +	ktime_t time_start, time_end;
> +
> +	local_irq_disable();
> +
> +	time_start = ktime_get();
> +
> +	index = do_idle[index](dev, drv, index);
> +
> +	time_end = ktime_get();
> +
> +	local_irq_enable();
> +
> +	dev->last_residency =
> +		(int)ktime_to_us(ktime_sub(time_end, time_start));
> +
> +	return index;
> +}
> +
> +void common_cpuidle_devices_uninit(void)
> +{
> +	int cpu_id;
> +	struct cpuidle_device *dev;
> +
> +	for_each_possible_cpu(cpu_id) {
> +		dev = per_cpu_ptr(common_cpuidle_devices, cpu_id);
> +		cpuidle_unregister_device(dev);
> +	}
> +
> +	free_percpu(common_cpuidle_devices);
> +}

If the registering sequence aborts, won't cpuidle_unregister_device 
leads to a kernel warning as it could be specified with a cpu which has 
*not* been registered yet ?

Perhaps we should pass the cpuid from where the cpu has failed an do a 
reverse unregister sequence.

void common_cpuidle_devices_uninit(int cpu)
{
         for (cpu--; cpu >= 0; cpu--) {
                 device = &per_cpu(common_cpuidle_devices, cpu);
                 cpuidle_unregister_device(device);
         }
...


> +
> +/**
> + * common_cpuidle_init() - Provides some commonly used init functionality.
> + * @pdrv		Pointer to your cpuidle_driver object.
> + * @simple		Use the common simple_enter wrapper?
> + * @driver_data_init	Pointer to your platform function to initialize your
> + *			platform specific driver data.  Use NULL if platform
> + *			specific data is not needed.
> + *
> + * Common cpuidle init interface to provide common cpuidle functionality
> + * used by many platforms.
> + */
> +int __init common_cpuidle_init(struct cpuidle_driver *pdrv, bool simple,
> +			 void (*driver_data_init)(struct cpuidle_device *dev))
> +{
> +	struct cpuidle_device *dev;
> +	struct cpuidle_driver *drv;
> +	int i, cpu_id, ret;
> +
> +	if (!pdrv || pdrv->state_count>  CPUIDLE_STATE_MAX) {
> +		pr_err("%s: Invalid Input\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	drv = kmalloc(sizeof(struct cpuidle_driver), GFP_KERNEL);
> +	if (!drv) {
> +		pr_err("%s: no memory for cpuidle driver\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	*drv = *pdrv;

Rob can you explain why is needed to copy this structure ?

Maybe kmemdup is more adequate here.

drv = kmemdup(pdrv, sizeof(*drv), GFP_KERNEL);

> +
> +	for (i = 0; simple&&  (i<  drv->state_count); i++) {
> +		do_idle[i] = drv->states[i].enter;
> +		drv->states[i].enter = simple_enter;
> +	}

Do we really need a 'simple' parameter ? Is there an idle enter function 
which does not correspond to the 'simple' scheme except omap3/4 ?

Maybe I am wrong but that looks a bit hacky because we are trying to 
override the functions the driver had previously defined and in order to 
prevent to modify the cpuidle.c core and more code.

I am wondering if it is possible to move the usual:

[ local_irq_disable(), getnstimeofday(before), myidle, 
getnstimeofday(after), local_irq_enable(), dev->last_residency = 
after-before, return index ]

to cpuidle.c/cpuidle_idle_call and wrap the
	entered_state = target_state->enter(dev, drv, next_state)
with these simple scheme.

Also I am not sure local_irq_disable is needed because AFAICT the idle 
function is called with the local_irq_disable. For example, the 
intel_idle driver does not do that and assume the enter_idle function is 
called with the local irq disabled.

Looking at the code :

arch/arm/kernel/process.c : pm_idle is wrapped with local_irq_disable / 
local_irq_enable.

arch/x86/kernel/process_32/64.c : pm_idle is called with 
local_irq_disable but assumes the function will enable local irq

arch/ia64/kernel/process.c : the code assumes the idle function will 
disable/enable the local irq.

etc ...

It seems the code with the different arch is non consistent except there 
is a technical reason I don't know. May be making them consistent will 
help to factor out this part of the code and make the common framework 
more simple.

It is just a suggestion and IMO that could be done later on top of this 
patchset.


> +	ret = cpuidle_register_driver(drv);
> +	if (ret) {
> +		pr_err("%s: Failed to register cpuidle driver\n", __func__);
> +		goto free_drv;
> +	}
> +
> +	common_cpuidle_devices = alloc_percpu(struct cpuidle_device);
> +	if (common_cpuidle_devices == NULL) {
> +		ret = -ENOMEM;
> +		goto unregister_drv;
> +	}
> +
> +	/* initialize state data for each cpuidle_device */
> +	for_each_possible_cpu(cpu_id) {
> +		dev = per_cpu_ptr(common_cpuidle_devices, cpu_id);
> +		dev->cpu = cpu_id;
> +		dev->state_count = drv->state_count;
> +
> +		if (driver_data_init)
> +			driver_data_init(dev);
> +
> +		ret = cpuidle_register_device(dev);
> +		if (ret) {
> +			pr_err("%s: Failed to register cpu %u\n",
> +				__func__, cpu_id);
> +			goto uninit;
> +		}
> +	}
> +
> +	return 0;
> +uninit:
> +
> +	common_cpuidle_devices_uninit();
> +
> +unregister_drv:
> +
> +	cpuidle_unregister_driver(drv);
> +
> +free_drv:
> +
> +	kfree(drv);
> +
> +	return ret;
> +}
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 712abcc..2aa89db 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -56,6 +56,16 @@ struct cpuidle_state {
>
>   #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
>
> +/* Common ARM WFI state */
> +#define CPUIDLE_ARM_WFI_STATE {\
> +	.enter                  = cpuidle_def_idle,\
> +	.exit_latency           = 2,\
> +	.target_residency       = 1,\
> +	.flags                  = CPUIDLE_FLAG_TIME_VALID,\
> +	.name                   = "WFI",\
> +	.desc                   = "ARM core clock gating (WFI)",\
> +}
> +
>   /**
>    * cpuidle_get_statedata - retrieves private driver state data
>    * @st_usage: the state usage statistics
> @@ -141,6 +151,13 @@ extern void cpuidle_resume_and_unlock(void);
>   extern int cpuidle_enable_device(struct cpuidle_device *dev);
>   extern void cpuidle_disable_device(struct cpuidle_device *dev);
>
> +/* provide a default idle function */
> +extern int cpuidle_def_idle(struct cpuidle_device *dev,
> +		       struct cpuidle_driver *drv, int index);
> +extern int common_cpuidle_init(struct cpuidle_driver *drv, bool simple,
> +			 void (*driver_data_init)(struct cpuidle_device *dev));
> +extern void common_cpuidle_devices_uninit(void);
> +
>   #else
>   static inline void disable_cpuidle(void) { }
>   static inline int cpuidle_idle_call(void) { return -ENODEV; }
> @@ -157,6 +174,13 @@ static inline void cpuidle_resume_and_unlock(void) { }
>   static inline int cpuidle_enable_device(struct cpuidle_device *dev)
>   {return -ENODEV; }
>   static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
> +static inline int cpuidle_def_idle(struct cpuidle_device *dev,
> +		       struct cpuidle_driver *drv, int index)
> +{return -ENODEV; }
> +static inline int common_cpuidle_init(struct cpuidle_driver *pdrv,
> +	bool simple, void (*driver_data_init)(struct cpuidle_device *dev))
> +{return -ENODEV; }
> +static inline void common_cpuidle_devices_uninit(void) { }
>
>   #endif
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
