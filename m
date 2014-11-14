From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Nov 2014 10:03:29 -0800
Subject: [PATCH v4 4/6] ARM: dts: AM335x: Make charge delay a DT
 parameter for TSC
In-Reply-To: <1415941651-28962-5-git-send-email-vigneshr@ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <1415941651-28962-5-git-send-email-vigneshr@ti.com>
Message-ID: <20141114180328.GU31250@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vignesh R <vigneshr@ti.com> [141113 21:42]:
> The charge delay value is by default 0x400. But it can be set to lower
> values on some boards, as long as false pen-ups are avoided. Lowering the
> value increases the sampling rate (though current sampling rate is
> sufficient for TSC operation). In some boards, the value has to be
> increased to avoid false pen-up events. Hence, charge delay has been
> made a DT parameter.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

As long as the input and DT people are OK with this, ack for
merging the .dts changes along with the input patches:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
> 
> v4:
>  - Set charge delay to 0x400 as default. Most devices function normally
>    at this value
> 
>  .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt  | 15 +++++++++++++++
>  arch/arm/boot/dts/am335x-evm.dts                          |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> index 878549ba814d..6df5028a4ad3 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> @@ -28,6 +28,20 @@ Required properties:
>  	ti,adc-channels: List of analog inputs available for ADC.
>  			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
>  
> +Optional properties:
> +- child "tsc"
> +	ti,charge-delay: Length of touch screen charge delay step in terms of
> +			 ADC clock cycles. Charge delay value should be large
> +			 in order to avoid false pen-up events. This value
> +			 affects the overall sampling speed, hence need to be
> +			 kept as low as possible, while avoiding false pen-up
> +			 event. Start from a lower value, say 0x400, and
> +			 increase value until false pen-up events are avoided.
> +			 The pen-up detection happens immediately after the
> +			 charge step, so this does in fact function as a
> +			 hardware knob for adjusting the amount of "settling
> +			 time".
> +
>  Example:
>  	tscadc: tscadc at 44e0d000 {
>  		compatible = "ti,am3359-tscadc";
> @@ -36,6 +50,7 @@ Example:
>  			ti,x-plate-resistance = <200>;
>  			ti,coordiante-readouts = <5>;
>  			ti,wire-config = <0x00 0x11 0x22 0x33>;
> +			ti,charge-delay = <0x400>;
>  		};
>  
>  		adc {
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index e2156a583de7..ce12f6ef1e28 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -641,6 +641,7 @@
>  		ti,x-plate-resistance = <200>;
>  		ti,coordinate-readouts = <5>;
>  		ti,wire-config = <0x00 0x11 0x22 0x33>;
> +		ti,charge-delay = <0x400>;
>  	};
>  
>  	adc {
> -- 
> 1.9.1
> 
