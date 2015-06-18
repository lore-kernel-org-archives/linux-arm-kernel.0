From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 18 Jun 2015 23:50:02 +0200
Subject: [PATCH 02/13] driver-core: defer all probes until late_initcall
In-Reply-To: <1434548543-22949-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1434548543-22949-3-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <2834968.DlsDAmbXkG@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 17, 2015 03:42:12 PM Tomeu Vizoso wrote:
> To decrease the chances of devices deferring their probes because of
> dependencies not having probed yet because of their drivers not having
> registered yet, delay all probing until the late initcall level.
> 
> This will allow us to avoid deferred probes completely later by probing
> dependencies on demand, or by probing them in dependency order.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/base/dd.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index a638bbb..18438aa 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -407,6 +407,12 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
>  	if (!device_is_registered(dev))
>  		return -ENODEV;
>  
> +	/* Defer all probes until we start processing the queue */
> +	if (!driver_deferred_probe_enable) {
> +		driver_deferred_probe_add(dev);

Do I think correctly that this will effectively force everybody to use deferred
probing?

> +		return 0;
> +	}
> +
>  	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
>  		 drv->bus->name, __func__, dev_name(dev), drv->name);
>  
> @@ -585,7 +591,7 @@ EXPORT_SYMBOL_GPL(device_attach);
>  
>  void device_initial_probe(struct device *dev)
>  {
> -	__device_attach(dev, true);
> +	__device_attach(dev, driver_deferred_probe_enable);
>  }
>  
>  static int __driver_attach(struct device *dev, void *data)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
