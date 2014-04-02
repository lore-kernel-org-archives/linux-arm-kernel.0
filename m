From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 2 Apr 2014 19:39:35 +0800
Subject: [PATCH] ARM i.MX51: Add Digi ConnectCore devicetree
In-Reply-To: <1396075706-25384-2-git-send-email-shc_work@mail.ru>
References: <1396075706-25384-1-git-send-email-shc_work@mail.ru>
 <1396075706-25384-2-git-send-email-shc_work@mail.ru>
Message-ID: <20140402113934.GH8753@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 29, 2014 at 10:48:26AM +0400, Alexander Shiyan wrote:
> This patch adds support for Digi ConnectCore? i.MX51/Wi-i.MX51 SOM
> and basic support for the ConnectCore for i.MX51 JumpStart Kit.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---

...

> +#include "imx51-digi-connectcore-som.dtsi"
> +
> +/ {
> +	model = "Digi ConnectCore CC(W)-MX51 JSK";
> +	compatible = "digi,connectcore-ccxmx51-jsk",
> +		     "digi,connectcore-ccxmx51-som", "fsl,imx51";

You may want to send another patch to DT maintainers to add 'digi' into
Documentation/devicetree/bindings/vendor-prefixes.txt.

> +
> +	chosen {
> +		linux,stdout-path = &uart1;
> +	};
> +};

...

> +&nfc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_nfc>;
> +	nand-bus-width = <8>;
> +	nand-ecc-mode = "hw";
> +	nand-on-flash-bbt;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	status = "okay";
> +
> +	partition at 0 {
> +		label = "boot";
> +		reg = <0x00000 0x80000>;
> +	};
> +
> +	partition at 1 {
> +		label = "env";
> +		reg = <0x80000 0x40000>;
> +	};

@Sascha, does the argument that we shouldn't have partition table in the
mainline dtb still stands?

> +};
> +
> +&usbotg {
> +	phy_type = "utmi_wide";
> +	disable-over-current;
> +	/* Device role is not known, keep status disabled */
> +};
> +
> +&weim {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_weim>;
> +	status = "okay";
> +
> +	lan9221: lan9221 at ce000000 {

How does 'ce000000' in the node name comes?

Shawn

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lan9221>;
> +		compatible = "smsc,lan9221", "smsc,lan9115";
> +		reg = <5 0x00000000 0x1000>;
> +		fsl,weim-cs-timing = <
> +			0x00420081 0x00000000
> +			0x32260000 0x00000000
> +			0x72080f00 0x00000000
> +		>;
> +		clocks = <&clks IMX5_CLK_DUMMY>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
> +		phy-mode = "mii";
> +		reg-io-width = <2>;
> +		smsc,irq-push-pull;
> +		vdd33a-supply = <&gpo2_reg>;
> +		vddvario-supply = <&gpo2_reg>;
> +	};
> +};
