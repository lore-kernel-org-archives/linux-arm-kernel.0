From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 Jul 2018 14:09:53 +0800
Subject: [PATCH v2] ARM: dts: imx51: Fix USB PHY duplicate unit-address
In-Reply-To: <1530211296-24591-1-git-send-email-festevam@gmail.com>
References: <1530211296-24591-1-git-send-email-festevam@gmail.com>
Message-ID: <20180703060951.GF4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 03:41:36PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Currently the following DTC warnings are seen with W=1:
> 
> arch/arm/boot/dts/imx51-babbage.dtb: Warning (unique_unit_address): /usbphy/usbphy at 0: duplicate unit-address (also used in node /usbphy/usbh1phy at 0)
> arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dtb: Warning (unique_unit_address): /usbphy/usbphy at 0: duplicate unit-address (also used in node /usbphy/usbh1phy at 0)
> 
> Fix it by moving the USB PHY nodes outside of simple-bus and drop the
> unneeded unit-address, which matches the bindings documentation
> at Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes since v1:
> - Make it a single patch including the imx51.dtsi change (Shawn)
> 
>  arch/arm/boot/dts/imx51-babbage.dts                 | 21 +++++++--------------
>  .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts   | 19 ++++++-------------
>  arch/arm/boot/dts/imx51.dtsi                        | 17 +++++------------
>  3 files changed, 18 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index b8ca73d..de46906 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -170,20 +170,13 @@
>  		mux-ext-port = <3>;
>  	};
>  
> -	usbphy {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "simple-bus";
> -
> -		usbh1phy: usbh1phy at 0 {
> -			compatible = "usb-nop-xceiv";
> -			reg = <0>;
> -			clocks = <&clk_usb>;
> -			clock-names = "main_clk";
> -			reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
> -			vcc-supply = <&vusb_reg>;
> -			#phy-cells = <0>;
> -		};
> +	usbh1phy: usbh1phy1 {

usbh1phy1 ...

> +		compatible = "usb-nop-xceiv";
> +		clocks = <&clk_usb>;
> +		clock-names = "main_clk";
> +		reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
> +		vcc-supply = <&vusb_reg>;
> +		#phy-cells = <0>;
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
> index b3d952f..2320464 100644
> --- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
> +++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
> @@ -83,19 +83,12 @@
>  		fsl,mux-ext-port = <3>;
>  	};
>  
> -	usbphy {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "simple-bus";
> -
> -		usbh1phy: usbh1phy at 0 {
> -			compatible = "usb-nop-xceiv";
> -			reg = <0>;
> -			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
> -			clock-names = "main_clk";
> -			clock-frequency = <19200000>;
> -			#phy-cells = <0>;
> -		};
> +	usbh1phy: usbh1phy {

... usbh1phy?  Can we name the usbphy nodes a bit more consistent?  I
would even suggest to name them in the same way as usbphy0 in
i.mx51.dtsi.  That said, usbphy1 should just work?

Shawn

> +		compatible = "usb-nop-xceiv";
> +		clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
> +		clock-names = "main_clk";
> +		clock-frequency = <19200000>;
> +		#phy-cells = <0>;
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index fe01b89..89520c1 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -93,18 +93,11 @@
>  		};
>  	};
>  
> -	usbphy {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "simple-bus";
> -
> -		usbphy0: usbphy at 0 {
> -			compatible = "usb-nop-xceiv";
> -			reg = <0>;
> -			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
> -			clock-names = "main_clk";
> -			#phy-cells = <0>;
> -		};
> +	usbphy0: usbphy0 {
> +		compatible = "usb-nop-xceiv";
> +		clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
> +		clock-names = "main_clk";
> +		#phy-cells = <0>;
>  	};
>  
>  	display-subsystem {
> -- 
> 2.7.4
> 
