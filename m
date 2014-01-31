From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jan 2014 14:46:38 +0100
Subject: [PATCH v5 14/14] ARM: sun7i: dts: Add ahci / sata support
In-Reply-To: <1390417489-5354-15-git-send-email-hdegoede@redhat.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
 <1390417489-5354-15-git-send-email-hdegoede@redhat.com>
Message-ID: <20140131134638.GH2950@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 08:04:49PM +0100, Hans de Goede wrote:
> This patch adds sunxi sata support to A20 boards that have such a connector.
> Some boards also feature a regulator via a GPIO and support for this is also
> added.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |  6 ++++++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |  6 ++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi                |  8 ++++++++
>  4 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> index 48777cd..1cab521 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -13,6 +13,7 @@
>  
>  /dts-v1/;
>  /include/ "sun7i-a20.dtsi"
> +/include/ "sunxi-ahci-reg.dtsi"
>  
>  / {
>  	model = "Cubietech Cubieboard2";
> @@ -28,6 +29,11 @@
>  			status = "okay";
>  		};
>  
> +		ahci: sata at 01c18000 {
> +			target-supply = <&reg_ahci_5v>;
> +			status = "okay";
> +		};
> +
>  		pinctrl at 01c20800 {
>  			mmc0_cd_pin_cubieboard2: mmc0_cd_pin at 0 {
>  				allwinner,pins = "PH1";
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index 2684f27..1247ea1 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -13,6 +13,7 @@
>  
>  /dts-v1/;
>  /include/ "sun7i-a20.dtsi"
> +/include/ "sunxi-ahci-reg.dtsi"
>  
>  / {
>  	model = "Cubietech Cubietruck";
> @@ -28,6 +29,11 @@
>  			status = "okay";
>  		};
>  
> +		ahci: sata at 01c18000 {
> +			target-supply = <&reg_ahci_5v>;
> +			status = "okay";
> +		};
> +
>  		pinctrl at 01c20800 {
>  			mmc0_cd_pin_cubietruck: mmc0_cd_pin at 0 {
>  				allwinner,pins = "PH1";
> @@ -36,6 +42,13 @@
>  				allwinner,pull = <0>;
>  			};
>  
> +			ahci_pwr_pin_cubietruck: ahci_pwr_pin at 1 {
> +				allwinner,pins = "PH12";
> +				allwinner,function = "gpio_out";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +
>  			led_pins_cubietruck: led_pins at 0 {
>  				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
>  				allwinner,function = "gpio_out";
> @@ -84,4 +97,11 @@
>  			gpios = <&pio 7 7 0>;
>  		};
>  	};
> +
> +	regulators {
> +		reg_ahci_5v: ahci-5v {
> +			pinctrl-0 = <&ahci_pwr_pin_cubietruck>;
> +			gpio = <&pio 7 12 0>;
> +		};
> +	};
>  };
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> index bf6f6c8..f135886 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> @@ -13,6 +13,7 @@
>  
>  /dts-v1/;
>  /include/ "sun7i-a20.dtsi"
> +/include/ "sunxi-ahci-reg.dtsi"
>  
>  / {
>  	model = "Olimex A20-Olinuxino Micro";
> @@ -37,6 +38,11 @@
>  			status = "okay";
>  		};
>  
> +		ahci: sata at 01c18000 {
> +			target-supply = <&reg_ahci_5v>;
> +			status = "okay";
> +		};
> +
>  		pinctrl at 01c20800 {
>  			mmc0_cd_pin_olinuxinom: mmc0_cd_pin at 0 {
>  				allwinner,pins = "PH1";
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index c9c123a..0657bad 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -347,6 +347,14 @@
>  			status = "disabled";
>  		};
>  
> +		ahci: sata at 01c18000 {
> +			compatible = "allwinner,sun4i-a10-ahci";
> +			reg = <0x01c18000 0x1000>;
> +			interrupts = <0 56 1>;

This is supposed to be a level triggered interrupt, not an edge
triggered one.

Thanks for your work!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/d3dbd525/attachment-0001.sig>
