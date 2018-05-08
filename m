From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 8 May 2018 23:04:14 +0200
Subject: [PATCH] arm: dts: atmel: graph_child_address warning fixes
In-Reply-To: <20180508135930.5768-1-robh@kernel.org>
References: <20180508135930.5768-1-robh@kernel.org>
Message-ID: <20180508230414.23a2f201@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  8 May 2018 08:59:25 -0500
Rob Herring <robh@kernel.org> wrote:

> Addresses for graph ports and endpoints are not necessary when
> there's only a single child. Fix the following warnings removing
> unnecessary addresses on OF graph nodes:
> 
> Warning (graph_child_address): /ahb/apb/hlcdc at f0030000/hlcdc-display-controller: graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary
> Warning (graph_child_address): /ahb/apb/hlcdc at f0030000/hlcdc-display-controller/port at 0: graph node has single child node 'endpoint', #address-cells/#size-cells are not necessary
> Warning (graph_child_address): /ahb/apb/isi at f0034000/port: graph node has single child node 'endpoint', #address-cells/#size-cells are not necessary
> Warning (graph_child_address): /panel/port at 0: graph node has single child node 'endpoint at 0', #address-cells/#size-cells are not necessary
> 
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts | 15 ++++-----------
>  arch/arm/boot/dts/at91sam9g45.dtsi          |  2 --
>  arch/arm/boot/dts/at91sam9n12.dtsi          |  8 +-------
>  arch/arm/boot/dts/at91sam9n12ek.dts         | 14 ++++----------
>  arch/arm/boot/dts/at91sam9x5_lcd.dtsi       |  7 +------
>  arch/arm/boot/dts/at91sam9x5dm.dtsi         | 13 ++++---------
>  arch/arm/boot/dts/sama5d3.dtsi              |  2 --
>  arch/arm/boot/dts/sama5d3_lcd.dtsi          |  8 +-------
>  arch/arm/boot/dts/sama5d4.dtsi              |  8 +-------

For the hlcdc changes

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

I'll update the DT bindinds doc accordingly.

Thanks,

Boris

>  9 files changed, 16 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts b/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
> index fe05aaa7ac87..72c3b077fb46 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
> @@ -49,9 +49,8 @@
>  					pinctrl-names = "default";
>  					pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
>  
> -					port at 0 {
> -						hlcdc_panel_output: endpoint at 0 {
> -							reg = <0>;
> +					port {
> +						hlcdc_panel_output: endpoint {
>  							remote-endpoint = <&panel_input>;
>  						};
>  					};
> @@ -144,16 +143,10 @@
>  		/* Actually Ampire 800480R2 */
>  		compatible = "foxlink,fl500wvr00-a0t", "simple-panel";
>  		backlight = <&backlight>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		status = "okay";
>  
> -		port at 0 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			panel_input: endpoint at 0 {
> -				reg = <0>;
> +		port {
> +			panel_input: endpoint {
>  				remote-endpoint = <&hlcdc_panel_output>;
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 1ee25a475be8..36729e3f2899 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -1114,8 +1114,6 @@
>  				clock-names = "isi_clk";
>  				status = "disabled";
>  				port {
> -					#address-cells = <1>;
> -					#size-cells = <0>;
>  				};
>  			};
>  
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index 37cb81f457b5..a071fccb729b 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -475,13 +475,7 @@
>  
>  				hlcdc-display-controller {
>  					compatible = "atmel,hlcdc-display-controller";
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					port at 0 {
> -						#address-cells = <1>;
> -						#size-cells = <0>;
> -						reg = <0>;
> +					port {
>  					};
>  				};
>  
> diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
> index c43095c5cb5c..eb0c1e11fa4d 100644
> --- a/arch/arm/boot/dts/at91sam9n12ek.dts
> +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
> @@ -134,9 +134,8 @@
>  					pinctrl-names = "default";
>  					pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
>  
> -					port at 0 {
> -						hlcdc_panel_output: endpoint at 0 {
> -							reg = <0>;
> +					port {
> +						hlcdc_panel_output: endpoint {
>  							remote-endpoint = <&panel_input>;
>  						};
>  					};
> @@ -246,13 +245,8 @@
>  		#size-cells = <0>;
>  		status = "okay";
>  
> -		port at 0 {
> -			reg = <0>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			panel_input: endpoint at 0 {
> -				reg = <0>;
> +		port {
> +			panel_input: endpoint {
>  				remote-endpoint = <&hlcdc_panel_output>;
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9x5_lcd.dtsi b/arch/arm/boot/dts/at91sam9x5_lcd.dtsi
> index 1629db9dd563..e243dff67a67 100644
> --- a/arch/arm/boot/dts/at91sam9x5_lcd.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5_lcd.dtsi
> @@ -23,13 +23,8 @@
>  
>  				hlcdc-display-controller {
>  					compatible = "atmel,hlcdc-display-controller";
> -					#address-cells = <1>;
> -					#size-cells = <0>;
>  
> -					port at 0 {
> -						#address-cells = <1>;
> -						#size-cells = <0>;
> -						reg = <0>;
> +					port {
>  					};
>  				};
>  
> diff --git a/arch/arm/boot/dts/at91sam9x5dm.dtsi b/arch/arm/boot/dts/at91sam9x5dm.dtsi
> index 34c089fe0bc0..5aea8fd09ad6 100644
> --- a/arch/arm/boot/dts/at91sam9x5dm.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5dm.dtsi
> @@ -29,9 +29,8 @@
>  					pinctrl-names = "default";
>  					pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
>  
> -					port at 0 {
> -						hlcdc_panel_output: endpoint at 0 {
> -							reg = <0>;
> +					port {
> +						hlcdc_panel_output: endpoint {
>  							remote-endpoint = <&panel_input>;
>  						};
>  					};
> @@ -80,12 +79,8 @@
>  		#size-cells = <0>;
>  		status = "disabled";
>  
> -		port at 0 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			panel_input: endpoint at 0 {
> -				reg = <0>;
> +		port {
> +			panel_input: endpoint {
>  				remote-endpoint = <&hlcdc_panel_output>;
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index eae5e1ee9cd8..2c51042e1f6b 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -239,8 +239,6 @@
>  				clock-names = "isi_clk";
>  				status = "disabled";
>  				port {
> -					#address-cells = <1>;
> -					#size-cells = <0>;
>  				};
>  			};
>  
> diff --git a/arch/arm/boot/dts/sama5d3_lcd.dtsi b/arch/arm/boot/dts/sama5d3_lcd.dtsi
> index be7cfefc6c31..2d042d7ec531 100644
> --- a/arch/arm/boot/dts/sama5d3_lcd.dtsi
> +++ b/arch/arm/boot/dts/sama5d3_lcd.dtsi
> @@ -23,13 +23,7 @@
>  
>  				hlcdc-display-controller {
>  					compatible = "atmel,hlcdc-display-controller";
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					port at 0 {
> -						#address-cells = <1>;
> -						#size-cells = <0>;
> -						reg = <0>;
> +					port {
>  					};
>  				};
>  
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 0cf9beddd556..90d7b64915ec 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -333,13 +333,7 @@
>  
>  				hlcdc-display-controller {
>  					compatible = "atmel,hlcdc-display-controller";
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					port at 0 {
> -						#address-cells = <1>;
> -						#size-cells = <0>;
> -						reg = <0>;
> +					port {
>  					};
>  				};
>  
