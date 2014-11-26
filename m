From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Nov 2014 11:12:46 +0000
Subject: [PATCH v11 2/2] irqchip: gicv2m: Add DT bindings for GICv2m
In-Reply-To: <1416941243-7181-3-git-send-email-marc.zyngier@arm.com>
References: <1416941243-7181-1-git-send-email-marc.zyngier@arm.com>
 <1416941243-7181-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20141126111246.GB4340@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 06:47:23PM +0000, Marc Zyngier wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> Update the GIC DT bindings to support GICv2m.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> [maz: split DT patch from main driver, updated changelog]
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt | 53 +++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index c7d2fa1..375147e 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -96,3 +96,56 @@ Example:
>  		      <0x2c006000 0x2000>;
>  		interrupts = <1 9 0xf04>;
>  	};
> +
> +
> +* GICv2m extension for MSI/MSI-x support (Optional)
> +
> +Certain revisions of GIC-400 supports MSI/MSI-x via V2M register frame(s).
> +This is enabled by specifying v2m sub-node(s).
> +
> +Required properties:
> +
> +- compatible	    : The value here should contain "arm,gic-v2m-frame".
> +
> +- msi-controller    : Identifies the node as an MSI controller.
> +
> +- reg		    : GICv2m MSI interface register base and size

It would be worth having a note that ranges, #address-cells, and
#size-cells are necessary in the GIC node to map this.

Otherwise this looks fine to me.

Mark.

> +
> +Optional properties:
> +
> +- arm,msi-base-spi  : When the MSI_TYPER register contains an incorrect
> +  		      value, this property should contain the SPI base of
> +		      the MSI frame, overriding the HW value.
> +
> +- arm,msi-num-spis  : When the MSI_TYPER register contains an incorrect
> +  		      value, this property should contain the number of
> +		      SPIs assigned to the frame, overriding the HW value.
> +
> +Example:
> +
> +	interrupt-controller at e1101000 {
> +		compatible = "arm,gic-400";
> +		#interrupt-cells = <3>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		interrupt-controller;
> +		interrupts = <1 8 0xf04>;
> +		ranges = <0 0 0 0xe1100000 0 0x100000>;
> +		reg = <0x0 0xe1110000 0 0x01000>,
> +		      <0x0 0xe112f000 0 0x02000>,
> +		      <0x0 0xe1140000 0 0x10000>,
> +		      <0x0 0xe1160000 0 0x10000>;
> +		v2m0: v2m at 0x8000 {
> +			compatible = "arm,gic-v2m-frame";
> +			msi-controller;
> +			reg = <0x0 0x80000 0 0x1000>;
> +		};
> +
> +		....
> +
> +		v2mN: v2m at 0x9000 {
> +			compatible = "arm,gic-v2m-frame";
> +			msi-controller;
> +			reg = <0x0 0x90000 0 0x1000>;
> +		};
> +	};
> -- 
> 2.1.3
> 
> 
