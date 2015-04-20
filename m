From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 20 Apr 2015 22:42:44 +0800
Subject: [PATCH v13 2/3] power-domain: rockchip: add power domain driver
In-Reply-To: <1429522004.14597.8.camel@x220>
References: <1429438552-17733-1-git-send-email-wxt@rock-chips.com>	
 <1429440280-18915-1-git-send-email-wxt@rock-chips.com>
 <1429522004.14597.8.camel@x220>
Message-ID: <55351064.7090409@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

Thanks your commnets!:-)

? 2015?04?20? 17:26, Paul Bolle ??:
> On Sun, 2015-04-19 at 18:44 +0800, Caesar Wang wrote:
>> --- a/arch/arm/mach-rockchip/Makefile
>> +++ b/arch/arm/mach-rockchip/Makefile
> +obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
>
> PM_GENERIC_DOMAINS is a bool symbol, so pm_domains.o can never be part
> of a module. Is that correct?

Yeah, So this platform_driver does not need to set an owner, it will be 
populated by the
driver core.
>
>> --- /dev/null
>> +++ b/arch/arm/mach-rockchip/pm_domains.c
>> +#include <linux/module.h>
> This include could probably be dropped.

Yeah. As the about said.
>> +static const struct of_device_id rockchip_pm_domain_dt_match[] = {
>> +	{
>> +		.compatible = "rockchip,rk3288-power-controller",
>> +		.data = (void *)&rk3288_pmu,
>> +	},
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, rockchip_pm_domain_dt_match);
> The MODULE_DEVICE_TABLE() macro will be preprocessed away for built-in
> code, according to include/linux/module.h.

So,do you think we should remove it?
wow.....,looks we should remove it.
>> +static struct platform_driver rockchip_pm_domain_driver = {
>> +	.probe = rockchip_pm_domain_probe,
>> +	.driver = {
>> +		.name   = "rockchip-pm-domain",
>> +		.owner  = THIS_MODULE,
> According to include/linux/export.h THIS_MODULE is equivalent to NULL
> for built-in code. So I think this line is not needed.
>

Yeah,you are right.
>> +		.of_match_table = rockchip_pm_domain_dt_match,
>> +		/*
>> +		 * We can't forcibly eject devices form power domain,
>> +		 * so we can't really remove power domains once they
>> +		 * were added.
>> +		 */
>> +		.suppress_bind_attrs = true,
>> +	},
>> +};
> Thanks,
>
>
> Paul Bolle
>
>
>
>
Thanks,

Caesar

-- 
**************************************************************************************
???    Caesar Wang
Product R&D Dept.III
Fuzhou Rockchip Electronics Co.Ltd
Addr?  NO.18 Building, A District, Fuzhou Software Park,Gulou District,Fuzhou, Fujian,China(Fuzhou Headquarters)
               21F,Malata Building,Kejizhongyi Avenue,Nanshan District,Shenzhen  (Shenzhen Office)
Tel?+86-591-83991906/07 - 8221
Mobile:+86 15059456742
E-mail : wxt at rock-chips.com
***************************************************************************************
***************************************************************************************
IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents of this email and any attachments may
contain information that is privileged, confidential and/or exempt from disclosure under applicable law and relevant NDA.
If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the
information is STRICTLY PROHIBITED. Please immediately contact the sender as soon as possible and destroy the material
in its entirety in any format. Thank you.
***************************************************************************************
