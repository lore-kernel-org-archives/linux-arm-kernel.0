From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 18 Mar 2016 18:45:41 +0100
Subject: [PATCH v2 4/4] documentation: Fix pinctrl documentation for
 Meson8 / Meson8b
In-Reply-To: <1457516519-15319-1-git-send-email-carlo@caione.org>
References: <20160305042646.GL13525@rob-hp-laptop>
 <1457516519-15319-1-git-send-email-carlo@caione.org>
Message-ID: <56EC3EC5.3030605@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.03.2016 um 10:41 schrieb Carlo Caione:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Fix pin controller documentation introducing the new compatibles for
> the pinctrl drivers specific for aobus / cbus.
> 
> This is needed because we have changed the pin controller driver: we
> have now a single specialized pinctrl driver / compatible for each bus
> the controller is attached to, instead of one single driver dealing with
> all the controllers we have on different buses.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
> Hey Rob,
> I'm resubmitting a V2 only for this patch since the driver changes have
> been already taken by Linus.
> 
> Thanks,
> ---
>  .../devicetree/bindings/pinctrl/meson,pinctrl.txt  | 38 ++++------------------
>  1 file changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> index 3f6a524..ca6d283 100644
> --- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> @@ -1,13 +1,16 @@
>  == Amlogic Meson pinmux controller ==
>  
>  Required properties for the root node:
> - - compatible: "amlogic,meson8-pinctrl" or "amlogic,meson8b-pinctrl"
> + - compatible: one of "amlogic,meson8-cbus-pinctrl"
> +		      "amlogic,meson8b-cbus-pinctrl"
> +		      "amlogic,meson8-aobus-pinctrl"
> +		      "amlogic,meson8b-aobus-pinctrl"
>   - reg: address and size of registers controlling irq functionality
>  
>  === GPIO sub-nodes ===
>  
> -The 2 power domains of the controller (regular and always-on) are
> -represented as sub-nodes and each of them acts as a GPIO controller.
> +Each power domain of the controller (regular and always-on) is
> +represented as a sub-node and it acts as a GPIO controller.

This paragraph still sounds outdated to me: With regular and always-on
being separate devices now, there is no "and" here, nor different power
domains as "GPIO sub-nodes" (heading).

Otherwise looks okay to me, and +1 for doing the incompatible split.
gxbb already models cbus and aobus as simple-bus'es.

Regards,
Andreas

>  
>  Required properties for sub-nodes are:
>   - reg: should contain address and size for mux, pull-enable, pull and
> @@ -18,10 +21,6 @@ Required properties for sub-nodes are:
>   - gpio-controller: identifies the node as a gpio controller
>   - #gpio-cells: must be 2
>  
> -Valid sub-node names are:
> - - "banks" for the regular domain
> - - "ao-bank" for the always-on domain
> -
>  === Other sub-nodes ===
>  
>  Child nodes without the "gpio-controller" represent some desired
> @@ -45,7 +44,7 @@ pinctrl-bindings.txt
>  === Example ===
>  
>  	pinctrl: pinctrl at c1109880 {
> -		compatible = "amlogic,meson8-pinctrl";
> +		compatible = "amlogic,meson8-cbus-pinctrl";
>  		reg = <0xc1109880 0x10>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -61,15 +60,6 @@ pinctrl-bindings.txt
>  			#gpio-cells = <2>;
>                 };
>  
> -		gpio_ao: ao-bank at c1108030 {
> -			reg = <0xc8100014 0x4>,
> -			      <0xc810002c 0x4>,
> -			      <0xc8100024 0x8>;
> -			reg-names = "mux", "pull", "gpio";
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -		};
> -
>  		nand {
>  			mux {
>  				groups = "nand_io", "nand_io_ce0", "nand_io_ce1",
> @@ -79,18 +69,4 @@ pinctrl-bindings.txt
>  				function = "nand";
>  			};
>  		};
> -
> -		uart_ao_a {
> -			mux {
> -				groups = "uart_tx_ao_a", "uart_rx_ao_a",
> -					 "uart_cts_ao_a", "uart_rts_ao_a";
> -				function = "uart_ao";
> -			};
> -
> -			conf {
> -				pins = "GPIOAO_0", "GPIOAO_1",
> -				       "GPIOAO_2", "GPIOAO_3";
> -				bias-disable;
> -			};
> -		};
>  	};
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
