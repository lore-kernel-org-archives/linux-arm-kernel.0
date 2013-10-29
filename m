From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 29 Oct 2013 16:21:28 +0100
Subject: [PATCH v3 02/10] spmi: Linux driver framework for SPMI
In-Reply-To: <149bbfe89e37376cc176c3aeb6c1fab9e4fd2b91.1382985169.git.joshc@codeaurora.org>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <149bbfe89e37376cc176c3aeb6c1fab9e4fd2b91.1382985169.git.joshc@codeaurora.org>
Message-ID: <526FD278.8080102@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Couple of high-level comments on the in-kernel API.

On 10/28/2013 07:12 PM, Josh Cartwright wrote:
> +#ifdef CONFIG_PM_SLEEP
> +static int spmi_pm_suspend(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm)
> +		return pm_generic_suspend(dev);

pm_generic_suspend() checks both dev->driver and dev->driver->pm and returns
0 if either of them is NULL, so there should be no need to wrap the function.

> +	else
> +		return 0;
> +}
> +
> +static int spmi_pm_resume(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm)
> +		return pm_generic_resume(dev);

Same here

> +	else
> +		return 0;
> +}
> +#else
> +#define spmi_pm_suspend		NULL
> +#define spmi_pm_resume		NULL
> +#endif
[...]
> +/**
> + * spmi_controller_remove: Controller tear-down.
> + * @ctrl: controller to be removed.
> + *
> + * Controller added with the above API is torn down using this API.
> + */
> +int spmi_controller_remove(struct spmi_controller *ctrl)

The return type should be void. The function can't fail and nobody is going
to check the return value anyway.

> +{
> +	int dummy;
> +
> +	if (!ctrl)
> +		return -EINVAL;
> +
> +	dummy = device_for_each_child(&ctrl->dev, NULL,
> +				      spmi_ctrl_remove_device);
> +	device_unregister(&ctrl->dev);

Should be device_del(). device_unregister() will do both device_del() and
put_device(). But usually you'd want to do something in between like release
resources used by the controller.

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(spmi_controller_remove);
> +
[...]
> +/**
> + * spmi_controller_alloc: Allocate a new SPMI controller
> + * @ctrl: associated controller
> + *
> + * Caller is responsible for either calling spmi_device_add() to add the
> + * newly allocated controller, or calling spmi_device_put() to discard it.
> + */
> +struct spmi_device *spmi_device_alloc(struct spmi_controller *ctrl);
> +
> +static inline void spmi_device_put(struct spmi_device *sdev)

For symmetry reasons it might make sense to call this spmi_device_free().

> +{
> +	if (sdev)
> +		put_device(&sdev->dev);
> +}
[...]
> +#define to_spmi_controller(d) container_of(d, struct spmi_controller, dev)

Should be a inline function for better type safety.

[...]
> +static inline void spmi_controller_put(struct spmi_controller *ctrl)

For symmetry reasons it might make sense to call this spmi_controller_free().

> +{
> +	if (ctrl)
> +		put_device(&ctrl->dev);
> +}
> +
[....]
> +struct spmi_driver {
> +	struct device_driver driver;
> +	int	(*probe)(struct spmi_device *sdev);
> +	int	(*remove)(struct spmi_device *sdev);

The type of the remove function should be found. The Linux device model
doesn't really allow for device removal to fail.

> +	void	(*shutdown)(struct spmi_device *sdev);
> +	int	(*suspend)(struct spmi_device *sdev, pm_message_t pmesg);
> +	int	(*resume)(struct spmi_device *sdev);

The framework seems to support dev_pm_ops just fine, there should be no need
for legacy suspend/resume callbacks.

> +};
> +#define to_spmi_driver(d) container_of(d, struct spmi_driver, driver)

Inline function here as well
[...]
