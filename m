From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Nov 2015 10:58:35 -0600
Subject: [PATCH 03/10] dt-bindings: interrupt-controllers: add
 description of SIC1 and SIC2
In-Reply-To: <1447982925-30138-4-git-send-email-vz@mleia.com>
References: <1447982925-30138-1-git-send-email-vz@mleia.com>
 <1447982925-30138-4-git-send-email-vz@mleia.com>
Message-ID: <20151120165835.GA17916@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 03:28:38AM +0200, Vladimir Zapolskiy wrote:
> NXP LPC32xx has three interrupt controllers, namely root Main
> Interrupt Controller (MIC) and two supplementary Sub Interrupt
> Controllers (SIC1 and SIC2), four interrupt outputs from SIC1 and SIC2
> are connected to MIC.
> 
> Also the change describes two additional optional properties:
> * interrupt-controller-name - human readable name of an interrupt
>   controller,

Why? compatible is human readable. If you don't like that, then put the 
string in the driver.

> * wakeup-sources - list of mappings between a hardware interrupt and
>   its correspondent wakeup source to exit CPU STOP mode.

This needs further discussion as I mentioned.

The rest looks fine.

Rob
 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  .../interrupt-controller/nxp,lpc3220-mic.txt       | 99 ++++++++++++++++------
>  1 file changed, 75 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
> index 539adca..99e41ca 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
> @@ -1,38 +1,89 @@
> -* NXP LPC32xx Main Interrupt Controller
> -  (MIC, including SIC1 and SIC2 secondary controllers)
> +* NXP LPC32xx MIC, SIC1 and SIC2 Interrupt Controllers
>  
>  Required properties:
> -- compatible: Should be "nxp,lpc3220-mic"
> -- interrupt-controller: Identifies the node as an interrupt controller.
> -- interrupt-parent: Empty for the interrupt controller itself
> -- #interrupt-cells: The number of cells to define the interrupts. Should be 2.
> -  The first cell is the IRQ number
> -  The second cell is used to specify mode:
> -      1 = low-to-high edge triggered
> -      2 = high-to-low edge triggered
> -      4 = active high level-sensitive
> -      8 = active low level-sensitive
> -      Default for internal sources should be set to 4 (active high).
> -- reg: Should contain MIC registers location and length
> +- compatible: "nxp,lpc3220-mic" or "nxp,lpc3220-sic".
> +- reg: should contain IC registers location and length
> +- interrupt-controller: identifies the node as an interrupt controller.
> +- #interrupt-cells: the number of cells to define an interrupt, should be 2.
> +  The first cell is the IRQ number, the second cell is used to specify
> +  one of the supported modes:
> +      IRQ_TYPE_EDGE_RISING = low-to-high edge triggered
> +      IRQ_TYPE_EDGE_FALLING = high-to-low edge triggered
> +      IRQ_TYPE_LEVEL_HIGH = active high level-sensitive
> +      IRQ_TYPE_LEVEL_LOW = active low level-sensitive
> +      Default for internal sources should be set to IRQ_TYPE_LEVEL_HIGH.
> +
> +Optional properties:
> +- interrupt-parent: empty for MIC interrupt controller, link to parent
> +  MIC interrupt controller for SIC1 and SIC2
> +- interrupts: empty for MIC interrupt controller, cascaded MIC
> +  hardware interrupts for SIC1 and SIC2
> +- interrupt-controller-name: readable interrupt controller name
> +- wakeup-sources: mapping of interrupts handled by the controller and
> +  which may serve as a wakeup source.
>  
>  Examples:
> -	/*
> -	 * MIC
> -	 */
> +
> +	/* LPC32xx MIC, SIC1 and SIC2 interrupt controllers */
>  	mic: interrupt-controller at 40008000 {
>  		compatible = "nxp,lpc3220-mic";
> +		reg = <0x40008000 0x4000>;
> +		interrupt-controller;
> +		interrupt-controller-name = "mic";
> +		#interrupt-cells = <2>;
> +
> +		wakeup-sources = <&wakeup_int 7 29>,
> +				 <&wakeup_int 25 27>;
> +	};
> +
> +	sic1: interrupt-controller at 4000C000 {
> +		compatible = "nxp,lpc3220-sic";
> +		reg = <0x4000C000 0x4000>;
> +		interrupt-controller;
> +		interrupt-controller-name = "sic1";
> +		#interrupt-cells = <2>;
> +
> +		interrupt-parent = <&mic>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
> +			     <30 IRQ_TYPE_LEVEL_LOW>;
> +
> +		wakeup-sources = <&wakeup_int 16 22>, <&wakeup_int 19 26>,
> +				 <&wakeup_int 20 25>, <&wakeup_int 21 31>,
> +				 <&wakeup_int 24 20>, <&wakeup_int 29 8>,
> +				 <&wakeup_int 30 6>, <&wakeup_int 31 7>,
> +				 <&wakeup_pin 25 4>;
> +	};
> +
> +	sic2: interrupt-controller at 40010000 {
> +		compatible = "nxp,lpc3220-sic";
> +		reg = <0x40010000 0x4000>;
>  		interrupt-controller;
> -		interrupt-parent;
> +		interrupt-controller-name = "sic2";
>  		#interrupt-cells = <2>;
> -		reg = <0x40008000 0xC000>;
> +
> +		interrupt-parent = <&mic>;
> +		interrupts = <1 IRQ_TYPE_LEVEL_LOW>,
> +			     <31 IRQ_TYPE_LEVEL_LOW>;
> +
> +		wakeup-sources = <&wakeup_int 0 0>, <&wakeup_int 1 1>,
> +				 <&wakeup_int 2 2>, <&wakeup_int 3 3>,
> +				 <&wakeup_int 4 4>, <&wakeup_int 5 5>,
> +				 <&wakeup_int 6 8>, <&wakeup_pin 3 9>,
> +				 <&wakeup_pin 4 10>, <&wakeup_pin 5 11>,
> +				 <&wakeup_pin 6 6>, <&wakeup_pin 7 15>,
> +				 <&wakeup_pin 8 20>, <&wakeup_pin 9 31>,
> +				 <&wakeup_pin 10 22>, <&wakeup_pin 11 23>,
> +				 <&wakeup_pin 12 24>, <&wakeup_pin 13 25>,
> +				 <&wakeup_pin 14 26>, <&wakeup_pin 15 27>,
> +				 <&wakeup_pin 16 27>, <&wakeup_pin 18 18>,
> +				 <&wakeup_pin 23 7>, <&wakeup_pin 26 19>,
> +				 <&wakeup_pin 30 12>;
>  	};
>  
> -	/*
> -	 * ADC
> -	 */
> +	/* ADC */
>  	adc at 40048000 {
>  		compatible = "nxp,lpc3220-adc";
>  		reg = <0x40048000 0x1000>;
> -		interrupt-parent = <&mic>;
> -		interrupts = <39 4>;
> +		interrupt-parent = <&sic1>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> -- 
> 2.1.4
> 
