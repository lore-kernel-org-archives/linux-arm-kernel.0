From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Apr 2012 16:11:31 -0600
Subject: [PATCH V2 2/4] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <d931a52be65ad0b6354cb5de21cd2006ab100ea0.1333538870.git.viresh.kumar@st.com>
References: <cover.1333538869.git.viresh.kumar@st.com>
 <d931a52be65ad0b6354cb5de21cd2006ab100ea0.1333538870.git.viresh.kumar@st.com>
Message-ID: <4F7CC713.8040409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2012 05:35 AM, Viresh Kumar wrote:
> This adds pinctrl driver for SPEAr platform. It also updates MAINTAINERS file
> for SPEAr pinctrl drivers.

> +int __devinit spear_pinctrl_probe(struct platform_device *pdev,
> +		struct spear_pinctrl_machdata *machdata)
> +{
...
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
...
> +	pmx->vbase = devm_ioremap(&pdev->dev, res->start, resource_size(res));

If this driver is DT-only, you can replace those two calls with of_iomap().

> +	platform_set_drvdata(pdev, pmx);

This should probably before the pinctrl_register() call, just in case
pinctrl_register() starts calling the pinctrl driver ops immediately,
and the drvdata is needed by the callbacks.

(Yes, I should fix up the Tegra driver for both of those)

> +	dev_info(&pdev->dev, "Registered with virtual address 0x%08x, physical address 0x%08x\n",
> +			(u32)pmx->vbase, res->start);

Is that useful?

> +int __devexit spear_pinctrl_remove(struct platform_device *pdev)
> +{
> +	struct spear_pmx *pmx = platform_get_drvdata(pdev);
> +
> +	platform_set_drvdata(pdev, NULL);

You don't need to do that; nothing should be touching the drvdata once
the driver has been removed, so the value doesn't matter.
