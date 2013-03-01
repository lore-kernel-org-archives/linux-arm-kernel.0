From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 01 Mar 2013 13:00:56 -0700
Subject: [PATCH v4 2/8] reset: Add reset controller API
In-Reply-To: <1361878774-6382-3-git-send-email-p.zabel@pengutronix.de>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
 <1361878774-6382-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <513108F8.30902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2013 04:39 AM, Philipp Zabel wrote:
> This adds a simple API for devices to request being reset
> by separate reset controller hardware and implements the
> reset signal device tree binding.

> diff --git a/drivers/reset/core.c b/drivers/reset/core.c

> +int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
> +			  const struct of_phandle_args *reset_spec, u32 *flags)
> +{
> +	if (WARN_ON(reset_spec->args_count < rcdev->of_reset_n_cells))
> +		return -EINVAL;

Would != make more sense than < ?

> +
> +	if (reset_spec->args[0] >= rcdev->nr_resets)
> +		return -EINVAL;
> +
> +	if (flags)
> +		*flags = reset_spec->args[1];

if (flags)
    if (reset_spec->args_count > 1)
        *flags = reset_spec->args[1];
    else
        *flags = 0;

?

> +struct reset_control *reset_control_get(struct device *dev, const char *id)
...
> +	mutex_lock(&reset_controller_list_mutex);
> +	rcdev = NULL;
> +	list_for_each_entry(r, &reset_controller_list, list) {
> +		if (args.np == r->of_node) {
> +			rcdev = r;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&reset_controller_list_mutex);

At this point, rcdev could be removed from that list, and perhaps even
start to point at free'd memory.

> +	of_node_put(args.np);
> +
> +	if (!rcdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	rstc_id = rcdev->of_xlate(rcdev, &args, NULL);
> +	if (rstc_id < 0)
> +		return ERR_PTR(rstc_id);
> +
> +	try_module_get(rcdev->owner);

What about error-handling here?

I think you want to drop reset_controller_list_mutex only after the call
to try_module_get()?

> +static int devm_reset_control_match(struct device *dev, void *res, void *data)
> +{
> +	struct reset_control **rstc = res;
> +	if (!rstc || !*rstc) {
> +		WARN_ON(!rstc || !*rstc);

I think you can if (WARN_ON(...)).

I'm not sure if the error-checks are quite right though;
reset_control_get always returns an error-pointer for errors, never
NULL, so the pointer can't ever be NULL. If it somehow was (e.g. client
usage error), then that NULL pointer would never match anything, so the
error-check still wouldn't be useful.

I'm not sure why this is a ** here; below in devm_reset_control_put()
you pass a just a *; are you expected to pass &rstc there instead?

> +void devm_reset_control_put(struct reset_control *rstc)
> +{
> +	int ret;
> +
> +	ret = devres_release(rstc->dev, devm_reset_control_release,
> +			     devm_reset_control_match, rstc);
> +	if (ret)
> +		WARN_ON(ret);
> +}
> +EXPORT_SYMBOL_GPL(devm_reset_control_put);
