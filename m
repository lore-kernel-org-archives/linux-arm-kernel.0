From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 14 Aug 2017 16:31:51 +0200
Subject: [PATCH 1/2] ARM64: dts: marvell: enable USB host on Armada-7040-DB
In-Reply-To: <20170809144437.26858-1-miquel.raynal@free-electrons.com> (Miquel
 Raynal's message of "Wed, 9 Aug 2017 16:44:36 +0200")
References: <20170809140538.692b3e6d@windsurf>
 <20170809144437.26858-1-miquel.raynal@free-electrons.com>
Message-ID: <87shgukyp4.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On mer., ao?t 09 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> From: Hanna Hawa <hannah@marvell.com>
>
> Add I2C expander and USB host PHY (host 0 and host 1) to enable
> USB VBUS on USB ports of type A on Armada-7040-DB.
>

Applied on mvebu/dt64

Thanks,

Gregory

> Signed-off-by: Hanna Hawa <hannah@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts | 39 ++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> index 92c761c380d3..9c3bdf87e543 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> @@ -44,6 +44,7 @@
>   * Device Tree file for Marvell Armada 7040 Development board platform
>   */
>  
> +#include <dt-bindings/gpio/gpio.h>
>  #include "armada-7040.dtsi"
>  
>  / {
> @@ -59,6 +60,34 @@
>  		device_type = "memory";
>  		reg = <0x0 0x0 0x0 0x80000000>;
>  	};
> +
> +	cpm_reg_usb3_0_vbus: cpm-usb3-0-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb3h0-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&expander0 0 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	cpm_reg_usb3_1_vbus: cpm-usb3-1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb3h1-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&expander0 1 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	cpm_usb3_0_phy: cpm-usb3-0-phy {
> +		compatible = "usb-nop-xceiv";
> +		vcc-supply = <&cpm_reg_usb3_0_vbus>;
> +	};
> +
> +	cpm_usb3_1_phy: cpm-usb3-1-phy {
> +		compatible = "usb-nop-xceiv";
> +		vcc-supply = <&cpm_reg_usb3_1_vbus>;
> +	};
>  };
>  
>  &i2c0 {
> @@ -105,6 +134,14 @@
>  &cpm_i2c0 {
>  	status = "okay";
>  	clock-frequency = <100000>;
> +
> +	expander0: pca9555 at 21 {
> +		compatible = "nxp,pca9555";
> +		pinctrl-names = "default";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		reg = <0x21>;
> +	};
>  };
>  
>  &cpm_spi1 {
> @@ -140,10 +177,12 @@
>  };
>  
>  &cpm_usb3_0 {
> +	usb-phy = <&cpm_usb3_0_phy>;
>  	status = "okay";
>  };
>  
>  &cpm_usb3_1 {
> +	usb-phy = <&cpm_usb3_1_phy>;
>  	status = "okay";
>  };
>  
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
