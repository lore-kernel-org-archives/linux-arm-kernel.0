From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Tue, 27 Jan 2015 00:57:00 +0100
Subject: [PATCH v4 6/7] ARM: zynq: DT: Add pinctrl information
In-Reply-To: <1420818231-13451-7-git-send-email-soren.brinkmann@xilinx.com>
References: <1420818231-13451-1-git-send-email-soren.brinkmann@xilinx.com>
 <1420818231-13451-7-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <54C6D44C.4060106@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.01.2015 um 16:43 schrieb Soren Brinkmann:
> Add pinctrl descriptions to the zc702 and zc706 device trees.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Tested-by: Andreas F?rber <afaerber@suse.de>
> ---
> Changes since v1:
>  - remove 'pinctrl-' prefix for pinctrl sub-nodes
>  - separate config and mux nodes
> 
> Changes since RFC v2:
>  - add pinconf properties to zc702 mdio node
>  - remove arguments from bias-related props
> 
> Changes since RFC v1:
>  - separate DT changes into their own patch
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi |   8 +-
>  arch/arm/boot/dts/zynq-zc702.dts | 181 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/zynq-zc706.dts | 152 ++++++++++++++++++++++++++++++++
>  3 files changed, 340 insertions(+), 1 deletion(-)
[...]
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index 280f02dd4ddc..4995412f116f 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
[...]
> @@ -50,15 +52,24 @@
>  	status = "okay";
>  	phy-mode = "rgmii-id";
>  	phy-handle = <&ethernet_phy>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gem0_default>;
>  
>  	ethernet_phy: ethernet-phy at 7 {
>  		reg = <7>;
>  	};
>  };
>  
> +&gpio0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpio0_default>;

On linux-next the equivalent no longer works for the Parallella, with
gpio failing to probe.

If I move these two properties to the leds node (for which I am
configuring gpio 7) then I get a heartbeat as before.

Regards,
Andreas

> +};
> +
>  &i2c0 {
>  	status = "okay";
>  	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c0_default>;
>  
>  	i2cswitch at 74 {
>  		compatible = "nxp,pca9548";
> @@ -132,10 +143,180 @@
>  	};
>  };
>  
> +&pinctrl0 {
[...]
> +	pinctrl_gpio0_default: gpio0-default {
> +		mux {
> +			function = "gpio0";
> +			groups = "gpio0_7_grp", "gpio0_8_grp", "gpio0_9_grp",
> +				 "gpio0_10_grp", "gpio0_11_grp", "gpio0_12_grp",
> +				 "gpio0_13_grp", "gpio0_14_grp";
> +		};
> +
> +		conf {
> +			groups = "gpio0_7_grp", "gpio0_8_grp", "gpio0_9_grp",
> +				 "gpio0_10_grp", "gpio0_11_grp", "gpio0_12_grp",
> +				 "gpio0_13_grp", "gpio0_14_grp";
> +			slew-rate = <0>;
> +			io-standard = <1>;
> +		};
> +
> +		conf-pull-up {
> +			pins = "MIO9", "MIO10", "MIO11", "MIO12", "MIO13", "MIO14";
> +			bias-pull-up;
> +		};
> +
> +		conf-pull-none {
> +			pins = "MIO7", "MIO8";
> +			bias-disable;
> +		};
> +	};
[...]
> +};
> +
>  &sdhci0 {
>  	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sdhci0_default>;
>  };
>  
>  &uart1 {
>  	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1_default>;
>  };
[dito for zc706]

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/1d700d8e/attachment.sig>
