From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 16 Jan 2013 21:15:47 +0100
Subject: [PATCH 2/7] reset: Add reset controller API
In-Reply-To: <1358352787-15441-3-git-send-email-p.zabel@pengutronix.de>
References: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
 <1358352787-15441-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130116201547.GW1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 05:13:02PM +0100, Philipp Zabel wrote:
> This adds a simple API for devices to request being reset
> by separate reset controller hardware and implements the
> reset signal device tree binding.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/Kconfig        |    2 +
>  drivers/Makefile       |    2 +
>  drivers/reset/Kconfig  |   10 ++
>  drivers/reset/Makefile |    2 +
>  drivers/reset/core.c   |  241 ++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 257 insertions(+)
>  create mode 100644 drivers/reset/Kconfig
>  create mode 100644 drivers/reset/Makefile
>  create mode 100644 drivers/reset/core.c
> 
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index f5fb072..51f73ae 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -158,4 +158,6 @@ source "drivers/irqchip/Kconfig"
>  
>  source "drivers/ipack/Kconfig"
>  
> +source "drivers/reset/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 346ecc5..870bf7e 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -42,6 +42,8 @@ ifndef CONFIG_ARCH_USES_GETTIMEOFFSET
>  obj-y				+= clocksource/
>  endif
>  
> +obj-$(CONFIG_RESET_CONTROLLER)	+= reset/
> +
>  # tty/ comes before char/ so that the VT console is the boot-time
>  # default.
>  obj-y				+= tty/
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> new file mode 100644
> index 0000000..82dc89e
> --- /dev/null
> +++ b/drivers/reset/Kconfig
> @@ -0,0 +1,10 @@
> +menuconfig RESET_CONTROLLER
> +	bool "Reset Controller Support"
> +	help
> +	  Generic Reset Controller support.
> +
> +	  This framework is designed to abstract reset handling of devices
> +	  via GPIOs or SoC-internal reset controller modules.
> +
> +	  If unsure, say no.
> +
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> new file mode 100644
> index 0000000..9a7b6df
> --- /dev/null
> +++ b/drivers/reset/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_RESET_CONTROLLER) += core.o
> +
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> new file mode 100644
> index 0000000..f0ed61b
> --- /dev/null
> +++ b/drivers/reset/core.c
> @@ -0,0 +1,241 @@
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
> + * @id: ID of the reset controller in the reset
> + *      controller device
> + */
> +struct reset_control {
> +	struct reset_controller_dev *rcdev;
> +	unsigned int id;
> +};
> +
> +/**
> + * reset_controller_register - register a reset controller
> + *
> + * @ops: a pointer to struct reset_controller_ops callbacks
> + *
> + * Returns a struct reset_controller_dev or IS_ERR() condition
> + * containing errno.

The comment seems wrong.

> + */
> +int reset_controller_register(struct reset_controller_dev *rcdev)
> +{
> +	mutex_lock(&reset_controller_list_mutex);
> +	list_add(&rcdev->list, &reset_controller_list);
> +	mutex_unlock(&reset_controller_list_mutex);
> +
> +	return 0;
> +}
> +
> +/**
> + * reset_control_reset - reset the controlled device
> + * @rstc: reset controller
> + */
> +int reset_control_reset(struct reset_control *rstc)
> +{
> +	if (rstc->rcdev->ops->reset)
> +		return rstc->rcdev->ops->reset(rstc->id);
> +
> +	return 0;
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
> +		return rstc->rcdev->ops->assert(rstc->id);
> +
> +	return 0;
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
> +		return rstc->rcdev->ops->deassert(rstc->id);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(reset_control_deassert);
> +
> +/**
> + * reset_control_is_asserted - deasserts the reset line

copy-paste from the function above?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
