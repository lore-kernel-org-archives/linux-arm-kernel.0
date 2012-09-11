From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 11 Sep 2012 12:30:07 +0200
Subject: [PATCH 07/14] arm: at91: dt: at91sam9 add serial pinctrl support
In-Reply-To: <1344603731-32667-7-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-7-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <504F12AF.6030103@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2012 03:02 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Set the dbgu pinctrl config by default as we have only one possible config
> For other uart set the rxd/txd by default.
> 
> For at91sam9x5ek create soc based dts as we need to include specific soc dtsi.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

I am fine with this:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/boot/dts/at91sam9260.dtsi                 |  109 ++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9263.dtsi                 |   57 ++++++++++
>  arch/arm/boot/dts/at91sam9g15.dtsi                 |   28 +++++
>  arch/arm/boot/dts/at91sam9g15ek.dts                |   16 +++
>  arch/arm/boot/dts/at91sam9g25.dtsi                 |   28 +++++
>  arch/arm/boot/dts/at91sam9g25ek.dts                |   65 +++---------
>  arch/arm/boot/dts/at91sam9g35.dtsi                 |   28 +++++
>  arch/arm/boot/dts/at91sam9g35ek.dts                |   16 +++
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |   73 +++++++++++++
>  arch/arm/boot/dts/at91sam9n12.dtsi                 |   83 +++++++++++++++
>  arch/arm/boot/dts/at91sam9x25.dtsi                 |   28 +++++
>  arch/arm/boot/dts/at91sam9x25ek.dts                |   16 +++
>  arch/arm/boot/dts/at91sam9x35.dtsi                 |   28 +++++
>  arch/arm/boot/dts/at91sam9x35ek.dts                |   16 +++
>  arch/arm/boot/dts/at91sam9x5.dtsi                  |   93 ++++++++++++++++-
>  .../dts/{at91sam9g25ek.dts => at91sam9x5ek.dtsi}   |    8 +-
>  arch/arm/mach-at91/Makefile.boot                   |    4 +
>  17 files changed, 639 insertions(+), 57 deletions(-)
>  create mode 100644 arch/arm/boot/dts/at91sam9g15.dtsi
>  create mode 100644 arch/arm/boot/dts/at91sam9g15ek.dts
>  create mode 100644 arch/arm/boot/dts/at91sam9g25.dtsi
>  rewrite arch/arm/boot/dts/at91sam9g25ek.dts (62%)
>  create mode 100644 arch/arm/boot/dts/at91sam9g35.dtsi
>  create mode 100644 arch/arm/boot/dts/at91sam9g35ek.dts
>  create mode 100644 arch/arm/boot/dts/at91sam9x25.dtsi
>  create mode 100644 arch/arm/boot/dts/at91sam9x25ek.dts
>  create mode 100644 arch/arm/boot/dts/at91sam9x35.dtsi
>  create mode 100644 arch/arm/boot/dts/at91sam9x35ek.dts
>  rename arch/arm/boot/dts/{at91sam9g25ek.dts => at91sam9x5ek.dtsi} (75%)
> 
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> index 353eb53..8ee7cd3 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -112,6 +112,101 @@
>  				      >;
>  
>  				/* shared pinctrl settings */
> +				dbgu {
> +					pinctrl_dbgu: dbgu-0 {
> +						atmel,pins =
> +							<1 14 0x1 0x0	/* PB14 periph A */
> +							 1 15 0x1 0x1>;	/* PB15 periph with pullup */
> +					};
> +				};
> +
> +				uart0 {
> +					pinctrl_uart0: uart0-0 {
> +						atmel,pins =
> +							<1 4 0x1 0x0	/* PB4 periph A */
> +							 1 5 0x1 0x0>;	/* PB5 periph A */
> +					};
> +
> +					pinctrl_uart0_rts_cts: uart0_rts_cts-0 {
> +						atmel,pins =
> +							<1 26 0x1 0x0	/* PB26 periph A */
> +							 1 27 0x1 0x0>;	/* PB27 periph A */
> +					};
> +
> +					pinctrl_uart0_dtr_dsr: uart0_dtr_dsr-0 {
> +						atmel,pins =
> +							<1 24 0x1 0x0	/* PB24 periph A */
> +							 1 22 0x1 0x0>;	/* PB22 periph A */
> +					};
> +
> +					pinctrl_uart0_dcd: uart0_dcd-0 {
> +						atmel,pins =
> +							<1 23 0x1 0x0>;	/* PB23 periph A */
> +					};
> +
> +					pinctrl_uart0_ri: uart0_ri-0 {
> +						atmel,pins =
> +							<1 25 0x1 0x0>;	/* PB25 periph A */
> +					};
> +				};
> +
> +				uart1 {
> +					pinctrl_uart1: uart1-0 {
> +						atmel,pins =
> +							<2 6 0x1 0x1	/* PB6 periph A with pullup */
> +							 2 7 0x1 0x0>;	/* PB7 periph A */
> +					};
> +
> +					pinctrl_uart1_rts_cts: uart1_rts_cts-0 {
> +						atmel,pins =
> +							<1 28 0x1 0x0	/* PB28 periph A */
> +							 1 29 0x1 0x0>;	/* PB29 periph A */
> +					};
> +				};
> +
> +				uart2 {
> +					pinctrl_uart2: uart2-0 {
> +						atmel,pins =
> +							<1 8 0x1 0x1	/* PB8 periph A with pullup */
> +							 1 9 0x1 0x0>;	/* PB9 periph A */
> +					};
> +
> +					pinctrl_uart2_rts_cts: uart2_rts_cts-0 {
> +						atmel,pins =
> +							<0 4 0x1 0x0	/* PA4 periph A */
> +							 0 5 0x1 0x0>;	/* PA5 periph A */
> +					};
> +				};
> +
> +				uart3 {
> +					pinctrl_uart3: uart3-0 {
> +						atmel,pins =
> +							<2 10 0x1 0x1	/* PB10 periph A with pullup */
> +							 2 11 0x1 0x0>;	/* PB11 periph A */
> +					};
> +
> +					pinctrl_uart3_rts_cts: uart3_rts_cts-0 {
> +						atmel,pins =
> +							<3 8 0x2 0x0	/* PB8 periph B */
> +							 3 10 0x2 0x0>;	/* PB10 periph B */
> +					};
> +				};
> +
> +				uart4 {
> +					pinctrl_uart4: uart4-0 {
> +						atmel,pins =
> +							<0 31 0x2 0x1	/* PA31 periph B with pullup */
> +							 0 30 0x2 0x0>;	/* PA30 periph B */
> +					};
> +				};
> +
> +				uart5 {
> +					pinctrl_uart5: uart5-0 {
> +						atmel,pins =
> +							<2 12 0x1 0x1	/* PB12 periph A with pullup */
> +							 2 13 0x1 0x0>;	/* PB13 periph A */
> +					};
> +				};
>  
>  				pioA: gpio at fffff400 {
>  					compatible = "atmel,at91rm9200-gpio";
> @@ -145,6 +240,8 @@
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfffff200 0x200>;
>  				interrupts = <1 4 7>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_dbgu>;
>  				status = "disabled";
>  			};
>  
> @@ -154,6 +251,8 @@
>  				interrupts = <6 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart0>;
>  				status = "disabled";
>  			};
>  
> @@ -163,6 +262,8 @@
>  				interrupts = <7 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart1>;
>  				status = "disabled";
>  			};
>  
> @@ -172,6 +273,8 @@
>  				interrupts = <8 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart2>;
>  				status = "disabled";
>  			};
>  
> @@ -181,6 +284,8 @@
>  				interrupts = <23 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart3>;
>  				status = "disabled";
>  			};
>  
> @@ -190,6 +295,8 @@
>  				interrupts = <24 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart4>;
>  				status = "disabled";
>  			};
>  
> @@ -199,6 +306,8 @@
>  				interrupts = <25 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart5>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> index e52d5f8..2d054c2 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -105,6 +105,55 @@
>  				      >;
>  
>  				/* shared pinctrl settings */
> +				dbgu {
> +					pinctrl_dbgu: dbgu-0 {
> +						atmel,pins =
> +							<2 30 0x1 0x0	/* PC30 periph A */
> +							 2 31 0x1 0x1>;	/* PC31 periph with pullup */
> +					};
> +				};
> +
> +				uart0 {
> +					pinctrl_uart0: uart0-0 {
> +						atmel,pins =
> +							<0 26 0x1 0x1	/* PA26 periph A with pullup */
> +							 0 27 0x1 0x0>;	/* PA27 periph A */
> +					};
> +
> +					pinctrl_uart0_rts_cts: uart0_rts_cts-0 {
> +						atmel,pins =
> +							<0 28 0x1 0x0	/* PA28 periph A */
> +							 0 29 0x1 0x0>;	/* PA29 periph A */
> +					};
> +				};
> +
> +				uart1 {
> +					pinctrl_uart1: uart1-0 {
> +						atmel,pins =
> +							<3 0 0x1 0x1	/* PD0 periph A with pullup */
> +							 3 1 0x1 0x0>;	/* PD1 periph A */
> +					};
> +
> +					pinctrl_uart1_rts_cts: uart1_rts_cts-0 {
> +						atmel,pins =
> +							<3 7 0x2 0x0	/* PD7 periph B */
> +							 3 8 0x2 0x0>;	/* PD8 periph B */
> +					};
> +				};
> +
> +				uart2 {
> +					pinctrl_uart2: uart2-0 {
> +						atmel,pins =
> +							<3 2 0x1 0x1	/* PD2 periph A with pullup */
> +							 3 3 0x1 0x0>;	/* PD3 periph A */
> +					};
> +
> +					pinctrl_uart2_rts_cts: uart2_rts_cts-0 {
> +						atmel,pins =
> +							<3 5 0x2 0x0	/* PD5 periph B */
> +							 4 6 0x2 0x0>;	/* PD6 periph B */
> +					};
> +				};
>  
>  				pioA: gpio at fffff200 {
>  					compatible = "atmel,at91rm9200-gpio";
> @@ -156,6 +205,8 @@
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xffffee00 0x200>;
>  				interrupts = <1 4 7>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_dbgu>;
>  				status = "disabled";
>  			};
>  
> @@ -165,6 +216,8 @@
>  				interrupts = <7 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart0>;
>  				status = "disabled";
>  			};
>  
> @@ -174,6 +227,8 @@
>  				interrupts = <8 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart1>;
>  				status = "disabled";
>  			};
>  
> @@ -183,6 +238,8 @@
>  				interrupts = <9 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart2>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/at91sam9g15.dtsi b/arch/arm/boot/dts/at91sam9g15.dtsi
> new file mode 100644
> index 0000000..b0a86ab
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9g15.dtsi
> @@ -0,0 +1,28 @@
> +/*
> + * at91sam9g15.dtsi - Device Tree Include file for AT91SAM9G15 SoC
> + *
> + * Copyright (C) 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> + *
> + * Licensed under GPLv2.
> + */
> +
> +/include/ "at91sam9x5.dtsi"
> +
> +/ {
> +	model = "Atmel AT91SAM9G15 SoC";
> +	compatible = "atmel, at91sam9g15, atmel,at91sam9x5";
> +
> +	ahb {
> +		apb {
> +			pinctrl at fffff200 {
> +				atmel,mux-mask = <
> +				      /*    A         B          C     */
> +				       0xffffffff 0xffe0399f 0x00000000  /* pioA */
> +				       0x00040000 0x00047e3f 0x00000000  /* pioB */
> +				       0xfdffffff 0x00000000 0xb83fffff  /* pioC */
> +				       0x003fffff 0x003f8000 0x00000000  /* pioD */
> +				      >;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/at91sam9g15ek.dts b/arch/arm/boot/dts/at91sam9g15ek.dts
> new file mode 100644
> index 0000000..86dd3f6
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9g15ek.dts
> @@ -0,0 +1,16 @@
> +/*
> + * at91sam9g15ek.dts - Device Tree file for AT91SAM9G15-EK board
> + *
> + *  Copyright (C) 2012 Atmel,
> + *                2012 Nicolas Ferre <nicolas.ferre@atmel.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +/dts-v1/;
> +/include/ "at91sam9g15.dtsi"
> +/include/ "at91sam9x5ek.dtsi"
> +
> +/ {
> +	model = "Atmel AT91SAM9G25-EK";
> +	compatible = "atmel,at91sam9g15ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
> +};
> diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91sam9g25.dtsi
> new file mode 100644
> index 0000000..5886ac2
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9g25.dtsi
> @@ -0,0 +1,28 @@
> +/*
> + * at91sam9g25.dtsi - Device Tree Include file for AT91SAM9G25 SoC
> + *
> + * Copyright (C) 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> + *
> + * Licensed under GPLv2.
> + */
> +
> +/include/ "at91sam9x5.dtsi"
> +
> +/ {
> +	model = "Atmel AT91SAM9G25 SoC";
> +	compatible = "atmel, at91sam9g25, atmel,at91sam9x5";
> +
> +	ahb {
> +		apb {
> +			pinctrl at fffff200 {
> +				atmel,mux-mask = <
> +				      /*    A         B          C     */
> +				       0xffffffff 0xffe0399f 0xc000001c  /* pioA */
> +				       0x0007ffff 0x8000fe3f 0x00000000  /* pioB */
> +				       0x80000000 0x07c0ffff 0xb83fffff  /* pioC */
> +				       0x003fffff 0x003f8000 0x00000000  /* pioD */
> +				      >;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
> dissimilarity index 62%
> index 7829a4d..c5ab16f 100644
> --- a/arch/arm/boot/dts/at91sam9g25ek.dts
> +++ b/arch/arm/boot/dts/at91sam9g25ek.dts
> @@ -1,49 +1,16 @@
> -/*
> - * at91sam9g25ek.dts - Device Tree file for AT91SAM9G25-EK board
> - *
> - *  Copyright (C) 2012 Atmel,
> - *                2012 Nicolas Ferre <nicolas.ferre@atmel.com>
> - *
> - * Licensed under GPLv2 or later.
> - */
> -/dts-v1/;
> -/include/ "at91sam9x5.dtsi"
> -/include/ "at91sam9x5cm.dtsi"
> -
> -/ {
> -	model = "Atmel AT91SAM9G25-EK";
> -	compatible = "atmel,at91sam9g25ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
> -
> -	chosen {
> -		bootargs = "128M console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1 root=ubi0:rootfs";
> -	};
> -
> -	ahb {
> -		apb {
> -			dbgu: serial at fffff200 {
> -				status = "okay";
> -			};
> -
> -			usart0: serial at f801c000 {
> -				status = "okay";
> -			};
> -
> -			macb0: ethernet at f802c000 {
> -				phy-mode = "rmii";
> -				status = "okay";
> -			};
> -		};
> -
> -		usb0: ohci at 00600000 {
> -			status = "okay";
> -			num-ports = <2>;
> -			atmel,vbus-gpio = <&pioD 19 1
> -					   &pioD 20 1
> -					  >;
> -		};
> -
> -		usb1: ehci at 00700000 {
> -			status = "okay";
> -		};
> -	};
> -};
> +/*
> + * at91sam9g25ek.dts - Device Tree file for AT91SAM9G25-EK board
> + *
> + *  Copyright (C) 2012 Atmel,
> + *                2012 Nicolas Ferre <nicolas.ferre@atmel.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +/dts-v1/;
> +/include/ "at91sam9g25.dtsi"
> +/include/ "at91sam9x5ek.dtsi"
> +
> +/ {
> +	model = "Atmel AT91SAM9G25-EK";
> +	compatible = "atmel,at91sam9g25ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
> +};
> diff --git a/arch/arm/boot/dts/at91sam9g35.dtsi b/arch/arm/boot/dts/at91sam9g35.dtsi
> new file mode 100644
> index 0000000..9cc9446
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9g35.dtsi
> @@ -0,0 +1,28 @@
> +/*
> + * at91sam9g35.dtsi - Device Tree Include file for AT91SAM9G35 SoC
> + *
> + * Copyright (C) 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> + *
> + * Licensed under GPLv2.
> + */
> +
> +/include/ "at91sam9x5.dtsi"
> +
> +/ {
> +	model = "Atmel AT91SAM9rG5 SoC";
> +	compatible = "atmel, at91sam9g35, atmel,at91sam9x5";
> +
> +	ahb {
> +		apb {
> +			pinctrl at fffff200 {
> +				atmel,mux-mask = <
> +				      /*    A         B          C     */
> +				       0xffffffff 0xffe0399f 0xc000000c  /* pioA */
> +				       0x000406ff 0x00047e3f 0x00000000  /* pioB */
> +				       0xfdffffff 0x00000000 0xb83fffff  /* pioC */
> +				       0x003fffff 0x003f8000 0x00000000  /* pioD */
> +				      >;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/at91sam9g35ek.dts b/arch/arm/boot/dts/at91sam9g35ek.dts
> new file mode 100644
> index 0000000..95944bd
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9g35ek.dts
> @@ -0,0 +1,16 @@
> +/*
> + * at91sam9g35ek.dts - Device Tree file for AT91SAM9G35-EK board
> + *
> + *  Copyright (C) 2012 Atmel,
> + *                2012 Nicolas Ferre <nicolas.ferre@atmel.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +/dts-v1/;
> +/include/ "at91sam9g35.dtsi"
> +/include/ "at91sam9x5ek.dtsi"
> +
> +/ {
> +	model = "Atmel AT91SAM9G35-EK";
> +	compatible = "atmel,at91sam9g35ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
> +};
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 0e64221..cfe197a 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -124,6 +124,69 @@
>  				      >;
>  
>  				/* shared pinctrl settings */
> +				dbgu {
> +					pinctrl_dbgu: dbgu-0 {
> +						atmel,pins =
> +							<1 12 0x1 0x0	/* PB12 periph A */
> +							 1 13 0x1 0x0>;	/* PB13 periph A */
> +					};
> +				};
> +
> +				uart0 {
> +					pinctrl_uart0: uart0-0 {
> +						atmel,pins =
> +							<1 19 0x1 0x1	/* PB19 periph A with pullup */
> +							 1 18 0x1 0x0>;	/* PB18 periph A */
> +					};
> +
> +					pinctrl_uart0_rts_cts: uart0_rts_cts-0 {
> +						atmel,pins =
> +							<1 17 0x2 0x0	/* PB17 periph B */
> +							 1 15 0x2 0x0>;	/* PB15 periph B */
> +					};
> +				};
> +
> +				uart1 {
> +					pinctrl_uart1: uart1-0 {
> +						atmel,pins =
> +							<1 4 0x1 0x1	/* PB4 periph A with pullup */
> +							 1 5 0x1 0x0>;	/* PB5 periph A */
> +					};
> +
> +					pinctrl_uart1_rts_cts: uart1_rts_cts-0 {
> +						atmel,pins =
> +							<3 16 0x1 0x0	/* PD16 periph A */
> +							 3 17 0x1 0x0>;	/* PD17 periph A */
> +					};
> +				};
> +
> +				uart2 {
> +					pinctrl_uart2: uart2-0 {
> +						atmel,pins =
> +							<1 6 0x1 0x1	/* PB6 periph A with pullup */
> +							 1 7 0x1 0x0>;	/* PB7 periph A */
> +					};
> +
> +					pinctrl_uart2_rts_cts: uart2_rts_cts-0 {
> +						atmel,pins =
> +							<2 9 0x2 0x0	/* PC9 periph B */
> +							 2 11 0x2 0x0>;	/* PC11 periph B */
> +					};
> +				};
> +
> +				uart3 {
> +					pinctrl_uart3: uart3-0 {
> +						atmel,pins =
> +							<1 8 0x1 0x1	/* PB9 periph A with pullup */
> +							 1 9 0x1 0x0>;	/* PB8 periph A */
> +					};
> +
> +					pinctrl_uart3_rts_cts: uart3_rts_cts-0 {
> +						atmel,pins =
> +							<0 23 0x2 0x0	/* PA23 periph B */
> +							 0 24 0x2 0x0>;	/* PA24 periph B */
> +					};
> +				};
>  
>  				pioA: gpio at fffff200 {
>  					compatible = "atmel,at91rm9200-gpio";
> @@ -175,6 +238,8 @@
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xffffee00 0x200>;
>  				interrupts = <1 4 7>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_dbgu>;
>  				status = "disabled";
>  			};
>  
> @@ -184,6 +249,8 @@
>  				interrupts = <7 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart0>;
>  				status = "disabled";
>  			};
>  
> @@ -193,6 +260,8 @@
>  				interrupts = <8 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart1>;
>  				status = "disabled";
>  			};
>  
> @@ -202,6 +271,8 @@
>  				interrupts = <9 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart2>;
>  				status = "disabled";
>  			};
>  
> @@ -211,6 +282,8 @@
>  				interrupts = <10 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart3>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index ae23a03..36a6ce0 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -116,6 +116,79 @@
>  				      >;
>  
>  				/* shared pinctrl settings */
> +				dbgu {
> +					pinctrl_dbgu: dbgu-0 {
> +						atmel,pins =
> +							<0 9 0x1 0x0	/* PA9 periph A */
> +							 0 10 0x1 0x1>;	/* PA10 periph with pullup */
> +					};
> +				};
> +
> +				uart0 {
> +					pinctrl_uart0: uart0-0 {
> +						atmel,pins =
> +							<0 1 0x1 0x1	/* PA1 periph A with pullup */
> +							 0 0 0x1 0x0>;	/* PA0 periph A */
> +					};
> +
> +					pinctrl_uart0_rts_cts: uart0_rts_cts-0 {
> +						atmel,pins =
> +							<0 2 0x1 0x0	/* PA2 periph A */
> +							 0 3 0x1 0x0>;	/* PA3 periph A */
> +					};
> +				};
> +
> +				uart1 {
> +					pinctrl_uart1: uart1-0 {
> +						atmel,pins =
> +							<0 6 0x1 0x1	/* PA6 periph A with pullup */
> +							 0 5 0x1 0x0>;	/* PA5 periph A */
> +					};
> +				};
> +
> +				uart2 {
> +					pinctrl_uart2: uart2-0 {
> +						atmel,pins =
> +							<0 8 0x1 0x1	/* PA8 periph A with pullup */
> +							 0 7 0x1 0x0>;	/* PA7 periph A */
> +					};
> +
> +					pinctrl_uart2_rts_cts: uart2_rts_cts-0 {
> +						atmel,pins =
> +							<1 0 0x2 0x0	/* PB0 periph B */
> +							 1 1 0x2 0x0>;	/* PB1 periph B */
> +					};
> +				};
> +
> +				uart3 {
> +					pinctrl_uart3: uart3-0 {
> +						atmel,pins =
> +							<2 23 0x2 0x1	/* PC23 periph B with pullup */
> +							 2 22 0x2 0x0>;	/* PC22 periph B */
> +					};
> +
> +					pinctrl_uart3_rts_cts: uart3_rts_cts-0 {
> +						atmel,pins =
> +							<2 24 0x2 0x0	/* PC24 periph B */
> +							 2 25 0x2 0x0>;	/* PC25 periph B */
> +					};
> +				};
> +
> +				usart0 {
> +					pinctrl_usart0: usart0-0 {
> +						atmel,pins =
> +							<2 9 0x3 0x1	/* PC9 periph C with pullup */
> +							 2 8 0x3 0x0>;	/* PC8 periph C */
> +					};
> +				};
> +
> +				usart1 {
> +					pinctrl_usart1: usart1-0 {
> +						atmel,pins =
> +							<2 16 0x3 0x1	/* PC17 periph C with pullup */
> +							 2 17 0x3 0x0>;	/* PC16 periph C */
> +					};
> +				};
>  
>  				pioA: gpio at fffff400 {
>  					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> @@ -158,6 +231,8 @@
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfffff200 0x200>;
>  				interrupts = <1 4 7>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_dbgu>;
>  				status = "disabled";
>  			};
>  
> @@ -167,6 +242,8 @@
>  				interrupts = <5 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart0>;
>  				status = "disabled";
>  			};
>  
> @@ -176,6 +253,8 @@
>  				interrupts = <6 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart1>;
>  				status = "disabled";
>  			};
>  
> @@ -185,6 +264,8 @@
>  				interrupts = <7 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart2>;
>  				status = "disabled";
>  			};
>  
> @@ -194,6 +275,8 @@
>  				interrupts = <8 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart3>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9x25.dtsi b/arch/arm/boot/dts/at91sam9x25.dtsi
> new file mode 100644
> index 0000000..d03d734
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9x25.dtsi
> @@ -0,0 +1,28 @@
> +/*
> + * at91sam9x25.dtsi - Device Tree Include file for AT91SAM9X25 SoC
> + *
> + * Copyright (C) 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> + *
> + * Licensed under GPLv2.
> + */
> +
> +/include/ "at91sam9x5.dtsi"
> +
> +/ {
> +	model = "Atmel AT91SAM9X25 SoC";
> +	compatible = "atmel, at91sam9x25, atmel,at91sam9x5";
> +
> +	ahb {
> +		apb {
> +			pinctrl at fffff200 {
> +				atmel,mux-mask = <
> +				      /*    A         B          C     */
> +				       0xffffffff 0xffe03fff 0xc000001c  /* pioA */
> +				       0x0007ffff 0x00047e3f 0x00000000  /* pioB */
> +				       0x80000000 0xfffd0000 0xb83fffff  /* pioC */
> +				       0x003fffff 0x003f8000 0x00000000  /* pioD */
> +				      >;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/at91sam9x25ek.dts b/arch/arm/boot/dts/at91sam9x25ek.dts
> new file mode 100644
> index 0000000..af907ea
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9x25ek.dts
> @@ -0,0 +1,16 @@
> +/*
> + * at91sam9x25ek.dts - Device Tree file for AT91SAM9X25-EK board
> + *
> + *  Copyright (C) 2012 Atmel,
> + *                2012 Nicolas Ferre <nicolas.ferre@atmel.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +/dts-v1/;
> +/include/ "at91sam9x25.dtsi"
> +/include/ "at91sam9x5ek.dtsi"
> +
> +/ {
> +	model = "Atmel AT91SAM9G25-EK";
> +	compatible = "atmel,at91sam9x25ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
> +};
> diff --git a/arch/arm/boot/dts/at91sam9x35.dtsi b/arch/arm/boot/dts/at91sam9x35.dtsi
> new file mode 100644
> index 0000000..139e67e
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9x35.dtsi
> @@ -0,0 +1,28 @@
> +/*
> + * at91sam9x35.dtsi - Device Tree Include file for AT91SAM9X35 SoC
> + *
> + * Copyright (C) 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> + *
> + * Licensed under GPLv2.
> + */
> +
> +/include/ "at91sam9x5.dtsi"
> +
> +/ {
> +	model = "Atmel AT91SAM9X35 SoC";
> +	compatible = "atmel, at91sam9x35, atmel,at91sam9x5";
> +
> +	ahb {
> +		apb {
> +			pinctrl at fffff200 {
> +				atmel,mux-mask = <
> +				      /*    A         B          C     */
> +				       0xffffffff 0xffe03fff 0xc000000c  /* pioA */
> +				       0x000406ff 0x00047e3f 0x00000000  /* pioB */
> +				       0xfdffffff 0x00000000 0xb83fffff  /* pioC */
> +				       0x003fffff 0x003f8000 0x00000000  /* pioD */
> +				      >;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/at91sam9x35ek.dts b/arch/arm/boot/dts/at91sam9x35ek.dts
> new file mode 100644
> index 0000000..5ccb607
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9x35ek.dts
> @@ -0,0 +1,16 @@
> +/*
> + * at91sam9x35ek.dts - Device Tree file for AT91SAM9X35-EK board
> + *
> + *  Copyright (C) 2012 Atmel,
> + *                2012 Nicolas Ferre <nicolas.ferre@atmel.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +/dts-v1/;
> +/include/ "at91sam9x35.dtsi"
> +/include/ "at91sam9x5ek.dtsi"
> +
> +/ {
> +	model = "Atmel AT91SAM9X35-EK";
> +	compatible = "atmel,at91sam9x35ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
> +};
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index d1df4ea..c585f04 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -118,12 +118,91 @@
>  				atmel,mux-mask = <
>  				      /*    A         B          C     */
>  				       0xffffffff 0xffe0399f 0xc000001c  /* pioA */
> -				       0xffffffff 0xffc003ff 0xffc003ff  /* pioB */
> -				       0xffffffff 0xffc003ff 0xffc003ff  /* pioC */
> -				       0xffffffff 0xffc003ff 0xffc003ff  /* pioD */
> +				       0x0007ffff 0x8000fe3f 0x00000000  /* pioB */
> +				       0x80000000 0x07c0ffff 0xb83fffff  /* pioC */
> +				       0x003fffff 0x003f8000 0x00000000  /* pioD */
>  				      >;
>  
>  				/* shared pinctrl settings */
> +				dbgu {
> +					pinctrl_dbgu: dbgu-0 {
> +						atmel,pins =
> +							<0 9 0x1 0x0	/* PA9 periph A */
> +							 0 10 0x1 0x1>;	/* PA10 periph A with pullup */
> +					};
> +				};
> +
> +				uart0 {
> +					pinctrl_uart0: uart0-0 {
> +						atmel,pins =
> +							<0 0 0x1 0x1	/* PA0 periph A with pullup */
> +							 0 1 0x1 0x0>;	/* PA1 periph A */
> +					};
> +
> +					pinctrl_uart0_rts_cts: uart0_rts_cts-0 {
> +						atmel,pins =
> +							<0 2 0x1 0x0	/* PA2 periph A */
> +							 0 3 0x1 0x0>;	/* PA3 periph A */
> +					};
> +				};
> +
> +				uart1 {
> +					pinctrl_uart1: uart1-0 {
> +						atmel,pins =
> +							<0 5 0x1 0x1	/* PA5 periph A with pullup */
> +							 0 6 0x1 0x0>;	/* PA6 periph A */
> +					};
> +
> +					pinctrl_uart1_rts_cts: uart1_rts_cts-0 {
> +						atmel,pins =
> +							<3 27 0x3 0x0	/* PC27 periph C */
> +							 3 28 0x3 0x0>;	/* PC28 periph C */
> +					};
> +				};
> +
> +				uart2 {
> +					pinctrl_uart2: uart2-0 {
> +						atmel,pins =
> +							<0 7 0x1 0x1	/* PA7 periph A with pullup */
> +							 0 8 0x1 0x0>;	/* PA8 periph A */
> +					};
> +
> +					pinctrl_uart2_rts_cts: uart2_rts_cts-0 {
> +						atmel,pins =
> +							<0 0 0x2 0x0	/* PB0 periph B */
> +							 0 1 0x2 0x0>;	/* PB1 periph B */
> +					};
> +				};
> +
> +				uart3 {
> +					pinctrl_uart3: uart3-0 {
> +						atmel,pins =
> +							<3 23 0x2 0x1	/* PC22 periph B with pullup */
> +							 3 23 0x2 0x0>;	/* PC23 periph B */
> +					};
> +
> +					pinctrl_uart3_rts_cts: uart3_rts_cts-0 {
> +						atmel,pins =
> +							<3 24 0x2 0x0	/* PC24 periph B */
> +							 3 25 0x2 0x0>;	/* PC25 periph B */
> +					};
> +				};
> +
> +				usart0 {
> +					pinctrl_usart0: usart0-0 {
> +						atmel,pins =
> +							<3 8 0x3 0x0	/* PC8 periph C */
> +							 3 9 0x3 0x1>;	/* PC9 periph C with pullup */
> +					};
> +				};
> +
> +				usart1 {
> +					pinctrl_usart1: usart1-0 {
> +						atmel,pins =
> +							<3 16 0x3 0x0	/* PC16 periph C */
> +							 3 17 0x3 0x1>;	/* PC17 periph C with pullup */
> +					};
> +				};
>  
>  				pioA: gpio at fffff400 {
>  					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> @@ -168,6 +247,8 @@
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xfffff200 0x200>;
>  				interrupts = <1 4 7>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_dbgu>;
>  				status = "disabled";
>  			};
>  
> @@ -177,6 +258,8 @@
>  				interrupts = <5 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart0>;
>  				status = "disabled";
>  			};
>  
> @@ -186,6 +269,8 @@
>  				interrupts = <6 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart1>;
>  				status = "disabled";
>  			};
>  
> @@ -195,6 +280,8 @@
>  				interrupts = <7 4 5>;
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart2>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> similarity index 75%
> rename from arch/arm/boot/dts/at91sam9g25ek.dts
> rename to arch/arm/boot/dts/at91sam9x5ek.dtsi
> index 7829a4d..e5000a7 100644
> --- a/arch/arm/boot/dts/at91sam9g25ek.dts
> +++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> @@ -1,18 +1,16 @@
>  /*
> - * at91sam9g25ek.dts - Device Tree file for AT91SAM9G25-EK board
> + * at91sam9x5ek.dtsi - Device Tree file for AT91SAM9x5CM Base board
>   *
>   *  Copyright (C) 2012 Atmel,
>   *                2012 Nicolas Ferre <nicolas.ferre@atmel.com>
>   *
>   * Licensed under GPLv2 or later.
>   */
> -/dts-v1/;
> -/include/ "at91sam9x5.dtsi"
>  /include/ "at91sam9x5cm.dtsi"
>  
>  / {
> -	model = "Atmel AT91SAM9G25-EK";
> -	compatible = "atmel,at91sam9g25ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
> +	model = "Atmel AT91SAM9X5-EK";
> +	compatible = "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
>  
>  	chosen {
>  		bootargs = "128M console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1 root=ubi0:rootfs";
> diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
> index 30bb733..0838d30 100644
> --- a/arch/arm/mach-at91/Makefile.boot
> +++ b/arch/arm/mach-at91/Makefile.boot
> @@ -35,4 +35,8 @@ dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9m10g45ek.dtb
>  # sam9n12
>  dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9n12ek.dtb
>  # sam9x5
> +dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g15ek.dtb
>  dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g25ek.dtb
> +dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g35ek.dtb
> +dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9x25ek.dtb
> +dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9x35ek.dtb
> 


-- 
Nicolas Ferre
