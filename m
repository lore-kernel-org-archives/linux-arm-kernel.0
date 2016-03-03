From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 02 Mar 2016 16:57:27 -0800
Subject: [RFC v3 02/12] PM / Domains: Support IRQ safe PM domains
In-Reply-To: <1456866931-37851-4-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Tue, 1 Mar 2016 14:15:21 -0700")
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
 <1456866931-37851-4-git-send-email-lina.iyer@linaro.org>
Message-ID: <7hziugxts8.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Generic Power Domains currently support turning on/off only in process
> context. This prevents the usage of PM domains for domains that could be
> powered on/off in a context where IRQs are disabled. Many such domains
> exist today and do not get powered off, when the IRQ safe devices in
> that domain are powered off, because of this limitation.
>
> However, not all domains can operate in IRQ safe contexts. Genpd
> therefore, has to support both cases where the domain may or may not
> operate in IRQ safe contexts. Configuring genpd to use an appropriate
> lock for that domain, would allow domains that have IRQ safe devices to
> runtime suspend and resume, in atomic context.
>
> To achieve domain specific locking, set the domain's ->flag to
> GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that genpd
> should use a spinlock instead of a mutex for locking the domain. Locking
> is abstracted through genpd_lock() and genpd_unlock() functions that use
> the flag to determine the appropriate lock to be used for that domain.
>
> Domains that have lower latency to suspend and resume and can operate
> with IRQs disabled may now be able to save power, when the component
> devices and sub-domains are idle at runtime.
>
> The restriction this imposes on the domain hierarchy is that non-IRQ
> safe domains may not have IRQ-safe subdomains, but IRQ safe domains may
> have IRQ safe and non-IRQ safe domains and devices.

I'm starting to think we also need a patch to the debugfg
pm_genpd_summary that will show which domains and which devices are IRQ
safe.

> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Krzysztof Koz?owski <k.kozlowski@samsung.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  Documentation/power/devices.txt |  12 ++++-
>  drivers/base/power/domain.c     | 105 ++++++++++++++++++++++++++++++++++++----
>  include/linux/pm_domain.h       |  11 ++++-
>  3 files changed, 117 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
> index 8ba6625..a622136 100644
> --- a/Documentation/power/devices.txt
> +++ b/Documentation/power/devices.txt
> @@ -607,7 +607,17 @@ individually.  Instead, a set of devices sharing a power resource can be put
>  into a low-power state together at the same time by turning off the shared
>  power resource.  Of course, they also need to be put into the full-power state
>  together, by turning the shared power resource on.  A set of devices with this
> -property is often referred to as a power domain.
> +property is often referred to as a power domain. A power domain may also be
> +nested inside another power domain.
> +
> +Devices, by default, operate in process context. If a device can operate in

Not device(s), but runtime PM callbacks for devices are what happen in
process context by default.

> +IRQ safe context that has to be explicitly indicated by setting the irq_safe
> +boolean inside struct generic_pm_domain to be true.

Maybe reference pm_runtime.txt documentation where this is described in
more detail.

> Power domains by default,
> +operate in process context but could have devices that are IRQ safe. Such
> +power domains cannot be powered on/off during runtime PM.

because...  ?

> On the other hand,
> +IRQ safe PM domains that have IRQ safe devices may be powered off when all
> +the devices are in idle. An IRQ safe domain may only be attached as a
> +subdomain to another IRQ safe domain.

The documentation should describe these limitations more, and the
reasons.

Also, this whole new paragraph you added should probably be the last
paragraph in this section, rather than between these two.

Maybe add a sub-section about IRQ safe domains and their limitations.

>  Support for power domains is provided through the pm_domain field of struct
>  device.  This field is a pointer to an object of type struct dev_pm_domain,
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 20533d9..9541d80 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -75,11 +75,59 @@ static const struct genpd_lock_fns genpd_mtx_fns  = {
>  	.unlock = genpd_unlock_mtx,
>  };
>  
> +static void genpd_lock_spin(struct generic_pm_domain *genpd)
> +	__acquires(&genpd->slock)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&genpd->slock, flags);
> +	genpd->lock_flags = flags;
> +}
> +
> +static void genpd_lock_nested_spin(struct generic_pm_domain *genpd,
> +					int depth)
> +	__acquires(&genpd->slock)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave_nested(&genpd->slock, flags, depth);
> +	genpd->lock_flags = flags;
> +}
> +
> +static int genpd_lock_interruptible_spin(struct generic_pm_domain *genpd)
> +	__acquires(&genpd->slock)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&genpd->slock, flags);
> +	genpd->lock_flags = flags;
> +	return 0;
> +}
> +
> +static void genpd_unlock_spin(struct generic_pm_domain *genpd)
> +	__releases(&genpd->slock)
> +{
> +	spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
> +}
> +
> +static const struct genpd_lock_fns genpd_spin_fns = {
> +	.lock = genpd_lock_spin,
> +	.lock_nested = genpd_lock_nested_spin,
> +	.lock_interruptible = genpd_lock_interruptible_spin,
> +	.unlock = genpd_unlock_spin,
> +};
> +
>  #define genpd_lock(p)			p->lock_fns->lock(p)
>  #define genpd_lock_nested(p, d)		p->lock_fns->lock_nested(p, d)
>  #define genpd_lock_interruptible(p)	p->lock_fns->lock_interruptible(p)
>  #define genpd_unlock(p)			p->lock_fns->unlock(p)
>  
> +static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
> +		struct generic_pm_domain *genpd)
> +{
> +	return dev->power.irq_safe && !genpd->irq_safe;
> +}
> +
>  /*
>   * Get the generic PM domain for a particular struct device.
>   * This validates the struct device pointer, the PM domain pointer,
> @@ -356,8 +404,17 @@ static int genpd_poweroff(struct generic_pm_domain *genpd, bool is_async)
>  		if (stat > PM_QOS_FLAGS_NONE)
>  			return -EBUSY;
>  
> -		if (!pm_runtime_suspended(pdd->dev) || pdd->dev->power.irq_safe)
> +		/*
> +		 * We do not want to power off the domain if the device is
> +		 * not suspended or an IRQ safe device is part of this
> +		 * non-IRQ safe domain.
> +		 */
> +		if (!pm_runtime_suspended(pdd->dev) ||
> +			irq_safe_dev_in_no_sleep_domain(pdd->dev, genpd))
>  			not_suspended++;
> +		WARN_ONCE(irq_safe_dev_in_no_sleep_domain(pdd->dev, genpd),
> +				"PM domain %s will not be powered off\n",
> +				genpd->name);

This WARN should include why.  "...because it contains IRQ safe
devices." or something similar, so it gives users a hint about what's
going on.

>  	}
>  
>  	if (not_suspended > 1 || (not_suspended == 1 && is_async))
> @@ -473,10 +530,13 @@ static int pm_genpd_runtime_suspend(struct device *dev)
>  	}
>  
>  	/*
> -	 * If power.irq_safe is set, this routine will be run with interrupts
> -	 * off, so it can't use mutexes.
> +	 * If power.irq_safe is set, this routine may be run with
> +	 * IRQ disabled, so suspend only if the power domain is

s/IRQ/IRQs/ (though I'm not sure why you changed from "interrupts off")

> +	 * irq_safe.
>  	 */
> -	if (dev->power.irq_safe)
> +	WARN_ONCE(irq_safe_dev_in_no_sleep_domain(dev, genpd),
> +			"genpd %s will not be powered off\n", genpd->name);

again, add why.

> +	if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
>  		return 0;
>  
>  	genpd_lock(genpd);
> @@ -510,8 +570,11 @@ static int pm_genpd_runtime_resume(struct device *dev)
>  	if (IS_ERR(genpd))
>  		return -EINVAL;
>  
> -	/* If power.irq_safe, the PM domain is never powered off. */
> -	if (dev->power.irq_safe) {
> +	/*
> +	 * As we don't power off a non IRQ safe domain, which holds
> +	 * an IRQ safe device, we don't need to restore power to it.
> +	 */
> +	if (dev->power.irq_safe && !genpd->irq_safe) {
>  		timed = false;
>  		goto out;
>  	}
> @@ -1394,6 +1457,17 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>  	    || genpd == subdomain)
>  		return -EINVAL;
>  
> +	/*
> +	 * If the domain can be powered on/off in an IRQ safe
> +	 * context, ensure that the subdomain can also be
> +	 * powered on/off in that context.
> +	 */
> +	if (!genpd->irq_safe && subdomain->irq_safe) {
> +		WARN("Parent %s of subdomain %s must be IRQ safe\n",
> +				genpd->name, subdomain->name);
> +		return -EINVAL;
> +	}
> +
>  	link = kzalloc(sizeof(*link), GFP_KERNEL);
>  	if (!link)
>  		return -ENOMEM;
> @@ -1610,6 +1684,19 @@ static int of_genpd_device_parse_states(struct device_node *np,
>  	return 0;
>  }
>  
> +static void genpd_lock_init(struct generic_pm_domain *genpd)
> +{
> +	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
> +		spin_lock_init(&genpd->slock);
> +		genpd->irq_safe = true;
> +		genpd->lock_fns = &genpd_spin_fns;
> +	} else {
> +		mutex_init(&genpd->mlock);
> +		genpd->irq_safe = false;
> +		genpd->lock_fns = &genpd_mtx_fns;
> +	}
> +}
> +
>  /**
>   * pm_genpd_init - Initialize a generic I/O PM domain object.
>   * @genpd: PM domain object to initialize.
> @@ -1635,8 +1722,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  	INIT_LIST_HEAD(&genpd->master_links);
>  	INIT_LIST_HEAD(&genpd->slave_links);
>  	INIT_LIST_HEAD(&genpd->dev_list);
> -	mutex_init(&genpd->mlock);
> -	genpd->lock_fns = &genpd_mtx_fns;
> +	genpd_lock_init(genpd);
>  	genpd->gov = gov;
>  	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
>  	atomic_set(&genpd->sd_count, 0);
> @@ -2077,7 +2163,8 @@ static int pm_genpd_summary_one(struct seq_file *s,
>  	}
>  
>  	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
> -		kobj_path = kobject_get_path(&pm_data->dev->kobj, GFP_KERNEL);
> +		kobj_path = kobject_get_path(&pm_data->dev->kobj,
> +				genpd->irq_safe ? GFP_ATOMIC : GFP_KERNEL);

hmm, really? the debugfs stuff is called from atomic context?

Oh, because these same functions currently use the genpd->lock mutex.
Shrug.  OK.

>  		if (kobj_path == NULL)
>  			continue;
>  
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 6bebc56..0091282 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -15,9 +15,11 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/notifier.h>
> +#include <linux/spinlock.h>
>  
>  /* Defines used for the flags field in the struct generic_pm_domain */
>  #define GENPD_FLAG_PM_CLK	(1U << 0) /* PM domain uses PM clk */
> +#define GENPD_FLAG_IRQ_SAFE	(1U << 1) /* PM domain operates in atomic */
>  
>  enum gpd_status {
>  	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
> @@ -76,7 +78,14 @@ struct generic_pm_domain {
>  	unsigned int state_count; /* number of states */
>  	unsigned int state_idx; /* state that genpd will go to when off */
>  	const struct genpd_lock_fns *lock_fns;
> -	struct mutex mlock;
> +	bool irq_safe;
> +	union {
> +		struct mutex mlock;
> +		struct {
> +			spinlock_t slock;
> +			unsigned long lock_flags;
> +		};
> +	};
>  
>  };

Kevin
