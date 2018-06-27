From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 28 Jun 2018 01:23:43 +0300
Subject: [PATCH v2] driver core: add a debugfs entry to show deferred
 devices
In-Reply-To: <20180627220656.19298-1-javierm@redhat.com>
References: <20180627220656.19298-1-javierm@redhat.com>
Message-ID: <CAHp75Vc5o54BwnQfJFXixpMD3yRTHy6UJq-m09gd1aou1B5fmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 1:06 AM, Javier Martinez Canillas
<javierm@redhat.com> wrote:
> With Device Trees (DT), the dependencies of the devices are defined in the
> DT, then the drivers parse that information to lookup the needed resources
> that have as dependencies.
>
> Since drivers and devices are registered in a non-deterministic way, it is
> possible that a device that is a dependency has not been registered yet by
> the time that is looked up.
>
> In this case the driver that requires this dependency cannot probe and has
> to defer it. So the driver core adds it to a list of deferred devices that
> is iterated again every time that a new driver is probed successfully.
>
> For debugging purposes it may be useful to know what are the devices whose
> probe function was deferred. Add a debugfs entry showing that information.
>
>   $ cat /sys/kernel/debug/devices_deferred
>   48070000.i2c:twl at 48:bci
>   musb-hdrc.0.auto
>   omapdrm.0
>
> This information could be obtained partially by enabling debugging, but it
> means that the kernel log has to be parsed and the probe deferral balanced
> with the successes. This can be error probe and has to be done in a ad-hoc
> manner by everyone who needs to debug these kind of issues.
>
> Since the information is already known by the kernel, just show it to make
> it easier to debug.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> ---
>
> Andy, I didn't carry your Reviewed-by tag because it wasn't clear to me
> if you had agreed with the patch or not from your last email.

I just had agreed on the concerns that Greg pointed out to. If it's
resolved (*),
I'm fine with the change per se. So, my tag still stays

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(*) At least I'd got the rationale behind it, though it wasn't clear
in the previous commit message.

>
> Changes since RFC v1:
> - Remove unneeded ret variable from deferred_devs_show()
>
> Changes since RFC v2:
> - Use DEFINE_SHOW_ATTRIBUTE() macro.
> - Don't propagate debugfs_create_file() error.
> - Remove IS_ENABLED(CONFIG_DEBUG_FS) guards.
> - Drop RFC prefix.
>
> Changes since v1:
> - Better explain in the commit message why this patch is useful.
> - Rename deferred_devices entry to devices_deferred.
> - Add an exit function and remove the debugfs entry.
>
>
>  drivers/base/dd.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 1435d7281c6..489c484301b 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -16,6 +16,7 @@
>   * Copyright (c) 2007-2009 Novell Inc.
>   */
>
> +#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> @@ -53,6 +54,7 @@ static DEFINE_MUTEX(deferred_probe_mutex);
>  static LIST_HEAD(deferred_probe_pending_list);
>  static LIST_HEAD(deferred_probe_active_list);
>  static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
> +static struct dentry *deferred_devices;
>  static bool initcalls_done;
>
>  /*
> @@ -224,6 +226,24 @@ void device_unblock_probing(void)
>         driver_deferred_probe_trigger();
>  }
>
> +/*
> + * deferred_devs_show() - Show the devices in the deferred probe pending list.
> + */
> +static int deferred_devs_show(struct seq_file *s, void *data)
> +{
> +       struct device_private *curr;
> +
> +       mutex_lock(&deferred_probe_mutex);
> +
> +       list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
> +               seq_printf(s, "%s\n", dev_name(curr->device));
> +
> +       mutex_unlock(&deferred_probe_mutex);
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(deferred_devs);
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
> @@ -233,6 +253,9 @@ void device_unblock_probing(void)
>   */
>  static int deferred_probe_initcall(void)
>  {
> +       deferred_devices = debugfs_create_file("devices_deferred", 0444, NULL,
> +                                              NULL, &deferred_devs_fops);
> +
>         driver_deferred_probe_enable = true;
>         driver_deferred_probe_trigger();
>         /* Sort as many dependencies as possible before exiting initcalls */
> @@ -242,6 +265,12 @@ static int deferred_probe_initcall(void)
>  }
>  late_initcall(deferred_probe_initcall);
>
> +static void __exit deferred_probe_exit(void)
> +{
> +       debugfs_remove_recursive(deferred_devices);
> +}
> +__exitcall(deferred_probe_exit);
> +
>  /**
>   * device_is_bound() - Check if device is bound to a driver
>   * @dev: device to check
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
