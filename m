From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 27 Jul 2015 22:44:21 +0800
Subject: [PATCH] ARM: dts: sabresd: use simple-panel instead of
 display-timings for LVDS1
In-Reply-To: <1436883355-11256-1-git-send-email-fabio.estevam@freescale.com>
References: <1436883355-11256-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20150727144421.GS12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 11:15:55AM -0300, Fabio Estevam wrote:
> We can use the compatible string "hannstar,hsd100pxn1" for representing
> the LCD panel that is connected to the LVDS1 port.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index cca847e..5fecb3a 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -115,7 +115,7 @@
>  		mux-ext-port = <3>;
>  	};
>  
> -	backlight {
> +	backlight_lvds: backlight_lvds {

Minus rather than underscore should be used in node name.  I'm actually
wondering whether the change is needed at all.

Shawn

>  		compatible = "pwm-backlight";
>  		pwms = <&pwm1 0 5000000>;
>  		brightness-levels = <0 4 8 16 32 64 128 255>;
> @@ -123,6 +123,17 @@
>  		status = "okay";
>  	};
>  
> +	panel {
> +		compatible = "hannstar,hsd100pxn1";
> +		backlight = <&backlight_lvds>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&lvds1_out>;
> +			};
> +		};
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  		pinctrl-names = "default";
> @@ -508,18 +519,11 @@
>  		fsl,data-width = <18>;
>  		status = "okay";
>  
> -		display-timings {
> -			native-mode = <&timing0>;
> -			timing0: hsd100pxn1 {
> -				clock-frequency = <65000000>;
> -				hactive = <1024>;
> -				vactive = <768>;
> -				hback-porch = <220>;
> -				hfront-porch = <40>;
> -				vback-porch = <21>;
> -				vfront-porch = <7>;
> -				hsync-len = <60>;
> -				vsync-len = <10>;
> +		port at 4 {
> +			reg = <4>;
> +
> +			lvds1_out: endpoint {
> +				remote-endpoint = <&panel_in>;
>  			};
>  		};
>  	};
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
