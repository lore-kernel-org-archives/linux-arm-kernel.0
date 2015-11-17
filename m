From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 17 Nov 2015 15:37:32 -0700
Subject: [PATCH RFC 08/27] PM / Domains: Support IRQ safe PM domains
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1447799871-56374-9-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generic Power Domains currently support turning on/off only in process
context. This prevents the usage of PM domains for domains that could be
powered on/off in a context where IRQs are disabled. Many such domains
exist today and do not get powered off, when the IRQ safe devices in
that domain are powered off, because of this limitation.

However, not all domains can operate in IRQ safe contexts. Genpd
therefore, has to support both cases where the domain may or may not
operate in IRQ safe contexts. Configuring genpd to use an appropriate
lock for that domain, would allow domains that have IRQ safe devices to
runtime suspend and resume, in atomic context.

To achieve domain specific locking, set the domain's ->flag to
GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that genpd
should use a spinlock instead of a mutex for locking the domain. Locking
is abstracted through genpd_lock() and genpd_unlock() functions that use
the flag to determine the appropriate lock to be used for that domain.
Domains that have lower latency to suspend and resume and can operate
with IRQs disabled may now be able to save power, when the component
devices and sub-domains are idle at runtime.

The restriction this imposes on the domain hierarchy is that sub-domains
and all devices in the IRQ safe domain's hierarchy also have to be IRQ
safe, so that we dont try to lock a mutex, while holding a spinlock.
Non-IRQ safe domains may continue to have devices and sub-domains that
may or may not be IRQ safe.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Koz?owski <k.kozlowski@samsung.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/power/devices.txt |  11 ++-
 drivers/base/power/domain.c     | 197 ++++++++++++++++++++++++++++++++--------
 include/linux/pm_domain.h       |  12 ++-
 3 files changed, 178 insertions(+), 42 deletions(-)

diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
index 8ba6625..bde6141 100644
--- a/Documentation/power/devices.txt
+++ b/Documentation/power/devices.txt
@@ -607,7 +607,16 @@ individually.  Instead, a set of devices sharing a power resource can be put
 into a low-power state together at the same time by turning off the shared
 power resource.  Of course, they also need to be put into the full-power state
 together, by turning the shared power resource on.  A set of devices with this
-property is often referred to as a power domain.
+property is often referred to as a power domain. A power domain may also be
+nested inside another power domain.
+
+Devices, by default, operate in process context and if a device can operate in
+IRQ safe context, has to be explicitly set as IRQ safe. Power domains by
+default, operate in process context but could have devices that are IRQ safe.
+Such power domains cannot be powered on/off during runtime PM. On the other
+hand, an IRQ safe PM domain that can be powered on/off and suspended or resumed
+in an atomic context, may contain IRQ safe devices. Such domains may only
+contain IRQ safe devices or IRQ safe sub-domains.
 
 Support for power domains is provided through the pm_domain field of struct
 device.  This field is a pointer to an object of type struct dev_pm_domain,
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index abc81bd..8df43f8 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -44,6 +44,80 @@ static int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
+static inline int genpd_lock_nosleep(struct generic_pm_domain *genpd,
+					unsigned int subclass)
+	__acquires(&genpd->slock)
+{
+	unsigned long flags;
+
+	if (subclass > 0)
+		spin_lock_irqsave_nested(&genpd->slock, flags, subclass);
+	else
+		spin_lock_irqsave(&genpd->slock, flags);
+
+	genpd->lock_flags = flags;
+	return 0;
+}
+
+static inline void genpd_unlock_nosleep(struct generic_pm_domain *genpd)
+	__releases(&genpd->slock)
+{
+	spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
+}
+
+static inline int genpd_lock_irq(struct generic_pm_domain *genpd,
+					unsigned int subclass)
+	__acquires(&genpd->mlock)
+{
+	if (subclass > 0)
+		mutex_lock_nested(&genpd->mlock, subclass);
+	else
+		mutex_lock(&genpd->mlock);
+	return 0;
+}
+
+static inline int genpd_lock_interruptible_irq(struct generic_pm_domain *genpd)
+	__acquires(&genpd->mlock)
+{
+	return mutex_lock_interruptible(&genpd->mlock);
+}
+
+static inline void genpd_unlock_irq(struct generic_pm_domain *genpd)
+	__releases(&genpd->mlock)
+{
+	mutex_unlock(&genpd->mlock);
+}
+
+static inline int genpd_lock(struct generic_pm_domain *genpd)
+{
+	return genpd->irq_safe ? genpd_lock_nosleep(genpd, 0)
+			: genpd_lock_irq(genpd, 0);
+}
+
+static inline int genpd_lock_nested(struct generic_pm_domain *genpd)
+{
+	return genpd->irq_safe ? genpd_lock_nosleep(genpd, SINGLE_DEPTH_NESTING)
+			: genpd_lock_irq(genpd, SINGLE_DEPTH_NESTING);
+}
+
+static inline int genpd_lock_interruptible(struct generic_pm_domain *genpd)
+{
+	return genpd->irq_safe ? genpd_lock_nosleep(genpd, 0)
+			: genpd_lock_interruptible_irq(genpd);
+}
+
+static inline void genpd_unlock(struct generic_pm_domain *genpd)
+{
+	return genpd->irq_safe ? genpd_unlock_nosleep(genpd)
+			: genpd_unlock_irq(genpd);
+}
+
+static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
+		struct generic_pm_domain *genpd)
+{
+	return dev->power.irq_safe && !genpd->irq_safe;
+}
+
 /*
  * Get the generic PM domain for a particular struct device.
  * This validates the struct device pointer, the PM domain pointer,
@@ -238,9 +312,9 @@ static int genpd_poweron(struct generic_pm_domain *genpd)
 {
 	int ret;
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	ret = __genpd_poweron(genpd);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 	return ret;
 }
 
@@ -282,9 +356,9 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 		spin_unlock_irq(&dev->power.lock);
 
 		if (!IS_ERR(genpd)) {
-			mutex_lock(&genpd->lock);
+			genpd_lock(genpd);
 			genpd->max_off_time_changed = true;
-			mutex_unlock(&genpd->lock);
+			genpd_unlock(genpd);
 		}
 
 		dev = dev->parent;
@@ -330,8 +404,17 @@ static int genpd_poweroff(struct generic_pm_domain *genpd, bool is_async)
 		if (stat > PM_QOS_FLAGS_NONE)
 			return -EBUSY;
 
-		if (!pm_runtime_suspended(pdd->dev) || pdd->dev->power.irq_safe)
+		/*
+		 * We do not want to power off the domain if the device is
+		 * not suspended or an IRQ safe device is part of this
+		 * non-IRQ safe domain.
+		 */
+		if (!pm_runtime_suspended(pdd->dev) ||
+			irq_safe_dev_in_no_sleep_domain(pdd->dev, genpd))
 			not_suspended++;
+		WARN_ONCE(irq_safe_dev_in_no_sleep_domain(pdd->dev, genpd),
+				"PM domain %s will not be powered off\n",
+				genpd->name);
 	}
 
 	if (not_suspended > 1 || (not_suspended == 1 && is_async))
@@ -381,9 +464,9 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 
 	genpd = container_of(work, struct generic_pm_domain, power_off_work);
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	genpd_poweroff(genpd, true);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 }
 
 /**
@@ -437,15 +520,18 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	}
 
 	/*
-	 * If power.irq_safe is set, this routine will be run with interrupts
-	 * off, so it can't use mutexes.
+	 * If power.irq_safe is set, this routine may be run with
+	 * IRQ disabled, so suspend only if the power domain is
+	 * irq_safe.
 	 */
-	if (dev->power.irq_safe)
+	WARN_ONCE(irq_safe_dev_in_no_sleep_domain(dev, genpd),
+			"genpd %s will not be powered off\n", genpd->name);
+	if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
 		return 0;
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	genpd_poweroff(genpd, false);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	return 0;
 }
@@ -473,15 +559,18 @@ static int pm_genpd_runtime_resume(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	/* If power.irq_safe, the PM domain is never powered off. */
-	if (dev->power.irq_safe) {
+	/*
+	 * As we dont power off a non IRQ safe domain, which holds
+	 * an IRQ safe device, we dont need to restore power to it.
+	 */
+	if (dev->power.irq_safe && !genpd->irq_safe) {
 		timed = false;
 		goto out;
 	}
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	ret = __genpd_poweron(genpd);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	if (ret)
 		return ret;
@@ -695,14 +784,14 @@ static int pm_genpd_prepare(struct device *dev)
 	if (resume_needed(dev, genpd))
 		pm_runtime_resume(dev);
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	if (genpd->prepared_count++ == 0) {
 		genpd->suspended_count = 0;
 		genpd->suspend_power_off = genpd->status == GPD_STATE_POWER_OFF;
 	}
 
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	if (genpd->suspend_power_off) {
 		pm_runtime_put_noidle(dev);
@@ -720,12 +809,12 @@ static int pm_genpd_prepare(struct device *dev)
 
 	ret = pm_generic_prepare(dev);
 	if (ret) {
-		mutex_lock(&genpd->lock);
+		genpd_lock(genpd);
 
 		if (--genpd->prepared_count == 0)
 			genpd->suspend_power_off = false;
 
-		mutex_unlock(&genpd->lock);
+		genpd_unlock(genpd);
 		pm_runtime_enable(dev);
 	}
 
@@ -1083,13 +1172,13 @@ static void pm_genpd_complete(struct device *dev)
 	if (IS_ERR(genpd))
 		return;
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	run_complete = !genpd->suspend_power_off;
 	if (--genpd->prepared_count == 0)
 		genpd->suspend_power_off = false;
 
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	if (run_complete) {
 		pm_generic_complete(dev);
@@ -1275,11 +1364,18 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
+	if (genpd->irq_safe && !dev->power.irq_safe) {
+		dev_err(dev,
+			"PM Domain %s is IRQ safe; device has to IRQ safe.\n",
+			genpd->name);
+		return -EINVAL;
+	}
+
 	gpd_data = genpd_alloc_dev_data(dev, genpd, td);
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	if (genpd->prepared_count > 0) {
 		ret = -EAGAIN;
@@ -1296,7 +1392,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1328,7 +1424,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 	gpd_data = to_gpd_data(pdd);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	if (genpd->prepared_count > 0) {
 		ret = -EAGAIN;
@@ -1343,14 +1439,14 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	list_del_init(&pdd->list_node);
 
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	genpd_free_dev_data(dev, gpd_data);
 
 	return 0;
 
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 	dev_pm_qos_add_notifier(dev, &gpd_data->nb);
 
 	return ret;
@@ -1371,12 +1467,23 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 	    || genpd == subdomain)
 		return -EINVAL;
 
+	/*
+	 * If the domain can be powered on/off in an IRQ safe
+	 * context, ensure that the subdomain can also be
+	 * powered on/off in that context.
+	 */
+	if (genpd->irq_safe && !subdomain->irq_safe) {
+		WARN("Sub-domain (%s) in an IRQ-safe domain (%s) has to be IRQ safe\n",
+				subdomain->name, genpd->name);
+		return -EINVAL;
+	}
+
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		return -ENOMEM;
 
-	mutex_lock(&genpd->lock);
-	mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
+	genpd_lock(genpd);
+	genpd_lock_nested(subdomain);
 
 	if (genpd->status == GPD_STATE_POWER_OFF
 	    &&  subdomain->status != GPD_STATE_POWER_OFF) {
@@ -1399,8 +1506,8 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 		genpd_sd_counter_inc(genpd);
 
  out:
-	mutex_unlock(&subdomain->lock);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(subdomain);
+	genpd_unlock(genpd);
 	if (ret)
 		kfree(link);
 	return ret;
@@ -1421,7 +1528,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
 		return -EINVAL;
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	if (!list_empty(&subdomain->slave_links) || subdomain->device_count) {
 		pr_warn("%s: unable to remove subdomain %s\n", genpd->name,
@@ -1434,7 +1541,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 		if (link->slave != subdomain)
 			continue;
 
-		mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
+		genpd_lock_nested(subdomain);
 
 		list_del(&link->master_node);
 		list_del(&link->slave_node);
@@ -1442,14 +1549,14 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 		if (subdomain->status != GPD_STATE_POWER_OFF)
 			genpd_sd_counter_dec(genpd);
 
-		mutex_unlock(&subdomain->lock);
+		genpd_unlock(subdomain);
 
 		ret = 0;
 		break;
 	}
 
 out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	return ret;
 }
@@ -1612,6 +1719,17 @@ static int of_genpd_device_parse_states(struct device_node *np,
 	return err;
 }
 
+static void genpd_lock_init(struct generic_pm_domain *genpd)
+{
+	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
+		spin_lock_init(&genpd->slock);
+		genpd->irq_safe = true;
+	} else {
+		mutex_init(&genpd->mlock);
+		genpd->irq_safe = false;
+	}
+}
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1636,7 +1754,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
-	mutex_init(&genpd->lock);
+	genpd_lock_init(genpd);
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
@@ -2100,7 +2218,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 	struct gpd_link *link;
 	int ret;
 
-	ret = mutex_lock_interruptible(&genpd->lock);
+	ret = genpd_lock_interruptible(genpd);
 	if (ret)
 		return -ERESTARTSYS;
 
@@ -2124,7 +2242,8 @@ static int pm_genpd_summary_one(struct seq_file *s,
 	}
 
 	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
-		kobj_path = kobject_get_path(&pm_data->dev->kobj, GFP_KERNEL);
+		kobj_path = kobject_get_path(&pm_data->dev->kobj,
+				genpd->irq_safe ? GFP_ATOMIC : GFP_KERNEL);
 		if (kobj_path == NULL)
 			continue;
 
@@ -2135,7 +2254,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 
 	seq_puts(s, "\n");
 exit:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	return 0;
 }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index fed024a..f1329ea 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -15,9 +15,11 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/notifier.h>
+#include <linux/spinlock.h>
 
 /* Defines used for the flags field in the struct generic_pm_domain */
 #define GENPD_FLAG_PM_CLK	(1U << 0) /* PM domain uses PM clk */
+#define GENPD_FLAG_IRQ_SAFE	(1U << 1) /* PM domain operates in atomic */
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
@@ -51,7 +53,6 @@ struct generic_pm_domain {
 	struct list_head master_links;	/* Links with PM domain as a master */
 	struct list_head slave_links;	/* Links with PM domain as a slave */
 	struct list_head dev_list;	/* List of devices */
-	struct mutex lock;
 	struct dev_power_governor *gov;
 	struct work_struct power_off_work;
 	const char *name;
@@ -75,7 +76,14 @@ struct generic_pm_domain {
 	struct genpd_power_state *states;
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
-
+	bool irq_safe;
+	union {
+		struct mutex mlock;
+		struct {
+			spinlock_t slock;
+			unsigned long lock_flags;
+		};
+	};
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
-- 
2.1.4
