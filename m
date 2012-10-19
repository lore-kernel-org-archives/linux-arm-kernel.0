From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 20 Oct 2012 11:37:41 +1300
Subject: [PATCH 1/3] ARM: dts: Update board files for pwm support
In-Reply-To: <1350643135-13197-1-git-send-email-linux@prisktech.co.nz>
References: <1350643135-13197-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1350686261.17901.1.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-19 at 23:38 +1300, Tony Prisk wrote:
> This patch adds pwm support to arch-vt8500 board files, and adds
> the use-case of pwm-backlight.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  arch/arm/boot/dts/vt8500-bv07.dts |    8 ++++++++
>  arch/arm/boot/dts/vt8500.dtsi     |   29 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/wm8505-ref.dts  |    8 ++++++++
>  arch/arm/boot/dts/wm8505.dtsi     |   29 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/wm8650-mid.dts  |    8 ++++++++
>  arch/arm/boot/dts/wm8650.dtsi     |   17 +++++++++++++----
>  6 files changed, 95 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vt8500-bv07.dts b/arch/arm/boot/dts/vt8500-bv07.dts
> index 567cf4e..3cba367 100644
> --- a/arch/arm/boot/dts/vt8500-bv07.dts
> +++ b/arch/arm/boot/dts/vt8500-bv07.dts
> @@ -33,4 +33,12 @@
>  			};
>  		};
>  	};
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm 0 50000>;
> +
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <5>;
> +	};
>  };
> diff --git a/arch/arm/boot/dts/vt8500.dtsi b/arch/arm/boot/dts/vt8500.dtsi
> index d8645e9..e196b2e 100644
> --- a/arch/arm/boot/dts/vt8500.dtsi
> +++ b/arch/arm/boot/dts/vt8500.dtsi
> @@ -40,14 +40,43 @@
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  
> +				ref25: ref25M {
> +					#clock-cells = <0>;
> +					compatible = "fixed-clock";
> +					clock-frequency = <25000000>;
> +				};
> +
>  				ref24: ref24M {
>  					#clock-cells = <0>;
>  					compatible = "fixed-clock";
>  					clock-frequency = <24000000>;
>  				};
> +
> +				pllb: pllb {
> +					#clock-cells = <0>;
> +					compatible = "via,vt8500-pll-clock";
> +					clocks = <&ref25>;
> +					reg = <0x204>;
> +				};
> +
> +				clkpwm: pwm {
> +					#clock-cells = <0>;
> +					compatible = "via,vt8500-device-clock";
> +					clocks = <&pllb>;
> +					divisor-reg = <0x348>;
> +					enable-reg = <0x250>;
> +					enable-bit = <14>;
> +				};
>  			};
>  		};
>  
> +		pwm: pwm at d8220000 {
> +			#pwm-cells = <2>;
> +			compatible = "via,vt8500-pwm";
> +			reg = <0xd8220000 0x100>;
> +			clocks = <&clkpwm>;
> +		};
> +
>  		timer at d8130100 {
>  			compatible = "via,vt8500-timer";
>  			reg = <0xd8130100 0x28>;
> diff --git a/arch/arm/boot/dts/wm8505-ref.dts b/arch/arm/boot/dts/wm8505-ref.dts
> index fd4e248..f51c0ed 100644
> --- a/arch/arm/boot/dts/wm8505-ref.dts
> +++ b/arch/arm/boot/dts/wm8505-ref.dts
> @@ -33,4 +33,12 @@
>  			};
>  		};
>  	};
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm 0 50000>;
> +
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <5>;
> +	};
>  };
> diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
> index b459691..83c8ec5 100644
> --- a/arch/arm/boot/dts/wm8505.dtsi
> +++ b/arch/arm/boot/dts/wm8505.dtsi
> @@ -54,14 +54,43 @@
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  
> +				ref25: ref25M {
> +					#clock-cells = <0>;
> +					compatible = "fixed-clock";
> +					clock-frequency = <25000000>;
> +				};
> +
>  				ref24: ref24M {
>  					#clock-cells = <0>;
>  					compatible = "fixed-clock";
>  					clock-frequency = <24000000>;
>  				};
> +
> +				pllb: pllb {
> +					#clock-cells = <0>;
> +					compatible = "via,vt8500-pll-clock";
> +					clocks = <&ref25>;
> +					reg = <0x204>;
> +				};
> +
> +				clkpwm: pwm {
> +					#clock-cells = <0>;
> +					compatible = "via,vt8500-device-clock";
> +					clocks = <&pllb>;
> +					divisor-reg = <0x348>;
> +					enable-reg = <0x250>;
> +					enable-bit = <10>;
> +				};
>  			};
>  		};
>  
> +		pwm: pwm at d8220000 {
> +			#pwm-cells = <2>;
> +			compatible = "via,vt8500-pwm";
> +			reg = <0xd8220000 0x100>;
> +			clocks = <&clkpwm>;
> +		};
> +
>  		timer at d8130100 {
>  			compatible = "via,vt8500-timer";
>  			reg = <0xd8130100 0x28>;
> diff --git a/arch/arm/boot/dts/wm8650-mid.dts b/arch/arm/boot/dts/wm8650-mid.dts
> index cefd938..7a05dd5 100644
> --- a/arch/arm/boot/dts/wm8650-mid.dts
> +++ b/arch/arm/boot/dts/wm8650-mid.dts
> @@ -33,4 +33,12 @@
>  			};
>  		};
>  	};
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm 0 50000>;
> +
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <5>;
> +	};
>  };
> diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
> index 83b9467..a25d240 100644
> --- a/arch/arm/boot/dts/wm8650.dtsi
> +++ b/arch/arm/boot/dts/wm8650.dtsi
> @@ -75,14 +75,16 @@
>  					reg = <0x204>;
>  				};
>  
> -				arm: arm {
> +				clkpwm: pwm {
>  					#clock-cells = <0>;
>  					compatible = "via,vt8500-device-clock";
> -					clocks = <&plla>;
> -					divisor-reg = <0x300>;
> +					clocks = <&pllb>;
> +					divisor-reg = <0x348>;
> +					enable-reg = <0x250>;
> +					enable-bit = <10>;
>  				};
>  
> -				sdhc: sdhc {
> +				clksdhc: sdhc {
>  					#clock-cells = <0>;
>  					compatible = "via,vt8500-device-clock";
>  					clocks = <&pllb>;
> @@ -94,6 +96,13 @@
>  			};
>  		};
>  
> +		pwm: pwm at d8220000 {
> +			#pwm-cells = <2>;
> +			compatible = "via,vt8500-pwm";
> +			reg = <0xd8220000 0x100>;
> +			clocks = <&clkpwm>;
> +		};
> +
>  		timer at d8130100 {
>  			compatible = "via,vt8500-timer";
>  			reg = <0xd8130100 0x28>;

Please don't pull Patch 1/3 to any trees. I will include in a
pull-request for arm-soc with other dts updates later on.

Patch 2/3 + 3/3 can be taken now or Ack'd and I'll do a pull-request
later.

Regards
Tony P
