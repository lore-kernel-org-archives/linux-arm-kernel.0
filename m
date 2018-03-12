From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 12 Mar 2018 17:28:56 +0000
Subject: [PATCH 01/10] ARM: dts: Augment VGA connector bridge on PB11MPcore
In-Reply-To: <20180311135307.6271-2-linus.walleij@linaro.org>
References: <20180311135307.6271-1-linus.walleij@linaro.org>
 <20180311135307.6271-2-linus.walleij@linaro.org>
Message-ID: <20180312172856.GL16053@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2018 at 02:52:58PM +0100, Linus Walleij wrote:
> The PL111 in the ARM reference platforms are connected to
> "panels" that are actually dumb VGA DAC connector bridges.
> Now that we can support the proper bridges in the DRM driver,
> fix this up.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Mali DP Maintainers <malidp@foss.arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Hi Linus,

Changes look sane to me, but again I lack hardware to test.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  arch/arm/boot/dts/arm-realview-pb11mp.dts | 78 +++++++++++++++++++++----------
>  1 file changed, 53 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm-realview-pb11mp.dts
> index 3944765ac4b0..36203288de42 100644
> --- a/arch/arm/boot/dts/arm-realview-pb11mp.dts
> +++ b/arch/arm/boot/dts/arm-realview-pb11mp.dts
> @@ -242,6 +242,49 @@
>  		bank-width = <4>;
>  	};
>  
> +	bridge {
> +		compatible = "ti,ths8134a", "ti,ths8134";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +
> +				vga_bridge_in: endpoint {
> +					remote-endpoint = <&clcd_pads>;
> +				};
> +			};
> +
> +			port at 1 {
> +				reg = <1>;
> +
> +				vga_bridge_out: endpoint {
> +					remote-endpoint = <&vga_con_in>;
> +				};
> +			};
> +		};
> +	};
> +
> +	vga {
> +		/*
> +		 * This DDC I2C is connected directly to the DVI portions
> +		 * of the connector, so it's not really working when the
> +		 * monitor is connected to the VGA connector.
> +		 */
> +		compatible = "vga-connector";
> +		ddc-i2c-bus = <&i2c1>;
> +
> +		port {
> +			vga_con_in: endpoint {
> +				remote-endpoint = <&vga_bridge_out>;
> +			};
> +		};
> +	};
> +
>  	soc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -575,6 +618,13 @@
>  			clock-names = "apb_pclk";
>  		};
>  
> +		i2c1: i2c at 10016000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "arm,versatile-i2c";
> +			reg = <0x10016000 0x1000>;
> +		};
> +
>  		rtc: rtc at 10017000 {
>  			compatible = "arm,pl031", "arm,primecell";
>  			reg = <0x10017000 0x1000>;
> @@ -609,37 +659,15 @@
>  			interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&oscclk4>, <&pclk>;
>  			clock-names = "clcdclk", "apb_pclk";
> -			max-memory-bandwidth = <130000000>; /* 16bpp @ 63.5MHz */
> +			/* 1024x768 16bpp @65MHz works fine */
> +			max-memory-bandwidth = <95000000>;
>  
>  			port {
>  				clcd_pads: endpoint {
> -					remote-endpoint = <&clcd_panel>;
> +					remote-endpoint = <&vga_bridge_in>;
>  					arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
>  				};
>  			};
> -
> -			panel {
> -				compatible = "panel-dpi";
> -
> -				port {
> -					clcd_panel: endpoint {
> -						remote-endpoint = <&clcd_pads>;
> -					};
> -				};
> -
> -				/* Standard 640x480 VGA timings */
> -				panel-timing {
> -					clock-frequency = <25175000>;
> -					hactive = <640>;
> -					hback-porch = <48>;
> -					hfront-porch = <16>;
> -					hsync-len = <96>;
> -					vactive = <480>;
> -					vback-porch = <33>;
> -					vfront-porch = <10>;
> -					vsync-len = <2>;
> -				};
> -			};
>  		};
>  
>  		/*
> -- 
> 2.14.3
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
