From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jul 2011 16:02:05 +0200
Subject: [PATCH 1/3] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201107151602.06282.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 July 2011, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/base/Kconfig    |   10 +++++
>  drivers/base/Makefile   |    1 +
>  drivers/base/soc.c      |   98 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sys_soc.h |   45 +++++++++++++++++++++

After looking at the patch again, I do have some important comments
after all. I had only looked at the documentation you posted, not
at the actual patch.

> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index d57e8d0..2feab2b 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -168,4 +168,14 @@ config SYS_HYPERVISOR
>  	bool
>  	default n
>  
> +config ARCH_NO_SYSDEV_OPS
> +	bool
> +	---help---
> +	  To be selected by architectures that don't use sysdev class or
> +	  sysdev driver power management (suspend/resume) and shutdown
> +	  operations.

You don't seem to be using this anywhere. What is this for?

> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> new file mode 100644
> index 0000000..30659f4
> --- /dev/null
> +++ b/drivers/base/soc.c
> @@ -0,0 +1,98 @@
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
> +struct device_attribute soc_attrs[] = {
> +	__ATTR(machine,  S_IRUGO, NULL, NULL),
> +	__ATTR(family,   S_IRUGO, NULL, NULL),
> +	__ATTR(soc_id,   S_IRUGO, NULL, NULL),
> +	__ATTR(revision, S_IRUGO, NULL, NULL),
> +	__ATTR_NULL,
> +};

This method does not work. You only set the function pointers
when you call soc_device_register, but they will end up overwriting
the existing function pointers when you have multiple callers of that
function.

It would be better to define a 'struct soc_device' derived from 'struct 
device' that holds a pointer to the actual strings (or operations, if
you insist) and provide a single soc_info_get() function that is used
for all the attributes.

> +const char *soc_names[] = { "1", "2", "3", "4", "5", "6", "7", "8" };
> +static int soc_count = 0;

This is a bit silly and artificially limits the number of SoC devices.
It's much simpler to just use dev_set_name().

> +static struct device soc_grandparent = {
> +	.init_name = "soc",
> +};
>
> +static int soc_device_create_files(struct device *soc);
> +static void soc_device_remove_files(struct device *soc);

No forward declarations for static functions please.

> +int __init soc_device_register(struct device *soc_parent,
> +			struct soc_callback_functions *soc_callbacks)
> +{
> +	int ret;
> +
> +	soc_attrs[MACHINE].show = soc_callbacks->get_machine_fn;
> +	soc_attrs[FAMILY].show = soc_callbacks->get_family_fn;
> +	soc_attrs[SOCID].show = soc_callbacks->get_soc_id_fn;
> +	soc_attrs[REVISION].show = soc_callbacks->get_revision_fn;

It's better to allocate the device here, so you don't have to
do it in each caller.

> +	soc_parent->init_name = soc_names[soc_count];
> +	soc_parent->parent = &soc_grandparent;
> +
> +	ret = device_register(soc_parent);
> +	if (ret)
> +		return ret;
> +
> +	soc_device_create_files(soc_parent);
> +
> +	soc_count++;

This needs some locking to ensure that you don't try to register
two devices with the same number.

> +
> +void __exit soc_device_unregister(struct device *soc_parent)
> +{
> +	/* Unregister and free SoC from sysfs */
> +	soc_device_remove_files(soc_parent);
> +	device_unregister(soc_parent);
> +
> +	if (--soc_count == 0)
> +		/* Unregister top-level SoC device '/sys/devices/soc' */
> +	device_unregister(&soc_grandparent);
> +}

The exit function does not make any sense if you cannot build the soc
support itself as a module, which in turn makes no sense at all.

> +
> +#define MAX_SOCS 8
> +#define MACHINE  0
> +#define FAMILY   1
> +#define SOCID    2
> +#define REVISION 3
> +

I think these defines are used nowhere by the individual drivers, so they
need not be in the header file. More importantly, the names are not put
in a proper namespace, so they can easily collide with other macros
or enums.

	Arnd
