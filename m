From: mbrugger@suse.com (Matthias Brugger)
Date: Thu, 27 Oct 2016 11:10:06 +0200
Subject: [RFC PATCH 1/5] of: introduce the overlay manager
In-Reply-To: <20161026145756.21689-2-antoine.tenart@free-electrons.com>
References: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
 <20161026145756.21689-2-antoine.tenart@free-electrons.com>
Message-ID: <1e9bb9f3-c365-2a7c-9da1-acc734bfadac@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/26/2016 04:57 PM, Antoine Tenart wrote:
> The overlay manager is an in-kernel library helping to handle dt overlay
> loading when using capes.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/of/Kconfig                           |   2 +
>  drivers/of/Makefile                          |   1 +
>  drivers/of/overlay-manager/Kconfig           |   6 +
>  drivers/of/overlay-manager/Makefile          |   1 +
>  drivers/of/overlay-manager/overlay-manager.c | 199 +++++++++++++++++++++++++++
>  include/linux/overlay-manager.h              |  38 +++++
>  6 files changed, 247 insertions(+)
>  create mode 100644 drivers/of/overlay-manager/Kconfig
>  create mode 100644 drivers/of/overlay-manager/Makefile
>  create mode 100644 drivers/of/overlay-manager/overlay-manager.c
>  create mode 100644 include/linux/overlay-manager.h
>
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index bc07ad30c9bf..e57aeaf0bf4f 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -116,4 +116,6 @@ config OF_OVERLAY
>  config OF_NUMA
>  	bool
>
> +source "drivers/of/overlay-manager/Kconfig"
> +
>  endif # OF
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index d7efd9d458aa..d738fd41271f 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.o
>  obj-$(CONFIG_OF_NUMA) += of_numa.o
>
>  obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> +obj-y += overlay-manager/
> diff --git a/drivers/of/overlay-manager/Kconfig b/drivers/of/overlay-manager/Kconfig
> new file mode 100644
> index 000000000000..eeb76054dcb8
> --- /dev/null
> +++ b/drivers/of/overlay-manager/Kconfig
> @@ -0,0 +1,6 @@
> +config OF_OVERLAY_MGR
> +	bool "Device Tree Overlay Manager"
> +	depends on OF_OVERLAY
> +	help
> +	  Enable the overlay manager to handle automatic overlay loading when
> +	  devices are detected.
> diff --git a/drivers/of/overlay-manager/Makefile b/drivers/of/overlay-manager/Makefile
> new file mode 100644
> index 000000000000..86d2b53950e7
> --- /dev/null
> +++ b/drivers/of/overlay-manager/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_OF_OVERLAY_MGR)			+= overlay-manager.o
> diff --git a/drivers/of/overlay-manager/overlay-manager.c b/drivers/of/overlay-manager/overlay-manager.c
> new file mode 100644
> index 000000000000..a725d7e24d38
> --- /dev/null
> +++ b/drivers/of/overlay-manager/overlay-manager.c
> @@ -0,0 +1,199 @@
> +/*
> + * Copyright (C) 2016 - Antoine Tenart <antoine.tenart@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/firmware.h>
> +#include <linux/list.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/overlay-manager.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +struct overlay_mgr_overlay {
> +	struct list_head list;
> +	char *name;
> +};
> +
> +LIST_HEAD(overlay_mgr_overlays);
> +LIST_HEAD(overlay_mgr_formats);

Maybe you can find some better names for this, or rename the structs.
This will make the code more readable.

> +DEFINE_SPINLOCK(overlay_mgr_lock);
> +DEFINE_SPINLOCK(overlay_mgr_format_lock);

As Thomas already said, a mutex should be fine. We are not doing any 
time critical here, right?

> +
> +/*
> + * overlay_mgr_register_format()
> + *
> + * Adds a new format candidate to the list of supported formats. The registered
> + * formats are used to parse the headers stored on the dips.
> + */
> +int overlay_mgr_register_format(struct overlay_mgr_format *candidate)
> +{
> +	struct overlay_mgr_format *format;
> +	int err = 0;
> +
> +	spin_lock(&overlay_mgr_format_lock);
> +
> +	/* Check if the format is already registered */
> +	list_for_each_entry(format, &overlay_mgr_formats, list) {
> +		if (!strcpy(format->name, candidate->name)) {
> +			err = -EEXIST;
> +			goto err;
> +		}
> +	}
> +
> +	list_add_tail(&candidate->list, &overlay_mgr_formats);
> +
> +err:
> +	spin_unlock(&overlay_mgr_format_lock);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(overlay_mgr_register_format);
> +
> +/*
> + * overlay_mgr_parse()
> + *
> + * Parse raw data with registered format parsers. Fills the candidate string if
> + * one parser understood the raw data format.
> + */
> +int overlay_mgr_parse(struct device *dev, void *data, char ***candidates,
> +		      unsigned *n)
> +{
> +	struct list_head *pos, *tmp;
> +	struct overlay_mgr_format *format;
> +
> +	list_for_each_safe(pos, tmp, &overlay_mgr_formats) {
> +		format = list_entry(pos, struct overlay_mgr_format, list);
> +
> +		format->parse(dev, data, candidates, n);
> +		if (n > 0)
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(overlay_mgr_parse);
> +
> +static int overlay_mgr_check_overlay(struct device_node *node)
> +{
> +	struct property *p;
> +	const char *str = NULL;
> +
> +	p = of_find_property(node, "compatible", NULL);
> +	if (!p)
> +		return -EINVAL;
> +
> +	do {
> +		str = of_prop_next_string(p, str);
> +		if (of_machine_is_compatible(str))
> +			return 0;
> +	} while (str);
> +
> +	return -EINVAL;
> +}
> +
> +/*
> + * _overlay_mgr_insert()
> + *
> + * Try to request and apply an overlay given a candidate name.
> + */
> +static int _overlay_mgr_apply(struct device *dev, char *candidate)

Should be __overlay_mgr_apply(...)

Cheers,
Matthias
