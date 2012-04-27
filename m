From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Apr 2012 09:49:00 -0600
Subject: [PATCHv3 2/4] ARM: tegra: Add SMMU enabler in AHB
In-Reply-To: <20120427.094826.1181797260264746303.hdoyu@nvidia.com>
References: <20120426202610.GA30690@arwen.pp.htv.fi><4F99B0F8.4040308@wwwdotorg.org><20120426203847.GC30690@arwen.pp.htv.fi>
 <20120427.094826.1181797260264746303.hdoyu@nvidia.com>
Message-ID: <4F9ABFEC.3090107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2012 12:48 AM, Hiroshi Doyu wrote:
...
> Then, what about something like the following?
> 
>  static int tegra_ahb_match_by_smmu(struct device *dev, void *data)
>  {
>  	struct tegra_ahb *ahb = dev_get_drvdata(dev);
>  	struct device_node *dn = data;
>  
>  	return (ahb->dev->of_node == dn) ? 1 : 0
>  }

I imagine that function and the driver_find_device() call that uses it
will be pretty common. It may make sense as a drivers/of utility
function, although perhaps we can wait until later to refactor it, once
we actually have multiple pieces of code that do this same thing.

>  int tegra_ahb_enable_smmu(struct device_node *ahb)
>  {
>  	struct device *dev;
>  	u32 val;
>  
>  	dev = driver_find_device(&tegra_ahb_driver.driver, NULL, ahb,
>  				 tegra_ahb_match_by_smmu);
>  	if (!dev)
>  		return -ENODEV;

Yes, -EPROBE_DEFER here as you mentioned in your followup email.

>  
>  	val = gizmo_readl(ahb, AHB_ARBITRATION_XBAR_CTRL);
>  	val |= AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE;
>  	gizmo_writel(ahb, val, AHB_ARBITRATION_XBAR_CTRL);
>  	return 0;
>  }
>  EXPORT_SYMBOL(tegra_ahb_enable_smmu);
> 
> 	Modified arch/arm/boot/dts/tegra30.dtsi
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> index 655bc47..28f9138 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -242,5 +242,6 @@
>  	smmu {
>  		compatible = "nvidia,tegra30-smmu";
>  		mc = <&mc>;
> +		ahb = <&ahb>;
>  	};
>  };

Yes, that's probably the best (even only) way to connect the two drivers
precisely.
