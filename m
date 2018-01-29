From: robh@kernel.org (Rob Herring)
Date: Mon, 29 Jan 2018 11:52:43 -0600
Subject: [PATCH 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <20180117183244.28303-3-l.stach@pengutronix.de>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-3-l.stach@pengutronix.de>
Message-ID: <20180129175243.yw2ja3bakqw2ih7n@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 07:32:43PM +0100, Lucas Stach wrote:
> This is the evaluation kit board for the i.MX8M. The current level of
> support yields a working console and is able to boot userspace from
> SD card or Network.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm64/boot/dts/nxp/Makefile       |   3 +
>  arch/arm64/boot/dts/nxp/imx8mq-evk.dts | 287 +++++++++++++++++++++++++++++++++
>  2 files changed, 290 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nxp/Makefile
>  create mode 100644 arch/arm64/boot/dts/nxp/imx8mq-evk.dts
> 
> diff --git a/arch/arm64/boot/dts/nxp/Makefile b/arch/arm64/boot/dts/nxp/Makefile
> new file mode 100644
> index 000000000000..1aebb1f16708
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nxp/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +dtb-$(CONFIG_SOC_IMX8MQ) += imx8m-evk.dtb
> diff --git a/arch/arm64/boot/dts/nxp/imx8mq-evk.dts b/arch/arm64/boot/dts/nxp/imx8mq-evk.dts
> new file mode 100644
> index 000000000000..ff77fdbcbfe3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nxp/imx8mq-evk.dts
> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +
> +/dts-v1/;
> +
> +#include "imx8mq.dtsi"
> +
> +/ {
> +	model = "NXP i.MX8MQ EVK";
> +	compatible = "nxp,imx8mq-evk", "nxp,imx8mq";

Documentation?

> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	memory at 40000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x40000000 0 0xc0000000>;
> +	};
> +
> +	reg_usdhc2_vmmc: usdhc2_vmmc {

Don't use '_'. Also, ideally this would follow generic node name 
convention, but we don't have anything defined and regulator binding is 
a bit odd. "regulator-3V3" perhaps.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pfuze100 at 8 {

pmic at 8

Rob
