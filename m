From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Thu, 1 Sep 2016 11:47:55 +0530
Subject: [PATCH v3 21/22] phy: Add support for Qualcomm's USB HSIC phy
In-Reply-To: <20160901004036.23936-22-stephen.boyd@linaro.org>
References: <20160901004036.23936-1-stephen.boyd@linaro.org>
 <20160901004036.23936-22-stephen.boyd@linaro.org>
Message-ID: <CAFp+6iGJo5P3_oFCboKmOno6QzcMhVHhTWVWPFw3fCop0PSa8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,


On Thu, Sep 1, 2016 at 6:10 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> The HSIC USB controller on qcom SoCs has an integrated all
> digital phy controlled via the ULPI viewport.
>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,usb-hsic-phy.txt  |  65 +++++++++
>  drivers/phy/Kconfig                                |   7 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-qcom-usb-hsic.c                    | 160 +++++++++++++++++++++
>  4 files changed, 233 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
>  create mode 100644 drivers/phy/phy-qcom-usb-hsic.c
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt b/Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
> new file mode 100644
> index 000000000000..3c7cb2be4b12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
> @@ -0,0 +1,65 @@
> +Qualcomm's USB HSIC PHY
> +
> +PROPERTIES
> +
> +- compatible:
> +    Usage: required
> +    Value type: <string>
> +    Definition: Should contain "qcom,usb-hsic-phy" and more specifically one of the
> +               following:
> +
> +                       "qcom,usb-hsic-phy-mdm9615"
> +                       "qcom,usb-hsic-phy-msm8974"
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
> +                a calibration sleep clock
> +
> +- clock-names:
> +    Usage: required
> +    Value type: <stringlist>
> +    Definition: Should contain "phy, "cal" and "cal_sleep"
> +
> +- pinctrl-names:
> +    Usage: required
> +    Value type: <stringlist>
> +    Definition: Should contain "init" and "default" in that order
> +
> +- pinctrl-0:
> +    Usage: required
> +    Value type: <prop-encoded-array>
> +    Definition: List of pinctrl settings to apply to keep HSIC pins in a glitch
> +                free state
> +
> +- pinctrl-1:
> +    Usage: required
> +    Value type: <prop-encoded-array>
> +    Definition: List of pinctrl settings to apply to mux out the HSIC pins
> +
> +EXAMPLE
> +
> +usb-controller {
> +       ulpi {
> +               phy {
> +                       compatible = "qcom,usb-hsic-phy-msm8974",
> +                                    "qcom,usb-hsic-phy";
> +                       #phy-cells = <0>;
> +                       pinctrl-names = "init", "default";
> +                       pinctrl-0 = <&hsic_sleep>;
> +                       pinctrl-1 = <&hsic_default>;
> +                       clocks = <&gcc GCC_USB_HSIC_CLK>,
> +                                <&gcc GCC_USB_HSIC_IO_CAL_CLK>,
> +                                <&gcc GCC_USB_HSIC_IO_CAL_SLEEP_CLK>;
> +                       clock-names = "phy", "cal", "cal_sleep";
> +                       assigned-clocks = <&gcc GCC_USB_HSIC_IO_CAL_CLK>;
> +                       assigned-clock-rates = <960000>;
> +               };
> +       };
> +};
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 19bff3a10f69..830c443eeabf 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -417,6 +417,13 @@ config PHY_QCOM_UFS
>         help
>           Support for UFS PHY on QCOM chipsets.
>
> +config PHY_QCOM_USB_HSIC
> +       tristate "Qualcomm USB HSIC ULPI PHY module"
> +       depends on USB_ULPI_BUS
> +       select GENERIC_PHY
> +       help
> +         Support for the USB HSIC ULPI compliant PHY on QCOM chipsets.
> +
>  config PHY_TUSB1210
>         tristate "TI TUSB1210 ULPI PHY module"
>         depends on USB_ULPI_BUS
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 90ae19879b0a..5422f543d17d 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_PHY_STIH41X_USB)         += phy-stih41x-usb.o
>  obj-$(CONFIG_PHY_QCOM_UFS)     += phy-qcom-ufs.o
>  obj-$(CONFIG_PHY_QCOM_UFS)     += phy-qcom-ufs-qmp-20nm.o
>  obj-$(CONFIG_PHY_QCOM_UFS)     += phy-qcom-ufs-qmp-14nm.o
> +obj-$(CONFIG_PHY_QCOM_USB_HSIC)        += phy-qcom-usb-hsic.o
>  obj-$(CONFIG_PHY_TUSB1210)             += phy-tusb1210.o
>  obj-$(CONFIG_PHY_BRCM_SATA)            += phy-brcm-sata.o
>  obj-$(CONFIG_PHY_PISTACHIO_USB)                += phy-pistachio-usb.o
> diff --git a/drivers/phy/phy-qcom-usb-hsic.c b/drivers/phy/phy-qcom-usb-hsic.c
> new file mode 100644
> index 000000000000..47690f9945b9
> --- /dev/null
> +++ b/drivers/phy/phy-qcom-usb-hsic.c
> @@ -0,0 +1,160 @@
> +/**
> + * Copyright (C) 2016 Linaro Ltd
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/module.h>
> +#include <linux/ulpi/driver.h>
> +#include <linux/ulpi/regs.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/pinctrl/pinctrl-state.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +
> +#include "ulpi_phy.h"
> +
> +#define ULPI_HSIC_CFG          0x30
> +#define ULPI_HSIC_IO_CAL       0x33
> +
> +struct qcom_usb_hsic_phy {
> +       struct ulpi *ulpi;
> +       struct phy *phy;
> +       struct pinctrl *pctl;
> +       struct clk *phy_clk;
> +       struct clk *cal_clk;
> +       struct clk *cal_sleep_clk;
> +};
> +
> +static int qcom_usb_hsic_phy_power_on(struct phy *phy)
> +{
> +       struct qcom_usb_hsic_phy *uphy = phy_get_drvdata(phy);
> +       struct ulpi *ulpi = uphy->ulpi;
> +       struct pinctrl_state *pins_default;
> +       int ret;
> +
> +       ret = clk_prepare_enable(uphy->phy_clk);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(uphy->cal_clk);
> +       if (ret)
> +               goto err_cal;
> +
> +       ret = clk_prepare_enable(uphy->cal_sleep_clk);
> +       if (ret)
> +               goto err_sleep;
> +
> +       /* Set periodic calibration interval to ~2.048sec in HSIC_IO_CAL_REG */
> +       ret = ulpi_write(ulpi, ULPI_HSIC_IO_CAL, 0xff);
> +       if (ret)
> +               goto err_ulpi;
> +
> +       /* Enable periodic IO calibration in HSIC_CFG register */
> +       ret = ulpi_write(ulpi, ULPI_HSIC_CFG, 0xa8);
> +       if (ret)
> +               goto err_ulpi;
> +
> +       /* Configure pins for HSIC functionality */
> +       pins_default = pinctrl_lookup_state(uphy->pctl, PINCTRL_STATE_DEFAULT);
> +       if (IS_ERR(pins_default))
> +               return PTR_ERR(pins_default);
> +
> +       ret = pinctrl_select_state(uphy->pctl, pins_default);
> +       if (ret)
> +               goto err_ulpi;
> +
> +        /* Enable HSIC mode in HSIC_CFG register */
> +       ret = ulpi_write(ulpi, ULPI_SET(ULPI_HSIC_CFG), 0x01);
> +       if (ret)
> +               goto err_ulpi;
> +
> +       /* Disable auto-resume */
> +       ret = ulpi_write(ulpi, ULPI_CLR(ULPI_IFC_CTRL),
> +                        ULPI_IFC_CTRL_AUTORESUME);
> +       if (ret)
> +               goto err_ulpi;
> +
> +       return ret;
> +err_ulpi:
> +       clk_disable_unprepare(uphy->cal_sleep_clk);
> +err_sleep:
> +       clk_disable_unprepare(uphy->cal_clk);
> +err_cal:
> +       clk_disable_unprepare(uphy->phy_clk);
> +       return ret;
> +}
> +
> +static int qcom_usb_hsic_phy_power_off(struct phy *phy)
> +{
> +       struct qcom_usb_hsic_phy *uphy = phy_get_drvdata(phy);
> +
> +       clk_disable_unprepare(uphy->cal_sleep_clk);
> +       clk_disable_unprepare(uphy->cal_clk);
> +       clk_disable_unprepare(uphy->phy_clk);
> +
> +       return 0;
> +}
> +
> +static const struct phy_ops qcom_usb_hsic_phy_ops = {
> +       .power_on = qcom_usb_hsic_phy_power_on,
> +       .power_off = qcom_usb_hsic_phy_power_off,
> +       .owner = THIS_MODULE,
> +};
> +
> +static int qcom_usb_hsic_phy_probe(struct ulpi *ulpi)
> +{
> +       struct qcom_usb_hsic_phy *uphy;
> +       struct phy_provider *p;
> +       struct clk *clk;
> +
> +       uphy = devm_kzalloc(&ulpi->dev, sizeof(*uphy), GFP_KERNEL);
> +       if (!uphy)
> +               return -ENOMEM;
> +       ulpi_set_drvdata(ulpi, uphy);
> +
> +       uphy->ulpi = ulpi;
> +       uphy->pctl = devm_pinctrl_get(&ulpi->dev);
> +       if (IS_ERR(uphy->pctl))
> +               return PTR_ERR(uphy->pctl);
> +
> +       uphy->phy_clk = clk = devm_clk_get(&ulpi->dev, "phy");
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       uphy->cal_clk = clk = devm_clk_get(&ulpi->dev, "cal");
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       uphy->cal_sleep_clk = clk = devm_clk_get(&ulpi->dev, "cal_sleep");
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       uphy->phy = devm_phy_create(&ulpi->dev, ulpi->dev.of_node,
> +                                   &qcom_usb_hsic_phy_ops);

There's a ulpi_phy library available in  drivers/phy/. Do we want to use that ?
That also creates a phy-lookup of this PHY so that the ulpi device's parent
can request the PHY.

You may want to modify the APIs available in ulpi_phy library to use the
devm_* APIs.

same applies to the next patch in the series.

> +       if (IS_ERR(uphy->phy))
> +               return PTR_ERR(uphy->phy);
> +       phy_set_drvdata(uphy->phy, uphy);
> +
> +       p = devm_of_phy_provider_register(&ulpi->dev, of_phy_simple_xlate);
> +       return PTR_ERR_OR_ZERO(p);
> +}
> +
> +static const struct of_device_id qcom_usb_hsic_phy_match[] = {
> +       { .compatible = "qcom,usb-hsic-phy", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, qcom_usb_hsic_phy_match);
> +
> +static struct ulpi_driver qcom_usb_hsic_phy_driver = {
> +       .probe = qcom_usb_hsic_phy_probe,
> +       .driver = {
> +               .name = "qcom_usb_hsic_phy",
> +               .of_match_table = qcom_usb_hsic_phy_match,
> +       },
> +};
> +module_ulpi_driver(qcom_usb_hsic_phy_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm USB HSIC phy");
> +MODULE_LICENSE("GPL v2");
> --
> 2.9.0.rc2.8.ga28705d
>
