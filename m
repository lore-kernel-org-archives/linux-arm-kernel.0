From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Apr 2011 20:36:44 +0200
Subject: [PATCH 1/3] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <1302792592-17484-2-git-send-email-lee.jones@linaro.org>
References: <1302792592-17484-1-git-send-email-lee.jones@linaro.org>
	<1302792592-17484-2-git-send-email-lee.jones@linaro.org>
Message-ID: <201104172036.45052.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thursday 14 April 2011, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

This definitely needs a changelog, explaining what the code is there for,
and why you chose this interface and not the alternatives we discussed
earlier.

> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> new file mode 100644
> index 0000000..5e4d6ef
> --- /dev/null
> +++ b/drivers/base/soc.c
> @@ -0,0 +1,127 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2011
> + *
> + * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + */

(I believe this would be Copyright Linaro Ltd, not ST-Ericsson SA,
but better ask internally in ST-Ericsson about what your rules are)

> +struct device *parent_soc;
> +struct device *soc[MAX_SOCS];

The array should not be needed here, you can simply iterate all soc
devices using device_for_each_child() if required.

Global variables should really not have such generic names. Better
make all variables static and make sure that the code using them
can at there properly.

> +int __init soc_device_register(struct device_attribute *soc_attrs[],
> +                               int soc_count)

This needs to return the soc device, otherwise there is nothing that
a platform can do with the device.

Passing the soc_count the way you do won't work when you have different
SoCs, so better require the user to call the register function repeatedly.


I think a nicer interface would be to pass a data structure into it
with the data you always want to export, and then have the soc
core create the necessary attributes, instead of requiring every
user to duplicate that code.

A possible interface might be

struct soc_device {
	const char *machine;
	const char *family;
	/* ... */
	struct device dev;
};

struct soc_device *soc_device_register(const char *machine, const char *family);

For the nonstandard attributes, I would recommend having the individual
drivers call device_create_file, in order to discourage the use of 
device specific attribute names.

> diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
> new file mode 100644
> index 0000000..988cf6f
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

No need to hardcode the maximum.

	Arnd
