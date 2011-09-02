From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 2 Sep 2011 16:31:01 +0200
Subject: [PATCH 3/5] mach-ux500: export System-on-Chip information ux500
	via sysfs
In-Reply-To: <1314880043-22517-3-git-send-email-lee.jones@linaro.org>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
	<1314880043-22517-3-git-send-email-lee.jones@linaro.org>
Message-ID: <201109021631.01527.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 September 2011, Lee Jones wrote:
> Here we make use of the new drivers/base/soc driver to export
> vital SoC information out to userspace via sysfs. This patch
> provides a data structure of strings to populate the base
> nodes found in:
> 
> /sys/devices/soc/[1|2|3|...]/[family|machine|revision|soc_id].
> 
> It also adds one more node as requested by ST-Ericsson.
> 'process' depicts the way in which the silicon was manufactured.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

The code looks much better than last time, but the description still
talks about 'using the drivers/base/soc driver', which is not how
you should think of or describe what you are doing.

What you do here is make the db8500 support an soc driver.

> diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
> index d35122e..8fd53c7 100644
> --- a/arch/arm/mach-ux500/id.c
> +++ b/arch/arm/mach-ux500/id.c

You should probably rename this file or fold it into one of the db8500
files.

>  }
> +
> +struct soc_device *soc_dev;
> +
> +static const char *ux500_get_machine(void)
> +{
> +	return kasprintf(GFP_KERNEL, "DB%4x", dbx500_partnumber());
> +}
> +
> +static const char *ux500_get_family(void)
> +{
> +	return kasprintf(GFP_KERNEL, "Ux500");
> +}
> +
> +static const char *ux500_get_revision(void)
> +{
> +	unsigned int rev = dbx500_revision();
> +
> +	if (rev == 0x01) {
> +		return kasprintf(GFP_KERNEL, "%s", "ED");
> +	}
> +	else if (rev >= 0xA0) {
> +		return kasprintf(GFP_KERNEL, "%d.%d" , (rev >> 4) - 0xA + 1, rev & 0xf);
> +	}
> +
> +	return kasprintf(GFP_KERNEL, "%s", "Unknown");
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
> +static void soc_info_populate(struct soc_device *soc_dev)
> +{
> +	soc_dev->machine  = ux500_get_machine();
> +	soc_dev->family   = ux500_get_family();
> +	soc_dev->revision = ux500_get_revision();
> +}

It's often better to have multiple smaller functions than to do
something too complex in just one function, but I think you are
overdoing it here. Not a huge problem though, just my opinion
on coding style.

> +struct device_attribute ux500_soc_attrs[] = {
> +	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL),
> +	__ATTR_NULL,
> +};
> +
> +static int __init ux500_soc_sysfs_init(void)
> +{
> +	int ret;
> +	int i = 0;
> +
> +	soc_dev = kzalloc(sizeof(*soc_dev), GFP_KERNEL);
> +	if (soc_dev == NULL)
> +		return -ENOMEM;
> +
> +	soc_info_populate(soc_dev);
> +
> +	ret = soc_device_register(&soc_dev->dev);
> +
> +	if (ret >= 0) {
> +		while (ux500_soc_attrs[i].attr.name != NULL) {
> +			ret = device_create_file(&soc_dev->dev, &ux500_soc_attrs[i++]);
> +			if (ret)
> +				goto out;
> +		}
> +	}

Better not make it too easy to add more of these, you don't want to
have people add random stuff here, so I would recommend just
using one device_create_file calls without the loop.

> diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
> index a7d363f..7d4c35f 100644
> --- a/arch/arm/mach-ux500/include/mach/setup.h
> +++ b/arch/arm/mach-ux500/include/mach/setup.h
> @@ -35,6 +35,7 @@ extern void __init amba_add_devices(struct amba_device *devs[], int num);
>  
>  struct sys_timer;
>  extern struct sys_timer ux500_timer;
> +extern struct soc_device *soc_dev;

Do you really need to make this global?

The soc_dev is the central data structure describing your soc system, so
you should have it available in all the places where it might be needed
anyway, e.g. to get the base address, as described in the other mail.

	Arnd
