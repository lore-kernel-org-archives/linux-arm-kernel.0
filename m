From: david@lechnology.com (David Lechner)
Date: Mon, 24 Oct 2016 19:48:08 -0500
Subject: [PATCH/RFT v2 17/17] ARM: dts: da850: add usb device node
In-Reply-To: <20161024164634.4330-18-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-18-ahaslam@baylibre.com>
Message-ID: <59ca6a1f-6db9-eed2-8e8a-77657c7febac@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 11:46 AM, ahaslam at baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
>
> This adds the usb (ohci) device node for the da850 soc.
> Also it enables it for the lcdk board
>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts | 8 ++++++++
>  arch/arm/boot/dts/da850.dtsi     | 8 ++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
> index 7b8ab21..fa91339 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -86,6 +86,14 @@
>  	};
>  };
>
> +&usb_phy {
> +	status = "okay";
> +};
> +
> +&usb {
> +	status = "okay";

Don't you need to specify a regulator here using the vbus-supply property?

> +};
> +
>  &serial2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&serial2_rxtx_pins>;
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 33fcdce..ec2cec3 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -381,6 +381,14 @@
>  			#phy-cells = <1>;
>  			status = "disabled";
>  		};
> +		usb: usb at 0225000 {

Don't need the leading 0 on usb at 225000

The alias (usb:) might need to be more specific since there is a second 
usb device that will be added later for musb. (The comments in the 
previous review only referred to the "usb" in "usb@", not the alias.)

> +			compatible = "ti,da830-ohci";
> +			reg = <0x225000 0x1000>;
> +			interrupts = <59>;
> +			phys = <&usb_phy 1>;
> +			phy-names = "usb-phy";
> +			status = "disabled";
> +		};
>  		gpio: gpio at 226000 {
>  			compatible = "ti,dm6441-gpio";
>  			gpio-controller;
>
