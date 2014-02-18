From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Feb 2014 15:22:21 +0100
Subject: [PATCH v7 5/8] ARM: dts: sun7i: Add support for mmc
In-Reply-To: <20140217100241.15040.24836.stgit@pagira.o2s.ch>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100241.15040.24836.stgit@pagira.o2s.ch>
Message-ID: <20140218142221.GJ3142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 11:02:41AM +0100, David Lanzend?rfer wrote:
> Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |    8 +++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |    8 +++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |   23 +++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi                |   61 +++++++++++++++++++++++
>  4 files changed, 100 insertions(+)
> 

I'd prefer to have three patches here:
   - One that add the controllers
   - One that add the pin muxing options
   - One that enable the controllers on the various boards.

> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> index 5c51cb8..ae800b6 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -34,6 +34,14 @@
>  			};
>  		};
>  
> +		mmc0: mmc at 01c0f000 {
> +			pinctrl-names = "default", "default";
> +			pinctrl-0 = <&mmc0_pins_a>;
> +			pinctrl-1 = <&mmc0_cd_pin_reference_design>;

This can be made a single pinctrl group, you don't need the pinctrl-1
stuff, it only complicates the node.

> +			cd-gpios = <&pio 7 1 0>; /* PH1 */
> +			status = "okay";
> +		};
> +
>  		pinctrl at 01c20800 {
>  			led_pins_cubieboard2: led_pins at 0 {
>  				allwinner,pins = "PH20", "PH21";
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index f9dcb61..370cef84 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -19,6 +19,14 @@
>  	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
>  
>  	soc at 01c00000 {
> +		mmc0: mmc at 01c0f000 {
> +			pinctrl-names = "default", "default";
> +			pinctrl-0 = <&mmc0_pins_a>;
> +			pinctrl-1 = <&mmc0_cd_pin_reference_design>;
> +			cd-gpios = <&pio 7 1 0>; /* PH1 */
> +			status = "okay";
> +		};
> +
>  		pinctrl at 01c20800 {
>  			led_pins_cubietruck: led_pins at 0 {
>  				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> index ead3013..685ec06 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> @@ -34,7 +34,30 @@
>  			};
>  		};
>  
> +		mmc0: mmc at 01c0f000 {
> +			pinctrl-names = "default", "default";
> +			pinctrl-0 = <&mmc0_pins_a>;
> +			pinctrl-1 = <&mmc0_cd_pin_reference_design>;
> +			cd-gpios = <&pio 7 1 0>; /* PH1 */
> +			status = "okay";
> +		};
> +
> +		mmc3: mmc at 01c12000 {
> +			pinctrl-names = "default", "default";
> +			pinctrl-0 = <&mmc3_pins_a>;
> +			pinctrl-1 = <&mmc3_cd_pin_olinuxinom>;
> +			cd-gpios = <&pio 7 11 0>; /* PH11 */
> +			status = "okay";
> +		};
> +
>  		pinctrl at 01c20800 {
> +			mmc3_cd_pin_olinuxinom: mmc3_cd_pin at 0 {
> +				allwinner,pins = "PH11";
> +				allwinner,function = "gpio_in";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <1>;
> +			};
> +
>  			led_pins_olinuxino: led_pins at 0 {
>  				allwinner,pins = "PH2";
>  				allwinner,function = "gpio_out";
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 9ff0948..5b55414 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -355,6 +355,46 @@
>  			#size-cells = <0>;
>  		};
>  
> +		mmc0: mmc at 01c0f000 {
> +			compatible = "allwinner,sun5i-a13-mmc";
> +			reg = <0x01c0f000 0x1000>;
> +			clocks = <&ahb_gates 8>, <&mmc0_clk>;
> +			clock-names = "ahb", "mod";
> +			interrupts = <0 32 4>;
> +			bus-width = <4>;

This belongs to the board, the controller itself is able to handle
several bus width.

> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc at 01c10000 {
> +			compatible = "allwinner,sun5i-a13-mmc";
> +			reg = <0x01c10000 0x1000>;
> +			clocks = <&ahb_gates 9>, <&mmc1_clk>;
> +			clock-names = "ahb", "mod";
> +			interrupts = <0 33 4>;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		mmc2: mmc at 01c11000 {
> +			compatible = "allwinner,sun5i-a13-mmc";
> +			reg = <0x01c11000 0x1000>;
> +			clocks = <&ahb_gates 10>, <&mmc2_clk>;
> +			clock-names = "ahb", "mod";
> +			interrupts = <0 34 4>;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		mmc3: mmc at 01c12000 {
> +			compatible = "allwinner,sun5i-a13-mmc";
> +			reg = <0x01c12000 0x1000>;
> +			clocks = <&ahb_gates 11>, <&mmc3_clk>;
> +			clock-names = "ahb", "mod";
> +			interrupts = <0 35 4>;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
>  		pio: pinctrl at 01c20800 {
>  			compatible = "allwinner,sun7i-a20-pinctrl";
>  			reg = <0x01c20800 0x400>;
> @@ -432,6 +472,27 @@
>  				allwinner,drive = <0>;
>  				allwinner,pull = <0>;
>  			};
> +
> +			mmc0_pins_a: mmc0 at 0 {
> +				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
> +				allwinner,function = "mmc0";
> +				allwinner,drive = <3>;
> +				allwinner,pull = <0>;
> +			};
> +
> +			mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
> +				allwinner,pins = "PH1";
> +				allwinner,function = "gpio_in";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <1>;
> +			};
> +
> +			mmc3_pins_a: mmc3 at 0 {
> +				allwinner,pins = "PI4","PI5","PI6","PI7","PI8","PI9";
> +				allwinner,function = "mmc3";
> +				allwinner,drive = <3>;
> +				allwinner,pull = <0>;
> +			};
>  		};
>  
>  		timer at 01c20c00 {
> 

Looks good otherwise.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/9f889a21/attachment.sig>
