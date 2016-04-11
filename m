From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 11 Apr 2016 22:49:18 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Pass the hannstar panel
 compatible string
In-Reply-To: <1459185048-25702-1-git-send-email-festevam@gmail.com>
References: <1459185048-25702-1-git-send-email-festevam@gmail.com>
Message-ID: <20160411144918.GA15904@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 02:10:48PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> It is preferred to use the panel compatible string rather than passing the
> LCD timings in the device tree.
> 
> So pass the "hannstar,hsd100pxn1" compatible string to describe
> the LVDS panel on this board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 0b5c4de..b78cd79 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -115,7 +115,7 @@
>  		mux-ext-port = <3>;
>  	};
>  
> -	backlight {
> +	backlight_lvds: backlight_lvds {

Hyphen instead of underscore should be used in node names.

I fixed it up and applied patch.

Shawn

>  		compatible = "pwm-backlight";
>  		pwms = <&pwm1 0 5000000>;
>  		brightness-levels = <0 4 8 16 32 64 128 255>;
> @@ -133,6 +133,17 @@
>  		        default-state = "on";
>  		};
>  	};
> +
> +	panel {
> +		compatible = "hannstar,hsd100pxn1";
> +		backlight = <&backlight_lvds>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&lvds0_out>;
> +			};
> +		};
> +	};
>  };
>  
>  &audmux {
> @@ -509,18 +520,11 @@
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
> +			lvds0_out: endpoint {
> +				remote-endpoint = <&panel_in>;
>  			};
>  		};
>  	};
> -- 
> 1.9.1
> 
> 
