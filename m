From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 28 Oct 2015 21:36:56 +0100
Subject: [PATCH v8 10/17] phy: Add driver for rockchip Display Port PHY
In-Reply-To: <1446021033-11537-1-git-send-email-ykk@rock-chips.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1446021033-11537-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1657250.2TWeX0dr1C@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Mittwoch, 28. Oktober 2015, 16:30:33 schrieb Yakir Yang:
> +static int rockchip_dp_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct phy_provider *phy_provider;
> +	struct rockchip_dp_phy *dp;
> +	struct resource *res;

drivers/phy/phy-rockchip-dp.c: In function 'rockchip_dp_phy_probe':
drivers/phy/phy-rockchip-dp.c:86:19: warning: unused variable 'res' [-Wunused-variable]

> +	struct phy *phy;
> +	int ret;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
> +	if (IS_ERR(dp))
> +		return -ENOMEM;
> +
> +	dp->dev = dev;
> +
> +	dp->phy_24m = devm_clk_get(dev, "24m");
> +	if (IS_ERR(dp->phy_24m)) {
> +		dev_err(dev, "cannot get clock 24m\n");
> +		return PTR_ERR(dp->phy_24m);
> +	}
> +
> +	ret = clk_set_rate(dp->phy_24m, 24000000);
> +	if (ret < 0) {
> +		dev_err(dp->dev, "cannot set clock phy_24m %d\n", ret);
> +		return ret;
> +	}
> +
