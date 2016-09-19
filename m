From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 19 Sep 2016 17:42:16 +0800
Subject: [RFC PATCH v2 05/11] ACPI: platform: setup MSI domain for ACPI
 based platform device
In-Reply-To: <57DABBB3.3020208@arm.com>
References: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
 <1473862879-7769-6-git-send-email-guohanjun@huawei.com>
 <57D97087.5040703@arm.com> <57DAAAAE.6010206@linaro.org>
 <57DABBB3.3020208@arm.com>
Message-ID: <ab8e5cf0-d5d6-c2c7-11c7-f0b738460f91@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/9/15 23:18, Marc Zyngier wrote:
> On 15/09/16 15:05, Hanjun Guo wrote:
>> Hi Marc,
[...]
>>>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>>>> index 6482d47..ea01a37 100644
>>>> --- a/drivers/base/platform.c
>>>> +++ b/drivers/base/platform.c
>>>> @@ -24,6 +24,7 @@
>>>>   #include <linux/pm_domain.h>
>>>>   #include <linux/idr.h>
>>>>   #include <linux/acpi.h>
>>>> +#include <linux/msi.h>
>>>>   #include <linux/clk/clk-conf.h>
>>>>   #include <linux/limits.h>
>>>>   #include <linux/property.h>
>>>> @@ -500,6 +501,7 @@ struct platform_device *platform_device_register_full(
>>>>   	pdev->dev.parent = pdevinfo->parent;
>>>>   	pdev->dev.fwnode = pdevinfo->fwnode;
>>>>
>>>> +	acpi_configure_msi_domain(&pdev->dev);
>>>
>>> It feels odd to put this in the generic code, while you could perfectly
>>> put the call into acpi_platform.c and keep the firmware stuff away from
>>> the generic code.
>>
>> My feeling is the same, I'm still trying to find a new way to do it,
>> but I can't simply put that in acpi_platform.c, because
>>
>> acpi_create_platform_device()
>>     platform_device_register_full()
>> 	platform_device_alloc()  --> dev is alloced
>>          ...
>>          dev.fwnode  is set
>> 	(I get the msi domain by the fwnode in acpi_configure_msi_domain)
>>          ...
>>          platform_device_add()  --> which the device is probed.
>>
>> For devices like irqchip which needs the dev->msi_domain to be
>> set before it's really probed, because it needs the msi domain
>> to be the parent domain.
>>
>> If I call the function in acpi_create_platform_device() before
>> platform_device_register_full(), we just can't set dev's msi
>> domain, but if call it after platform_device_register_full(),
>> the irqchip like mbigen will not get its parent domain...
>>
>> DT is using another API for platform device probe, so has no
>> problems like I said above, any suggestions to do it right in
>> ACPI?
>
> How about having something that's completely generic and solves
> the problem once and for all? Something like this:
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 6482d47..6f0f90b 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -533,6 +533,9 @@ struct platform_device *platform_device_register_full(
>  			goto err;
>  	}
>
> +	if (pdevinfo->pre_add_cb)
> +		pdevinfo->pre_add_cb(&pdev->dev);
> +
>  	ret = platform_device_add(pdev);
>  	if (ret) {
>  err:
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 98c2a7c..44ea133 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -74,6 +74,7 @@ struct platform_device_info {
>  		u64 dma_mask;
>
>  		struct property_entry *properties;
> +		void (*pre_add_cb)(struct device *);
>  };
>  extern struct platform_device *platform_device_register_full(
>  		const struct platform_device_info *pdevinfo);
>
> Plug pre_add_cb with your ACPI callback where you can do all the
> processing you want before the device is actually added.

Great, will do, thank you very much!

Hanjun
