From: peda@axentia.se (Peter Rosin)
Date: Mon, 17 Jul 2017 10:20:14 +0200
Subject: [PATCH v2 1/3] mux: Add mux_control_get_optional() API
In-Reply-To: <20170714214005.14967-2-stephen.boyd@linaro.org>
References: <20170714214005.14967-1-stephen.boyd@linaro.org>
 <20170714214005.14967-2-stephen.boyd@linaro.org>
Message-ID: <aac61f46-f963-2631-00e0-2d62baac6bf4@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generally looks like I imagined, but there are a few nits and some
things that I'd like to do differently. Comments inline. Thanks!

On 2017-07-14 23:40, Stephen Boyd wrote:
> Sometimes drivers only use muxes under certain scenarios. For
> example, the chipidea usb controller may be connected to a usb
> switch on some platforms, and connected directly to a usb port on
> others. The driver won't know one way or the other though, so add
> a mux_control_get_optional() API that allows the driver to
> differentiate errors getting the mux from there not being a mux
> for the driver to use at all.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  Documentation/driver-model/devres.txt |  1 +
>  drivers/mux/mux-core.c                | 98 ++++++++++++++++++++++++++++-------
>  include/linux/mux/consumer.h          |  4 ++
>  3 files changed, 83 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index 30e04f7a690d..4fdd3e63ff8b 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -342,6 +342,7 @@ MUX
>    devm_mux_chip_alloc()
>    devm_mux_chip_register()
>    devm_mux_control_get()
> +  devm_mux_control_get_optional()
>  
>  PER-CPU MEM
>    devm_alloc_percpu()
> diff --git a/drivers/mux/mux-core.c b/drivers/mux/mux-core.c
> index 90b8995f07cb..a0e5bf16f02f 100644
> --- a/drivers/mux/mux-core.c
> +++ b/drivers/mux/mux-core.c
> @@ -289,6 +289,9 @@ EXPORT_SYMBOL_GPL(devm_mux_chip_register);
>   */
>  unsigned int mux_control_states(struct mux_control *mux)
>  {
> +	if (!mux)
> +		return 0;
> +

I don't think this is appropriate. For this function, it might be ok,
but...

>  	return mux->states;
>  }
>  EXPORT_SYMBOL_GPL(mux_control_states);
> @@ -338,6 +341,9 @@ int mux_control_select(struct mux_control *mux, unsigned int state)
>  {
>  	int ret;
>  
> +	if (!mux)
> +		return 0;
> +

...here and for other cases below it's very odd to return "ok", when
-EINVAL or something seems much more appropriate. And if -EINVAL is
returned here, the benefit of returning fake values for anything
pretty much falls apart.

I simply don't like it, and prefer if the consumer code is arranged
to not call the mux functions when the optional get() does not find
the mux.

>  	ret = down_killable(&mux->lock);
>  	if (ret < 0)
>  		return ret;
> @@ -370,6 +376,9 @@ int mux_control_try_select(struct mux_control *mux, unsigned int state)
>  {
>  	int ret;
>  
> +	if (!mux)
> +		return 0;
> +
>  	if (down_trylock(&mux->lock))
>  		return -EBUSY;
>  
> @@ -398,6 +407,9 @@ int mux_control_deselect(struct mux_control *mux)
>  {
>  	int ret = 0;
>  
> +	if (!mux)
> +		return 0;
> +
>  	if (mux->idle_state != MUX_IDLE_AS_IS &&
>  	    mux->idle_state != mux->cached_state)
>  		ret = mux_control_set(mux, mux->idle_state);
> @@ -422,14 +434,8 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
>  	return dev ? to_mux_chip(dev) : NULL;
>  }
>  
> -/**
> - * mux_control_get() - Get the mux-control for a device.
> - * @dev: The device that needs a mux-control.
> - * @mux_name: The name identifying the mux-control.
> - *
> - * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
> - */
> -struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
> +struct mux_control *
> +__mux_control_get(struct device *dev, const char *mux_name, bool optional)
>  {
>  	struct device_node *np = dev->of_node;
>  	struct of_phandle_args args;
> @@ -441,6 +447,8 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>  	if (mux_name) {
>  		index = of_property_match_string(np, "mux-control-names",
>  						 mux_name);
> +		if (index == -EINVAL && optional)
> +			return NULL;

What about -ENODATA? And if an optional mux is found here, but lookup
fails later in e.g. the of_parse_phandle_with_args call, then I think
an error should be returned. Because that seems like an indication that
DT specifies that there *should* be a mux, but then there isn't one.

>  		if (index < 0) {
>  			dev_err(dev, "mux controller '%s' not found\n",
>  				mux_name);
> @@ -451,6 +459,8 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>  	ret = of_parse_phandle_with_args(np,
>  					 "mux-controls", "#mux-control-cells",
>  					 index, &args);
> +	if (ret == -ENOENT && optional)
> +		return NULL;
>  	if (ret) {
>  		dev_err(dev, "%s: failed to get mux-control %s(%i)\n",
>  			np->full_name, mux_name ?: "", index);
> @@ -482,9 +492,35 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>  	get_device(&mux_chip->dev);
>  	return &mux_chip->mux[controller];
>  }
> +
> +/**
> + * mux_control_get() - Get the mux-control for a device.
> + * @dev: The device that needs a mux-control.
> + * @mux_name: The name identifying the mux-control.
> + *
> + * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
> + */
> +struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
> +{
> +	return __mux_control_get(dev, mux_name, false);
> +}
>  EXPORT_SYMBOL_GPL(mux_control_get);
>  
>  /**
> + * mux_control_get_optional() - Get the optional mux-control for a device.
> + * @dev: The device that needs a mux-control.
> + * @mux_name: The name identifying the mux-control.
> + *
> + * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.

You don't mention that NULL may be returned, or when.

> + */
> +struct mux_control *
> +mux_control_get_optional(struct device *dev, const char *mux_name)
> +{
> +	return __mux_control_get(dev, mux_name, true);
> +}
> +EXPORT_SYMBOL_GPL(mux_control_get_optional);
> +
> +/**
>   * mux_control_put() - Put away the mux-control for good.
>   * @mux: The mux-control to put away.
>   *
> @@ -492,7 +528,8 @@ EXPORT_SYMBOL_GPL(mux_control_get);
>   */
>  void mux_control_put(struct mux_control *mux)
>  {
> -	put_device(&mux->chip->dev);
> +	if (mux)
> +		put_device(&mux->chip->dev);

Don't put it if you don't have it.

>  }
>  EXPORT_SYMBOL_GPL(mux_control_put);
>  
> @@ -503,16 +540,8 @@ static void devm_mux_control_release(struct device *dev, void *res)
>  	mux_control_put(mux);
>  }
>  
> -/**
> - * devm_mux_control_get() - Get the mux-control for a device, with resource
> - *			    management.
> - * @dev: The device that needs a mux-control.
> - * @mux_name: The name identifying the mux-control.
> - *
> - * Return: Pointer to the mux-control, or an ERR_PTR with a negative errno.
> - */
> -struct mux_control *devm_mux_control_get(struct device *dev,
> -					 const char *mux_name)
> +static struct mux_control *
> +__devm_mux_control_get(struct device *dev, const char *mux_name, bool optional)
>  {
>  	struct mux_control **ptr, *mux;
>  
> @@ -520,7 +549,7 @@ struct mux_control *devm_mux_control_get(struct device *dev,
>  	if (!ptr)
>  		return ERR_PTR(-ENOMEM);
>  
> -	mux = mux_control_get(dev, mux_name);
> +	mux = __mux_control_get(dev, mux_name, optional);
>  	if (IS_ERR(mux)) {
>  		devres_free(ptr);
>  		return mux;
> @@ -531,8 +560,37 @@ struct mux_control *devm_mux_control_get(struct device *dev,
>  
>  	return mux;
>  }
> +
> +/**
> + * devm_mux_control_get() - Get the mux-control for a device, with resource
> + *			    management.
> + * @dev: The device that needs a mux-control.
> + * @mux_name: The name identifying the mux-control.
> + *
> + * Return: Pointer to the mux-control, or an ERR_PTR with a negative errno.
> + */
> +struct mux_control *
> +devm_mux_control_get(struct device *dev, const char *mux_name)
> +{
> +	return __devm_mux_control_get(dev, mux_name, false);
> +}
>  EXPORT_SYMBOL_GPL(devm_mux_control_get);
>  
> +/**
> + * devm_mux_control_get_optional() - Get the optional mux-control for a device,
> + * 				     with resource management.
> + * @dev: The device that needs a mux-control.
> + * @mux_name: The name identifying the mux-control.
> + *
> + * Return: Pointer to the mux-control, or an ERR_PTR with a negative errno.

You don't mention that NULL may be returned, or when.

Cheers,
Peter

> + */
> +struct mux_control *
> +devm_mux_control_get_optional(struct device *dev, const char *mux_name)
> +{
> +	return __devm_mux_control_get(dev, mux_name, true);
> +}
> +EXPORT_SYMBOL_GPL(devm_mux_control_get_optional);
> +
>  /*
>   * Using subsys_initcall instead of module_init here to try to ensure - for
>   * the non-modular case - that the subsystem is initialized when mux consumers
> diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
> index 5577e1b773c4..5e2aa046f032 100644
> --- a/include/linux/mux/consumer.h
> +++ b/include/linux/mux/consumer.h
> @@ -24,9 +24,13 @@ int __must_check mux_control_try_select(struct mux_control *mux,
>  int mux_control_deselect(struct mux_control *mux);
>  
>  struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
> +struct mux_control *mux_control_get_optional(struct device *dev,
> +					     const char *mux_name);
>  void mux_control_put(struct mux_control *mux);
>  
>  struct mux_control *devm_mux_control_get(struct device *dev,
>  					 const char *mux_name);
> +struct mux_control *devm_mux_control_get_optional(struct device *dev,
> +						  const char *mux_name);
>  
>  #endif /* _LINUX_MUX_CONSUMER_H */
> 
