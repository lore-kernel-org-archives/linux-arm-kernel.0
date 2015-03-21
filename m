From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 21 Mar 2015 02:00:24 +0100
Subject: [PATCH v3] driver core / PM: Add PM domain callbacks for device
 setup/cleanup
In-Reply-To: <3289026.ADmXXipokh@vostro.rjw.lan>
References: <3533423.QQDErEmeTO@vostro.rjw.lan>
 <1654636.FxBHsexDm1@vostro.rjw.lan> <3289026.ADmXXipokh@vostro.rjw.lan>
Message-ID: <1945120.Dj0Xbsak18@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, March 20, 2015 01:59:27 PM Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If PM domains are in use, it may be necessary to prepare the code
> handling a PM domain for driver probing.  For example, in some
> cases device drivers rely on the ability to power on the devices
> with the help of the IO runtime PM framework and the PM domain
> code needs to be ready for that.  Also, if that code has not been
> fully initialized yet, the driver probing should be deferred.
> 
> Moreover, after the probing is complete, it may be necessary to
> put the PM domain in question into the state reflecting the current
> needs of the devices in it, for example, so that power is not drawn
> in vain.  The same should be done after removing a driver from
> a device, as the PM domain state may need to be changed to reflect
> the new situation.
> 
> For these reasons, introduce new PM domain callbacks, ->activate,
> ->sync and ->dismiss called, respectively, before probing for a
> device driver, after the probing has completed successfully and
> if the probing has failed or the driver has been removed.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> One more update taking Dmitry's comments into account and fixing an
> overoptimization bug spotted by Ulf.
> 
> And this actually contains the patch this time (clicked on "Send" too
> early last time, sorry about that).

Hi Greg,

Since everybody seems to like this one, do you have any objectctions against it?

If not, would it be a problem if I queued it up for 4.1?

Rafael


> ---
>  drivers/base/dd.c  |   14 ++++++++++++++
>  include/linux/pm.h |    8 ++++++++
>  2 files changed, 22 insertions(+)
> 
> Index: linux-pm/include/linux/pm.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm.h
> +++ linux-pm/include/linux/pm.h
> @@ -603,10 +603,18 @@ extern void dev_pm_put_subsys_data(struc
>   * Power domains provide callbacks that are executed during system suspend,
>   * hibernation, system resume and during runtime PM transitions along with
>   * subsystem-level and driver-level callbacks.
> + *
> + * @detach: Called when removing a device from the domain.
> + * @activate: Called before executing probe routines for bus types and drivers.
> + * @sync: Called after successful driver probe.
> + * @dismiss: Called after unsuccessful driver probe and after driver removal.
>   */
>  struct dev_pm_domain {
>  	struct dev_pm_ops	ops;
>  	void (*detach)(struct device *dev, bool power_off);
> +	int (*activate)(struct device *dev);
> +	void (*sync)(struct device *dev);
> +	void (*dismiss)(struct device *dev);
>  };
>  
>  /*
> Index: linux-pm/drivers/base/dd.c
> ===================================================================
> --- linux-pm.orig/drivers/base/dd.c
> +++ linux-pm/drivers/base/dd.c
> @@ -298,6 +298,12 @@ static int really_probe(struct device *d
>  		goto probe_failed;
>  	}
>  
> +	if (dev->pm_domain && dev->pm_domain->activate) {
> +		ret = dev->pm_domain->activate(dev);
> +		if (ret)
> +			goto probe_failed;
> +	}
> +
>  	if (dev->bus->probe) {
>  		ret = dev->bus->probe(dev);
>  		if (ret)
> @@ -308,6 +314,9 @@ static int really_probe(struct device *d
>  			goto probe_failed;
>  	}
>  
> +	if (dev->pm_domain && dev->pm_domain->sync)
> +		dev->pm_domain->sync(dev);
> +
>  	driver_bound(dev);
>  	ret = 1;
>  	pr_debug("bus: '%s': %s: bound device %s to driver %s\n",
> @@ -319,6 +328,8 @@ probe_failed:
>  	driver_sysfs_remove(dev);
>  	dev->driver = NULL;
>  	dev_set_drvdata(dev, NULL);
> +	if (dev->pm_domain && dev->pm_domain->dismiss)
> +		dev->pm_domain->dismiss(dev);
>  
>  	if (ret == -EPROBE_DEFER) {
>  		/* Driver requested deferred probing */
> @@ -525,6 +536,9 @@ static void __device_release_driver(stru
>  		devres_release_all(dev);
>  		dev->driver = NULL;
>  		dev_set_drvdata(dev, NULL);
> +		if (dev->pm_domain && dev->pm_domain->dismiss)
> +			dev->pm_domain->dismiss(dev);
> +
>  		klist_remove(&dev->p->knode_driver);
>  		if (dev->bus)
>  			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
