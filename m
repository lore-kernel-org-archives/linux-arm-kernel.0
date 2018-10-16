From: javierm@redhat.com (Javier Martinez Canillas)
Date: Tue, 16 Oct 2018 11:47:05 +0200
Subject: [PATCH 2/3] driver core: add deferring probe reason to
 devices_deferred property
In-Reply-To: <20181016072244.1216-3-a.hajda@samsung.com>
References: <20181016072244.1216-1-a.hajda@samsung.com>
 <CGME20181016072249eucas1p28855602564eb74a771fe521712962680@eucas1p2.samsung.com>
 <20181016072244.1216-3-a.hajda@samsung.com>
Message-ID: <ee6a3c34-e0f7-e7f8-b904-b738948f22bb@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2018 09:22 AM, Andrzej Hajda wrote:
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is probe_err function introduced recently,
> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
> will be attached to deferred device and printed when user read devices_deferred
> property.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/base/base.h |  3 +++
>  drivers/base/core.c | 15 +++++++++------
>  drivers/base/dd.c   | 34 +++++++++++++++++++++++++++++++++-
>  3 files changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 7a419a7a6235..6f9371bfe40b 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -75,6 +75,7 @@ struct device_private {
>  	struct klist_node knode_driver;
>  	struct klist_node knode_bus;
>  	struct list_head deferred_probe;
> +	char *deferred_probe_msg;
>  	struct device *device;
>  };
>  #define to_device_private_parent(obj)	\
> @@ -113,6 +114,8 @@ extern void device_release_driver_internal(struct device *dev,
>  extern void driver_detach(struct device_driver *drv);
>  extern int driver_probe_device(struct device_driver *drv, struct device *dev);
>  extern void driver_deferred_probe_del(struct device *dev);
> +extern void __deferred_probe_set_msg(const struct device *dev, const char *fmt,
> +				     va_list args);
>  static inline int driver_match_device(struct device_driver *drv,
>  				      struct device *dev)
>  {
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 23fabefb217a..df9895adf11b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3076,6 +3076,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>   *
>   * This helper implements common pattern present in probe functions for error
>   * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * In case of -EPROBE_DEFER it sets defer probe reason.
>   * It replaces code sequence:
>   * 	if (err != -EPROBE_DEFER)
>   * 		dev_err(dev, ...);
> @@ -3091,15 +3092,17 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
>  	struct va_format vaf;
>  	va_list args;
>  
> -	if (err != -EPROBE_DEFER) {
> -		va_start(args, fmt);
> +	va_start(args, fmt);
>  
> -		vaf.fmt = fmt;
> -		vaf.va = &args;
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
>  
> +	if (err != -EPROBE_DEFER)
>  		__dev_printk(KERN_ERR, dev, &vaf);
> -		va_end(args);
> -	}
> +	else
> +		__deferred_probe_set_msg(dev, fmt, args);
> +
> +	va_end(args);
>  
>  	return err;
>  }
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 169412ee4ae8..e2f81e538d4b 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -27,6 +27,7 @@
>  #include <linux/async.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/devinfo.h>
> +#include <linux/slab.h>
>  
>  #include "base.h"
>  #include "power/power.h"
> @@ -132,6 +133,8 @@ void driver_deferred_probe_del(struct device *dev)
>  	if (!list_empty(&dev->p->deferred_probe)) {
>  		dev_dbg(dev, "Removed from deferred list\n");
>  		list_del_init(&dev->p->deferred_probe);
> +		kfree(dev->p->deferred_probe_msg);
> +		dev->p->deferred_probe_msg = NULL;
>  	}
>  	mutex_unlock(&deferred_probe_mutex);
>  }
> @@ -202,6 +205,32 @@ void device_unblock_probing(void)
>  	driver_deferred_probe_trigger();
>  }
>  
> +/*
> + * __deferred_probe_set_msg() - Set defer probe reason message for device
> + */
> +void __deferred_probe_set_msg(const struct device *dev, const char *fmt,
> +				     va_list args)
> +{
> +	const int size = 128;
> +	char **p;
> +	int n;
> +
> +	mutex_lock(&deferred_probe_mutex);
> +
> +	p = &dev->p->deferred_probe_msg;
> +	if (!*p) {
> +		*p = kmalloc(size, GFP_KERNEL);
> +		if (!*p)
> +			goto end;
> +	}
> +	n = snprintf(*p, size, "%s %s: ", dev_driver_string(dev), dev_name(dev));
> +	if (n < size)
> +		vsnprintf(*p + n, size - n, fmt, args);

I wonder if the vsnprintf() return value should be checked and print a warning
if the message was truncated. Probably 128 is enough for most error messages?

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
 
Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
