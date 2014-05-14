From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 14 May 2014 11:27:54 +0100
Subject: [PATCH] of: Add of_device_destroy_children() function
In-Reply-To: <1399567069-3174-1-git-send-email-s.nawrocki@samsung.com>
References: <1399567069-3174-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140514102754.BC60BC4153D@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 08 May 2014 18:37:49 +0200, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
> This patch adds a helper function to unregister devices which
> were created by an of_platform_populate() call. The pattern
> used here can already be found in multiple drivers. This helper
> can now be used instead of repeating similar code in drivers.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---

Pawel has also submitted a patch for this. That patch is a little more
careful about how it removes nodes, so I'll be going with that one.

g.

> 
> This patch has been tested on ARM only (on Exynos4412 Trats2 board).
> 
>  drivers/of/device.c       |   24 ++++++++++++++++++++++++
>  include/linux/of_device.h |    3 +++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index dafb973..9303197 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -190,3 +190,27 @@ int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
> 
>  	return 0;
>  }
> +
> +static int __remove_child_device(struct device *dev, void *unused)
> +{
> +	if (of_match_node(of_default_bus_match_table, dev->of_node))
> +		of_device_destroy_children(dev);
> +
> +	device_unregister(dev);
> +	return 0;
> +}
> +
> +/**
> + * of_device_destroy_children - unregister @parent's child devices
> + * @parent: the parent device to start with
> + *
> + * Destroy all child devices of the @parent device, any grandchildren
> + * compatible with values listed in the of_default_bus_match_table will
> + * also be unregistered recursively.  This function can be used to
> + * destroy devices created by an of_platform_populate() call.
> + */
> +void of_device_destroy_children(struct device *parent)
> +{
> +	device_for_each_child(parent, NULL, __remove_child_device);
> +}
> +EXPORT_SYMBOL(of_device_destroy_children);
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index ef37021..0c41e0b 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -32,6 +32,7 @@ extern void of_dev_put(struct platform_device *dev);
>  extern int of_device_add(struct platform_device *pdev);
>  extern int of_device_register(struct platform_device *ofdev);
>  extern void of_device_unregister(struct platform_device *ofdev);
> +extern void of_device_destroy_children(struct device *parent);
> 
>  extern ssize_t of_device_get_modalias(struct device *dev,
>  					char *str, ssize_t len);
> @@ -64,6 +65,8 @@ static inline int of_driver_match_device(struct device *dev,
>  static inline void of_device_uevent(struct device *dev,
>  			struct kobj_uevent_env *env) { }
> 
> +static inline void of_device_destroy_children(struct device *parent) { }
> +
>  static inline int of_device_get_modalias(struct device *dev,
>  				   char *str, ssize_t len)
>  {
> --
> 1.7.9.5
> 
