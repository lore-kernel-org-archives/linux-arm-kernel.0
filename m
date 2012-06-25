From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 25 Jun 2012 10:33:58 +0200
Subject: [PATCH v3 2/7] ARM: at91: add of irq priorities support
In-Reply-To: <1340467539-12294-3-git-send-email-ludovic.desroches@atmel.com>
References: <1340467539-12294-1-git-send-email-ludovic.desroches@atmel.com>
 <1340467539-12294-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <4FE82276.5040901@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2012 06:05 PM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Add a third cell to define irq priority.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  .../devicetree/bindings/arm/atmel-aic.txt          |    8 +++--
>  arch/arm/boot/dts/at91sam9260.dtsi                 |   36 +++++++++---------
>  arch/arm/boot/dts/at91sam9263.dtsi                 |   30 ++++++++--------
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |   38 ++++++++++----------
>  arch/arm/boot/dts/at91sam9n12.dtsi                 |   30 ++++++++--------
>  arch/arm/boot/dts/at91sam9x5.dtsi                  |   38 ++++++++++----------
>  arch/arm/mach-at91/include/mach/at91_aic.h         |    3 ++
>  arch/arm/mach-at91/irq.c                           |   34 ++++++++++++++++--
>  8 files changed, 125 insertions(+), 92 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-aic.txt b/Documentation/devicetree/bindings/arm/atmel-aic.txt
> index 1953b0c..19078bf 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-aic.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-aic.txt
> @@ -4,7 +4,7 @@ Required properties:
>  - compatible: Should be "atmel,<chip>-aic"
>  - interrupt-controller: Identifies the node as an interrupt controller.
>  - interrupt-parent: For single AIC system, it is an empty property.
> -- #interrupt-cells: The number of cells to define the interrupts. It sould be 2.
> +- #interrupt-cells: The number of cells to define the interrupts. It sould be 3.
>    The first cell is the IRQ number (aka "Peripheral IDentifier" on datasheet).
>    The second cell is used to specify flags:
>      bits[3:0] trigger type and level flags:
> @@ -14,6 +14,8 @@ Required properties:
>        8 = active low level-sensitive.
>        Valid combinations are 1, 2, 3, 4, 8.
>        Default flag for internal sources should be set to 4 (active high).
> +  The third cell is used to specify the irq priority from 0 (lowest) to 7
> +  (highest).
>  - reg: Should contain AIC registers location and length
>  - atmel,external-irqs: u32 array of external irqs.
>  
> @@ -25,7 +27,7 @@ Examples:
>  		compatible = "atmel,at91rm9200-aic";
>  		interrupt-controller;
>  		interrupt-parent;
> -		#interrupt-cells = <2>;
> +		#interrupt-cells = <3>;
>  		reg = <0xfffff000 0x200>;
>  	};
>  
> @@ -35,5 +37,5 @@ Examples:
>  	dma: dma-controller at ffffec00 {
>  		compatible = "atmel,at91sam9g45-dma";
>  		reg = <0xffffec00 0x200>;
> -		interrupts = <21 4>;
> +		interrupts = <21 4 5>;
>  	};
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> index f2c9643..66389c1 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -52,7 +52,7 @@
>  			ranges;
>  
>  			aic: interrupt-controller at fffff000 {
> -				#interrupt-cells = <2>;
> +				#interrupt-cells = <3>;
>  				compatible = "atmel,at91rm9200-aic";
>  				interrupt-controller;
>  				reg = <0xfffff000 0x200>;
> @@ -82,25 +82,25 @@
>  			pit: timer at fffffd30 {
>  				compatible = "atmel,at91sam9260-pit";
>  				reg = <0xfffffd30 0xf>;
> -				interrupts = <1 4>;
> +				interrupts = <1 4 7>;
>  			};
>  
>  			tcb0: timer at fffa0000 {
>  				compatible = "atmel,at91rm9200-tcb";
>  				reg = <0xfffa0000 0x100>;
> -				interrupts = <17 4 18 4 19 4>;
> +				interrupts = <17 4 0 18 4 0 19 4 0>;
>  			};
>  
>  			tcb1: timer at fffdc000 {
>  				compatible = "atmel,at91rm9200-tcb";
>  				reg = <0xfffdc000 0x100>;
> -				interrupts = <26 4 27 4 28 4>;
> +				interrupts = <26 4 0 27 4 0 28 4 0>;
>  			};
>  
>  			pioA: gpio at fffff400 {
>  				compatible = "atmel,at91rm9200-gpio";
>  				reg = <0xfffff400 0x100>;
> -				interrupts = <2 4>;
> +				interrupts = <2 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -109,7 +109,7 @@
>  			pioB: gpio at fffff600 {
>  				compatible = "atmel,at91rm9200-gpio";
>  				reg = <0xfffff600 0x100>;
> -				interrupts = <3 4>;
> +				interrupts = <3 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -118,7 +118,7 @@
>  			pioC: gpio at fffff800 {
>  				compatible = "atmel,at91rm9200-gpio";
>  				reg = <0xfffff800 0x100>;
> -				interrupts = <4 4>;
> +				interrupts = <4 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -127,14 +127,14 @@
>  			dbgu: serial at fffff200 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfffff200 0x200>;
> -				interrupts = <1 4>;
> +				interrupts = <1 4 7>;
>  				status = "disabled";
>  			};
>  
>  			usart0: serial at fffb0000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfffb0000 0x200>;
> -				interrupts = <6 4>;
> +				interrupts = <6 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -143,7 +143,7 @@
>  			usart1: serial at fffb4000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfffb4000 0x200>;
> -				interrupts = <7 4>;
> +				interrupts = <7 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -152,7 +152,7 @@
>  			usart2: serial at fffb8000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfffb8000 0x200>;
> -				interrupts = <8 4>;
> +				interrupts = <8 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -161,7 +161,7 @@
>  			usart3: serial at fffd0000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfffd0000 0x200>;
> -				interrupts = <23 4>;
> +				interrupts = <23 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -170,7 +170,7 @@
>  			usart4: serial at fffd4000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfffd4000 0x200>;
> -				interrupts = <24 4>;
> +				interrupts = <24 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -179,7 +179,7 @@
>  			usart5: serial at fffd8000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfffd8000 0x200>;
> -				interrupts = <25 4>;
> +				interrupts = <25 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -188,21 +188,21 @@
>  			macb0: ethernet at fffc4000 {
>  				compatible = "cdns,at32ap7000-macb", "cdns,macb";
>  				reg = <0xfffc4000 0x100>;
> -				interrupts = <21 4>;
> +				interrupts = <21 4 3>;
>  				status = "disabled";
>  			};
>  
>  			usb1: gadget at fffa4000 {
>  				compatible = "atmel,at91rm9200-udc";
>  				reg = <0xfffa4000 0x4000>;
> -				interrupts = <10 4>;
> +				interrupts = <10 4 2>;
>  				status = "disabled";
>  			};
>  
>  			adc0: adc at fffe0000 {
>  				compatible = "atmel,at91sam9260-adc";
>  				reg = <0xfffe0000 0x100>;
> -				interrupts = <5 4>;
> +				interrupts = <5 4 0>;
>  				atmel,adc-use-external-triggers;
>  				atmel,adc-channels-used = <0xf>;
>  				atmel,adc-vref = <3300>;
> @@ -254,7 +254,7 @@
>  		usb0: ohci at 00500000 {
>  			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>  			reg = <0x00500000 0x100000>;
> -			interrupts = <20 4>;
> +			interrupts = <20 4 2>;
>  			status = "disabled";
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> index c803636..b460d6c 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -48,7 +48,7 @@
>  			ranges;
>  
>  			aic: interrupt-controller at fffff000 {
> -				#interrupt-cells = <2>;
> +				#interrupt-cells = <3>;
>  				compatible = "atmel,at91rm9200-aic";
>  				interrupt-controller;
>  				reg = <0xfffff000 0x200>;
> @@ -69,13 +69,13 @@
>  			pit: timer at fffffd30 {
>  				compatible = "atmel,at91sam9260-pit";
>  				reg = <0xfffffd30 0xf>;
> -				interrupts = <1 4>;
> +				interrupts = <1 4 7>;
>  			};
>  
>  			tcb0: timer at fff7c000 {
>  				compatible = "atmel,at91rm9200-tcb";
>  				reg = <0xfff7c000 0x100>;
> -				interrupts = <19 4>;
> +				interrupts = <19 4 0>;
>  			};
>  
>  			rstc at fffffd00 {
> @@ -91,7 +91,7 @@
>  			pioA: gpio at fffff200 {
>  				compatible = "atmel,at91rm9200-gpio";
>  				reg = <0xfffff200 0x100>;
> -				interrupts = <2 4>;
> +				interrupts = <2 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -100,7 +100,7 @@
>  			pioB: gpio at fffff400 {
>  				compatible = "atmel,at91rm9200-gpio";
>  				reg = <0xfffff400 0x100>;
> -				interrupts = <3 4>;
> +				interrupts = <3 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -109,7 +109,7 @@
>  			pioC: gpio at fffff600 {
>  				compatible = "atmel,at91rm9200-gpio";
>  				reg = <0xfffff600 0x100>;
> -				interrupts = <4 4>;
> +				interrupts = <4 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -118,7 +118,7 @@
>  			pioD: gpio at fffff800 {
>  				compatible = "atmel,at91rm9200-gpio";
>  				reg = <0xfffff800 0x100>;
> -				interrupts = <4 4>;
> +				interrupts = <4 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -127,7 +127,7 @@
>  			pioE: gpio at fffffa00 {
>  				compatible = "atmel,at91rm9200-gpio";
>  				reg = <0xfffffa00 0x100>;
> -				interrupts = <4 4>;
> +				interrupts = <4 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -136,14 +136,14 @@
>  			dbgu: serial at ffffee00 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xffffee00 0x200>;
> -				interrupts = <1 4>;
> +				interrupts = <1 4 7>;
>  				status = "disabled";
>  			};
>  
>  			usart0: serial at fff8c000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfff8c000 0x200>;
> -				interrupts = <7 4>;
> +				interrupts = <7 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -152,7 +152,7 @@
>  			usart1: serial at fff90000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfff90000 0x200>;
> -				interrupts = <8 4>;
> +				interrupts = <8 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -161,7 +161,7 @@
>  			usart2: serial at fff94000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfff94000 0x200>;
> -				interrupts = <9 4>;
> +				interrupts = <9 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -170,14 +170,14 @@
>  			macb0: ethernet at fffbc000 {
>  				compatible = "cdns,at32ap7000-macb", "cdns,macb";
>  				reg = <0xfffbc000 0x100>;
> -				interrupts = <21 4>;
> +				interrupts = <21 4 3>;
>  				status = "disabled";
>  			};
>  
>  			usb1: gadget at fff78000 {
>  				compatible = "atmel,at91rm9200-udc";
>  				reg = <0xfff78000 0x4000>;
> -				interrupts = <24 4>;
> +				interrupts = <24 4 2>;
>  				status = "disabled";
>  			};
>  		};
> @@ -201,7 +201,7 @@
>  		usb0: ohci at 00a00000 {
>  			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>  			reg = <0x00a00000 0x100000>;
> -			interrupts = <29 4>;
> +			interrupts = <29 4 2>;
>  			status = "disabled";
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 2d01ce2..bafa880 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -53,7 +53,7 @@
>  			ranges;
>  
>  			aic: interrupt-controller at fffff000 {
> -				#interrupt-cells = <2>;
> +				#interrupt-cells = <3>;
>  				compatible = "atmel,at91rm9200-aic";
>  				interrupt-controller;
>  				reg = <0xfffff000 0x200>;
> @@ -79,7 +79,7 @@
>  			pit: timer at fffffd30 {
>  				compatible = "atmel,at91sam9260-pit";
>  				reg = <0xfffffd30 0xf>;
> -				interrupts = <1 4>;
> +				interrupts = <1 4 7>;
>  			};
>  
>  
> @@ -91,25 +91,25 @@
>  			tcb0: timer at fff7c000 {
>  				compatible = "atmel,at91rm9200-tcb";
>  				reg = <0xfff7c000 0x100>;
> -				interrupts = <18 4>;
> +				interrupts = <18 4 0>;
>  			};
>  
>  			tcb1: timer at fffd4000 {
>  				compatible = "atmel,at91rm9200-tcb";
>  				reg = <0xfffd4000 0x100>;
> -				interrupts = <18 4>;
> +				interrupts = <18 4 0>;
>  			};
>  
>  			dma: dma-controller at ffffec00 {
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffec00 0x200>;
> -				interrupts = <21 4>;
> +				interrupts = <21 4 0>;
>  			};
>  
>  			pioA: gpio at fffff200 {
>  				compatible = "atmel,at91rm9200-gpio";
>  				reg = <0xfffff200 0x100>;
> -				interrupts = <2 4>;
> +				interrupts = <2 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -118,7 +118,7 @@
>  			pioB: gpio at fffff400 {
>  				compatible = "atmel,at91rm9200-gpio";
>  				reg = <0xfffff400 0x100>;
> -				interrupts = <3 4>;
> +				interrupts = <3 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -127,7 +127,7 @@
>  			pioC: gpio at fffff600 {
>  				compatible = "atmel,at91rm9200-gpio";
>  				reg = <0xfffff600 0x100>;
> -				interrupts = <4 4>;
> +				interrupts = <4 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -136,7 +136,7 @@
>  			pioD: gpio at fffff800 {
>  				compatible = "atmel,at91rm9200-gpio";
>  				reg = <0xfffff800 0x100>;
> -				interrupts = <5 4>;
> +				interrupts = <5 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -145,7 +145,7 @@
>  			pioE: gpio at fffffa00 {
>  				compatible = "atmel,at91rm9200-gpio";
>  				reg = <0xfffffa00 0x100>;
> -				interrupts = <5 4>;
> +				interrupts = <5 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -154,14 +154,14 @@
>  			dbgu: serial at ffffee00 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xffffee00 0x200>;
> -				interrupts = <1 4>;
> +				interrupts = <1 4 7>;
>  				status = "disabled";
>  			};
>  
>  			usart0: serial at fff8c000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfff8c000 0x200>;
> -				interrupts = <7 4>;
> +				interrupts = <7 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -170,7 +170,7 @@
>  			usart1: serial at fff90000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfff90000 0x200>;
> -				interrupts = <8 4>;
> +				interrupts = <8 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -179,7 +179,7 @@
>  			usart2: serial at fff94000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfff94000 0x200>;
> -				interrupts = <9 4>;
> +				interrupts = <9 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -188,7 +188,7 @@
>  			usart3: serial at fff98000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfff98000 0x200>;
> -				interrupts = <10 4>;
> +				interrupts = <10 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -197,14 +197,14 @@
>  			macb0: ethernet at fffbc000 {
>  				compatible = "cdns,at32ap7000-macb", "cdns,macb";
>  				reg = <0xfffbc000 0x100>;
> -				interrupts = <25 4>;
> +				interrupts = <25 4 3>;
>  				status = "disabled";
>  			};
>  
>  			adc0: adc at fffb0000 {
>  				compatible = "atmel,at91sam9260-adc";
>  				reg = <0xfffb0000 0x100>;
> -				interrupts = <20 4>;
> +				interrupts = <20 4 0>;
>  				atmel,adc-use-external-triggers;
>  				atmel,adc-channels-used = <0xff>;
>  				atmel,adc-vref = <3300>;
> @@ -258,14 +258,14 @@
>  		usb0: ohci at 00700000 {
>  			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>  			reg = <0x00700000 0x100000>;
> -			interrupts = <22 4>;
> +			interrupts = <22 4 2>;
>  			status = "disabled";
>  		};
>  
>  		usb1: ehci at 00800000 {
>  			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
>  			reg = <0x00800000 0x100000>;
> -			interrupts = <22 4>;
> +			interrupts = <22 4 2>;
>  			status = "disabled";
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index cb84de7..bfac0df 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -50,7 +50,7 @@
>  			ranges;
>  
>  			aic: interrupt-controller at fffff000 {
> -				#interrupt-cells = <2>;
> +				#interrupt-cells = <3>;
>  				compatible = "atmel,at91rm9200-aic";
>  				interrupt-controller;
>  				reg = <0xfffff000 0x200>;
> @@ -74,7 +74,7 @@
>  			pit: timer at fffffe30 {
>  				compatible = "atmel,at91sam9260-pit";
>  				reg = <0xfffffe30 0xf>;
> -				interrupts = <1 4>;
> +				interrupts = <1 4 7>;
>  			};
>  
>  			shdwc at fffffe10 {
> @@ -85,25 +85,25 @@
>  			tcb0: timer at f8008000 {
>  				compatible = "atmel,at91sam9x5-tcb";
>  				reg = <0xf8008000 0x100>;
> -				interrupts = <17 4>;
> +				interrupts = <17 4 0>;
>  			};
>  
>  			tcb1: timer at f800c000 {
>  				compatible = "atmel,at91sam9x5-tcb";
>  				reg = <0xf800c000 0x100>;
> -				interrupts = <17 4>;
> +				interrupts = <17 4 0>;
>  			};
>  
>  			dma: dma-controller at ffffec00 {
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffec00 0x200>;
> -				interrupts = <20 4>;
> +				interrupts = <20 4 0>;
>  			};
>  
>  			pioA: gpio at fffff400 {
>  				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  				reg = <0xfffff400 0x100>;
> -				interrupts = <2 4>;
> +				interrupts = <2 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -112,7 +112,7 @@
>  			pioB: gpio at fffff600 {
>  				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  				reg = <0xfffff600 0x100>;
> -				interrupts = <2 4>;
> +				interrupts = <2 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -121,7 +121,7 @@
>  			pioC: gpio at fffff800 {
>  				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  				reg = <0xfffff800 0x100>;
> -				interrupts = <3 4>;
> +				interrupts = <3 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -130,7 +130,7 @@
>  			pioD: gpio at fffffa00 {
>  				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  				reg = <0xfffffa00 0x100>;
> -				interrupts = <3 4>;
> +				interrupts = <3 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -139,14 +139,14 @@
>  			dbgu: serial at fffff200 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfffff200 0x200>;
> -				interrupts = <1 4>;
> +				interrupts = <1 4 7>;
>  				status = "disabled";
>  			};
>  
>  			usart0: serial at f801c000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xf801c000 0x4000>;
> -				interrupts = <5 4>;
> +				interrupts = <5 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -155,7 +155,7 @@
>  			usart1: serial at f8020000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xf8020000 0x4000>;
> -				interrupts = <6 4>;
> +				interrupts = <6 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -164,7 +164,7 @@
>  			usart2: serial at f8024000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xf8024000 0x4000>;
> -				interrupts = <7 4>;
> +				interrupts = <7 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -173,7 +173,7 @@
>  			usart3: serial at f8028000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xf8028000 0x4000>;
> -				interrupts = <8 4>;
> +				interrupts = <8 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -201,7 +201,7 @@
>  		usb0: ohci at 00500000 {
>  			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>  			reg = <0x00500000 0x00100000>;
> -			interrupts = <22 4>;
> +			interrupts = <22 4 2>;
>  			status = "disabled";
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 6a0a0fb..4a18c39 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -51,7 +51,7 @@
>  			ranges;
>  
>  			aic: interrupt-controller at fffff000 {
> -				#interrupt-cells = <2>;
> +				#interrupt-cells = <3>;
>  				compatible = "atmel,at91rm9200-aic";
>  				interrupt-controller;
>  				reg = <0xfffff000 0x200>;
> @@ -81,37 +81,37 @@
>  			pit: timer at fffffe30 {
>  				compatible = "atmel,at91sam9260-pit";
>  				reg = <0xfffffe30 0xf>;
> -				interrupts = <1 4>;
> +				interrupts = <1 4 7>;
>  			};
>  
>  			tcb0: timer at f8008000 {
>  				compatible = "atmel,at91sam9x5-tcb";
>  				reg = <0xf8008000 0x100>;
> -				interrupts = <17 4>;
> +				interrupts = <17 4 0>;
>  			};
>  
>  			tcb1: timer at f800c000 {
>  				compatible = "atmel,at91sam9x5-tcb";
>  				reg = <0xf800c000 0x100>;
> -				interrupts = <17 4>;
> +				interrupts = <17 4 0>;
>  			};
>  
>  			dma0: dma-controller at ffffec00 {
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffec00 0x200>;
> -				interrupts = <20 4>;
> +				interrupts = <20 4 0>;
>  			};
>  
>  			dma1: dma-controller at ffffee00 {
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffee00 0x200>;
> -				interrupts = <21 4>;
> +				interrupts = <21 4 0>;
>  			};
>  
>  			pioA: gpio at fffff400 {
>  				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  				reg = <0xfffff400 0x100>;
> -				interrupts = <2 4>;
> +				interrupts = <2 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -120,7 +120,7 @@
>  			pioB: gpio at fffff600 {
>  				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  				reg = <0xfffff600 0x100>;
> -				interrupts = <2 4>;
> +				interrupts = <2 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -129,7 +129,7 @@
>  			pioC: gpio at fffff800 {
>  				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  				reg = <0xfffff800 0x100>;
> -				interrupts = <3 4>;
> +				interrupts = <3 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -138,7 +138,7 @@
>  			pioD: gpio at fffffa00 {
>  				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  				reg = <0xfffffa00 0x100>;
> -				interrupts = <3 4>;
> +				interrupts = <3 4 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
>  				interrupt-controller;
> @@ -147,14 +147,14 @@
>  			dbgu: serial at fffff200 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfffff200 0x200>;
> -				interrupts = <1 4>;
> +				interrupts = <1 4 7>;
>  				status = "disabled";
>  			};
>  
>  			usart0: serial at f801c000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xf801c000 0x200>;
> -				interrupts = <5 4>;
> +				interrupts = <5 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -163,7 +163,7 @@
>  			usart1: serial at f8020000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xf8020000 0x200>;
> -				interrupts = <6 4>;
> +				interrupts = <6 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -172,7 +172,7 @@
>  			usart2: serial at f8024000 {
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xf8024000 0x200>;
> -				interrupts = <7 4>;
> +				interrupts = <7 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
>  				status = "disabled";
> @@ -181,21 +181,21 @@
>  			macb0: ethernet at f802c000 {
>  				compatible = "cdns,at32ap7000-macb", "cdns,macb";
>  				reg = <0xf802c000 0x100>;
> -				interrupts = <24 4>;
> +				interrupts = <24 4 3>;
>  				status = "disabled";
>  			};
>  
>  			macb1: ethernet at f8030000 {
>  				compatible = "cdns,at32ap7000-macb", "cdns,macb";
>  				reg = <0xf8030000 0x100>;
> -				interrupts = <27 4>;
> +				interrupts = <27 4 3>;
>  				status = "disabled";
>  			};
>  
>  			adc0: adc at f804c000 {
>  				compatible = "atmel,at91sam9260-adc";
>  				reg = <0xf804c000 0x100>;
> -				interrupts = <19 4>;
> +				interrupts = <19 4 0>;
>  				atmel,adc-use-external;
>  				atmel,adc-channels-used = <0xffff>;
>  				atmel,adc-vref = <3300>;
> @@ -249,14 +249,14 @@
>  		usb0: ohci at 00600000 {
>  			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>  			reg = <0x00600000 0x100000>;
> -			interrupts = <22 4>;
> +			interrupts = <22 4 2>;
>  			status = "disabled";
>  		};
>  
>  		usb1: ehci at 00700000 {
>  			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
>  			reg = <0x00700000 0x100000>;
> -			interrupts = <22 4>;
> +			interrupts = <22 4 2>;
>  			status = "disabled";
>  		};
>  	};
> diff --git a/arch/arm/mach-at91/include/mach/at91_aic.h b/arch/arm/mach-at91/include/mach/at91_aic.h
> index c1413ed..3af7272 100644
> --- a/arch/arm/mach-at91/include/mach/at91_aic.h
> +++ b/arch/arm/mach-at91/include/mach/at91_aic.h
> @@ -28,6 +28,9 @@ extern void __iomem *at91_aic_base;
>  .extern at91_aic_base
>  #endif
>  
> +#define AT91_AIC_IRQ_MIN_PRIORITY	0
> +#define AT91_AIC_IRQ_MAX_PRIORITY	7
> +
>  #define AT91_AIC_SMR(n)		((n) * 4)		/* Source Mode Registers 0-31 */
>  #define		AT91_AIC_PRIOR		(7 << 0)		/* Priority Level */
>  #define		AT91_AIC_SRCTYPE	(3 << 5)		/* Interrupt Source Type */
> diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
> index df8605f..cc009be 100644
> --- a/arch/arm/mach-at91/irq.c
> +++ b/arch/arm/mach-at91/irq.c
> @@ -30,6 +30,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/err.h>
> +#include <linux/slab.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/irq.h>
> @@ -42,6 +43,7 @@
>  void __iomem *at91_aic_base;
>  static struct irq_domain *at91_aic_domain;
>  static struct device_node *at91_aic_np;
> +static unsigned int *at91_aic_irq_priorities;
>  
>  static void at91_aic_mask_irq(struct irq_data *d)
>  {
> @@ -177,8 +179,9 @@ static int at91_aic_irq_map(struct irq_domain *h, unsigned int virq,
>  	/* Put virq number in Source Vector Register */
>  	at91_aic_write(AT91_AIC_SVR(hw), virq);
>  
> -	/* Active Low interrupt, without priority */
> -	at91_aic_write(AT91_AIC_SMR(hw), AT91_AIC_SRCTYPE_LOW);
> +	/* Active Low interrupt, with priority */
> +	at91_aic_write(AT91_AIC_SMR(hw),
> +	               AT91_AIC_SRCTYPE_LOW | at91_aic_irq_priorities[hw]);
>  
>  	irq_set_chip_and_handler(virq, &at91_aic_chip, handle_fasteoi_irq);
>  	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
> @@ -186,9 +189,28 @@ static int at91_aic_irq_map(struct irq_domain *h, unsigned int virq,
>  	return 0;
>  }
>  
> +static int at91_aic_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
> +                               const u32 *intspec, unsigned int intsize,
> +                               irq_hw_number_t *out_hwirq, unsigned int *out_type)
> +{
> +	if (WARN_ON(intsize < 3))
> +		return -EINVAL;
> +	if (WARN_ON(intspec[0] >= NR_AIC_IRQS))
> +		return -EINVAL;
> +	if (WARN_ON((intspec[2] < AT91_AIC_IRQ_MIN_PRIORITY)
> +	            || (intspec[2] > AT91_AIC_IRQ_MAX_PRIORITY)))
> +		return -EINVAL;
> +
> +	*out_hwirq = intspec[0];
> +	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
> +	at91_aic_irq_priorities[*out_hwirq] = intspec[2];
> +
> +	return 0;
> +}
> +
>  static struct irq_domain_ops at91_aic_irq_ops = {
>  	.map	= at91_aic_irq_map,
> -	.xlate	= irq_domain_xlate_twocell,
> +	.xlate	= at91_aic_irq_domain_xlate,
>  };
>  
>  int __init at91_aic_of_init(struct device_node *node,
> @@ -198,6 +220,12 @@ int __init at91_aic_of_init(struct device_node *node,
>  	const __be32 *p;
>  	u32 val;
>  
> +	at91_aic_irq_priorities = kzalloc(NR_AIC_IRQS
> +	                                  * sizeof(*at91_aic_irq_priorities),
> +	                                  GFP_KERNEL);
> +	if (!at91_aic_irq_priorities)
> +		return -ENOMEM;
> +
>  	at91_aic_base = of_iomap(node, 0);
>  	at91_aic_np = node;
>  
> 


-- 
Nicolas Ferre
