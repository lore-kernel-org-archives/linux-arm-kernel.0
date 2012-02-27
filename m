From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 27 Feb 2012 17:19:13 +0100
Subject: [PATCH v5 1/9] cpuidle: Add commonly used functionality for
 consolidation
In-Reply-To: <1330318063-25460-2-git-send-email-rob.lee@linaro.org>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
 <1330318063-25460-2-git-send-email-rob.lee@linaro.org>
Message-ID: <CAORVsuXiWJKn93OAa-bLvPEJo12zzmDSPYeGdsku+zEr2taR4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert,

On Mon, Feb 27, 2012 at 5:47 AM, Robert Lee <rob.lee@linaro.org> wrote:
> Add functionality that is commonly duplicated by various platforms.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
> ?drivers/cpuidle/cpuidle.c | ? 37 ++++++++++++++++++------------
> ?include/linux/cpuidle.h ? | ? 55 +++++++++++++++++++++++++++++++++++++++++++++
> ?2 files changed, 77 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
...

> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 712abcc..6563683 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -15,6 +15,7 @@
> ?#include <linux/list.h>
> ?#include <linux/kobject.h>
> ?#include <linux/completion.h>
> +#include <linux/hrtimer.h>
>
> ?#define CPUIDLE_STATE_MAX ? ? ?8
> ?#define CPUIDLE_NAME_LEN ? ? ? 16
> @@ -56,6 +57,16 @@ struct cpuidle_state {
>
> ?#define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
>
> +/* Common ARM WFI state */
> +#define CPUIDLE_ARM_WFI_STATE {\
> + ? ? ? .enter ? ? ? ? ? ? ? ? ?= cpuidle_simple_enter,\
> + ? ? ? .exit_latency ? ? ? ? ? = 1,\
> + ? ? ? .target_residency ? ? ? = 1,\
> + ? ? ? .flags ? ? ? ? ? ? ? ? ?= CPUIDLE_FLAG_TIME_VALID,\
> + ? ? ? .name ? ? ? ? ? ? ? ? ? = "WFI",\
> + ? ? ? .desc ? ? ? ? ? ? ? ? ? = "ARM core clock gating (WFI)",\
> +}
This macro should belong to an ARM only header.

> +
> ?/**
> ?* cpuidle_get_statedata - retrieves private driver state data
> ?* @st_usage: the state usage statistics
> @@ -122,6 +133,14 @@ struct cpuidle_driver {
> ? ? ? ?struct module ? ? ? ? ? *owner;
>
> ? ? ? ?unsigned int ? ? ? ? ? ?power_specified:1;
> + ? ? ? /*
> + ? ? ? ?* use the core cpuidle time keeping. This has been implemented for the
> + ? ? ? ?* entire driver instead of per state as currently the device enter
> + ? ? ? ?* fuction allows the entered state to change which requires handling
> + ? ? ? ?* that requires a (subjectively) unnecessary decrease to efficiency
> + ? ? ? ?* in this commonly called code.
> + ? ? ? ?*/
> + ? ? ? unsigned int ? ? ? ? ? ?en_core_tk_irqen:1;
Does the description reads as 'the time accounting is only performed
if en_core_tk_irqen is set'?
Also it suggests that changing (i.e. demoting) the state is kind of a
problem, which is unclear. IIUC the state change is handled correctly
in cpuidle_idle_call, is that correct?

> ? ? ? ?struct cpuidle_state ? ?states[CPUIDLE_STATE_MAX];
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? state_count;
> ? ? ? ?int ? ? ? ? ? ? ? ? ? ? safe_state_index;
> @@ -140,6 +159,39 @@ extern void cpuidle_pause_and_lock(void);
> ?extern void cpuidle_resume_and_unlock(void);
> ?extern int cpuidle_enable_device(struct cpuidle_device *dev);
> ?extern void cpuidle_disable_device(struct cpuidle_device *dev);
> +extern int cpuidle_simple_enter(struct cpuidle_device *dev,
> + ? ? ? ? ? ? ? struct cpuidle_driver *drv, int index);
> +
> +/**
> + * cpuidle_enter_wrap - performing timekeeping and irq around enter function
> + * @dev: pointer to a valid cpuidle_device object
> + * @drv: pointer to a valid cpuidle_driver object
> + * @index: index of the target cpuidle state.
> + */
> +static inline int cpuidle_wrap_enter(struct cpuidle_device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct cpuidle_driver *drv, int index,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int (*enter)(struct cpuidle_device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct cpuidle_driver *drv, int index))
The function name does not match the description (cpuidle_enter_wrap
vs cpuidle_wrap_enter).

> +{
> + ? ? ? ktime_t time_start, time_end;
> + ? ? ? s64 diff;
> +
> + ? ? ? time_start = ktime_get();
> +
> + ? ? ? index = enter(dev, drv, index);
> +
> + ? ? ? time_end = ktime_get();
> +
> + ? ? ? local_irq_enable();
> +
> + ? ? ? diff = ktime_to_us(ktime_sub(time_end, time_start));
> + ? ? ? if (diff > INT_MAX)
> + ? ? ? ? ? ? ? diff = INT_MAX;
> +
> + ? ? ? dev->last_residency = (int) diff;
> +
> + ? ? ? return index;
> +}
>
> ?#else
> ?static inline void disable_cpuidle(void) { }
...

Regards,
Jean
