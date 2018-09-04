From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 4 Sep 2018 07:54:41 +0530
Subject: [PATCH] phy: Convert to using %pOFn instead of device_node.name
In-Reply-To: <20180828015252.28511-39-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-39-robh@kernel.org>
Message-ID: <9dcceda0-1d92-0a7a-feb1-887414021ac9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tuesday 28 August 2018 07:22 AM, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

I assume it should be okay to get this merged in the next merge window?

Thanks
Kishon
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/phy/broadcom/phy-bcm-cygnus-pcie.c    | 4 ++--
>   drivers/phy/broadcom/phy-brcm-sata.c          | 4 ++--
>   drivers/phy/marvell/phy-berlin-sata.c         | 6 +++---
>   drivers/phy/qualcomm/phy-qcom-qmp.c           | 2 +-
>   drivers/phy/rockchip/phy-rockchip-emmc.c      | 4 ++--
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 8 ++++----
>   drivers/phy/rockchip/phy-rockchip-typec.c     | 8 ++++----
>   drivers/phy/rockchip/phy-rockchip-usb.c       | 4 ++--
>   drivers/phy/tegra/xusb.c                      | 4 ++--
>   9 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c b/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
> index 0f4ac5d63cff..b074682d9dd8 100644
> --- a/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
> +++ b/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
> @@ -153,8 +153,8 @@ static int cygnus_pcie_phy_probe(struct platform_device *pdev)
>   		struct cygnus_pcie_phy *p;
>   
>   		if (of_property_read_u32(child, "reg", &id)) {
> -			dev_err(dev, "missing reg property for %s\n",
> -				child->name);
> +			dev_err(dev, "missing reg property for %pOFn\n",
> +				child);
>   			ret = -EINVAL;
>   			goto put_child;
>   		}
> diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
> index 8708ea3b4d6d..ac57f5a41708 100644
> --- a/drivers/phy/broadcom/phy-brcm-sata.c
> +++ b/drivers/phy/broadcom/phy-brcm-sata.c
> @@ -600,8 +600,8 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>   		struct brcm_sata_port *port;
>   
>   		if (of_property_read_u32(child, "reg", &id)) {
> -			dev_err(dev, "missing reg property in node %s\n",
> -					child->name);
> +			dev_err(dev, "missing reg property in node %pOFn\n",
> +					child);
>   			ret = -EINVAL;
>   			goto put_child;
>   		}
> diff --git a/drivers/phy/marvell/phy-berlin-sata.c b/drivers/phy/marvell/phy-berlin-sata.c
> index c1bb6725e48f..a91fc67fc4e0 100644
> --- a/drivers/phy/marvell/phy-berlin-sata.c
> +++ b/drivers/phy/marvell/phy-berlin-sata.c
> @@ -231,14 +231,14 @@ static int phy_berlin_sata_probe(struct platform_device *pdev)
>   		struct phy_berlin_desc *phy_desc;
>   
>   		if (of_property_read_u32(child, "reg", &phy_id)) {
> -			dev_err(dev, "missing reg property in node %s\n",
> -				child->name);
> +			dev_err(dev, "missing reg property in node %pOFn\n",
> +				child);
>   			ret = -EINVAL;
>   			goto put_child;
>   		}
>   
>   		if (phy_id >= ARRAY_SIZE(phy_berlin_power_down_bits)) {
> -			dev_err(dev, "invalid reg in node %s\n", child->name);
> +			dev_err(dev, "invalid reg in node %pOFn\n", child);
>   			ret = -EINVAL;
>   			goto put_child;
>   		}
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 4c470104a0d6..baa59484a90c 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1400,7 +1400,7 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>   
>   	ret = of_property_read_string(np, "clock-output-names", &init.name);
>   	if (ret) {
> -		dev_err(qmp->dev, "%s: No clock-output-names\n", np->name);
> +		dev_err(qmp->dev, "%pOFn: No clock-output-names\n", np);
>   		return ret;
>   	}
>   
> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
> index b237360f95f6..19bf84f0bc67 100644
> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
> @@ -337,8 +337,8 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	if (of_property_read_u32(dev->of_node, "reg", &reg_offset)) {
> -		dev_err(dev, "missing reg property in node %s\n",
> -			dev->of_node->name);
> +		dev_err(dev, "missing reg property in node %pOFn\n",
> +			dev->of_node);
>   		return -EINVAL;
>   	}
>   
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 5049dac79bd0..24bd2717abdb 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1116,8 +1116,8 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>   	}
>   
>   	if (of_property_read_u32(np, "reg", &reg)) {
> -		dev_err(dev, "the reg property is not assigned in %s node\n",
> -			np->name);
> +		dev_err(dev, "the reg property is not assigned in %pOFn node\n",
> +			np);
>   		return -EINVAL;
>   	}
>   
> @@ -1143,8 +1143,8 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>   	}
>   
>   	if (!rphy->phy_cfg) {
> -		dev_err(dev, "no phy-config can be matched with %s node\n",
> -			np->name);
> +		dev_err(dev, "no phy-config can be matched with %pOFn node\n",
> +			np);
>   		return -EINVAL;
>   	}
>   
> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
> index 76a4b58ec771..c57e496f0b0c 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
> @@ -1145,8 +1145,8 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
>   	}
>   
>   	if (!tcphy->port_cfgs) {
> -		dev_err(dev, "no phy-config can be matched with %s node\n",
> -			np->name);
> +		dev_err(dev, "no phy-config can be matched with %pOFn node\n",
> +			np);
>   		return -EINVAL;
>   	}
>   
> @@ -1186,8 +1186,8 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
>   			continue;
>   
>   		if (IS_ERR(phy)) {
> -			dev_err(dev, "failed to create phy: %s\n",
> -				child_np->name);
> +			dev_err(dev, "failed to create phy: %pOFn\n",
> +				child_np);
>   			pm_runtime_disable(dev);
>   			return PTR_ERR(phy);
>   		}
> diff --git a/drivers/phy/rockchip/phy-rockchip-usb.c b/drivers/phy/rockchip/phy-rockchip-usb.c
> index 3378eeb7a562..269c86329cb8 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usb.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usb.c
> @@ -208,8 +208,8 @@ static int rockchip_usb_phy_init(struct rockchip_usb_phy_base *base,
>   	rk_phy->np = child;
>   
>   	if (of_property_read_u32(child, "reg", &reg_offset)) {
> -		dev_err(base->dev, "missing reg property in node %s\n",
> -			child->name);
> +		dev_err(base->dev, "missing reg property in node %pOFn\n",
> +			child);
>   		return -EINVAL;
>   	}
>   
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index de1b4ebe4de2..5b3b8863363e 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -115,8 +115,8 @@ int tegra_xusb_lane_parse_dt(struct tegra_xusb_lane *lane,
>   
>   	err = match_string(lane->soc->funcs, lane->soc->num_funcs, function);
>   	if (err < 0) {
> -		dev_err(dev, "invalid function \"%s\" for lane \"%s\"\n",
> -			function, np->name);
> +		dev_err(dev, "invalid function \"%s\" for lane \"%pOFn\"\n",
> +			function, np);
>   		return err;
>   	}
>   
> 
