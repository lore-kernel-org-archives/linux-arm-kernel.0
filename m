From: eduardo.valentin@nokia.com (Eduardo Valentin)
Date: Fri, 11 Mar 2011 15:50:43 +0200
Subject: [RFC PATCHv2 1/2] Export SoC info through sysfs
In-Reply-To: <1299846911-15782-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299846911-15782-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
Message-ID: <20110311135043.GA9320@besouro.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Mar 11, 2011 at 01:35:10PM +0100, ext Maxime Coquelin wrote:
> Common base to export System-on-Chip related informations through sysfs.
> 
> Creation of a "socinfo" directory under /sys/.
> Creation of SoC information entries.
> 
> Signed-off-by: Maxime COQUELIN <maxime.coquelin-nonst@stericsson.com>
> ---
>  Documentation/ABI/testing/sysfs-socinfo |   16 ++++++
>  drivers/base/Kconfig                    |    3 +
>  drivers/base/Makefile                   |    1 +
>  drivers/base/soc.c                      |   79 +++++++++++++++++++++++++++++++
>  include/linux/sys_soc.h                 |   50 +++++++++++++++++++
>  5 files changed, 149 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-socinfo
>  create mode 100644 drivers/base/soc.c
>  create mode 100644 include/linux/sys_soc.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-socinfo b/Documentation/ABI/testing/sysfs-socinfo
> new file mode 100644
> index 0000000..afd9da2
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-socinfo
> @@ -0,0 +1,16 @@
> +What:		/sys/socinfo
> +Date:		March 2011
> +contact:	Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>
> +Description:
> +		The /sys/socinfo directory contains information about the
> +		System-on-Chip.	It is only available if platform implements it.
> +		This directory contains two kind of attributes :
> +			- common attributes: 
> +				* machine: the name of the machine.
> +				* family: the family name of the SoC
> +			- SoC-specific attributes: The SoC vendor can declare attributes
> +			  to export some strings to user-space, like the serial-number for
> +			  example.
> +
> +Users:
> +		User-space applications which needs these kind of attributes.
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
> index 5f51c3b..f3bcfb3 100644
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
> index 0000000..046b43b
> --- /dev/null
> +++ b/drivers/base/soc.c
> @@ -0,0 +1,79 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2011
> + * Author: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com> for ST-Ericsson.
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
> +struct kobject *soc_object;
> +
> +ssize_t show_soc_info(struct kobject *kobj,
> +			struct kobj_attribute *attr, char *buf)
> +{
> +	struct sysfs_soc_info *si = container_of(attr,
> +				struct sysfs_soc_info, attr);
> +
> +	if (si->info)
> +		return sprintf(buf, "%s\n", si->info);
> +
> +	return si->get_info(buf, si);
> +}
> +
> +int __init register_sysfs_soc_info(struct sysfs_soc_info *info, int nb_info)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < nb_info; i++) {
> +		ret = sysfs_create_file(soc_object, &info[i].attr.attr);
> +		if (ret) {
> +			for (i -= 1; i >= 0; i--)
> +				sysfs_remove_file(soc_object, &info[i].attr.attr);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
