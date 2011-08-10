From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 10 Aug 2011 14:34:39 +0100
Subject: [PATCH 3/4] mach-ux500: export System-on-Chip information ux500
	via sysfs
In-Reply-To: <1312981422-13294-3-git-send-email-lee.jones@linaro.org>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<1312981422-13294-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20110810133439.GH2680@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

A few nits inline.

Jamie

On Wed, Aug 10, 2011 at 02:03:41PM +0100, Lee Jones wrote:
> Here we make use of the new drivers/base/soc driver to export
> vital SoC information out to userspace via sysfs. This patch
> provides a data structure of strings to populate the base
> nodes found in:
> 
> /sys/devices/soc/[1|2|3|...]/[family|machine|revision|soc_id].
> 
> It also adds one more node as requested by ST-Ericsson.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/Kconfig              |    1 +
>  arch/arm/mach-ux500/id.c                 |  115 ++++++++++++++++++++++++++++++
>  arch/arm/mach-ux500/include/mach/setup.h |    1 +
>  3 files changed, 117 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
> index 4210cb4..4d2f2c2 100644
> --- a/arch/arm/mach-ux500/Kconfig
> +++ b/arch/arm/mach-ux500/Kconfig
> @@ -26,6 +26,7 @@ config MACH_U8500
>  	bool "U8500 Development platform"
>  	depends on UX500_SOC_DB8500
>  	select TPS6105X
> +	select SYS_SOC
>  	help
>  	  Include support for the mop500 development platform.
>  
> diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
> index d35122e..917d222 100644
> --- a/arch/arm/mach-ux500/id.c
> +++ b/arch/arm/mach-ux500/id.c
> @@ -2,12 +2,17 @@
>   * Copyright (C) ST-Ericsson SA 2010
>   *
>   * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
> + * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson
>   * License terms: GNU General Public License (GPL) version 2
>   */
>  
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/sys_soc.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/platform_device.h>
>  
>  #include <asm/cputype.h>
>  #include <asm/tlbflush.h>
> @@ -105,3 +110,113 @@ void __init ux500_map_io(void)
>  
>  	ux500_print_soc_info(asicid);
>  }
> +
> +#define U8500_BB_UID_BASE (U8500_BACKUPRAM1_BASE + 0xFC0)
> +#define U8500_BB_UID_LENGTH 5
> +
> +struct device *soc_parent;
> +
> +static void ux500_get_machine(char *buf)
> +{
> +	sprintf(buf, "DB%4x", dbx500_partnumber());
> +}
> +
> +static void ux500_get_family(char *buf)
> +{
> +	sprintf(buf, "Ux500");
> +}
> +
> +static void ux500_get_soc_id(char *buf)
> +{
> +	void __iomem *uid_base;
> +	int i;
> +	ssize_t sz = 0;
> +
> +	if (dbx500_partnumber() == 0x8500) {
> +		uid_base = __io_address(U8500_BB_UID_BASE);
> +		for (i = 0; i < U8500_BB_UID_LENGTH; i++) {
> +			sz += sprintf(buf + sz, "%08x", readl(uid_base + i * sizeof(u32)));
> +		}
> +		return;
> +	} else {
> +		/* Don't know where it is located for U5500 */
> +		sprintf(buf, "N/A");
> +		return;
> +	}
> +}
> +
> +static void ux500_get_revision(char *buf)
> +{
> +	unsigned int rev = dbx500_revision();
> +
> +	if (rev == 0x01) {
> +		sprintf(buf, "%s", "ED");
> +		return;
> +	}
> +	else if (rev >= 0xA0) {
> +		sprintf(buf, "%d.%d" , (rev >> 4) - 0xA + 1, rev & 0xf);
> +		return;
> +	}
> +
> +	sprintf(buf, "%s", "Unknown");
> +}
> +
> +static ssize_t ux500_get_process(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	if (dbx500_id.process == 0x00)
> +		return sprintf(buf, "Standard\n");
> +
> +	return sprintf(buf, "%02xnm\n", dbx500_id.process);
> +}
> +
> +static void soc_info_put(struct soc_device *soc_dev)
> +{
> +	char buf[1024];
> +
> +	ux500_get_machine(buf);
> +	soc_dev->machine = kzalloc(strlen(buf), GFP_KERNEL);
> +	strcpy((char *)soc_dev->machine, buf);
> +
> +	ux500_get_family(buf);
> +	soc_dev->family = kzalloc(strlen(buf), GFP_KERNEL);
> +	strcpy((char *)soc_dev->family, buf);
> +
> +	ux500_get_soc_id(buf);
> +	soc_dev->soc_id = kzalloc(strlen(buf), GFP_KERNEL);
> +	strcpy((char *)soc_dev->soc_id, buf);
> +
> +	ux500_get_revision(buf);
> +	soc_dev->revision = kzalloc(strlen(buf), GFP_KERNEL);
> +	strcpy((char *)soc_dev->revision, buf);

The returns of kzalloc() aren't checked here, but this can be simplified 
if you have the helpers do the allocation e.g.

	static const char *ux500_get_revision(void)
	{
		return kasprintf(GFP_KERNEL, "%s", ...);
	}

> +}
> +
> +struct device_attribute ux500_soc_attrs[] = {
> +	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL),
> +	__ATTR_NULL,
> +};
> +
> +static int __init ux500_soc_sysfs_init(void)
> +{
> +	int ret;
> +	int i = 0;
> +	struct soc_device *soc_dev = kzalloc(sizeof(struct soc_device), GFP_KERNEL);
> +
> +	soc_parent = kzalloc(sizeof(struct device), GFP_KERNEL);

Should check the return values of kzalloc() here.  
kzalloc(sizeof(*soc_parent), GFP_KERNEL) might be a bit safer too.

> +	soc_info_put(soc_dev);

soc_info_put() sounds like a reference counting thing to me, so 
soc_info_populate() would be nicer :-)

> +
> +	ret = soc_device_register(soc_parent, soc_dev);
> +
> +	if (ret >= 0) {
> +		while (ux500_soc_attrs[i].attr.name != NULL) {
> +			ret = device_create_file(soc_parent, &ux500_soc_attrs[i++]);
> +			if (ret)
> +				goto out;
> +		}
> +	}
> +out:
> +	return ret;
> +}
> +postcore_initcall(ux500_soc_sysfs_init);
> diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
> index a7d363f..a24093f 100644
> --- a/arch/arm/mach-ux500/include/mach/setup.h
> +++ b/arch/arm/mach-ux500/include/mach/setup.h
> @@ -35,6 +35,7 @@ extern void __init amba_add_devices(struct amba_device *devs[], int num);
>  
>  struct sys_timer;
>  extern struct sys_timer ux500_timer;
> +extern struct device *soc_parent;
>  
>  #define __IO_DEV_DESC(x, sz)	{		\
>  	.virtual	= IO_ADDRESS(x),	\
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
