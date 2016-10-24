From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 24 Oct 2016 19:33:37 +0800
Subject: [PATCH v2] ARM: dts: imx6sx: Add UDOO Neo support
In-Reply-To: <1476629064-10634-1-git-send-email-afaerber@suse.de>
References: <1476629064-10634-1-git-send-email-afaerber@suse.de>
Message-ID: <20161024113337.GE30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 16, 2016 at 04:44:23PM +0200, Andreas F?rber wrote:
> Add initial device trees for UDOO Neo Basic, Extended and Full boards:
> * Serial console is enabled, other serial ports are prepared.
> * I2C based PMIC is enabled.
> * Ethernet is enabled for Basic and Full.
> * SDHC is enabled, with the SDIO_PWR GPIO modeled as a regulator.
> * Both user LEDs are enabled, with the orange one reserved for the M4
>   and with the SD card as default trigger for the red LED.
> 
> The decision on a board compatible string is deferred to later.
> 
> Cc: Ettore Chimenti <ettore.chimenti@udoo.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

<snip>

> +/ {
> +	compatible = "fsl,imx6sx";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		red {
> +			label = "udoo-neo:red:mmc";
> +			gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +			linux,default-trigger = "mmc0";
> +		};
> +
> +		orange {
> +			label = "udoo-neo:orange:user";
> +			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;
> +			default-state = "keep";
> +		};
> +	};
> +
> +	sdio_pwr_reg: sd-gpio-regulator {

We do have a recommended naming schema for fixed regulator.  I updated
it a bit as below, and applied the patch.

Shawn

> +		compatible = "regulator-fixed";
> +		gpio = <&gpio6 1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-name = "SDIO_PWR";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +	};
> +};

diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
index 314d25b15641..2b65d26f4396 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
@@ -66,7 +66,7 @@
                };
        };
 
-       sdio_pwr_reg: sd-gpio-regulator {
+       reg_sdio_pwr: regulator-sdio-pwr {
                compatible = "regulator-fixed";
                gpio = <&gpio6 1 GPIO_ACTIVE_HIGH>;
                enable-active-high;
@@ -283,7 +283,7 @@
 &usdhc2 {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_usdhc2>;
-       vmmc-supply = <&sdio_pwr_reg>;
+       vmmc-supply = <&reg_sdio_pwr>;
        bus-width = <4>;
        cd-gpios = <&gpio6 2 GPIO_ACTIVE_LOW>;
        no-1-8-v;
