From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 28 Jun 2016 10:49:37 +0200
Subject: [PATCH 20/21] phy: Add support for Qualcomm's USB HSIC phy
In-Reply-To: <20160626072838.28082-21-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-21-stephen.boyd@linaro.org>
Message-ID: <57723A21.3060602@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2016 09:28 AM, Stephen Boyd wrote:
> The HSIC USB controller on qcom SoCs has an integrated all
> digital phy controlled via the ULPI viewport.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,usb-hsic-phy.txt  |  60 ++++++++
>  drivers/phy/Kconfig                                |   7 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-qcom-usb-hsic.c                    | 161 +++++++++++++++++++++
>  4 files changed, 229 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
>  create mode 100644 drivers/phy/phy-qcom-usb-hsic.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt b/Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
> new file mode 100644
> index 000000000000..6b1c6aad2962
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
> @@ -0,0 +1,60 @@
> +Qualcomm's USB HSIC PHY
> +
> +PROPERTIES
> +
> +- compatible:
> +    Usage: required
> +    Value type: <string>
> +    Definition: Should contain "qcom,usb-hsic-phy"
> +
> +- #phy-cells:
> +    Usage: required
> +    Value type: <u32>
> +    Definition: Should contain 0
> +
> +- clocks:
> +    Usage: required
> +    Value type: <prop-encoded-array>
> +    Definition: Should contain clock specifier for phy, calibration and
> +                optionally a calibration sleep clock
> +
> +- clock-names:
> +    Usage: required
> +    Value type: <stringlist>
> +    Definition: Should contain "phy, "cal" and optionally "cal_sleep"
> +

[...]

> +
> +static int qcom_usb_hsic_phy_power_on(struct phy *phy)
> +{
> +	struct qcom_usb_hsic_phy *uphy = phy_get_drvdata(phy);
> +	struct ulpi *ulpi = uphy->ulpi;
> +	struct pinctrl_state *pins_default;
> +	int ret;
> +
> +	ret = clk_prepare_enable(uphy->phy_clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(uphy->cal_clk);
> +	if (ret)
> +		goto err_cal;
> +
> +	ret = clk_prepare_enable(uphy->cal_sleep_clk);
> +	if (ret)
> +		goto err_sleep;
> +

[...]

> +
> +	return ret;
> +err_ulpi:
> +	clk_disable_unprepare(uphy->cal_sleep_clk);
> +err_sleep:
> +	clk_disable_unprepare(uphy->cal_clk);
> +err_cal:
> +	clk_disable_unprepare(uphy->phy_clk);
> +	return ret;
> +}
> +
> +static int qcom_usb_hsic_phy_power_off(struct phy *phy)
> +{
> +	struct qcom_usb_hsic_phy *uphy = phy_get_drvdata(phy);
> +
> +	clk_disable_unprepare(uphy->cal_sleep_clk);
> +	clk_disable_unprepare(uphy->cal_clk);
> +	clk_disable_unprepare(uphy->phy_clk);

[...]

> +static int qcom_usb_hsic_phy_probe(struct ulpi *ulpi)
> +{
> +	struct qcom_usb_hsic_phy *uphy;
> +	struct phy_provider *p;
> +	struct clk *clk;
> +
> +	uphy = devm_kzalloc(&ulpi->dev, sizeof(*uphy), GFP_KERNEL);
> +	if (!uphy)
> +		return -ENOMEM;
> +	ulpi_set_drvdata(ulpi, uphy);
> +
> +	uphy->ulpi = ulpi;
> +	uphy->pctl = devm_pinctrl_get(&ulpi->dev);
> +	if (IS_ERR(uphy->pctl))
> +		return PTR_ERR(uphy->pctl);
> +
> +	uphy->phy_clk = clk = devm_clk_get(&ulpi->dev, "phy");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	uphy->cal_clk = clk = devm_clk_get(&ulpi->dev, "cal");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	uphy->cal_sleep_clk = clk = devm_clk_get(&ulpi->dev, "cal_sleep");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);

Hi Stephen,

In the bindings the cal_sleep is marked optional, and I think should be since AFAIK
it's not present on MDM9615 for example.

Also MDM9615 HSIC requires "core", "alt-core", "phy", "cal" and "iface" clocks.
I assume "core" can be attributed to the main chipidea node, but I think "alt-core" and "iface" should be also optionnal.

Finally, it misses an optional reset line AFAIK mandatory on MDM9615.

Neil

> +
> +	uphy->phy = devm_phy_create(&ulpi->dev, ulpi->dev.of_node,
> +				    &qcom_usb_hsic_phy_ops);
> +	if (IS_ERR(uphy->phy))
> +		return PTR_ERR(uphy->phy);
> +	phy_set_drvdata(uphy->phy, uphy);
> +
> +	p = devm_of_phy_provider_register(&ulpi->dev, of_phy_simple_xlate);
> +	return PTR_ERR_OR_ZERO(p);
> +}
> +
> +
> +static const struct of_device_id qcom_usb_hsic_phy_match[] = {
> +	{ .compatible = "qcom,usb-hsic-phy", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qcom_usb_hsic_phy_match);
> +
> +static struct ulpi_driver qcom_usb_hsic_phy_driver = {
> +	.probe = qcom_usb_hsic_phy_probe,
> +	.driver = {
> +		.name = "qcom_usb_hsic_phy",
> +		.of_match_table = qcom_usb_hsic_phy_match
> +	},
> +};
> +module_ulpi_driver(qcom_usb_hsic_phy_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm USB HSIC phy");
> +MODULE_LICENSE("GPL v2");
> 
