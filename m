From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 10 Aug 2011 14:29:56 +0100
Subject: [PATCH 1/4] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20110810132956.GG2680@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

A few minor comments inline.

Jamie

On Wed, Aug 10, 2011 at 02:03:39PM +0100, Lee Jones wrote:
> This patch introduces a new driver to drivers/base. The
> driver provides a means to export vital SoC data out to
> userspace via sysfs. Standard information applicable to all
> SoCs are exported to:
> 
> /sys/devices/soc/[1|2|3|...]/[family|machine|revision|soc_id].
> 
> It is possible to create SoC specific items via the
> soc_parent, which is returned post-registration, although
> this should be discouraged.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/base/Kconfig    |    3 +
>  drivers/base/Makefile   |    1 +
>  drivers/base/soc.c      |  104 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sys_soc.h |   41 ++++++++++++++++++
>  4 files changed, 149 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/base/soc.c
>  create mode 100644 include/linux/sys_soc.h
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index d57e8d0..372ef3a 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -168,4 +168,7 @@ config SYS_HYPERVISOR
>  	bool
>  	default n
>  
> +config SYS_SOC
> +	bool
> +
>  endmenu
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 4c5701c..a0d246d 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -18,6 +18,7 @@ ifeq ($(CONFIG_SYSFS),y)
>  obj-$(CONFIG_MODULES)	+= module.o
>  endif
>  obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
> +obj-$(CONFIG_SYS_SOC) += soc.o
>  
>  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
>  
> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> new file mode 100644
> index 0000000..05944ef
> --- /dev/null
> +++ b/drivers/base/soc.c
> @@ -0,0 +1,104 @@
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
> +static int soc_count = 0;
> +
> +static struct device soc_grandparent = {
> +	.init_name = "soc",
> +};
> +
> +static ssize_t soc_info_get(struct device *dev,
> +			struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct soc_device *soc_dev = dev->platform_data;
> +
> +	if (!strncmp(attr->attr.name, "machine", 7))
> +		return sprintf(buf, "%s\n", soc_dev->machine);
> +	if (!strncmp(attr->attr.name, "family", 6))
> +		return sprintf(buf, "%s\n", soc_dev->family);
> +	if (!strncmp(attr->attr.name, "soc_id", 6))
> +		return sprintf(buf, "%s\n", soc_dev->soc_id);
> +	if (!strncmp(attr->attr.name, "revision", 8))
> +		return sprintf(buf, "%s\n", soc_dev->revision);

I think strcmp() would be better here rather than strncmp() otherwise 
there could be problems if someone adds an attribute that has a previous 
one as a starting sub-string.

> +
> +	return sprintf(buf, "Unknown attribute name - %s\n", attr->attr.name);

Just return -EINVAL or similar here to propogate the error to the user.

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
> +static void __exit soc_device_remove_files(struct device *soc)
> +{
> +	int i = 0;
> +
> +	while (soc_attrs[i++].attr.name != NULL)
> +		device_remove_file(soc, &soc_attrs[i]);
> +}
> +
> +static int __init soc_device_create_files(struct device *soc)
> +{
> +	int ret = 0;
> +	int i   = 0;
> +
> +	while (soc_attrs[i].attr.name != NULL) {
> +		ret = device_create_file(soc, &soc_attrs[i++]);
> +		if (ret)
> +			goto out;
> +	}
> +	return ret;
> +
> +out:
> +	soc_device_remove_files(soc);

This should count back from i and unregister the attributes as 
soc_device_remove_files may try and remove files that didn't get 
registered.

> +	return ret;
> +}
> +
> +int __init soc_device_register(struct device *soc_parent,
> +			struct soc_device *soc_dev)
> +{
> +	int ret;
> +
> +	spin_lock_irq(&register_lock);
> +
> +	if (!soc_count) {
> +		/* Register top-level SoC device '/sys/devices/soc' */
> +		ret = device_register(&soc_grandparent);
> +		if (ret)
> +		{
> +			spin_unlock_irq(&register_lock);
> +			return ret;
> +		}
> +	}
> +
> +	soc_count++;
> +	soc_parent->parent = &soc_grandparent;
> +	dev_set_name(soc_parent, "%i", soc_count);
> +	soc_parent->platform_data = soc_dev;

I don't think platform_data is the right place for this.  It's not clear 
what soc_parent and soc_dev do here as soc_dev never gets registered.

Should this be:

	soc_dev->parent = &soc_grandparent;
	dev_set_name(soc_dev, "%i", soc_count);
	device_register(soc_dev);

and drop soc_parent and add the files to soc_device?  In soc_info_get(), 
you could then do:

	struct soc_device *soc = container_of(dev, struct soc_device, dev);

> +	spin_unlock_irq(&register_lock);
> +
> +	ret = device_register(soc_parent);
> +	if (ret)
> +		return ret;
> +
> +	soc_device_create_files(soc_parent);
> +
> +	return ret;
> +}
> diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
> new file mode 100644
> index 0000000..3de6405
> --- /dev/null
> +++ b/include/linux/sys_soc.h
> @@ -0,0 +1,41 @@
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
> +#define MAX_SOCS 8
> +#define MACHINE  0
> +#define FAMILY   1
> +#define SOCID    2
> +#define REVISION 3

These defines don't appear to be used anywhere afaict.

> +
> +struct soc_device {
> +	struct device dev;
> +	const char *machine;
> +	const char *family;
> +	const char *soc_id;
> +	const char *revision;
> +};
> +
> +/**
> + * soc_device_register - register SoC as a device
> + * @soc_parent: Parent node '/sys/devices/soc/X'
> + * @soc_dev: SoC device specific information
> + */
> +int soc_device_register(struct device *soc_parent,
> +			struct soc_device *soc_dev);
> +
> +/**
> + *  soc_device_unregister - unregister SoC as a device
> + * @soc_parent: Parent node '/sys/devices/soc/X'
> + */
> +void soc_device_unregister(struct device *soc_parent);

This doesn't appear to exist, and probably doesn't need to.
