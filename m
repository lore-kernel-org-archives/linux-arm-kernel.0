From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 20 Jun 2018 07:51:45 +0900
Subject: [PATCH] driver core: add a debugfs entry to show deferred devices
In-Reply-To: <20180619205914.21375-1-javierm@redhat.com>
References: <20180619205914.21375-1-javierm@redhat.com>
Message-ID: <20180619225145.GA23389@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 10:59:14PM +0200, Javier Martinez Canillas wrote:
> For debugging purposes it may be useful to know what are the devices whose
> probe function was deferred. Add a debugfs entry showing that information.
> 
>   $ cat /sys/kernel/debug/deferred_devices
>   48070000.i2c:twl at 48:bci
>   musb-hdrc.0.auto
>   omapdrm.0
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> ---
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
>  drivers/base/dd.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 1435d7281c6..8ec9e3cfbe4 100644
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
> @@ -224,6 +225,24 @@ void device_unblock_probing(void)
>  	driver_deferred_probe_trigger();
>  }
>  
> +/*
> + * deferred_devs_show() - Show the devices in the deferred probe pending list.
> + */
> +static int deferred_devs_show(struct seq_file *s, void *data)
> +{
> +	struct device_private *curr;
> +
> +	mutex_lock(&deferred_probe_mutex);
> +
> +	list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
> +		seq_printf(s, "%s\n", dev_name(curr->device));
> +
> +	mutex_unlock(&deferred_probe_mutex);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(deferred_devs);
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
> @@ -233,6 +252,9 @@ void device_unblock_probing(void)
>   */
>  static int deferred_probe_initcall(void)
>  {
> +	debugfs_create_file("deferred_devices", 0444, NULL, NULL,
> +			    &deferred_devs_fops);

In the root of debugfs?

Anyway, what about "devices_deferred", to help keep things semi-sane if
we have other driver core debugfs entries?

And you don't remove the file ever?

And what is the use of this file?  What can you do with this
information?  Who is going to use it?  Don't we have other deferred
probe debugging somewhere else?

thanks,

greg k-h
