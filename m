From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 9 Jul 2013 15:34:13 +0200
Subject: [PATCH 1/7] serial: at91: correct definition from DMA to PDC
In-Reply-To: <20130709112238.GB18012@ns203013.ovh.net>
References: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
 <1373351626-30143-2-git-send-email-elen.song@atmel.com>
 <20130709112238.GB18012@ns203013.ovh.net>
Message-ID: <20130709133413.GE18012@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:22 Tue 09 Jul     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 14:33 Tue 09 Jul     , Elen Song wrote:
> > The DMA is available since at91sam9x5 socs, before that, we use PDC.
> > 
> > Signed-off-by: Elen Song <elen.song@atmel.com>
> > ---
> >  Documentation/devicetree/bindings/serial/rs485.txt |    4 +-
> >  .../devicetree/bindings/tty/serial/atmel-usart.txt |   12 ++--
> >  arch/arm/boot/dts/at91rm9200.dtsi                  |   16 ++---
> >  arch/arm/boot/dts/at91sam9260.dtsi                 |   24 +++----
> >  arch/arm/boot/dts/at91sam9263.dtsi                 |   12 ++--
> >  arch/arm/boot/dts/at91sam9g45.dtsi                 |   16 ++---
> >  arch/arm/mach-at91/at91rm9200_devices.c            |   20 +++---
> >  arch/arm/mach-at91/at91sam9260_devices.c           |   28 ++++----
> >  arch/arm/mach-at91/at91sam9261_devices.c           |   16 ++---
> >  arch/arm/mach-at91/at91sam9263_devices.c           |   16 ++---
> >  arch/arm/mach-at91/at91sam9g45_devices.c           |   20 +++---
> >  arch/arm/mach-at91/at91sam9rl_devices.c            |   20 +++---
> >  drivers/tty/serial/atmel_serial.c                  |   74 ++++++++++----------
> >  include/linux/platform_data/atmel.h                |    4 +-
> >  14 files changed, 141 insertions(+), 141 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
> > index 1e753c6..7c8581e 100644
> > --- a/Documentation/devicetree/bindings/serial/rs485.txt
> > +++ b/Documentation/devicetree/bindings/serial/rs485.txt
> > @@ -23,8 +23,8 @@ RS485 example for Atmel USART:
> >  		compatible = "atmel,at91sam9260-usart";
> >  		reg = <0xfff8c000 0x4000>;
> >  		interrupts = <7>;
> > -		atmel,use-dma-rx;
> > -		atmel,use-dma-tx;
> > +		atmel,use-pdc-rx;
> > +		atmel,use-pdc-tx;
> 
> you break dt compatibility this is not acceptable

current the use-dma-r/tx just mean you want to use the DMA for rx or tx
keep it as is

to detect if you want to use PDC or DMA just check the presence of the dmas
property
	dmas = <&dma0 1 9>,
as example

This way you do not break the dt compatibility

Best Regards,
J.
> 
> Best Regards,
> J.
> >  		linux,rs485-enabled-at-boot-time;
> >  		rs485-rts-delay = <0 200>;		// in milliseconds
> >  	};
> > diff --git a/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
> > index a49d9a1..82f45ec 100644
> > --- a/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
> > +++ b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
> > @@ -8,8 +8,8 @@ Required properties:
> >  - interrupts: Should contain interrupt
> >  
> >  Optional properties:
> > -- atmel,use-dma-rx: use of PDC or DMA for receiving data
> > -- atmel,use-dma-tx: use of PDC or DMA for transmitting data
> > +- atmel,use-pdc-rx: use of PDC for receiving data
> > +- atmel,use-pdc-tx: use of PDC for transmitting data
> >  
> >  <chip> compatible description:
> >  - at91rm9200:  legacy USART support
> > @@ -19,9 +19,9 @@ Example:
> >  
> >  	usart0: serial at fff8c000 {
> >  		compatible = "atmel,at91sam9260-usart";
> > -		reg = <0xfff8c000 0x4000>;
> > -		interrupts = <7>;
> > -		atmel,use-dma-rx;
> > -		atmel,use-dma-tx;
> > +		reg = <0xfff8c000 0x200>;
> > +		interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
> > +		atmel,use-pdc-rx;
> > +		atmel,use-pdc-tx;
> >  	};
> >  
> > diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
> > index 1fc645e..2dcef27 100644
> > --- a/arch/arm/boot/dts/at91rm9200.dtsi
> > +++ b/arch/arm/boot/dts/at91rm9200.dtsi
> > @@ -537,8 +537,8 @@
> >  				compatible = "atmel,at91rm9200-usart";
> >  				reg = <0xfffc0000 0x200>;
> >  				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_uart0>;
> >  				status = "disabled";
> > @@ -548,8 +548,8 @@
> >  				compatible = "atmel,at91rm9200-usart";
> >  				reg = <0xfffc4000 0x200>;
> >  				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_uart1>;
> >  				status = "disabled";
> > @@ -559,8 +559,8 @@
> >  				compatible = "atmel,at91rm9200-usart";
> >  				reg = <0xfffc8000 0x200>;
> >  				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_uart2>;
> >  				status = "disabled";
> > @@ -570,8 +570,8 @@
> >  				compatible = "atmel,at91rm9200-usart";
> >  				reg = <0xfffcc000 0x200>;
> >  				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_uart3>;
> >  				status = "disabled";
> > diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> > index 899a7cf..1fcf6f6 100644
> > --- a/arch/arm/boot/dts/at91sam9260.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> > @@ -475,8 +475,8 @@
> >  				compatible = "atmel,at91sam9260-usart";
> >  				reg = <0xfffb0000 0x200>;
> >  				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_usart0>;
> >  				status = "disabled";
> > @@ -486,8 +486,8 @@
> >  				compatible = "atmel,at91sam9260-usart";
> >  				reg = <0xfffb4000 0x200>;
> >  				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_usart1>;
> >  				status = "disabled";
> > @@ -497,8 +497,8 @@
> >  				compatible = "atmel,at91sam9260-usart";
> >  				reg = <0xfffb8000 0x200>;
> >  				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_usart2>;
> >  				status = "disabled";
> > @@ -508,8 +508,8 @@
> >  				compatible = "atmel,at91sam9260-usart";
> >  				reg = <0xfffd0000 0x200>;
> >  				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_usart3>;
> >  				status = "disabled";
> > @@ -519,8 +519,8 @@
> >  				compatible = "atmel,at91sam9260-usart";
> >  				reg = <0xfffd4000 0x200>;
> >  				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_uart0>;
> >  				status = "disabled";
> > @@ -530,8 +530,8 @@
> >  				compatible = "atmel,at91sam9260-usart";
> >  				reg = <0xfffd8000 0x200>;
> >  				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_uart1>;
> >  				status = "disabled";
> > diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> > index ff63811..eb1dac2 100644
> > --- a/arch/arm/boot/dts/at91sam9263.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> > @@ -426,8 +426,8 @@
> >  				compatible = "atmel,at91sam9260-usart";
> >  				reg = <0xfff8c000 0x200>;
> >  				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_usart0>;
> >  				status = "disabled";
> > @@ -437,8 +437,8 @@
> >  				compatible = "atmel,at91sam9260-usart";
> >  				reg = <0xfff90000 0x200>;
> >  				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_usart1>;
> >  				status = "disabled";
> > @@ -448,8 +448,8 @@
> >  				compatible = "atmel,at91sam9260-usart";
> >  				reg = <0xfff94000 0x200>;
> >  				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_usart2>;
> >  				status = "disabled";
> > diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> > index cb44bbb..13c7682 100644
> > --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> > @@ -485,8 +485,8 @@
> >  				compatible = "atmel,at91sam9260-usart";
> >  				reg = <0xfff8c000 0x200>;
> >  				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_usart0>;
> >  				status = "disabled";
> > @@ -496,8 +496,8 @@
> >  				compatible = "atmel,at91sam9260-usart";
> >  				reg = <0xfff90000 0x200>;
> >  				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_usart1>;
> >  				status = "disabled";
> > @@ -507,8 +507,8 @@
> >  				compatible = "atmel,at91sam9260-usart";
> >  				reg = <0xfff94000 0x200>;
> >  				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_usart2>;
> >  				status = "disabled";
> > @@ -518,8 +518,8 @@
> >  				compatible = "atmel,at91sam9260-usart";
> >  				reg = <0xfff98000 0x200>;
> >  				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 5>;
> > -				atmel,use-dma-rx;
> > -				atmel,use-dma-tx;
> > +				atmel,use-pdc-rx;
> > +				atmel,use-pdc-tx;
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&pinctrl_usart3>;
> >  				status = "disabled";
> > diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
> > index 3ebc979..6766d17 100644
> > --- a/arch/arm/mach-at91/at91rm9200_devices.c
> > +++ b/arch/arm/mach-at91/at91rm9200_devices.c
> > @@ -920,8 +920,8 @@ static struct resource dbgu_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data dbgu_data = {
> > -	.use_dma_tx	= 0,
> > -	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
> > +	.use_pdc_tx	= 0,
> > +	.use_pdc_rx	= 0,		/* DBGU not capable of receive PDC */
> >  };
> >  
> >  static u64 dbgu_dmamask = DMA_BIT_MASK(32);
> > @@ -958,8 +958,8 @@ static struct resource uart0_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart0_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart0_dmamask = DMA_BIT_MASK(32);
> > @@ -1007,8 +1007,8 @@ static struct resource uart1_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart1_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart1_dmamask = DMA_BIT_MASK(32);
> > @@ -1058,8 +1058,8 @@ static struct resource uart2_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart2_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart2_dmamask = DMA_BIT_MASK(32);
> > @@ -1101,8 +1101,8 @@ static struct resource uart3_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart3_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart3_dmamask = DMA_BIT_MASK(32);
> > diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
> > index eda8d16..0a087a7c 100644
> > --- a/arch/arm/mach-at91/at91sam9260_devices.c
> > +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> > @@ -817,8 +817,8 @@ static struct resource dbgu_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data dbgu_data = {
> > -	.use_dma_tx	= 0,
> > -	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
> > +	.use_pdc_tx	= 0,
> > +	.use_pdc_rx	= 0,		/* DBGU not capable of receive PDC */
> >  };
> >  
> >  static u64 dbgu_dmamask = DMA_BIT_MASK(32);
> > @@ -855,8 +855,8 @@ static struct resource uart0_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart0_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart0_dmamask = DMA_BIT_MASK(32);
> > @@ -906,8 +906,8 @@ static struct resource uart1_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart1_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart1_dmamask = DMA_BIT_MASK(32);
> > @@ -949,8 +949,8 @@ static struct resource uart2_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart2_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart2_dmamask = DMA_BIT_MASK(32);
> > @@ -992,8 +992,8 @@ static struct resource uart3_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart3_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart3_dmamask = DMA_BIT_MASK(32);
> > @@ -1035,8 +1035,8 @@ static struct resource uart4_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart4_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart4_dmamask = DMA_BIT_MASK(32);
> > @@ -1073,8 +1073,8 @@ static struct resource uart5_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart5_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart5_dmamask = DMA_BIT_MASK(32);
> > diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
> > index 629ea5f..fcaae28 100644
> > --- a/arch/arm/mach-at91/at91sam9261_devices.c
> > +++ b/arch/arm/mach-at91/at91sam9261_devices.c
> > @@ -878,8 +878,8 @@ static struct resource dbgu_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data dbgu_data = {
> > -	.use_dma_tx	= 0,
> > -	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
> > +	.use_pdc_tx	= 0,
> > +	.use_pdc_rx	= 0,		/* DBGU not capable of receive PDC */
> >  };
> >  
> >  static u64 dbgu_dmamask = DMA_BIT_MASK(32);
> > @@ -916,8 +916,8 @@ static struct resource uart0_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart0_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart0_dmamask = DMA_BIT_MASK(32);
> > @@ -959,8 +959,8 @@ static struct resource uart1_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart1_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart1_dmamask = DMA_BIT_MASK(32);
> > @@ -1002,8 +1002,8 @@ static struct resource uart2_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart2_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart2_dmamask = DMA_BIT_MASK(32);
> > diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
> > index 858c8aa..a62216b 100644
> > --- a/arch/arm/mach-at91/at91sam9263_devices.c
> > +++ b/arch/arm/mach-at91/at91sam9263_devices.c
> > @@ -1322,8 +1322,8 @@ static struct resource dbgu_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data dbgu_data = {
> > -	.use_dma_tx	= 0,
> > -	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
> > +	.use_pdc_tx	= 0,
> > +	.use_pdc_rx	= 0,		/* DBGU not capable of receive PDC */
> >  };
> >  
> >  static u64 dbgu_dmamask = DMA_BIT_MASK(32);
> > @@ -1360,8 +1360,8 @@ static struct resource uart0_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart0_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart0_dmamask = DMA_BIT_MASK(32);
> > @@ -1403,8 +1403,8 @@ static struct resource uart1_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart1_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart1_dmamask = DMA_BIT_MASK(32);
> > @@ -1446,8 +1446,8 @@ static struct resource uart2_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart2_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart2_dmamask = DMA_BIT_MASK(32);
> > diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> > index acb703e..4c81fd1 100644
> > --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> > +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> > @@ -1585,8 +1585,8 @@ static struct resource dbgu_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data dbgu_data = {
> > -	.use_dma_tx	= 0,
> > -	.use_dma_rx	= 0,
> > +	.use_pdc_tx	= 0,
> > +	.use_pdc_rx	= 0,
> >  };
> >  
> >  static u64 dbgu_dmamask = DMA_BIT_MASK(32);
> > @@ -1623,8 +1623,8 @@ static struct resource uart0_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart0_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart0_dmamask = DMA_BIT_MASK(32);
> > @@ -1666,8 +1666,8 @@ static struct resource uart1_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart1_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart1_dmamask = DMA_BIT_MASK(32);
> > @@ -1709,8 +1709,8 @@ static struct resource uart2_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart2_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart2_dmamask = DMA_BIT_MASK(32);
> > @@ -1752,8 +1752,8 @@ static struct resource uart3_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart3_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart3_dmamask = DMA_BIT_MASK(32);
> > diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
> > index 352468f..5cd8c76 100644
> > --- a/arch/arm/mach-at91/at91sam9rl_devices.c
> > +++ b/arch/arm/mach-at91/at91sam9rl_devices.c
> > @@ -954,8 +954,8 @@ static struct resource dbgu_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data dbgu_data = {
> > -	.use_dma_tx	= 0,
> > -	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
> > +	.use_pdc_tx	= 0,
> > +	.use_pdc_rx	= 0,		/* DBGU not capable of receive PDC */
> >  };
> >  
> >  static u64 dbgu_dmamask = DMA_BIT_MASK(32);
> > @@ -992,8 +992,8 @@ static struct resource uart0_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart0_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart0_dmamask = DMA_BIT_MASK(32);
> > @@ -1043,8 +1043,8 @@ static struct resource uart1_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart1_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart1_dmamask = DMA_BIT_MASK(32);
> > @@ -1086,8 +1086,8 @@ static struct resource uart2_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart2_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart2_dmamask = DMA_BIT_MASK(32);
> > @@ -1129,8 +1129,8 @@ static struct resource uart3_resources[] = {
> >  };
> >  
> >  static struct atmel_uart_data uart3_data = {
> > -	.use_dma_tx	= 1,
> > -	.use_dma_rx	= 1,
> > +	.use_pdc_tx	= 1,
> > +	.use_pdc_rx	= 1,
> >  };
> >  
> >  static u64 uart3_dmamask = DMA_BIT_MASK(32);
> > diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> > index 3467462..ab9de8a 100644
> > --- a/drivers/tty/serial/atmel_serial.c
> > +++ b/drivers/tty/serial/atmel_serial.c
> > @@ -140,11 +140,11 @@ struct atmel_uart_port {
> >  	u32			backup_imr;	/* IMR saved during suspend */
> >  	int			break_active;	/* break being received */
> >  
> > -	short			use_dma_rx;	/* enable PDC receiver */
> > +	short			use_pdc_rx;	/* enable PDC receiver */
> >  	short			pdc_rx_idx;	/* current PDC RX buffer */
> >  	struct atmel_dma_buffer	pdc_rx[2];	/* PDC receier */
> >  
> > -	short			use_dma_tx;	/* enable PDC transmitter */
> > +	short			use_pdc_tx;	/* enable PDC transmitter */
> >  	struct atmel_dma_buffer	pdc_tx;		/* PDC transmitter */
> >  
> >  	struct tasklet_struct	tasklet;
> > @@ -181,26 +181,26 @@ to_atmel_uart_port(struct uart_port *uart)
> >  }
> >  
> >  #ifdef CONFIG_SERIAL_ATMEL_PDC
> > -static bool atmel_use_dma_rx(struct uart_port *port)
> > +static bool atmel_use_pdc_rx(struct uart_port *port)
> >  {
> >  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> >  
> > -	return atmel_port->use_dma_rx;
> > +	return atmel_port->use_pdc_rx;
> >  }
> >  
> > -static bool atmel_use_dma_tx(struct uart_port *port)
> > +static bool atmel_use_pdc_tx(struct uart_port *port)
> >  {
> >  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> >  
> > -	return atmel_port->use_dma_tx;
> > +	return atmel_port->use_pdc_tx;
> >  }
> >  #else
> > -static bool atmel_use_dma_rx(struct uart_port *port)
> > +static bool atmel_use_pdc_rx(struct uart_port *port)
> >  {
> >  	return false;
> >  }
> >  
> > -static bool atmel_use_dma_tx(struct uart_port *port)
> > +static bool atmel_use_pdc_tx(struct uart_port *port)
> >  {
> >  	return false;
> >  }
> > @@ -233,7 +233,7 @@ void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
> >  		mode |= ATMEL_US_USMODE_RS485;
> >  	} else {
> >  		dev_dbg(port->dev, "Setting UART to RS232\n");
> > -		if (atmel_use_dma_tx(port))
> > +		if (atmel_use_pdc_tx(port))
> >  			atmel_port->tx_done_mask = ATMEL_US_ENDTX |
> >  				ATMEL_US_TXBUFE;
> >  		else
> > @@ -345,7 +345,7 @@ static void atmel_stop_tx(struct uart_port *port)
> >  {
> >  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> >  
> > -	if (atmel_use_dma_tx(port)) {
> > +	if (atmel_use_pdc_tx(port)) {
> >  		/* disable PDC transmit */
> >  		UART_PUT_PTCR(port, ATMEL_PDC_TXTDIS);
> >  	}
> > @@ -364,7 +364,7 @@ static void atmel_start_tx(struct uart_port *port)
> >  {
> >  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> >  
> > -	if (atmel_use_dma_tx(port)) {
> > +	if (atmel_use_pdc_tx(port)) {
> >  		if (UART_GET_PTSR(port) & ATMEL_PDC_TXTEN)
> >  			/* The transmitter is already running.  Yes, we
> >  			   really need this.*/
> > @@ -390,7 +390,7 @@ static void atmel_start_rx(struct uart_port *port)
> >  
> >  	UART_PUT_CR(port, ATMEL_US_RXEN);
> >  
> > -	if (atmel_use_dma_rx(port)) {
> > +	if (atmel_use_pdc_rx(port)) {
> >  		/* enable PDC controller */
> >  		UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
> >  			port->read_status_mask);
> > @@ -407,7 +407,7 @@ static void atmel_stop_rx(struct uart_port *port)
> >  {
> >  	UART_PUT_CR(port, ATMEL_US_RXDIS);
> >  
> > -	if (atmel_use_dma_rx(port)) {
> > +	if (atmel_use_pdc_rx(port)) {
> >  		/* disable PDC receive */
> >  		UART_PUT_PTCR(port, ATMEL_PDC_RXTDIS);
> >  		UART_PUT_IDR(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
> > @@ -572,7 +572,7 @@ atmel_handle_receive(struct uart_port *port, unsigned int pending)
> >  {
> >  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> >  
> > -	if (atmel_use_dma_rx(port)) {
> > +	if (atmel_use_pdc_rx(port)) {
> >  		/*
> >  		 * PDC receive. Just schedule the tasklet and let it
> >  		 * figure out the details.
> > @@ -661,7 +661,7 @@ static irqreturn_t atmel_interrupt(int irq, void *dev_id)
> >  /*
> >   * Called from tasklet with ENDTX and TXBUFE interrupts disabled.
> >   */
> > -static void atmel_tx_dma(struct uart_port *port)
> > +static void atmel_tx_pdc(struct uart_port *port)
> >  {
> >  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> >  	struct circ_buf *xmit = &port->state->xmit;
> > @@ -778,7 +778,7 @@ static void atmel_rx_from_ring(struct uart_port *port)
> >  	spin_lock(&port->lock);
> >  }
> >  
> > -static void atmel_rx_from_dma(struct uart_port *port)
> > +static void atmel_rx_from_pdc(struct uart_port *port)
> >  {
> >  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> >  	struct tty_port *tport = &port->state->port;
> > @@ -868,8 +868,8 @@ static void atmel_tasklet_func(unsigned long data)
> >  	/* The interrupt handler does not take the lock */
> >  	spin_lock(&port->lock);
> >  
> > -	if (atmel_use_dma_tx(port))
> > -		atmel_tx_dma(port);
> > +	if (atmel_use_pdc_tx(port))
> > +		atmel_tx_pdc(port);
> >  	else
> >  		atmel_tx_chars(port);
> >  
> > @@ -893,8 +893,8 @@ static void atmel_tasklet_func(unsigned long data)
> >  		atmel_port->irq_status_prev = status;
> >  	}
> >  
> > -	if (atmel_use_dma_rx(port))
> > -		atmel_rx_from_dma(port);
> > +	if (atmel_use_pdc_rx(port))
> > +		atmel_rx_from_pdc(port);
> >  	else
> >  		atmel_rx_from_ring(port);
> >  
> > @@ -930,7 +930,7 @@ static int atmel_startup(struct uart_port *port)
> >  	/*
> >  	 * Initialize DMA (if necessary)
> >  	 */
> > -	if (atmel_use_dma_rx(port)) {
> > +	if (atmel_use_pdc_rx(port)) {
> >  		int i;
> >  
> >  		for (i = 0; i < 2; i++) {
> > @@ -964,7 +964,7 @@ static int atmel_startup(struct uart_port *port)
> >  		UART_PUT_RNPR(port, atmel_port->pdc_rx[1].dma_addr);
> >  		UART_PUT_RNCR(port, PDC_BUFFER_SIZE);
> >  	}
> > -	if (atmel_use_dma_tx(port)) {
> > +	if (atmel_use_pdc_tx(port)) {
> >  		struct atmel_dma_buffer *pdc = &atmel_port->pdc_tx;
> >  		struct circ_buf *xmit = &port->state->xmit;
> >  
> > @@ -1000,7 +1000,7 @@ static int atmel_startup(struct uart_port *port)
> >  	/* enable xmit & rcvr */
> >  	UART_PUT_CR(port, ATMEL_US_TXEN | ATMEL_US_RXEN);
> >  
> > -	if (atmel_use_dma_rx(port)) {
> > +	if (atmel_use_pdc_rx(port)) {
> >  		/* set UART timeout */
> >  		UART_PUT_RTOR(port, PDC_RX_TIMEOUT);
> >  		UART_PUT_CR(port, ATMEL_US_STTTO);
> > @@ -1031,7 +1031,7 @@ static void atmel_shutdown(struct uart_port *port)
> >  	/*
> >  	 * Shut-down the DMA.
> >  	 */
> > -	if (atmel_use_dma_rx(port)) {
> > +	if (atmel_use_pdc_rx(port)) {
> >  		int i;
> >  
> >  		for (i = 0; i < 2; i++) {
> > @@ -1044,7 +1044,7 @@ static void atmel_shutdown(struct uart_port *port)
> >  			kfree(pdc->buf);
> >  		}
> >  	}
> > -	if (atmel_use_dma_tx(port)) {
> > +	if (atmel_use_pdc_tx(port)) {
> >  		struct atmel_dma_buffer *pdc = &atmel_port->pdc_tx;
> >  
> >  		dma_unmap_single(port->dev,
> > @@ -1080,7 +1080,7 @@ static void atmel_flush_buffer(struct uart_port *port)
> >  {
> >  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> >  
> > -	if (atmel_use_dma_tx(port)) {
> > +	if (atmel_use_pdc_tx(port)) {
> >  		UART_PUT_TCR(port, 0);
> >  		atmel_port->pdc_tx.ofs = 0;
> >  	}
> > @@ -1193,7 +1193,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
> >  	if (termios->c_iflag & (BRKINT | PARMRK))
> >  		port->read_status_mask |= ATMEL_US_RXBRK;
> >  
> > -	if (atmel_use_dma_rx(port))
> > +	if (atmel_use_pdc_rx(port))
> >  		/* need to enable error interrupts */
> >  		UART_PUT_IER(port, port->read_status_mask);
> >  
> > @@ -1429,14 +1429,14 @@ static void atmel_of_init_port(struct atmel_uart_port *atmel_port,
> >  	u32 rs485_delay[2];
> >  
> >  	/* DMA/PDC usage specification */
> > -	if (of_get_property(np, "atmel,use-dma-rx", NULL))
> > -		atmel_port->use_dma_rx	= 1;
> > +	if (of_get_property(np, "atmel,use-pdc-rx", NULL))
> > +		atmel_port->use_pdc_rx	= 1;
> >  	else
> > -		atmel_port->use_dma_rx	= 0;
> > -	if (of_get_property(np, "atmel,use-dma-tx", NULL))
> > -		atmel_port->use_dma_tx	= 1;
> > +		atmel_port->use_pdc_rx	= 0;
> > +	if (of_get_property(np, "atmel,use-pdc-tx", NULL))
> > +		atmel_port->use_pdc_tx	= 1;
> >  	else
> > -		atmel_port->use_dma_tx	= 0;
> > +		atmel_port->use_pdc_tx	= 0;
> >  
> >  	/* rs485 properties */
> >  	if (of_property_read_u32_array(np, "rs485-rts-delay",
> > @@ -1467,8 +1467,8 @@ static void atmel_init_port(struct atmel_uart_port *atmel_port,
> >  	if (pdev->dev.of_node) {
> >  		atmel_of_init_port(atmel_port, pdev->dev.of_node);
> >  	} else {
> > -		atmel_port->use_dma_rx	= pdata->use_dma_rx;
> > -		atmel_port->use_dma_tx	= pdata->use_dma_tx;
> > +		atmel_port->use_pdc_rx	= pdata->use_pdc_rx;
> > +		atmel_port->use_pdc_tx	= pdata->use_pdc_tx;
> >  		atmel_port->rs485	= pdata->rs485;
> >  	}
> >  
> > @@ -1505,7 +1505,7 @@ static void atmel_init_port(struct atmel_uart_port *atmel_port,
> >  	/* Use TXEMPTY for interrupt when rs485 else TXRDY or ENDTX|TXBUFE */
> >  	if (atmel_port->rs485.flags & SER_RS485_ENABLED)
> >  		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
> > -	else if (atmel_use_dma_tx(port)) {
> > +	else if (atmel_use_pdc_tx(port)) {
> >  		port->fifosize = PDC_BUFFER_SIZE;
> >  		atmel_port->tx_done_mask = ATMEL_US_ENDTX | ATMEL_US_TXBUFE;
> >  	} else {
> > @@ -1794,7 +1794,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
> >  		goto err;
> >  	}
> >  
> > -	if (!atmel_use_dma_rx(&port->uart)) {
> > +	if (!atmel_use_pdc_rx(&port->uart)) {
> >  		ret = -ENOMEM;
> >  		data = kmalloc(sizeof(struct atmel_uart_char)
> >  				* ATMEL_SERIAL_RINGSIZE, GFP_KERNEL);
> > diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
> > index 6a293b7..8965fed 100644
> > --- a/include/linux/platform_data/atmel.h
> > +++ b/include/linux/platform_data/atmel.h
> > @@ -76,8 +76,8 @@ struct atmel_nand_data {
> >   /* Serial */
> >  struct atmel_uart_data {
> >  	int			num;		/* port num */
> > -	short			use_dma_tx;	/* use transmit DMA? */
> > -	short			use_dma_rx;	/* use receive DMA? */
> > +	short			use_pdc_tx;	/* use transmit PDC? */
> > +	short			use_pdc_rx;	/* use receive PDC? */
> >  	void __iomem		*regs;		/* virt. base address, if any */
> >  	struct serial_rs485	rs485;		/* rs485 settings */
> >  };
> > -- 
> > 1.7.9.5
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
