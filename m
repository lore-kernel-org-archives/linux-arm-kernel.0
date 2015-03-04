From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 15:11:00 +0100
Subject: [PATCH 1/4] ARM: at91: dt: sama5d4: add ssc nodes
In-Reply-To: <1422859907-14881-2-git-send-email-voice.shen@atmel.com>
References: <1422859907-14881-1-git-send-email-voice.shen@atmel.com>
 <1422859907-14881-2-git-send-email-voice.shen@atmel.com>
Message-ID: <54F71274.8020805@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/02/2015 07:51, Bo Shen a ?crit :
> Add SSC 0 and 1 nodes.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
> 
>  arch/arm/boot/dts/sama5d4.dtsi | 70 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index b94995d..0b3e5f4 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -66,6 +66,8 @@
>  		tcb0 = &tcb0;
>  		tcb1 = &tcb1;
>  		i2c2 = &i2c2;
> +		ssc0 = &ssc0;
> +		ssc1 = &ssc1;
>  	};
>  	cpus {
>  		#address-cells = <1>;
> @@ -793,6 +795,24 @@
>  				clock-names = "mci_clk";
>  			};
>  
> +			ssc0: ssc at f8008000 {
> +				compatible = "atmel,at91sam9g45-ssc";
> +				reg = <0xf8008000 0x4000>;
> +				interrupts = <48 IRQ_TYPE_LEVEL_HIGH 0>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
> +				dmas = <&dma1
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> +					| AT91_XDMAC_DT_PERID(26))>,
> +				       <&dma1
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> +					| AT91_XDMAC_DT_PERID(27))>;
> +				dma-names = "tx", "rx";
> +				clocks = <&ssc0_clk>;
> +				clock-names = "pclk";
> +				status = "disabled";
> +			};
> +
>  			spi0: spi at f8010000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> @@ -941,6 +961,24 @@
>  				status = "disabled";
>  			};
>  
> +			ssc1: ssc at fc014000 {
> +				compatible = "atmel,at91sam9g45-ssc";
> +				reg = <0xfc014000 0x4000>;
> +				interrupts = <49 IRQ_TYPE_LEVEL_HIGH 0>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
> +				dmas = <&dma1
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> +					| AT91_XDMAC_DT_PERID(28))>,
> +				       <&dma1
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> +					| AT91_XDMAC_DT_PERID(29))>;
> +				dma-names = "tx", "rx";
> +				clocks = <&ssc1_clk>;
> +				clock-names = "pclk";
> +				status = "disabled";
> +			};
> +
>  			tcb1: timer at fc020000 {
>  				compatible = "atmel,at91sam9x5-tcb";
>  				reg = <0xfc020000 0x100>;
> @@ -1295,6 +1333,38 @@
>  						atmel,pins = <AT91_PIOE 0 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* conflicts with A0/NBS0, MCI0_CDB */
>  					};
>  				};
> +
> +				ssc0 {
> +					pinctrl_ssc0_tx: ssc0_tx {
> +						atmel,pins =
> +							<AT91_PIOB 27 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PB27 periph B TK0 */
> +							 AT91_PIOB 31 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PB31 periph B TF0 */
> +							 AT91_PIOB 28 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB28 periph B TD0 */
> +					};
> +
> +					pinctrl_ssc0_rx: ssc0_rx {
> +						atmel,pins =
> +							<AT91_PIOB 26 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PB26 periph B RK0 */
> +							 AT91_PIOB 30 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PB30 periph B RF0 */
> +							 AT91_PIOB 29 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB29 periph B RD0 */
> +					};
> +				};
> +
> +				ssc1 {
> +					pinctrl_ssc1_tx: ssc1_tx {
> +						atmel,pins =
> +							<AT91_PIOC 19 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC19 periph B TK1 */
> +							 AT91_PIOC 20 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC20 periph B TF1 */
> +							 AT91_PIOC 21 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PC21 periph B TD1 */
> +					};
> +
> +					pinctrl_ssc1_rx: ssc1_rx {
> +						atmel,pins =
> +							<AT91_PIOC 24 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC24 periph B RK1 */
> +							 AT91_PIOC 22 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC22 periph B RF1 */
> +							 AT91_PIOC 23 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PC23 periph B RD1 */
> +					};
> +				};

Nit: I modified these 2 nodes:
1/ sort alphabetically
2/ removed the "PC22 periph B" part of the comment with is not needed.

No need to re-send.
Thanks, bye.


>  			};
>  
>  			aic: interrupt-controller at fc06e000 {
> 


-- 
Nicolas Ferre
