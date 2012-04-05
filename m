From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 5 Apr 2012 10:26:26 +0530
Subject: [PATCH V2 2/4] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <4F7CC713.8040409@wwwdotorg.org>
References: <cover.1333538869.git.viresh.kumar@st.com>
 <d931a52be65ad0b6354cb5de21cd2006ab100ea0.1333538870.git.viresh.kumar@st.com>
 <4F7CC713.8040409@wwwdotorg.org>
Message-ID: <4F7D25FA.8040501@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/5/2012 3:41 AM, Stephen Warren wrote:
> On 04/04/2012 05:35 AM, Viresh Kumar wrote:
>> +int __devinit spear_pinctrl_probe(struct platform_device *pdev,
>> +		struct spear_pinctrl_machdata *machdata)
>> +{
> ...
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> ...
>> +	pmx->vbase = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> 
> If this driver is DT-only, you can replace those two calls with of_iomap().

Ya. This is DT-only. Will do that.

>> +	platform_set_drvdata(pdev, pmx);
> 
> This should probably before the pinctrl_register() call, just in case
> pinctrl_register() starts calling the pinctrl driver ops immediately,
> and the drvdata is needed by the callbacks.

I don't use platform_get_drvdata in ops. Only used in remove routine.
Still would move it up.

> (Yes, I should fix up the Tegra driver for both of those)

:)

>> +	dev_info(&pdev->dev, "Registered with virtual address 0x%08x, physical address 0x%08x\n",
>> +			(u32)pmx->vbase, res->start);
> 
> Is that useful?

It does. Can easily check from boot prints that everything worked as planned.

>> +int __devexit spear_pinctrl_remove(struct platform_device *pdev)
>> +{
>> +	struct spear_pmx *pmx = platform_get_drvdata(pdev);
>> +
>> +	platform_set_drvdata(pdev, NULL);
> 
> You don't need to do that; nothing should be touching the drvdata once
> the driver has been removed, so the value doesn't matter.

Why do most of the drivers do this? What can get called for them?

-- 
viresh
