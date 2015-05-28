From: grygorii.strashko@linaro.org (Grygorii.Strashko@linaro.org)
Date: Thu, 28 May 2015 17:49:52 +0300
Subject: [RFC v1] clk: Add Suspend/Resume Callbacks in Clock
In-Reply-To: <1432725110-11954-1-git-send-email-pankaj.dev@st.com>
References: <1432725110-11954-1-git-send-email-pankaj.dev@st.com>
Message-ID: <55672B10.8050909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2015 02:11 PM, Pankaj Dev wrote:
> Currently the CCF doesnt have any interface with the system when it
> goes into suspend state. This patch, on similar lines of syscore,
> adds clk_suspend/clk_resume functions before system enters suspend state
> Also there are suspend/resume hooks added for the clock driver
> 
> Acked-by: Olivier Bideau <olivier.bideau@st.com>
> Acked-by: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Pankaj Dev <pankaj.dev@st.com>


Nice:) Second try. FYI http://www.spinics.net/lists/linux-clk/msg00743.html

Regarding your patch:
 * @prepare:	Prepare the clock for enabling. This must not return until
 *		the clock is fully prepared, and it's safe to call clk_enable.
 *		This callback is intended to allow clock implementations to
 *		do any initialisation that may sleep. Called with
 *		prepare_lock held.
.un/prepare() callbacks intended to be used for slow clocks and may sleep, so
you can't call them when Syscore is suspended and with disabled IRQs.

> ---
>   drivers/clk/clk.c            |  194 ++++++++++++++++++++++++++++++++++++++++++
>   include/linux/clk-provider.h |   21 +++++
>   include/linux/clk.h          |   23 +++++
>   kernel/kexec.c               |    6 ++
>   kernel/power/hibernate.c     |   16 ++++
>   kernel/power/suspend.c       |    7 ++
>   6 files changed, 267 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 237f23f..3e3b1d7 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2811,6 +2811,200 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb)
>   }
>   EXPORT_SYMBOL_GPL(clk_notifier_unregister);
>   
> +#ifdef CONFIG_PM_SLEEP
> +int __clk_resume(struct clk_core *clk)
> +{
> +	int ret = 0;
> +	u8 p_index;
> +	unsigned long rate, parent_rate = 0;
> +
> +	/* restore parent */
> +	if (clk->ops->set_parent) {
> +		p_index = clk_fetch_parent_index(clk, clk->parent);
> +
> +		if (p_index != clk->ops->get_parent(clk->hw))
> +			ret = clk->ops->set_parent(clk->hw, p_index);
> +
> +		if (ret) {
> +			pr_err("%s: Fail to set parent %s\n",
> +			       __func__, clk->name);
> +			goto out;
> +		}
> +	}
> +
> +	/* restore rate */
> +	if (clk->ops->set_rate) {
> +		if (clk->parent)
> +			parent_rate = clk->parent->rate;
> +
> +		rate = clk->ops->recalc_rate(clk->hw, parent_rate);
> +
> +		if (rate != clk->rate)
> +			ret = clk->ops->set_rate(clk->hw, clk->rate,
> +						 parent_rate);
> +
> +		if (ret) {
> +			pr_err("%s: Fail to set rate %s\n",
> +			       __func__, clk->name);
> +			goto out;
> +		}
> +	}
> +
> +	/* restore prepare status */
> +	if (clk->ops->prepare && clk->prepare_count) {
> +		if (clk->ops->is_prepared) {
> +			if (!clk->ops->is_prepared(clk->hw))
> +				ret = clk->ops->prepare(clk->hw);
> +		} else {
> +			ret = clk->ops->prepare(clk->hw);
> +		}
> +		if (ret) {
> +			pr_err("%s: Fail to prepare %s\n",
> +			       __func__, clk->name);
> +			goto out;
> +		}
> +	}
> +
> +	/* restore enable status */
> +	if (clk->ops->enable && clk->enable_count) {
> +		if (clk->ops->is_enabled) {
> +			if (!clk->ops->is_enabled(clk->hw))
> +				ret = clk->ops->enable(clk->hw);
> +		} else {
> +			ret = clk->ops->enable(clk->hw);
> +		}
> +		if (ret) {
> +			pr_err("%s: Fail to enable %s\n",
> +			       __func__, clk->name);
> +			goto out;
> +		}
> +	}
> +	if (clk->ops->disable && !clk->enable_count) {
> +		if (clk->ops->is_enabled) {
> +			if (clk->ops->is_enabled(clk->hw))
> +				clk->ops->disable(clk->hw);
> +		} else {
> +			clk->ops->disable(clk->hw);
> +		}
> +	}
> +
> +	/* restore unprepare status */
> +	if (clk->ops->unprepare && !clk->prepare_count) {
> +		if (clk->ops->is_prepared) {
> +			if (!clk->ops->is_prepared(clk->hw))
> +				clk->ops->unprepare(clk->hw);
> +		} else {
> +			clk->ops->unprepare(clk->hw);
> +		}
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +static int _clk_resume(struct clk_core *clk)
> +{
> +	struct clk_core *child;
> +	int ret = 0;
> +
> +	if (!clk)
> +		return 0;
> +
> +	if (clk->ops->resume)
> +		ret = clk->ops->resume(clk->hw);
> +	else
> +		ret = __clk_resume(clk);
> +
> +	if (ret)
> +		return ret;
> +
> +	hlist_for_each_entry(child, &clk->children, child_node) {
> +		ret = _clk_resume(child);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +void clk_resume(void)
> +{
> +	struct clk_core *clk;
> +
> +	hlist_for_each_entry(clk, &clk_root_list, child_node)
> +		_clk_resume(clk);
> +
> +	hlist_for_each_entry(clk, &clk_orphan_list, child_node)
> +		_clk_resume(clk);
> +}
> +
> +int __clk_suspend(struct clk_core *clk)
> +{
> +	/* Currently, Nothing to do. Could be used in future */
> +	return 0;
> +}
> +
> +static int _clk_suspend(struct clk_core *clk)
> +{
> +	struct clk *child;
> +	int ret = 0;
> +
> +	if (!clk)
> +		return 0;
> +
> +	hlist_for_each_entry(child, &clk->children, child_node) {
> +		ret = _clk_suspend(child);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (clk->ops->suspend)
> +		return clk->ops->suspend(clk->hw);
> +
> +	return __clk_suspend(clk);
> +}
> +
> +int clk_suspend(void)
> +{
> +	struct clk_core *clk, *clkerr;
> +	int ret;
> +
> +	hlist_for_each_entry(clk, &clk_root_list, child_node) {
> +		ret = _clk_suspend(clk);
> +		if (ret) {
> +			/* Call resume of suspended clocks if error */
> +			hlist_for_each_entry(clkerr, &clk_root_list,
> +					     child_node) {
> +				if (clkerr == clk)
> +					goto out;
> +				_clk_resume(clkerr);
> +			}
> +			goto out;
> +		}
> +	}
> +
> +	hlist_for_each_entry(clk, &clk_orphan_list, child_node) {
> +		ret = _clk_suspend(clk);
> +		if (ret) {
> +			/* Call resume of suspended clocks if error */
> +			hlist_for_each_entry(clkerr, &clk_root_list,
> +					     child_node)
> +				_clk_resume(clkerr);
> +			hlist_for_each_entry(clkerr, &clk_orphan_list,
> +					     child_node) {
> +				if (clkerr == clk)
> +					goto out;
> +				_clk_resume(clkerr);
> +			}
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	return ret;
> +}
> +#endif
> +
>   #ifdef CONFIG_OF
>   /**
>    * struct of_clk_provider - Clock provider registration structure
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 5591ea7..ec6438d 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -151,6 +151,18 @@ struct dentry;
>    *		prepare_lock held.  Returns 0 on success, -EERROR otherwise.
>    *
>    *
> + * @suspend:	Called (if defined) when the system is about to enter
> + *		Suspend. Framework defined __clk_suspend is called, if
> + *		this callback is not defined. Optionally the driver could
> + *		also call __clk_suspend inside this callback.
> + *		Returns 0 on success, -EERROR otherwise.
> + *
> + * @resume:	Called (if defined) when the system is about to exit
> + *		Suspend. Framework defined __clk_resume is called, if
> + *		this callback is not defined. Optionally the driver could
> + *		also call __clk_resume inside this callback.
> + *		Returns 0 on success, -EERROR otherwise.
> + *
>    * The clk_enable/clk_disable and clk_prepare/clk_unprepare pairs allow
>    * implementations to split any work between atomic (enable) and sleepable
>    * (prepare) contexts.  If enabling a clock requires code that might sleep,
> @@ -194,6 +206,10 @@ struct clk_ops {
>   	int		(*set_phase)(struct clk_hw *hw, int degrees);
>   	void		(*init)(struct clk_hw *hw);
>   	int		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
> +#ifdef CONFIG_PM_SLEEP
> +	int             (*suspend)(struct clk_hw *hw);
> +	int             (*resume)(struct clk_hw *hw);
> +#endif
>   };
>   
>   /**
> @@ -596,6 +612,11 @@ static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
>   	dst->core = src->core;
>   }
>   
> +#ifdef CONFIG_PM_SLEEP
> +int __clk_suspend(struct clk_core *clk);
> +int __clk_resume(struct clk_core *clk);
> +#endif
> +
>   /*
>    * FIXME clock api without lock protection
>    */
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 68c16a6..5e6a636 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -394,6 +394,23 @@ struct clk *clk_get_parent(struct clk *clk);
>    */
>   struct clk *clk_get_sys(const char *dev_id, const char *con_id);
>   
> +#ifdef CONFIG_PM_SLEEP
> +/**
> + * clk_suspend - Called by the suspend framework before entering System Suspend
> + *
> + * Returns success (0) or negative errno
> + * Called with Interrupts disabled
> + */
> +int clk_suspend(void);
> +
> +/**
> + * clk_resume - Called by the suspend framework after exiting System Suspend
> + *
> + * Called with Interrupts disabled
> + */
> +void clk_resume(void);
> +#endif
> +
>   #else /* !CONFIG_HAVE_CLK */
>   
>   static inline struct clk *clk_get(struct device *dev, const char *id)
> @@ -447,6 +464,12 @@ static inline struct clk *clk_get_parent(struct clk *clk)
>   	return NULL;
>   }
>   
> +#ifdef CONFIG_PM_SLEEP
> +static inline int clk_suspend(void) {}
> +
> +static inline void clk_resume(void) {}
> +#endif
> +
>   #endif
>   
>   /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 38c25b1..28bce76 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -36,6 +36,7 @@
>   #include <linux/syscore_ops.h>
>   #include <linux/compiler.h>
>   #include <linux/hugetlb.h>
> +#include <linux/clk.h>
>   
>   #include <asm/page.h>
>   #include <asm/uaccess.h>
> @@ -2724,6 +2725,9 @@ int kernel_kexec(void)
>   		error = syscore_suspend();
>   		if (error)
>   			goto Enable_irqs;
> +		error = clk_suspend();
> +		if (error)
> +			goto Resume_syscore;
>   	} else
>   #endif
>   	{
> @@ -2746,6 +2750,8 @@ int kernel_kexec(void)
>   
>   #ifdef CONFIG_KEXEC_JUMP
>   	if (kexec_image->preserve_context) {
> +		clk_resume();
> + Resume_syscore:
>   		syscore_resume();
>    Enable_irqs:
>   		local_irq_enable();
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 2329daa..f9b45ff 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -30,6 +30,7 @@
>   #include <linux/genhd.h>
>   #include <linux/ktime.h>
>   #include <trace/events/power.h>
> +#include <linux/clk.h>
>   
>   #include "power.h"
>   
> @@ -292,6 +293,12 @@ static int create_image(int platform_mode)
>   		goto Enable_irqs;
>   	}
>   
> +	error = clk_suspend();
> +	if (error) {
> +		pr_err("PM: Clocks Suspend failed aborting hibernation\n");
> +		goto Power_up;
> +	}
> +
>   	if (hibernation_test(TEST_CORE) || pm_wakeup_pending())
>   		goto Power_up;
>   
> @@ -310,6 +317,7 @@ static int create_image(int platform_mode)
>   
>   	platform_leave(platform_mode);
>   
> +	clk_resume();
>    Power_up:
>   	syscore_resume();
>   
> @@ -442,6 +450,10 @@ static int resume_target_kernel(bool platform_mode)
>   	if (error)
>   		goto Enable_irqs;
>   
> +	error = clk_suspend();
> +	if (error)
> +		goto Resume_syscore;
> +
>   	save_processor_state();
>   	error = restore_highmem();
>   	if (!error) {
> @@ -467,6 +479,8 @@ static int resume_target_kernel(bool platform_mode)
>   	restore_processor_state();
>   	touch_softlockup_watchdog();
>   
> +	clk_resume();
> + Resume_syscore:
>   	syscore_resume();
>   
>    Enable_irqs:
> @@ -556,6 +570,7 @@ int hibernation_platform_enter(void)
>   
>   	local_irq_disable();
>   	syscore_suspend();
> +	clk_suspend();
>   	if (pm_wakeup_pending()) {
>   		error = -EAGAIN;
>   		goto Power_up;
> @@ -566,6 +581,7 @@ int hibernation_platform_enter(void)
>   	while (1);
>   
>    Power_up:
> +	clk_resume();
>   	syscore_resume();
>   	local_irq_enable();
>   	enable_nonboot_cpus();
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index b7d6b3a..3a9abb7 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -28,6 +28,7 @@
>   #include <linux/ftrace.h>
>   #include <trace/events/power.h>
>   #include <linux/compiler.h>
> +#include <linux/clk.h>
>   
>   #include "power.h"
>   
> @@ -349,6 +350,10 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
>   
>   	error = syscore_suspend();
>   	if (!error) {
> +		error = clk_suspend();
> +		if (error)
> +			goto Resume_syscore;
> +
>   		*wakeup = pm_wakeup_pending();
>   		if (!(suspend_test(TEST_CORE) || *wakeup)) {
>   			trace_suspend_resume(TPS("machine_suspend"),
> @@ -358,6 +363,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
>   				state, false);
>   			events_check_enabled = false;
>   		}
> +		clk_resume();
> +Resume_syscore:
>   		syscore_resume();
>   	}
>   
> 


-- 
regards,
-grygorii
