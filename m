From: gregkh@suse.de (Greg KH)
Date: Wed, 10 Aug 2011 08:02:04 -0700
Subject: [PATCH 1/4] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20110810150204.GB7938@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Then don't return the pointer, if you don't want it to be used.

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

Please just use the in-kernel api for stuff like this, and don't roll
your own.

> +
> +static struct device soc_grandparent = {
> +	.init_name = "soc",
> +};

No, please NEVER create a static struct device.  Again, use the properly
kernel functions that are provided to you to create such a thing.

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
> +
> +	return sprintf(buf, "Unknown attribute name - %s\n", attr->attr.name);

No need to return the unknown attribute name, that's what userspace just
asked for, so it knows it.  Return an error instead (-EINVAL);

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

We do have this ability to add and remove whole attribute groups at
once.

Your ability to reinvent core code is admirable though :)

You really want to make this whole thing a class, and use it that way
instead of what you are trying to do here (roll your own class by
reinventing all of the same code again.)

Please rewrite it that way, it will be much simpler, and smaller, and
work properly (hint, you have races here with userspace tools...)

> +#include <linux/platform_device.h>

Why is platform device needed?

> +
> +#define MAX_SOCS 8

Why have a max?

> +#define MACHINE  0
> +#define FAMILY   1
> +#define SOCID    2
> +#define REVISION 3

Why does the whole kernel need these, very generic, defines?
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

No, you should just pass in the information for the soc device, and have
the core create everything for you (like the struct device and the
rest.)  So, soc_device should really just have everything above, minus
the struct device, as that would be better to pass into the function
from callers.

greg k-h
