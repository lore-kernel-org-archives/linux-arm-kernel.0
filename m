From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Apr 2012 13:55:13 -0600
Subject: [PATCHv3 2/4] ARM: tegra: Add SMMU enabler in AHB
In-Reply-To: <1335352072-4001-2-git-send-email-hdoyu@nvidia.com>
References: <1335352072-4001-1-git-send-email-hdoyu@nvidia.com>
 <1335352072-4001-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <4F99A821.2040406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2012 05:07 AM, Hiroshi DOYU wrote:
> Add extern func, "tegra_ahb_enable_smmu()" to inform AHB that SMMU is
> ready.

> +#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> +static int __tegra_ahb_enable_smmu(struct device *dev, void *data)
...
> +int tegra_ahb_enable_smmu(void)
> +{
> +	return driver_for_each_device(&tegra_ahb_driver.driver, NULL, NULL,
> +				      __tegra_ahb_enable_smmu);
> +}
> +EXPORT_SYMBOL(tegra_ahb_enable_smmu);
> +#endif

That looks like a neat solution to avoid having a global device object.

However, if that driver_for_each_device finds no devices, the function
still succeeds. That doesn't seem right, and doesn't allow e.g. the SMMU
to defer its probe until the AHB driver has completed.

Perhaps add a local int variable to tegra_ahb_enable_smmu(), pass the
address to __tegra_ahb_enable_smmu, and have it increment the int. Then,
after calling driver_for_each_device,:

if (!ahb_device_count)
    return -EPROBE_DEFER
if (WARN_ON(ahb_device_count != 1))
    return -EINVAL;
return 0;
