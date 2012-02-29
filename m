From: deepthi@linux.vnet.ibm.com (Deepthi Dharwar)
Date: Wed, 29 Feb 2012 16:43:19 +0530
Subject: [PATCH v6 1/9] cpuidle: Add common time keeping and irq enabling
In-Reply-To: <1330485109-7327-2-git-send-email-rob.lee@linaro.org>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
 <1330485109-7327-2-git-send-email-rob.lee@linaro.org>
Message-ID: <4F4E084F.5050505@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


On 02/29/2012 08:41 AM, Robert Lee wrote:

> Make necessary changes to implement time keeping and irq enabling
> in the core cpuidle code.  This will allow the removal of these
> functionalities from various platform cpuidle implementations whose
> timekeeping and irq enabling follows the form in this common code.
> 
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
>  arch/arm/include/asm/cpuidle.h |   14 ++++++
>  drivers/cpuidle/cpuidle.c      |   90 ++++++++++++++++++++++++++++++++--------
>  include/linux/cpuidle.h        |   13 ++++++
>  3 files changed, 99 insertions(+), 18 deletions(-)
>  create mode 100644 arch/arm/include/asm/cpuidle.h
> 
> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
> new file mode 100644
> index 0000000..1d2075b
> --- /dev/null
> +++ b/arch/arm/include/asm/cpuidle.h
> @@ -0,0 +1,14 @@
> +#ifndef __ASM_ARM_CPUIDLE_H
> +#define __ASM_ARM_CPUIDLE_H
> +
> +/* Common ARM WFI state */
> +#define CPUIDLE_ARM_WFI_STATE {\
> +	.enter                  = cpuidle_simple_enter,\
> +	.exit_latency           = 1,\
> +	.target_residency       = 1,\
> +	.flags                  = CPUIDLE_FLAG_TIME_VALID,\
> +	.name                   = "WFI",\
> +	.desc                   = "ARM core clock gating (WFI)",\
> +}
> +
> +#endif
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 59f4261..00b02f5 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -18,6 +18,7 @@
>  #include <linux/ktime.h>
>  #include <linux/hrtimer.h>
>  #include <linux/module.h>
> +#include <asm/proc-fns.h>
>  #include <trace/events/power.h>
> 
>  #include "cpuidle.h"
> @@ -53,6 +54,24 @@ static void cpuidle_kick_cpus(void) {}
> 
>  static int __cpuidle_register_device(struct cpuidle_device *dev);
> 
> +static inline int cpuidle_enter(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	struct cpuidle_state *target_state = &drv->states[index];
> +	return target_state->enter(dev, drv, index);
> +}
> +
> +static inline int cpuidle_enter_tk(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv, int index)
> +{
> +	return cpuidle_wrap_enter(dev, drv, index, cpuidle_enter);
> +}
> +
> +typedef int (*cpuidle_enter_t)(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv, int index);
> +
> +static cpuidle_enter_t cpuidle_enter_ops;
> +
>  /**
>   * cpuidle_idle_call - the main idle loop
>   *
> @@ -63,7 +82,6 @@ int cpuidle_idle_call(void)
>  {
>  	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
>  	struct cpuidle_driver *drv = cpuidle_get_driver();
> -	struct cpuidle_state *target_state;
>  	int next_state, entered_state;
> 
>  	if (off)
> @@ -92,12 +110,10 @@ int cpuidle_idle_call(void)
>  		return 0;
>  	}
> 
> -	target_state = &drv->states[next_state];
> -
>  	trace_power_start(POWER_CSTATE, next_state, dev->cpu);
>  	trace_cpu_idle(next_state, dev->cpu);
> 
> -	entered_state = target_state->enter(dev, drv, next_state);
> +	entered_state = cpuidle_enter_ops(dev, drv, next_state);
> 
>  	trace_power_end(dev->cpu);
>  	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
> @@ -110,7 +126,8 @@ int cpuidle_idle_call(void)
>  		dev->states_usage[entered_state].time +=
>  				(unsigned long long)dev->last_residency;
>  		dev->states_usage[entered_state].usage++;
> -	}
> +	} else
> +		dev->last_residency = 0;
> 
>  	/* give the governor an opportunity to reflect on the outcome */
>  	if (cpuidle_curr_governor->reflect)
> @@ -164,20 +181,29 @@ void cpuidle_resume_and_unlock(void)
> 
>  EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
> 
> -#ifdef CONFIG_ARCH_HAS_CPU_RELAX
> -static int poll_idle(struct cpuidle_device *dev,
> -		struct cpuidle_driver *drv, int index)
> +/**
> + * cpuidle_wrap_enter - performs timekeeping and irqen around enter function
> + * @dev: pointer to a valid cpuidle_device object
> + * @drv: pointer to a valid cpuidle_driver object
> + * @index: index of the target cpuidle state.
> + */
> +int cpuidle_wrap_enter(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index,
> +				int (*enter)(struct cpuidle_device *dev,
> +					struct cpuidle_driver *drv, int index))
>  {
> -	ktime_t	t1, t2;
> +	ktime_t time_start, time_end;
>  	s64 diff;
> 
> -	t1 = ktime_get();
> +	time_start = ktime_get();
> +
> +	index = enter(dev, drv, index);
> +
> +	time_end = ktime_get();
> +
>  	local_irq_enable();
> -	while (!need_resched())
> -		cpu_relax();
> 
> -	t2 = ktime_get();
> -	diff = ktime_to_us(ktime_sub(t2, t1));
> +	diff = ktime_to_us(ktime_sub(time_end, time_start));
>  	if (diff > INT_MAX)
>  		diff = INT_MAX;
> 
> @@ -186,6 +212,31 @@ static int poll_idle(struct cpuidle_device *dev,
>  	return index;
>  }
> 
> +int cpuidle_simple_enter(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index)
> +{
> +	cpu_do_idle();
> +
> +	return index;
> +}


The enter routines are always part of  the specific driver code rather
than in the generic cpuidle framework code.
The above function is arm driver specific enter routine, and should be
in arch specific file.
Right now, this causes a build break on Powerpc and Intel boxes.

drivers/cpuidle/cpuidle.c:21:26: error: asm/proc-fns.h: No such file or
directory
drivers/cpuidle/cpuidle.c: In function ?cpuidle_simple_enter?:
drivers/cpuidle/cpuidle.c:218: error: implicit declaration of function
?cpu_do_idle?
make[2]: *** [drivers/cpuidle/cpuidle.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers/cpuidle] Error 2
make[1]: *** Waiting for unfinished jobs....


> +
> +#ifdef CONFIG_ARCH_HAS_CPU_RELAX
> +static inline int __poll_idle(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index)
> +{
> +	while (!need_resched())
> +		cpu_relax();
> +
> +	return index;
> +}
> +
> +static int poll_idle(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index)
> +{
> +	return cpuidle_wrap_enter(dev,	drv, index,
> +				__poll_idle);
> +}
> +
>  static void poll_idle_init(struct cpuidle_driver *drv)
>  {
>  	struct cpuidle_state *state = &drv->states[0];
> @@ -195,7 +246,6 @@ static void poll_idle_init(struct cpuidle_driver *drv)
>  	state->exit_latency = 0;
>  	state->target_residency = 0;
>  	state->power_usage = -1;
> -	state->flags = 0;


Also, why is that these flags have been eliminated ?

>  	state->enter = poll_idle;
>  }
>  #else
> @@ -212,10 +262,11 @@ static void poll_idle_init(struct cpuidle_driver *drv) {}
>  int cpuidle_enable_device(struct cpuidle_device *dev)
>  {
>  	int ret, i;
> +	struct cpuidle_driver *drv = cpuidle_get_driver();
> 
>  	if (dev->enabled)
>  		return 0;
> -	if (!cpuidle_get_driver() || !cpuidle_curr_governor)
> +	if (!drv || !cpuidle_curr_governor)
>  		return -EIO;
>  	if (!dev->state_count)
>  		return -EINVAL;
> @@ -226,13 +277,16 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
>  			return ret;
>  	}
> 
> -	poll_idle_init(cpuidle_get_driver());
> +	cpuidle_enter_ops = drv->en_core_tk_irqen ?
> +		cpuidle_enter_tk : cpuidle_enter;
> +
> +	poll_idle_init(drv);
> 
>  	if ((ret = cpuidle_add_state_sysfs(dev)))
>  		return ret;
> 
>  	if (cpuidle_curr_governor->enable &&
> -	    (ret = cpuidle_curr_governor->enable(cpuidle_get_driver(), dev)))
> +	    (ret = cpuidle_curr_governor->enable(drv, dev)))
>  		goto fail_sysfs;
> 
>  	for (i = 0; i < dev->state_count; i++) {
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 712abcc..c91b018 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -15,6 +15,7 @@
>  #include <linux/list.h>
>  #include <linux/kobject.h>
>  #include <linux/completion.h>
> +#include <linux/hrtimer.h>
> 
>  #define CPUIDLE_STATE_MAX	8
>  #define CPUIDLE_NAME_LEN	16
> @@ -122,6 +123,8 @@ struct cpuidle_driver {
>  	struct module 		*owner;
> 
>  	unsigned int		power_specified:1;
> +	/* set to 1 to use the core cpuidle time keeping (for all states). */
> +	unsigned int		en_core_tk_irqen:1;
>  	struct cpuidle_state	states[CPUIDLE_STATE_MAX];
>  	int			state_count;
>  	int			safe_state_index;
> @@ -140,6 +143,13 @@ extern void cpuidle_pause_and_lock(void);
>  extern void cpuidle_resume_and_unlock(void);
>  extern int cpuidle_enable_device(struct cpuidle_device *dev);
>  extern void cpuidle_disable_device(struct cpuidle_device *dev);
> +extern int cpuidle_simple_enter(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index);
> +
> +extern int cpuidle_wrap_enter(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index,
> +				int (*enter)(struct cpuidle_device *dev,
> +					struct cpuidle_driver *drv, int index));
> 
>  #else
>  static inline void disable_cpuidle(void) { }
> @@ -157,6 +167,9 @@ static inline void cpuidle_resume_and_unlock(void) { }
>  static inline int cpuidle_enable_device(struct cpuidle_device *dev)
>  {return -ENODEV; }
>  static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
> +static inline int cpuidle_simple_enter(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index)
> +{return -ENODEV; }
> 
>  #endif
> 


I am for generic time keeping framework, this would remove
loads of redundant code for the same in all the backend drivers.

Cheers,
Deepthi
