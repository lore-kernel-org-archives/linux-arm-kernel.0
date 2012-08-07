From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 7 Aug 2012 14:50:20 +0200
Subject: [PATCH 3/4] at91: regroup gpio and pinctrl under a simple-bus
In-Reply-To: <1342359637-15325-3-git-send-email-plagnioj@jcrosoft.com>
References: <20120715131618.GF4450@game.jcrosoft.org>
 <1342359637-15325-1-git-send-email-plagnioj@jcrosoft.com>
 <1342359637-15325-3-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <50210F0C.8050507@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2012 03:40 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Fix also the reg size as we have 512 bytes bank not 256 bytes per gpio/mux
> controller

Definitively, there is not enough information about the purpose of this
patch: please elaborate a bit more the comment.

Moreover, it seems strange to change the device tree files without
introducing the pinctrl/pinmux driver (and the associated documentation)
at the same time...

So, no, not these changes now.

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/boot/dts/at91sam9260.dtsi |   56 ++++++++++++---------
>  arch/arm/boot/dts/at91sam9263.dtsi |   98 ++++++++++++++++++++----------------
>  arch/arm/boot/dts/at91sam9g45.dtsi |   87 ++++++++++++++++++--------------
>  arch/arm/boot/dts/at91sam9n12.dtsi |   79 ++++++++++++++++-------------
>  arch/arm/boot/dts/at91sam9x5.dtsi  |   73 +++++++++++++++------------
>  5 files changed, 223 insertions(+), 170 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> index f449efc..1f6c3cd 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -96,31 +96,41 @@
>  				interrupts = <26 4 27 4 28 4>;
>  			};
>  
> -			pioA: gpio at fffff400 {
> -				compatible = "atmel,at91rm9200-gpio";
> -				reg = <0xfffff400 0x100>;
> -				interrupts = <2 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> +			pinctrl at fffff400 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges;
> +				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
> +				reg = <0xfffff400 0x200
> +				       0xfffff600 0x200
> +				       0xfffff800 0x200>;
> +
> +				pioA: gpio at 80018000 {
> +					compatible = "atmel,at91rm9200-gpio";
> +					reg = <0xfffff400 0x200>;
> +					interrupts = <2 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  
> -			pioB: gpio at fffff600 {
> -				compatible = "atmel,at91rm9200-gpio";
> -				reg = <0xfffff600 0x100>;
> -				interrupts = <3 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> +				pioB: gpio at fffff600 {
> +					compatible = "atmel,at91rm9200-gpio";
> +					reg = <0xfffff600 0x200>;
> +					interrupts = <3 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  
> -			pioC: gpio at fffff800 {
> -				compatible = "atmel,at91rm9200-gpio";
> -				reg = <0xfffff800 0x100>;
> -				interrupts = <4 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> +				pioC: gpio at fffff800 {
> +					compatible = "atmel,at91rm9200-gpio";
> +					reg = <0xfffff800 0x200>;
> +					interrupts = <4 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  			};
>  
>  			dbgu: serial at fffff200 {
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> index 0209913..84ac493 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -87,49 +87,61 @@
>  				reg = <0xfffffd10 0x10>;
>  			};
>  
> -			pioA: gpio at fffff200 {
> -				compatible = "atmel,at91rm9200-gpio";
> -				reg = <0xfffff200 0x100>;
> -				interrupts = <2 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> -
> -			pioB: gpio at fffff400 {
> -				compatible = "atmel,at91rm9200-gpio";
> -				reg = <0xfffff400 0x100>;
> -				interrupts = <3 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> -
> -			pioC: gpio at fffff600 {
> -				compatible = "atmel,at91rm9200-gpio";
> -				reg = <0xfffff600 0x100>;
> -				interrupts = <4 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> -
> -			pioD: gpio at fffff800 {
> -				compatible = "atmel,at91rm9200-gpio";
> -				reg = <0xfffff800 0x100>;
> -				interrupts = <4 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> -
> -			pioE: gpio at fffffa00 {
> -				compatible = "atmel,at91rm9200-gpio";
> -				reg = <0xfffffa00 0x100>;
> -				interrupts = <4 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> +			pinctrl at fffff200 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges;
> +				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
> +				reg = <0xfffff200 0x200
> +				       0xfffff400 0x200
> +				       0xfffff600 0x200
> +				       0xfffff800 0x200
> +				       0xfffffa00 0x200>;
> +
> +				pioA: gpio at fffff200 {
> +					compatible = "atmel,at91rm9200-gpio";
> +					reg = <0xfffff200 0x200>;
> +					interrupts = <2 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
> +
> +				pioB: gpio at fffff400 {
> +					compatible = "atmel,at91rm9200-gpio";
> +					reg = <0xfffff400 0x200>;
> +					interrupts = <3 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
> +
> +				pioC: gpio at fffff600 {
> +					compatible = "atmel,at91rm9200-gpio";
> +					reg = <0xfffff600 0x200>;
> +					interrupts = <4 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
> +
> +				pioD: gpio at fffff800 {
> +					compatible = "atmel,at91rm9200-gpio";
> +					reg = <0xfffff800 0x200>;
> +					interrupts = <4 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
> +
> +				pioE: gpio at fffffa00 {
> +					compatible = "atmel,at91rm9200-gpio";
> +					reg = <0xfffffa00 0x200>;
> +					interrupts = <4 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  			};
>  
>  			dbgu: serial at ffffee00 {
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 7dbccaf..9e03049 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -105,49 +105,58 @@
>  				interrupts = <21 4>;
>  			};
>  
> -			pioA: gpio at fffff200 {
> -				compatible = "atmel,at91rm9200-gpio";
> -				reg = <0xfffff200 0x100>;
> -				interrupts = <2 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> +			pinctrl at fffff200 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges;
> +				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
> +
> +				reg = <0xfffff200 0xa00>;
> +
> +				pioA: gpio at fffff200 {
> +					compatible = "atmel,at91rm9200-gpio";
> +					reg = <0xfffff200 0x200>;
> +					interrupts = <2 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  
> -			pioB: gpio at fffff400 {
> -				compatible = "atmel,at91rm9200-gpio";
> -				reg = <0xfffff400 0x100>;
> -				interrupts = <3 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> +				pioB: gpio at fffff400 {
> +					compatible = "atmel,at91rm9200-gpio";
> +					reg = <0xfffff400 0x200>;
> +					interrupts = <3 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  
> -			pioC: gpio at fffff600 {
> -				compatible = "atmel,at91rm9200-gpio";
> -				reg = <0xfffff600 0x100>;
> -				interrupts = <4 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> +				pioC: gpio at fffff600 {
> +					compatible = "atmel,at91rm9200-gpio";
> +					reg = <0xfffff600 0x200>;
> +					interrupts = <4 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  
> -			pioD: gpio at fffff800 {
> -				compatible = "atmel,at91rm9200-gpio";
> -				reg = <0xfffff800 0x100>;
> -				interrupts = <5 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> +				pioD: gpio at fffff800 {
> +					compatible = "atmel,at91rm9200-gpio";
> +					reg = <0xfffff800 0x200>;
> +					interrupts = <5 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  
> -			pioE: gpio at fffffa00 {
> -				compatible = "atmel,at91rm9200-gpio";
> -				reg = <0xfffffa00 0x100>;
> -				interrupts = <5 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> +				pioE: gpio at fffffa00 {
> +					compatible = "atmel,at91rm9200-gpio";
> +					reg = <0xfffffa00 0x200>;
> +					interrupts = <5 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  			};
>  
>  			dbgu: serial at ffffee00 {
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index cb84de7..7bd81c4 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -100,40 +100,51 @@
>  				interrupts = <20 4>;
>  			};
>  
> -			pioA: gpio at fffff400 {
> -				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> -				reg = <0xfffff400 0x100>;
> -				interrupts = <2 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> -
> -			pioB: gpio at fffff600 {
> -				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> -				reg = <0xfffff600 0x100>;
> -				interrupts = <2 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> -
> -			pioC: gpio at fffff800 {
> -				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> -				reg = <0xfffff800 0x100>;
> -				interrupts = <3 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> -
> -			pioD: gpio at fffffa00 {
> -				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> -				reg = <0xfffffa00 0x100>;
> -				interrupts = <3 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> +			pinctrl at fffff400 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges;
> +				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
> +				reg = <0xfffff400 0x200
> +				       0xfffff600 0x200
> +				       0xfffff800 0x200
> +				       0xfffffa00 0x200>;
> +
> +				pioA: gpio at fffff400 {
> +					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> +					reg = <0xfffff400 0x200>;
> +					interrupts = <2 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
> +
> +				pioB: gpio at fffff600 {
> +					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> +					reg = <0xfffff600 0x200>;
> +					interrupts = <2 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
> +
> +				pioC: gpio at fffff800 {
> +					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> +					reg = <0xfffff800 0x200>;
> +					interrupts = <3 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
> +
> +				pioD: gpio at fffffa00 {
> +					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> +					reg = <0xfffffa00 0x200>;
> +					interrupts = <3 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  			};
>  
>  			dbgu: serial at fffff200 {
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 6b3ef43..e25c8d0 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -107,40 +107,51 @@
>  				interrupts = <21 4>;
>  			};
>  
> -			pioA: gpio at fffff400 {
> -				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> -				reg = <0xfffff400 0x100>;
> -				interrupts = <2 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> +			pinctrl at fffff200 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges;
> +				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
> +				reg = <0xfffff400 0x200
> +				       0xfffff600 0x200
> +				       0xfffff800 0x200
> +				       0xfffffa00 0x200>;
> +
> +				pioA: gpio at fffff400 {
> +					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> +					reg = <0xfffff400 0x200>;
> +					interrupts = <2 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  
> -			pioB: gpio at fffff600 {
> -				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> -				reg = <0xfffff600 0x100>;
> -				interrupts = <2 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> +				pioB: gpio at fffff600 {
> +					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> +					reg = <0xfffff600 0x200>;
> +					interrupts = <2 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  
> -			pioC: gpio at fffff800 {
> -				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> -				reg = <0xfffff800 0x100>;
> -				interrupts = <3 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> -			};
> +				pioC: gpio at fffff800 {
> +					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> +					reg = <0xfffff800 0x200>;
> +					interrupts = <3 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  
> -			pioD: gpio at fffffa00 {
> -				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> -				reg = <0xfffffa00 0x100>;
> -				interrupts = <3 4>;
> -				#gpio-cells = <2>;
> -				gpio-controller;
> -				interrupt-controller;
> +				pioD: gpio at fffffa00 {
> +					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> +					reg = <0xfffffa00 0x200>;
> +					interrupts = <3 4>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					interrupt-controller;
> +				};
>  			};
>  
>  			dbgu: serial at fffff200 {
> 


-- 
Nicolas Ferre
