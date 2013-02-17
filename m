From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 17 Feb 2013 22:51:38 +0800
Subject: [PATCH v2 2/8] reset: Add reset controller API
In-Reply-To: <1360776872-18584-3-git-send-email-p.zabel@pengutronix.de>
References: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
 <1360776872-18584-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130217145136.GD6782@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 06:34:26PM +0100, Philipp Zabel wrote:
> This adds a simple API for devices to request being reset
> by separate reset controller hardware and implements the
> reset signal device tree binding.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> ---
> Changes since v1:
>  - Added missing header files.
>  - Fixed reset_controller_register comment.
>  - Added missing reset_controller_unregister.
>  - Made reset_control_reset/assert/deassert return -ENOSYS
>    if not implemented by the reset controller driver.
>  - Fixed reset_control_put to not access rstc after freeing it.
>  - Whitespace fixes
> ---
>  drivers/Kconfig                  |    2 +
>  drivers/Makefile                 |    3 +
>  drivers/reset/Kconfig            |    9 ++
>  drivers/reset/Makefile           |    1 +
>  drivers/reset/core.c             |  238 ++++++++++++++++++++++++++++++++++++++
>  include/linux/reset-controller.h |   39 +++++++
>  include/linux/reset.h            |   17 +++
>  7 files changed, 309 insertions(+)
>  create mode 100644 drivers/reset/Kconfig
>  create mode 100644 drivers/reset/Makefile
>  create mode 100644 drivers/reset/core.c
>  create mode 100644 include/linux/reset-controller.h
>  create mode 100644 include/linux/reset.h
> 
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 202fa6d..847f8e3 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -162,4 +162,6 @@ source "drivers/irqchip/Kconfig"
>  
>  source "drivers/ipack/Kconfig"
>  
> +source "drivers/reset/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 4af933d..682fb7c 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -42,6 +42,9 @@ ifndef CONFIG_ARCH_USES_GETTIMEOFFSET
>  obj-y				+= clocksource/
>  endif
>  
> +# reset controllers early, since gpu drivers might rely on them to initialize
> +obj-$(CONFIG_RESET_CONTROLLER)	+= reset/
> +
>  # tty/ comes before char/ so that the VT console is the boot-time
>  # default.
>  obj-y				+= tty/
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> new file mode 100644
> index 0000000..66ac385
> --- /dev/null
> +++ b/drivers/reset/Kconfig
> @@ -0,0 +1,9 @@
> +menuconfig RESET_CONTROLLER
> +	bool "Reset Controller Support"
> +	help
> +	  Generic Reset Controller support.
> +
> +	  This framework is designed to abstract reset handling of devices
> +	  via GPIOs or SoC-internal reset controller modules.
> +
> +	  If unsure, say no.
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> new file mode 100644
> index 0000000..1e2d83f
> --- /dev/null
> +++ b/drivers/reset/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_RESET_CONTROLLER) += core.o
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> new file mode 100644
> index 0000000..468f831
> --- /dev/null
> +++ b/drivers/reset/core.c
> @@ -0,0 +1,238 @@
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/reset.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +
> +static DEFINE_MUTEX(reset_controller_list_mutex);
> +static LIST_HEAD(reset_controller_list);
> +
> +/**
> + * struct reset_control - a reset control
> + *

I see two kerneldoc styles in the file.  Some have new lines here while
others do not.

And @rcdev is missing.

> + * @id: ID of the reset controller in the reset
> + *      controller device
> + */
> +struct reset_control {
> +	struct reset_controller_dev *rcdev;
> +	unsigned int id;
> +};
> +
> +/**
> + * reset_controller_register - register a reset controller device
> + *
> + * @rcdev: a pointer to struct reset_controller_dev
> + */
> +int reset_controller_register(struct reset_controller_dev *rcdev)
> +{
> +	mutex_lock(&reset_controller_list_mutex);
> +	list_add(&rcdev->list, &reset_controller_list);
> +	mutex_unlock(&reset_controller_list_mutex);
> +
> +	return 0;
> +}

I think we need EXPORT_SYMBOL_GPL on it, as the gpio-reset driver
added in patch #8 which supports module build will need it.

> +
> +/**
> + * reset_controller_unregister - unregister a reset controller device
> + *
> + * @rcdev: a pointer to struct reset_controller_dev
> + */
> +void reset_controller_unregister(struct reset_controller_dev *rcdev)
> +{
> +	mutex_lock(&reset_controller_list_mutex);
> +	list_del(&rcdev->list);
> +	mutex_unlock(&reset_controller_list_mutex);
> +}

Ditto

> +
> +/**
> + * reset_control_reset - reset the controlled device
> + * @rstc: reset controller
> + */
> +int reset_control_reset(struct reset_control *rstc)
> +{
> +	if (rstc->rcdev->ops->reset)
> +		return rstc->rcdev->ops->reset(rstc->rcdev, rstc->id);
> +
> +	return -ENOSYS;
> +}
> +EXPORT_SYMBOL_GPL(reset_control_reset);
> +
> +/**
> + * reset_control_assert - asserts the reset line
> + * @rstc: reset controller
> + */
> +int reset_control_assert(struct reset_control *rstc)
> +{
> +	if (rstc->rcdev->ops->assert)
> +		return rstc->rcdev->ops->assert(rstc->rcdev, rstc->id);
> +
> +	return -ENOSYS;
> +}
> +EXPORT_SYMBOL_GPL(reset_control_assert);
> +
> +/**
> + * reset_control_deassert - deasserts the reset line
> + * @rstc: reset controller
> + */
> +int reset_control_deassert(struct reset_control *rstc)
> +{
> +	if (rstc->rcdev->ops->deassert)
> +		return rstc->rcdev->ops->deassert(rstc->rcdev, rstc->id);
> +
> +	return -ENOSYS;
> +}
> +EXPORT_SYMBOL_GPL(reset_control_deassert);
> +
> +/**
> + * reset_control_get - Lookup and obtain a reference to a reset controller.
> + * @dev: device to be reset by the controller
> + * @id: reset line name
> + *
> + * Returns a struct reset_control or IS_ERR() condition containing errno.
> + *
> + * Use of id names is optional.
> + */
> +struct reset_control *reset_control_get(struct device *dev, const char *id)
> +{
> +	struct reset_control *rstc = ERR_PTR(-EPROBE_DEFER);
> +	struct reset_controller_dev *r, *rcdev;
> +	struct device_node *rcdev_node;
> +	struct of_phandle_args args;
> +	int rcdev_index;
> +	int ret;
> +	int i;
> +
> +	if (!dev)
> +		return ERR_PTR(-EINVAL);
> +
> +	rcdev_node = NULL;
> +	for (i = 0; rcdev_node == NULL; i++) {
> +		ret = of_parse_phandle_with_args(dev->of_node, "resets",
> +						 "#reset-cells", i, &args);
> +		if (ret)
> +			return ERR_PTR(ret);
> +		of_node_put(args.np);
> +		if (args.args_count <= 0)
> +			return ERR_PTR(-EINVAL);
> +
> +		if (id) {
> +			const char *reset_name;
> +			ret = of_property_read_string_index(dev->of_node,
> +							    "reset-names", i,
> +							    &reset_name);
> +			if (ret)
> +				return ERR_PTR(ret);
> +			if (strcmp(id, reset_name) != 0)
> +				continue;
> +		}
> +
> +		rcdev_index = args.args[0];
> +		rcdev_node = args.np;
> +		break;
> +	}

I feel the block could be simplified a little bit by calling
of_property_match_string(dev->of_node, "reset-names", id) to find the
index that is needed by of_parse_phandle_with_args() call. 

You might want to take a look at of_clk_get_by_name() -
drivers/clk/clkdev.c for example.

> +
> +	mutex_lock(&reset_controller_list_mutex);
> +	rcdev = NULL;
> +	list_for_each_entry(r, &reset_controller_list, list) {
> +		if (rcdev_node == r->of_node) {
> +			rcdev = r;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&reset_controller_list_mutex);
> +
> +	if (!rcdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	try_module_get(rcdev->owner);
> +
> +	rstc = kzalloc(sizeof(*rstc), GFP_KERNEL);
> +	if (!rstc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rstc->rcdev = rcdev;
> +	rstc->id = rcdev_index;
> +
> +	return rstc;
> +}
> +EXPORT_SYMBOL_GPL(reset_control_get);
> +
> +/**
> + * reset_control_put - free the reset controller
> + * @reset: reset controller

@rstc, not @reset.

> + */
> +
> +void reset_control_put(struct reset_control *rstc)
> +{
> +	if (IS_ERR(rstc))
> +		return;
> +
> +	module_put(rstc->rcdev->owner);
> +	kfree(rstc);
> +}
> +EXPORT_SYMBOL_GPL(reset_control_put);
> +
> +static void devm_reset_control_release(struct device *dev, void *res)
> +{
> +	reset_control_put(*(struct reset_control **)res);
> +}
> +
> +/**
> + * devm_reset_control_get - resource managed reset_control_get()
> + * @dev: device to be reset by the controller
> + * @id: reset line name
> + *
> + * Managed reset_control_get(). For reset controllers returned from this
> + * function, reset_control_put() is called automatically on driver detach.
> + * See reset_control_get() for more information.
> + */
> +struct reset_control *devm_reset_control_get(struct device *dev, const char *id)
> +{
> +	struct reset_control **ptr, *rstc;
> +
> +	ptr = devres_alloc(devm_reset_control_release, sizeof(*ptr),
> +			   GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rstc = reset_control_get(dev, id);
> +	if (!IS_ERR(rstc)) {
> +		*ptr = rstc;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}
> +
> +	return rstc;
> +}
> +EXPORT_SYMBOL_GPL(devm_reset_control_get);
> +
> +/**
> + * device_reset - find reset controller associated with the device
> + *                and perform reset
> + * @dev: device to be reset by the controller
> + *
> + * Convenience wrapper for reset_control_get() and reset_control_reset().
> + * This is useful for the common case of devices with single, dedicated reset
> + * lines.
> + */
> +int device_reset(struct device *dev)
> +{
> +	struct reset_control *rstc;
> +	int ret;
> +
> +	rstc = reset_control_get(dev, NULL);
> +	if (IS_ERR(rstc))
> +		return PTR_ERR(rstc);
> +
> +	ret = reset_control_reset(rstc);
> +
> +	kfree(rstc);

Shouldn't reset_control_put() be called here instead?

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(device_reset);
> diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
> new file mode 100644
> index 0000000..4d38aa3
> --- /dev/null
> +++ b/include/linux/reset-controller.h
> @@ -0,0 +1,39 @@
> +#ifndef _LINUX_RESET_CONTROLLER_H_
> +#define _LINUX_RESET_CONTROLLER_H_
> +
> +#include <linux/list.h>
> +
> +struct reset_controller_dev;
> +
> +/**
> + * struct reset_control_ops
> + *
> + * @reset: for self-deasserting resets, does all necessary
> + *         things to reset the device
> + * @assert: manually assert the reset line, if supported
> + * @deassert: manually deassert the reset line, if supported
> + */
> +struct reset_control_ops {
> +	int (*reset)(struct reset_controller_dev *rcdev, unsigned long id);
> +	int (*assert)(struct reset_controller_dev *rcdev, unsigned long id);
> +	int (*deassert)(struct reset_controller_dev *rcdev, unsigned long id);
> +};
> +
> +struct module;
> +struct device_node;
> +
> +/**
> + * struct reset_controller - reset controller entity that might

s/reset_controller/reset_controller_dev

> + *                           provide multiple reset controls

Kerneldoc of parameters are missing. 

Shawn

> + */
> +struct reset_controller_dev {
> +	struct reset_control_ops *ops;
> +	struct module *owner;
> +	struct list_head list;
> +	struct device_node *of_node;
> +};
> +
> +int reset_controller_register(struct reset_controller_dev *rcdev);
> +void reset_controller_unregister(struct reset_controller_dev *rcdev);
> +
> +#endif
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> new file mode 100644
> index 0000000..c4119c5
> --- /dev/null
> +++ b/include/linux/reset.h
> @@ -0,0 +1,17 @@
> +#ifndef _LINUX_RESET_H_
> +#define _LINUX_RESET_H_
> +
> +struct device;
> +struct reset_control;
> +
> +int reset_control_reset(struct reset_control *rstc);
> +int reset_control_assert(struct reset_control *rstc);
> +int reset_control_deassert(struct reset_control *rstc);
> +
> +struct reset_control *reset_controlr_get(struct device *dev, const char *id);
> +void reset_control_put(struct reset_control *rstc);
> +struct reset_control *devm_reset_control_get(struct device *dev, const char *id);
> +
> +int device_reset(struct device *dev);
> +
> +#endif
> -- 
> 1.7.10.4
> 
