From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 12 Mar 2018 17:37:37 +0000
Subject: [PATCH 06/10] ARM: dts: Augment panel setting for Versatile
In-Reply-To: <20180311135307.6271-7-linus.walleij@linaro.org>
References: <20180311135307.6271-1-linus.walleij@linaro.org>
 <20180311135307.6271-7-linus.walleij@linaro.org>
Message-ID: <20180312173736.GQ16053@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2018 at 02:53:03PM +0100, Linus Walleij wrote:
> This adds the actual VGA DAC bridge that is used in the
> Versatile AB, and sets the mode to 640x480 VGA.
> 
> The "clcd" clock was incorrectly named, the proper name
> (from bindings) is "clcdclk". So far drivers survived
> by just getting the first clock, but future drivers will
> use named clocks.
> 
> We add the panel connector to the
> "arm,versatile-tft-panel" as well, the signals actually
> fork on the board, reaching both the VGA DAC and the
> display connector.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Mali DP Maintainers <malidp@foss.arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

> ---
>  arch/arm/boot/dts/versatile-ab.dts | 83 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
> index 4a51612996bc..5f61d3609027 100644
> --- a/arch/arm/boot/dts/versatile-ab.dts
> +++ b/arch/arm/boot/dts/versatile-ab.dts
> @@ -30,6 +30,43 @@
>  		clock-frequency = <24000000>;
>  	};
>  
> +	bridge {
> +		compatible = "ti,ths8134b", "ti,ths8134";
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
> +					remote-endpoint = <&clcd_pads_vga_dac>;
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
> +		compatible = "vga-connector";
> +
> +		port {
> +			vga_con_in: endpoint {
> +				remote-endpoint = <&vga_bridge_out>;
> +			};
> +		};
> +	};
> +
>  	core-module at 10000000 {
>  		compatible = "arm,core-module-versatile", "syscon", "simple-mfd";
>  		reg = <0x10000000 0x200>;
> @@ -230,7 +267,39 @@
>  			reg = <0x10120000 0x1000>;
>  			interrupts = <16>;
>  			clocks = <&osc1>, <&pclk>;
> -			clock-names = "clcd", "apb_pclk";
> +			clock-names = "clcdclk", "apb_pclk";
> +			/* 800x600 16bpp @ 36MHz works fine */
> +			max-memory-bandwidth = <54000000>;
> +
> +			/*
> +			 * This port is routed through a PLD (Programmable
> +			 * Logic Device) that routes the output from the CLCD
> +			 * (after transformations) to the VGA DAC and also an
> +			 * external panel connector. The PLD is essential for
> +			 * supporting RGB565/BGR565.
> +			 *
> +			 * The signals from the port thus reaches two endpoints.
> +			 * The PLD is managed through a few special bits in the
> +			 * FPGA "sysreg".
> +			 *
> +			 * This arrangement can be clearly seen in
> +			 * ARM DUI 0225D, page 3-41, figure 3-19.
> +			 */

If I remember correctly, besides being able to flip outputs via "sysreg"
there was a debug menu on the microcontroller that had options to set
the MUX to the right output before OS boot.

That brings back a lot of memories that I thought I'll never have any
use of :)

Best regards,
Liviu

> +			port at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				clcd_pads_panel: endpoint at 0 {
> +					reg = <0>;
> +					remote-endpoint = <&panel_in>;
> +					arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
> +				};
> +				clcd_pads_vga_dac: endpoint at 1 {
> +					reg = <1>;
> +					remote-endpoint = <&vga_bridge_in>;
> +					arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
> +				};
> +			};
>  		};
>  
>  		sctl at 101e0000 {
> @@ -319,8 +388,18 @@
>  			ranges = <0 0x10000000 0x10000>;
>  
>  			sysreg at 0 {
> -				compatible = "arm,versatile-sysreg", "syscon";
> +				compatible = "arm,versatile-sysreg", "syscon", "simple-mfd";
>  				reg = <0x00000 0x1000>;
> +
> +				panel: display at 0 {
> +					compatible = "arm,versatile-tft-panel";
> +
> +					port {
> +						panel_in: endpoint {
> +							remote-endpoint = <&clcd_pads_panel>;
> +						};
> +					};
> +				};
>  			};
>  
>  			aaci at 4000 {
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
