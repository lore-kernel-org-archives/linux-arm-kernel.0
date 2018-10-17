From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 17 Oct 2018 14:35:00 +0300
Subject: [PATCH v2 2/3] driver core: add deferring probe reason to
 devices_deferred property
In-Reply-To: <20181017085936.30886-1-a.hajda@samsung.com>
References: <CGME20181017085952eucas1p2ff93b96d300aab2dc70b97bf266978ab@eucas1p2.samsung.com>
 <CAHp75VefP2qit3=s9E_uuOg4+J0Zk2OD-XjpVsWM7X3s2g-0wA@mail.gmail.com>
 <20181017085936.30886-1-a.hajda@samsung.com>
Message-ID: <CAHp75Vd2c3sHz=ZObsNAyEmOK-=__2=y-soDM5DqNUyLLK8jdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 11:59 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is probe_err function introduced recently,
> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
> will be attached to deferred device and printed when user read devices_deferred
> property.
>

Looks good to me (with one comment below since patch 1 will be changed anyway),
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> v2:
>   - changed __deferred_probe_set_msg args - like in __dev_printk, fits better,
>   - use kasprintf instead of bunch of code,
>   - keep consistent format of devices_deferred lines,
>   - added R-Bs (again I hope changes above are not against it).
> ---
>  drivers/base/base.h |  3 +++
>  drivers/base/core.c | 11 +++++++----
>  drivers/base/dd.c   | 21 ++++++++++++++++++++-
>  3 files changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 7a419a7a6235..effbd5e7f9f1 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -75,6 +75,7 @@ struct device_private {
>         struct klist_node knode_driver;
>         struct klist_node knode_bus;
>         struct list_head deferred_probe;
> +       char *deferred_probe_msg;
>         struct device *device;
>  };
>  #define to_device_private_parent(obj)  \
> @@ -113,6 +114,8 @@ extern void device_release_driver_internal(struct device *dev,
>  extern void driver_detach(struct device_driver *drv);
>  extern int driver_probe_device(struct device_driver *drv, struct device *dev);
>  extern void driver_deferred_probe_del(struct device *dev);
> +extern void __deferred_probe_set_msg(const struct device *dev,
> +                                    struct va_format *vaf);
>  static inline int driver_match_device(struct device_driver *drv,
>                                       struct device *dev)
>  {
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index aa6f3229d066..560758b2ae79 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3076,6 +3076,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>   *
>   * This helper implements common pattern present in probe functions for error
>   * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * In case of -EPROBE_DEFER it sets defer probe reason.
>   * It replaces code sequence:
>   *     if (err != -EPROBE_DEFER)
>   *             dev_err(dev, ...);
> @@ -3091,13 +3092,15 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
>         struct va_format vaf;
>         va_list args;
>
> -       if (err == -EPROBE_DEFER)
> -               return err;
> -
>         va_start(args, fmt);
>         vaf.fmt = fmt;
>         vaf.va = &args;

> -       dev_err(dev, "%pV, %d\n", &vaf, err);
> +

This new line can be part of patch 1.

> +       if (err != -EPROBE_DEFER)
> +               dev_err(dev, "%pV, %d\n", &vaf, err);
> +       else
> +               __deferred_probe_set_msg(dev, &vaf);
> +

Here you may still keep the same, i.e. positive, conditional.

>         va_end(args);
>
>         return err;
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 169412ee4ae8..345fbfe335d1 100644
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
>         if (!list_empty(&dev->p->deferred_probe)) {
>                 dev_dbg(dev, "Removed from deferred list\n");
>                 list_del_init(&dev->p->deferred_probe);
> +               kfree(dev->p->deferred_probe_msg);
> +               dev->p->deferred_probe_msg = NULL;
>         }
>         mutex_unlock(&deferred_probe_mutex);
>  }
> @@ -202,6 +205,21 @@ void device_unblock_probing(void)
>         driver_deferred_probe_trigger();
>  }
>
> +/*
> + * __deferred_probe_set_msg() - Set defer probe reason message for device
> + */
> +void __deferred_probe_set_msg(const struct device *dev, struct va_format *vaf)
> +{
> +       mutex_lock(&deferred_probe_mutex);
> +
> +       if (dev->p->deferred_probe_msg)
> +               kfree(dev->p->deferred_probe_msg);
> +       dev->p->deferred_probe_msg = kasprintf(GFP_KERNEL, "%s: %pV",
> +                                              dev_driver_string(dev), vaf);
> +
> +       mutex_unlock(&deferred_probe_mutex);
> +}
> +
>  /*
>   * deferred_devs_show() - Show the devices in the deferred probe pending list.
>   */
> @@ -212,7 +230,8 @@ static int deferred_devs_show(struct seq_file *s, void *data)
>         mutex_lock(&deferred_probe_mutex);
>
>         list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
> -               seq_printf(s, "%s\n", dev_name(curr->device));
> +               seq_printf(s, "%s\t%s\n", dev_name(curr->device),
> +                          curr->device->p->deferred_probe_msg ?: "");
>
>         mutex_unlock(&deferred_probe_mutex);
>
> --
> 2.18.0
>


-- 
With Best Regards,
Andy Shevchenko
