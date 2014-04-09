From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 09 Apr 2014 13:06:26 +0200
Subject: [PATCH V4 1/5] phy: Add new Exynos5 USB 3.0 PHY driver
In-Reply-To: <1396967803-28868-2-git-send-email-gautam.vivek@samsung.com>
References: <1396967803-28868-1-git-send-email-gautam.vivek@samsung.com>
 <1396967803-28868-2-git-send-email-gautam.vivek@samsung.com>
Message-ID: <534529B2.2020107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

Please see my comments inline.

On 08.04.2014 16:36, Vivek Gautam wrote:
> Add a new driver for the USB 3.0 PHY on Exynos5 series of SoCs.
> The new driver uses the generic PHY framework and will interact
> with DWC3 controller present on Exynos5 series of SoCs.
> Thereby, removing old phy-samsung-usb3 driver and related code
> used untill now which was based on usb/phy framework.
>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>   .../devicetree/bindings/phy/samsung-phy.txt        |   42 ++
>   drivers/phy/Kconfig                                |   11 +
>   drivers/phy/Makefile                               |    1 +
>   drivers/phy/phy-exynos5-usbdrd.c                   |  668 ++++++++++++++++++++
>   4 files changed, 722 insertions(+)
>   create mode 100644 drivers/phy/phy-exynos5-usbdrd.c

[snip]

> +	Additional clock required for Exynos5420:
> +	- usb30_sclk_100m: Additional special clock used for PHY operation
> +			   depicted as 'sclk_usbphy30' in CMU of Exynos5420.

Are you sure this isn't simply a gate for the ref clock, as it can be 
found on another SoC that is not upstream yet? I don't have 
documentation for Exynos 5420 so I can't tell, but I'd like to ask you 
to recheck this.

> +- samsung,syscon-phandle: phandle for syscon interface, which is used to
> +			  control pmu registers for power isolation.
> +- samsung,pmu-offset: phy power control register offset to pmu-system-controller
> +		      base.
> +- #phy-cells : from the generic PHY bindings, must be 1;
> +
> +For "samsung,exynos5250-usbdrd-phy" and "samsung,exynos5420-usbdrd-phy"
> +compatible PHYs, the second cell in the PHY specifier identifies the
> +PHY id, which is interpreted as follows:
> +  0 - UTMI+ type phy,
> +  1 - PIPE3 type phy,
> +
> +Example:
> +	usb3_phy: usbphy at 12100000 {
> +		compatible = "samsung,exynos5250-usbdrd-phy";
> +		reg = <0x12100000 0x100>;
> +		clocks = <&clock 286>, <&clock 1>;
> +		clock-names = "phy", "usb3phy_refclk";

Binding description above doesn't mention "usb3phy_refclk" entry.

> +		samsung,syscon-phandle = <&pmu_syscon>;
> +		samsung,pmu-offset = <0x704>;
> +		#phy-cells = <1>;
> +	};

[snip]

> diff --git a/drivers/phy/phy-exynos5-usbdrd.c b/drivers/phy/phy-exynos5-usbdrd.c
> new file mode 100644
> index 0000000..ff54a7c
> --- /dev/null
> +++ b/drivers/phy/phy-exynos5-usbdrd.c

[snip]

> +static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct exynos5_usbdrd_phy *phy_drd;
> +	struct phy_provider *phy_provider;
> +	struct resource *res;
> +	const struct of_device_id *match;
> +	const struct exynos5_usbdrd_phy_drvdata *drv_data;
> +	struct regmap *reg_pmu;
> +	u32 pmu_offset;
> +	int i;
> +
> +	/*
> +	 * Exynos systems are completely DT enabled,
> +	 * so lets not have any platform data support for this driver.
> +	 */
> +	if (!node) {
> +		dev_err(dev, "no device node found\n");

This error message is not very meaningful. I'd rather use something like 
"This driver can be only instantiated using Device Tree".

> +		return -ENODEV;
> +	}
> +
> +	match = of_match_node(exynos5_usbdrd_phy_of_match, pdev->dev.of_node);
> +	if (!match) {
> +		dev_err(dev, "of_match_node() failed\n");
> +		return -EINVAL;
> +	}
> +	drv_data = match->data;
> +
> +	phy_drd = devm_kzalloc(dev, sizeof(*phy_drd), GFP_KERNEL);
> +	if (!phy_drd)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, phy_drd);
> +	phy_drd->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	phy_drd->reg_phy = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(phy_drd->reg_phy)) {
> +		dev_err(dev, "Failed to map register memory (phy)\n");

devm_ioremap_resource() already prints an error message.

Best regards,
Tomasz
