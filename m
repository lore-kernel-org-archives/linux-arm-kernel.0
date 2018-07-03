From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 15:13:35 -0600
Subject: [PATCH v2 15/23] dt-bindings: ap806: add the thermal node in the
 syscon file
In-Reply-To: <20180625151239.20976-16-miquel.raynal@bootlin.com>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-16-miquel.raynal@bootlin.com>
Message-ID: <20180703211335.GA8858@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 05:12:31PM +0200, Miquel Raynal wrote:
> Explain the thermal bindings now that the thermal IP is described being
> inside of a system controller. Add a reference to the thermal-zone node.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../arm/marvell/ap806-system-controller.txt        | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> index a856eb9a4e05..a265f1628f36 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> @@ -11,6 +11,9 @@ For the top level node:
>   - compatible: must be: "syscon", "simple-mfd";
>   - reg: register area of the AP806 system controller
>  
> +SYSTEM CONTROLLER 0
> +===================
> +
>  Clocks:
>  -------
>  
> @@ -98,3 +101,38 @@ ap_syscon: system-controller at 6f4000 {
>  		gpio-ranges = <&ap_pinctrl 0 0 19>;
>  	};
>  };
> +
> +SYSTEM CONTROLLER 1
> +===================
> +
> +Thermal:
> +--------
> +
> +For common binding part and usage, refer to
> +Documentation/devicetree/bindings/thermal/thermal.txt
> +
> +The thermal IP can probe the temperature all around the processor. It
> +may feature several channels, each of them wired to one sensor.
> +
> +Required properties:
> +- compatible: must be one of:
> +  * marvell,armada-ap806-thermal
> +- reg: register range associated with the thermal functions.
> +
> +Optional properties:
> +- #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
> +  to this IP and represents the channel ID. There is one sensor per
> +  channel. O refers to the thermal IP internal channel, while positive
> +  IDs refer to each CPU.
> +
> +Example:
> +ap_syscon1: system-controller at 6f8000 {
> +	compatible = "syscon", "simple-mfd";
> +	reg = <0x6f8000 0x1000>;
> +
> +	ap_thermal: ap-thermal at 80 {

thermal-sensor at ...

With that,

Reviewed-by: Rob Herring <robh@kernel.org>


> +		compatible = "marvell,armada-ap806-thermal";
> +		reg = <0x80 0x10>;
> +		#thermal-sensor-cells = <1>;
> +	};
> +};
> -- 
> 2.14.1
> 
