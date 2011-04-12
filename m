From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 12 Apr 2011 13:46:22 +0100
Subject: [PATCH 1/3] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <4DA341EC.7010101@linaro.org>
References: <4DA341EC.7010101@linaro.org>
Message-ID: <20110412124621.GC10225@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Works fine on my platform, but I have a couple of questions.

On Mon, Apr 11, 2011 at 07:01:16PM +0100, Lee Jones wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/base/Kconfig    |    3 +
>  drivers/base/Makefile   |    1 +
>  drivers/base/soc.c      |   96 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sys_soc.h |   29 ++++++++++++++
>  4 files changed, 129 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/base/soc.c
>  create mode 100644 include/linux/sys_soc.h
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index e9e5238..f381fcc 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -168,6 +168,9 @@ config SYS_HYPERVISOR
>  	bool
>  	default n
>  
> +config SYS_SOC
> +	bool
> +
>  config ARCH_NO_SYSDEV_OPS
>  	bool
>  	---help---
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
> index 0000000..1a409e2
> --- /dev/null
> +++ b/drivers/base/soc.c
> @@ -0,0 +1,96 @@
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
> +static char *soc_names[] = {"1", "2", "3", "4", "5", "6", "7", "8" };

Could this be made const?  Actually, could we just use dev_set_name() 
and do it at runtime?

> +static struct device parent_soc = { .init_name = "soc", };

I don't think this device can be statically allocated.

> +struct device *soc[MAX_SOCS];
> +
> +static int soc_device_create_files(struct device *soc,
> +                                   struct device_attribute soc_attrs[]);
> +
> +static void soc_device_remove_files(struct device *soc,
> +                                    struct device_attribute soc_attrs[]);

If you move soc_device_remove_files() above soc_device_create_files() 
then I don't think you need these prototypes.

> +
> +static int __init soc_device_create_files(struct device *soc,
> +                                          struct device_attribute soc_attrs[])
> +{
> +	int ret = 0;
> +	int i = 0;
> +
> +	while (soc_attrs[i].attr.name != NULL) {
> +		ret = device_create_file(soc, &soc_attrs[i++]);
> +		if (ret)
> +			goto out;
> +	}
> +	return ret;
> +
> +out:
> +	soc_device_remove_files(soc, soc_attrs);
> +	return ret;
> +}
> +
> +static void __exit soc_device_remove_files(struct device *soc,
> +                                           struct device_attribute soc_attrs[])

This is used in the cleanup path of soc_device_create_files() so can't 
be annotated with __exit:

`soc_device_remove_files' referenced in section `.init.text' of 
drivers/built-in.o: defined in discarded section `.exit.text' of 
drivers/built-in.o

> +{
> +	int i = 0;
> +
> +	while (soc_attrs[i++].attr.name != NULL)
> +		device_remove_file(soc, &soc_attrs[i]);
> +}
> +
> +int __init soc_device_register(struct device_attribute *soc_attrs[],
> +                               int soc_count)
> +{
> +	int ret, i;

Shouldn't this check that soc_count < MAX_SOCS?

> +
> +	/* Register top-level SoC device '/sys/devices/soc' */
> +	ret = device_register(&parent_soc);
> +	if (ret)
> +		return ret;

I think that this device needs to be dynamically allocated and have a 
release function that does a kfree() on it.

> +
> +	/* Register each SoC and populate sysfs with requested attributes */
> +	for (i = 0; i < soc_count - 1; i++) {
> +		soc[i] = kmalloc(sizeof(struct device), GFP_KERNEL);
> +		if (!soc[i])
> +			return -ENOMEM;
> +
> +		memset(soc[i], 0, sizeof(struct device));

kzalloc() and remove the memset()?

> +		soc[i]->init_name = soc_names[i];

It would be good to use dev_set_name() here, but I wonder if perhaps the 
devices should be called soc1, soc2 etc rather than 1, 2?

> +		soc[i]->parent = &parent_soc;
> +
> +		ret = device_register(soc[i]);
> +		if (ret)
> +			return ret;
> +
> +		soc_device_create_files(soc[i], soc_attrs[i]);
> +	}
> +
> +	return ret;
> +}
> +
> +void __exit soc_device_unregister(struct device_attribute *soc_attrs[],
> +                                  int soc_count)
> +{
> +	int i;
> +
> +	/* Unregister and free all SoC from sysfs */
> +	for (i = 0; i < soc_count - 1; i++) {
> +		soc_device_remove_files(soc[i], soc_attrs[i]);
> +		device_unregister(soc[i]);
> +		kfree(soc[i]);

The kfree() should be done in the .release() method otherwise the device 
could be freed whilst someone still holds a reference.

> +	}
> +
> +	/* Unregister top-level SoC device '/sys/devices/soc' */
> +	device_unregister(&parent_soc);
> +}
> diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
> new file mode 100644
> index 0000000..072cd39
> --- /dev/null
> +++ b/include/linux/sys_soc.h
> @@ -0,0 +1,29 @@
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
> +
> +#define MAX_SOCS 8
> +
> +/**
> + * soc_device_register - register SoC as a device
> + * @soc_attr: Array of sysfs file attributes
> + * @soc: Parent node '/sys/devices/soc'
> + */
> +int soc_device_register(struct device_attribute *soc_attrs[],
> +                        int num_socs);
> +/**
> + *  soc_device_unregister - unregister SoC as a device
> + * @soc_attr: Array of sysfs file attributes
> + * @soc: Parent node '/sys/devices/soc'
> + */
> +void soc_device_unregister(struct device_attribute *soc_attrs[],
> +                           int num_socs);
> +
> +#endif /* __SYS_SOC_H */
> -- 
> 1.7.4.1
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
