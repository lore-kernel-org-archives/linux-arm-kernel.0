From: robherring2@gmail.com (Rob Herring)
Date: Tue, 06 Dec 2011 09:06:57 -0600
Subject: [RFC PATCH 1/8] ARM: Add commonly used cpuidle init code
In-Reply-To: <1323146291-10676-2-git-send-email-rob.lee@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
 <1323146291-10676-2-git-send-email-rob.lee@linaro.org>
Message-ID: <4EDE2F91.5090104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2011 10:38 PM, Robert Lee wrote:
> Add commonly used cpuidle init code to avoid unecessary duplication.
> 
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
>  arch/arm/common/Makefile       |    1 +
>  arch/arm/common/cpuidle.c      |  132 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/include/asm/cpuidle.h |   25 ++++++++

Why not move cpuidle drivers to drivers/idle/ ?

>  3 files changed, 158 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/common/cpuidle.c
>  create mode 100644 arch/arm/include/asm/cpuidle.h
> 
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index 6ea9b6f..0865f69 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_ARCH_IXP2000)	+= uengine.o
>  obj-$(CONFIG_ARCH_IXP23XX)	+= uengine.o
>  obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
>  obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
> +obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
> diff --git a/arch/arm/common/cpuidle.c b/arch/arm/common/cpuidle.c
> new file mode 100644
> index 0000000..e9a46a3
> --- /dev/null
> +++ b/arch/arm/common/cpuidle.c
> @@ -0,0 +1,132 @@
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
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/cpuidle.h>
> +#include <linux/hrtimer.h>
> +#include <linux/err.h>
> +#include <asm/cpuidle.h>
> +#include <asm/proc-fns.h>
> +
> +static struct cpuidle_device __percpu * arm_cpuidle_devices;
> +
> +static int (*mach_cpuidle)(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv,
> +				int index);
> +
> +static int arm_enter_idle(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv, int index)

I think how this works is backwards. This function is only called if
there is a NULL enter function for a state, but mach_cpuidle is global.
Ideally, I want to call this function for every state, but call a
different mach_cpuidle function for each state. Yes, you could select a
specific function for each state within the mach_cpuidle function, but
that seems silly to make the per state function global and then have to
select a per state function again. And if many users are doing that,
then it belongs in the common code.

> +{
> +	ktime_t time_start, time_end;
> +
> +	local_irq_disable();
> +	local_fiq_disable();
> +
> +	time_start = ktime_get();
> +
> +	index = mach_cpuidle(dev, drv, index);
> +
> +	time_end = ktime_get();
> +
> +	local_fiq_enable();
> +	local_irq_enable();
> +
> +	dev->last_residency =
> +		(int)ktime_to_us(ktime_sub(time_end, time_start));
> +
> +	return index;
> +}
> +
> +void arm_cpuidle_devices_uninit(void)
> +{
> +	int cpu_id;
> +	struct cpuidle_device *dev;
> +
> +	for_each_possible_cpu(cpu_id) {
> +		dev = per_cpu_ptr(arm_cpuidle_devices, cpu_id);
> +		cpuidle_unregister_device(dev);
> +	}
> +
> +	free_percpu(arm_cpuidle_devices);
> +	return;

Don't need return statement.

> +}
> +
> +int __init arm_cpuidle_init(struct cpuidle_driver *drv,
> +	int (*common_enter)(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index),
> +	void *driver_data[])
> +{
> +	struct cpuidle_device *dev;
> +	int i, cpu_id;
> +
> +	if (drv == NULL) {
> +		pr_err("%s: cpuidle_driver pointer NULL\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (drv->state_count > CPUIDLE_STATE_MAX)
> +		pr_err("%s: state count exceeds maximum\n", __func__);

return an error?

You can collapse these 2 parameter checks down to:

if (!drv || (drv->state_count > CPUIDLE_STATE_MAX))

> +
> +	mach_cpuidle = common_enter;
> +
> +	/* if state enter function not specified, use common_enter function */
> +	for (i = 0; i < drv->state_count; i++) {
> +		if (drv->states[i].enter == NULL) {
> +			if (mach_cpuidle == NULL) {

Usually !mach_cpuidle is preferred for NULL checks. You can move this
check out of the loop.

> +				pr_err("%s: 'enter' function pointer NULL\n",
> +				__func__);
> +				return -EINVAL;
> +			} else
> +				drv->states[i].enter = arm_enter_idle;
> +		}
> +	}
> +
> +	if (cpuidle_register_driver(drv)) {
> +		pr_err("%s: Failed to register cpuidle driver\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	arm_cpuidle_devices = alloc_percpu(struct cpuidle_device);
> +	if (arm_cpuidle_devices == NULL) {
> +		cpuidle_unregister_driver(drv);
> +		return -ENOMEM;
> +	}
> +
> +	/* initialize state data for each cpuidle_device */
> +	for_each_possible_cpu(cpu_id) {
> +
> +		dev = per_cpu_ptr(arm_cpuidle_devices, cpu_id);
> +		dev->cpu = cpu_id;
> +		dev->state_count = drv->state_count;
> +
> +		if (driver_data)
> +			for (i = 0; i < dev->state_count; i++) {

This would be more concise and less indentation:

for (i = 0; driver_data, i < dev->state_count; i++)

> +				dev->states_usage[i].driver_data =
> +							driver_data[i];
> +			}
> +
> +		if (cpuidle_register_device(dev)) {
> +			pr_err("%s: Failed to register cpu %u\n",
> +				__func__, cpu_id);
> +			return -ENODEV;

Leaking memory here from alloc_percpu.

Also, need to unregister driver. It's usually cleaner to use goto's for
error clean-up.

Rob
