From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 4 Mar 2016 10:04:38 +0800
Subject: [PATCH 3/3] ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB
 property
In-Reply-To: <56D8BB1D.6040108@maciej.szmigiero.name>
References: <1456999276-6315-1-git-send-email-peter.chen@nxp.com>
 <1456999276-6315-4-git-send-email-peter.chen@nxp.com>
 <56D8BB1D.6040108@maciej.szmigiero.name>
Message-ID: <20160304020438.GC30272@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 11:30:53PM +0100, Maciej S. Szmigiero wrote:
> Hi Peter,
> 
> On 03.03.2016 11:01, Peter Chen wrote:
> > From: Peter Chen <peter.chen@freescale.com>
> > 
> > The current dts describes USB HUB's property at USB controller's
> > entry, it is improper. The USB HUB should be the child node
> > under USB controller.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> 
> Thanks for patches!
> 
> VID:PID for hub on UDOO board is 0424:2514.
> 
> I've tested these patches on this board and was able to make USB work
> again with following DT changes:
> diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> index d3e54e4..4956de7 100644
> --- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> @@ -9,6 +9,8 @@
>   *
>   */
>  
> +#include <dt-bindings/gpio/gpio.h>
> +
>  / {
>  	chosen {
>  		stdout-path = &uart2;
> @@ -18,21 +27,11 @@
>  		reg = <0x10000000 0x40000000>;
>  	};
>  
> -	regulators {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		reg_usb_h1_vbus: regulator at 0 {
> -			compatible = "regulator-fixed";
> -			reg = <0>;
> -			regulator-name = "usb_h1_vbus";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			enable-active-high;
> -			startup-delay-us = <2>; /* USB2415 requires a POR of 1 us minimum */
> -			gpio = <&gpio7 12 0>;
> -		};
> +	usb2415_pwrseq: usb2415_pwrseq {
> +		compatible = "usb-pwrseq";
> +		clocks = <&clks IMX6QDL_CLK_CKO>;
> +		reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
> +		reset-duration-us = <3000>;
>  	};
>  
>  	sound {
> @@ -163,9 +218,16 @@
>  &usbh1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usbh>;
> -	vbus-supply = <&reg_usb_h1_vbus>;
> -	clocks = <&clks 201>;
>  	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	hub: usb2415 at 01 {
> +		compatible = "usb424,2514";
> +		reg = <1>;
> +		usb-pwrseq = <&usb2415_pwrseq>;
> +	};
>  };
>  
>  &usdhc3 {
> 
> 

Thank you very much.

-- 

Best Regards,
Peter Chen
