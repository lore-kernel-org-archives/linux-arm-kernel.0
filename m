From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jun 2011 10:00:13 +0100
Subject: [PATCH 2/3] Samsung SoC: ready to use NTC value inside kernel
In-Reply-To: <1309422387-11546-3-git-send-email-myungjoo.ham@samsung.com>
References: <1309422387-11546-1-git-send-email-myungjoo.ham@samsung.com>
	<1309422387-11546-3-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20110630090013.GP21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 05:26:26PM +0900, MyungJoo Ham wrote:
> diff --git a/arch/arm/plat-samsung/dev-adc.c b/arch/arm/plat-samsung/dev-adc.c
> index 622972c..526097a 100644
> --- a/arch/arm/plat-samsung/dev-adc.c
> +++ b/arch/arm/plat-samsung/dev-adc.c
> @@ -22,6 +22,8 @@
>  #include <plat/devs.h>
>  #include <plat/cpu.h>
>  
> +#include "../../../fs/sysfs/sysfs.h"

That is a big hint that you're doing something wrong.

> @@ -101,3 +103,63 @@ struct platform_device s3c_device_adc_ntc_thermistor = {
>  		.platform_data = &ntc_adc_pdata,
>  	},
>  };
> +
> +static struct device_attribute *ntc_attr;
> +
> +static int init_s3c_adc_ntc_read(void)
> +{
> +	struct kobject *ntc;
> +	struct sysfs_dirent *ntc_d;
> +
> +	ntc = &s3c_device_adc_ntc_thermistor.dev.kobj;
> +	ntc_d = sysfs_get_dirent(ntc->sd, get_ktype(ntc)->namespace(ntc),
> +				 "temp1_input");
> +	if (!ntc_d || sysfs_type(ntc_d) != SYSFS_KOBJ_ATTR) {
> +		dev_err(&s3c_device_adc_ntc_thermistor.dev,
> +			"Cannot initialize thermistor dirent info.\n");
> +		if (ntc_d)
> +			sysfs_put(ntc_d);
> +		return -ENODEV;
> +	}
> +	ntc_attr = container_of(ntc_d->s_attr.attr, struct device_attribute,
> +				attr);
> +
> +	sysfs_put(ntc_d);
> +	if (IS_ERR(ntc_attr)) {
> +		dev_err(&s3c_device_adc_ntc_thermistor.dev,
> +			"Cannot access NTC thermistor.\n");
> +		return PTR_ERR(ntc_attr);
> +	}
> +
> +	return 0;
> +}
> +
> +/* A helper function to read values from NTC, in 1/1000 Centigrade */
> +int read_s3c_adc_ntc(int *mC)
> +{
> +	char buf[32];
> +	int ret;
> +
> +	/* init should be done after ADC and NTC are probed */
> +	if (ntc_attr == NULL) {
> +		ret = init_s3c_adc_ntc_read();
> +		if (ret) {
> +			if (ntc_attr == NULL)
> +				ntc_attr = ERR_PTR(ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (IS_ERR(ntc_attr))
> +		return -ENODEV;
> +
> +	if (!ntc_attr->show)
> +		return -EINVAL;
> +
> +	ret = ntc_attr->show(&s3c_device_adc_ntc_thermistor.dev, ntc_attr, buf);
> +	if (ret < 0)
> +		return ret;
> +	sscanf(buf, "%d", mC);
> +
> +	return 0;
> +}

This is wrong on just about every level.  It needs to be rewritten to
avoid poking about in subsystem internal data structures, and you really
should not be sprint-ing a value to only sscanf it later.

Plus, container_of doesn't return a pointer-error code.

You need to come up with a far better way of doing this altogether.
