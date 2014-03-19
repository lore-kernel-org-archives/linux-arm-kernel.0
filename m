From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Mar 2014 16:39:29 +0100
Subject: [PATCH 10/11] ARM: at91/dt: move at91sam9rl SoC to the new
 slow/main clock models
In-Reply-To: <1395173924-3648-11-git-send-email-b.brezillon.dev@gmail.com>
References: <1395173924-3648-1-git-send-email-b.brezillon.dev@gmail.com>
 <1395173924-3648-11-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <20140319153929.GN12021@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/2014 at 21:18:43 +0100, Boris BREZILLON wrote :
> Move at91sam9rl SoC to the new main/slow clock model.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
> ---
>  arch/arm/boot/dts/at91sam9rl.dtsi |   45 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
> index 63e1784..b367047 100644
> --- a/arch/arm/boot/dts/at91sam9rl.dtsi
> +++ b/arch/arm/boot/dts/at91sam9rl.dtsi
> @@ -48,6 +48,20 @@
>  		reg = <0x20000000 0x04000000>;
>  	};
>  
> +	clocks {
> +		slow_xtal: slow_xtal {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <0>;
> +		};
> +
> +		main_xtal: main_xtal {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <0>;
> +		};
> +	};
> +
>  	ahb {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -548,12 +562,6 @@
>  				#size-cells = <0>;
>  				#interrupt-cells = <1>;
>  
> -				clk32k: slck {
> -					compatible = "fixed-clock";
> -					#clock-cells = <0>;
> -					clock-frequency = <32768>;
> -				};
> -
>  				main: mainck {
>  					compatible = "atmel,at91rm9200-clk-main";
>  					#clock-cells = <0>;

Somewhere, around here, you forgot:
-                                       clocks = <&clk32k>;
+                                       clocks = <&main_xtal>;


> @@ -769,6 +777,31 @@
>  				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
>  				status = "disabled";
>  			};
> +
> +			sckc at fffffd50 {
> +				compatible = "atmel,at91sam9x5-sckc";
> +
> +				slow_osc: slow_osc {
> +					compatible = "atmel,at91sam9x5-clk-slow-osc";
> +					#clock-cells = <0>;
> +					atmel,startup-time-usec = <1200000>;
> +					clocks = <&slow_xtal>;
> +				};
> +
> +				slow_rc_osc: slow_rc_osc {
> +					compatible = "atmel,at91sam9x5-clk-slow-rc-osc";
> +					#clock-cells = <0>;
> +					atmel,startup-time-usec = <75>;
> +					clock-frequency = <32768>;
> +					clock-accuracy = <50000000>;
> +				};
> +
> +				clk32k: slck {
> +					compatible = "atmel,at91sam9x5-clk-slow";
> +					#clock-cells = <0>;
> +					clocks = <&slow_rc_osc &slow_osc>;
> +				};
> +			};
>  		};
>  	};
>  
> -- 
> 1.7.9.5
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
