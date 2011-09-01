From: gregkh@suse.de (Greg KH)
Date: Thu, 1 Sep 2011 16:34:03 -0700
Subject: [PATCH 1/5] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20110901233403.GA28176@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2011 at 01:27:19PM +0100, Lee Jones wrote:
> This patch introduces a new driver to drivers/base. The
> driver provides a means to export vital SoC data out to
> userspace via sysfs. Standard information applicable to all
> SoCs are exported to:
> 
> /sys/devices/soc/[1|2|3|...]/[family|machine|revision|soc_id].
> 
> It is possible to create SoC specific items via the
> soc device, which is returned post-registration, although
> this should be discouraged.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/base/Kconfig    |    3 +
>  drivers/base/Makefile   |    1 +
>  drivers/base/soc.c      |  103 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sys_soc.h |   27 ++++++++++++
>  4 files changed, 134 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/base/soc.c
>  create mode 100644 include/linux/sys_soc.h
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 21cf46f..95f10c5 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -172,6 +172,9 @@ config SYS_HYPERVISOR
>  	bool
>  	default n
>  
> +config SYS_SOC
> +	bool
> +
>  source "drivers/base/regmap/Kconfig"
>  
>  endmenu
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 99a375a..a67a1e7 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_MODULES)	+= module.o
>  endif
>  obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
>  obj-$(CONFIG_REGMAP)	+= regmap/
> +obj-$(CONFIG_SYS_SOC) += soc.o
>  
>  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
>  
> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> new file mode 100644
> index 0000000..e9d908b
> --- /dev/null
> +++ b/drivers/base/soc.c
> @@ -0,0 +1,103 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2011
> + *
> + * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/stat.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +
> +static DEFINE_SPINLOCK(register_lock);

If this is really needed, please make it a mutex as you end up calling
code paths that can sleep.

> +static int soc_count = 0;

This should not be needed.

> +
> +static struct device soc_grandparent = {
> +	.init_name = "soc",
> +};

NEVER create a static struct device, this is totally not needed and
completly wrong.

> +static ssize_t soc_info_get(struct device *dev,
> +			struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
> +
> +	if (!strcmp(attr->attr.name, "machine"))
> +		return sprintf(buf, "%s\n", soc_dev->machine);
> +	if (!strcmp(attr->attr.name, "family"))
> +		return sprintf(buf, "%s\n", soc_dev->family);
> +	if (!strcmp(attr->attr.name, "revision"))
> +		return sprintf(buf, "%s\n", soc_dev->revision);
> +	if (!strcmp(attr->attr.name, "soc_id")) {
> +		if (soc_dev->pfn_soc_id)
> +			return sprintf(buf, "%s\n", soc_dev->pfn_soc_id());
> +		else return sprintf(buf, "N/A \n");

Move this line

> +	}
> +
> +	return -EINVAL;

To here?


> +}
> +
> +struct device_attribute soc_attrs[] = {
> +	__ATTR(machine,  S_IRUGO, soc_info_get,  NULL),
> +	__ATTR(family,   S_IRUGO, soc_info_get,  NULL),
> +	__ATTR(soc_id,   S_IRUGO, soc_info_get,  NULL),
> +	__ATTR(revision, S_IRUGO, soc_info_get,  NULL),
> +	__ATTR_NULL,
> +};
> +
> +static void soc_device_remove_files(struct device *soc, int i)
> +{
> +	while (i > 0)
> +		device_remove_file(soc, &soc_attrs[--i]);
> +}

You do know how to add multiple files, right?  Oh wait, this is all not
the way to do this in the first place.  You just raced userspace :(

> +
> +static int __init soc_device_create_files(struct device *dev)
> +{
> +	int ret = 0;
> +	int i   = 0;
> +
> +	while (soc_attrs[i].attr.name != NULL) {
> +		ret = device_create_file(dev, &soc_attrs[i++]);
> +		if (ret)
> +			goto out;
> +	}
> +	return ret;
> +
> +out:
> +	soc_device_remove_files(dev, --i);
> +	return ret;
> +}

Yup, you raced userspace.  Please use the proper api for defining a
group of attributes for a device by default so that the driver core
handles creating and destroying them correctly and in a way that will
not be racy (unlike this way.)

> +
> +int __init soc_device_register(struct device *dev)

Don't pass a struct device in here, why are you making the caller create
the device?  This is the function that should create it for you?

> +{
> +	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
> +	int ret;
> +
> +	spin_lock_irq(&register_lock);

Ok.

> +
> +	if (!soc_count) {
> +		/* Register top-level SoC device '/sys/devices/soc' */
> +		ret = device_register(&soc_grandparent);

device_register can't be called with a spinlock.  You must have gotten
lucky in your testing, if you tested this.

Anyway, this is not needed at all, please don't create "dummy" devices
in the sysfs tree, properly hook up your new device to where it should
be in the device tree.

> +		if (ret) {
> +			spin_unlock_irq(&register_lock);
> +			return ret;
> +		}
> +	}
> +
> +	soc_count++;

Nope, don't use this, again, use the correct kernel interface for
providing you with a unique number that increments as needed.  Don't
roll your own that will end up being wrong in the end (like this is,
what happens if you remove a device in the middle?)

> +	dev->parent = &soc_grandparent;

Nope, don't do that.

> +	dev_set_name(dev, "%i_%s", soc_count, soc_dev->machine);
> +
> +	spin_unlock_irq(&register_lock);
> +
> +	ret = device_register(dev);
> +	if (ret)
> +		return ret;
> +
> +	soc_device_create_files(dev);

Nor that.

See above for why.

> +
> +	return ret;
> +}
> diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
> new file mode 100644
> index 0000000..811d7fe
> --- /dev/null
> +++ b/include/linux/sys_soc.h
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2011
> + * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +#ifndef __SYS_SOC_H
> +#define __SYS_SOC_H
> +
> +#include <linux/kobject.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +
> +struct soc_device {
> +	struct device dev;
> +	const char *machine;
> +	const char *family;
> +	const char *revision;
> +	const char *(*pfn_soc_id)(void);
> +};

Nice structure, but why do you export it, you aren't using it anywhere,
nor should you be...

> +
> +/**
> + * soc_device_register - register SoC as a device
> + * @dev: Parent node '/sys/devices/soc/X'
> + */
> +int soc_device_register(struct device *dev);

This whole api needs to be rethunk, please, it's really wrong.

What you want is a way to create a soc device, by calling a function,
not be responsible for creating it, then call the soc core, and then
somehow, removing it.

Oh wait, you forgot to have a function to remove anything created with
the above call, that seems really broken and wrong.

greg k-h
