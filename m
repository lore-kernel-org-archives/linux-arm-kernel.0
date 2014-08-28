From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Aug 2014 19:50:39 +0100
Subject: [PATCH 2/5] phy: exynos5-usbdrd: Add pipe-clk and utmi-clk support
In-Reply-To: <1409212920-28526-3-git-send-email-gautam.vivek@samsung.com>
References: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
 <1409212920-28526-3-git-send-email-gautam.vivek@samsung.com>
Message-ID: <20140828185039.GB18464@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 09:01:57AM +0100, Vivek Gautam wrote:
> Exynos7 SoC has now separate gate control for 125MHz pipe3 phy
> clock, as well as 60MHz utmi phy clock.
> So get the same and control in the phy-exynos5-usbdrd driver.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  .../devicetree/bindings/phy/samsung-phy.txt        |    4 ++++
>  drivers/phy/phy-exynos5-usbdrd.c                   |   24 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
> index 7a6feea..b64d616 100644
> --- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
> @@ -135,6 +135,10 @@ Required properties:
>  	       PHY operations, associated by phy name. It is used to
>  	       determine bit values for clock settings register.
>  	       For Exynos5420 this is given as 'sclk_usbphy30' in CMU.
> +	- optional clocks: Next gen Exynos SoCs have following additional

It's not going to be 'Next gen' for long...

> +			   gate clocks available:
> +			   - phy_pipe: for PIPE3 phy
> +			   - phy_utmi: for UTMI+ phy
>  - samsung,pmu-syscon: phandle for PMU system controller interface, used to
>  		      control pmu registers for power isolation.
>  - #phy-cells : from the generic PHY bindings, must be 1;
> diff --git a/drivers/phy/phy-exynos5-usbdrd.c b/drivers/phy/phy-exynos5-usbdrd.c
> index b05302b..685c108 100644
> --- a/drivers/phy/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/phy-exynos5-usbdrd.c
> @@ -148,6 +148,8 @@ struct exynos5_usbdrd_phy_drvdata {
>   * @dev: pointer to device instance of this platform device
>   * @reg_phy: usb phy controller register memory base
>   * @clk: phy clock for register access
> + * @pipeclk: clock for pipe3 phy
> + * @utmiclk: clock for utmi+ phy
>   * @drv_data: pointer to SoC level driver data structure
>   * @phys[]: array for 'EXYNOS5_DRDPHYS_NUM' number of PHY
>   *	    instances each with its 'phy' and 'phy_cfg'.
> @@ -161,6 +163,8 @@ struct exynos5_usbdrd_phy {
>  	struct device *dev;
>  	void __iomem *reg_phy;
>  	struct clk *clk;
> +	struct clk *pipeclk;
> +	struct clk *utmiclk;
>  	const struct exynos5_usbdrd_phy_drvdata *drv_data;
>  	struct phy_usb_instance {
>  		struct phy *phy;
> @@ -446,6 +450,10 @@ static int exynos5_usbdrd_phy_power_on(struct phy *phy)
>  
>  	dev_dbg(phy_drd->dev, "Request to power_on usbdrd_phy phy\n");
>  
> +	if (!IS_ERR(phy_drd->utmiclk))
> +		clk_prepare_enable(phy_drd->utmiclk);
> +	if (!IS_ERR(phy_drd->pipeclk))
> +		clk_prepare_enable(phy_drd->pipeclk);
>  	clk_prepare_enable(phy_drd->ref_clk);
>  
>  	/* Enable VBUS supply */
> @@ -464,6 +472,10 @@ static int exynos5_usbdrd_phy_power_on(struct phy *phy)
>  
>  fail_vbus:
>  	clk_disable_unprepare(phy_drd->ref_clk);
> +	if (!IS_ERR(phy_drd->pipeclk))
> +		clk_disable_unprepare(phy_drd->pipeclk);
> +	if (!IS_ERR(phy_drd->utmiclk))
> +		clk_disable_unprepare(phy_drd->utmiclk);
>  
>  	return ret;
>  }
> @@ -483,6 +495,10 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
>  		regulator_disable(phy_drd->vbus);
>  
>  	clk_disable_unprepare(phy_drd->ref_clk);
> +	if (!IS_ERR(phy_drd->pipeclk))
> +		clk_disable_unprepare(phy_drd->pipeclk);
> +	if (!IS_ERR(phy_drd->utmiclk))
> +		clk_disable_unprepare(phy_drd->utmiclk);
>  
>  	return 0;
>  }
> @@ -581,6 +597,14 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
>  		return PTR_ERR(phy_drd->clk);
>  	}
>  
> +	phy_drd->pipeclk = devm_clk_get(dev, "phy_pipe");
> +	if (IS_ERR(phy_drd->pipeclk))
> +		dev_warn(dev, "Failed to get pipe3 phy operational clock\n");
> +
> +	phy_drd->utmiclk = devm_clk_get(dev, "phy_utmi");
> +	if (IS_ERR(phy_drd->utmiclk))
> +		dev_warn(dev, "Failed to get utmi phy operational clock\n");
> +

Pointless warnings for !Exynos7?

Would it not be better to set these to NULL and not litter the code with
IS_ERR checks?

Mark.
