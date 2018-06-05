From: robh@kernel.org (Rob Herring)
Date: Tue, 5 Jun 2018 14:29:02 -0600
Subject: [PATCH v2 12/16] dt-bindings/interrupt-controller: update
 Marvell ICU bindings
In-Reply-To: <20180522094042.24770-13-miquel.raynal@bootlin.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
 <20180522094042.24770-13-miquel.raynal@bootlin.com>
Message-ID: <20180605202902.GA8875@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 11:40:38AM +0200, Miquel Raynal wrote:
> Change the documentation to reflect the new bindings used for Marvell
> ICU. This involves describing each interrupt group as a subnode of the
> ICU node. Each of them having their own compatible.

Need to explain why you need to do this and why breaking backwards 
compatibility is okay.

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/interrupt-controller/marvell,icu.txt  | 81 ++++++++++++++++++----
>  1 file changed, 69 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
> index 649b7ec9d9b1..6f7e4355b3d8 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
> @@ -5,6 +5,8 @@ The Marvell ICU (Interrupt Consolidation Unit) controller is
>  responsible for collecting all wired-interrupt sources in the CP and
>  communicating them to the GIC in the AP, the unit translates interrupt
>  requests on input wires to MSG memory mapped transactions to the GIC.
> +These messages will access a different GIC memory area depending on
> +their type (NSR, SR, SEI, REI, etc).
>  
>  Required properties:
>  
> @@ -12,20 +14,19 @@ Required properties:
>  
>  - reg: Should contain ICU registers location and length.
>  
> +Subnodes: Each group of interrupt is declared as a subnode of the ICU,
> +with their own compatible.
> +
> +Required properties for the icu_nsr/icu_sei subnodes:
> +
> +- compatible: Should be "marvell,cp110-icu-nsr" or "marvell,cp110-icu-sei".
> +
>  - #interrupt-cells: Specifies the number of cells needed to encode an
> -  interrupt source. The value shall be 3.
> +  interrupt source. The value shall be 2.
>  
> -  The 1st cell is the group type of the ICU interrupt. Possible group
> -  types are:
> +  The 1st cell is the index of the interrupt in the ICU unit.
>  
> -   ICU_GRP_NSR (0x0) : Shared peripheral interrupt, non-secure
> -   ICU_GRP_SR  (0x1) : Shared peripheral interrupt, secure
> -   ICU_GRP_SEI (0x4) : System error interrupt
> -   ICU_GRP_REI (0x5) : RAM error interrupt

What happens to SR and REI interrupts?

> -
> -  The 2nd cell is the index of the interrupt in the ICU unit.
> -
> -  The 3rd cell is the type of the interrupt. See arm,gic.txt for
> +  The 2nd cell is the type of the interrupt. See arm,gic.txt for
>    details.
>  
>  - interrupt-controller: Identifies the node as an interrupt
> @@ -35,17 +36,73 @@ Required properties:
>    that allows to trigger interrupts using MSG memory mapped
>    transactions.
>  
> +Note: each 'interrupts' property referring to any 'icu_xxx' node shall
> +      have a different number within [0:206].
> +
>  Example:
>  
>  icu: interrupt-controller at 1e0000 {
>  	compatible = "marvell,cp110-icu";
>  	reg = <0x1e0000 0x440>;
> +
> +	CP110_LABEL(icu_nsr): icu-nsr {

'interrupt-controller' is the proper node name. Is there no register 
range associated sub nodes?

> +		compatible = "marvell,cp110-icu-nsr";
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		msi-parent = <&gicp>;
> +	};
> +
> +        CP110_LABEL(icu_sei): icu-sei {
> +                compatible = "marvell,cp110-icu-sei";
> +                #interrupt-cells = <2>;
> +                interrupt-controller;
> +                msi-parent = <&sei>;
> +        };

Mixture of tabs and spaces.

> +};
> +
> +node1 {
> +	interrupt-parent = <&icu_nsr>;
> +	interrupts = <106 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +node2 {
> +	interrupt-parent = <&icu_sei>;
> +	interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +/* Would not work with the above nodes */
> +node3 {
> +	interrupt-parent = <&icu_nsr>;
> +	interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +Note on legacy bindings:
> +Before using a subnode for each domain, only NSR were
> +supported. Bindings were different in this way:
> +
> +- #interrupt-cells: The value was 3.
> +	The 1st cell was the group type of the ICU interrupt. Possible
> +	group types were:
> +	ICU_GRP_NSR (0x0) : Shared peripheral interrupt, non-secure
> +	ICU_GRP_SR  (0x1) : Shared peripheral interrupt, secure
> +	ICU_GRP_SEI (0x4) : System error interrupt
> +	ICU_GRP_REI (0x5) : RAM error interrupt
> +	The 2nd cell was the index of the interrupt in the ICU unit.
> +	The 3rd cell was the type of the interrupt. See arm,gic.txt for
> +	details.
> +
> +Example:
> +
> +icu: interrupt-controller at 1e0000 {
> +	compatible = "marvell,cp110-icu";
> +	reg = <0x1e0000 0x440>;
> +
>  	#interrupt-cells = <3>;
>  	interrupt-controller;
>  	msi-parent = <&gicp>;
>  };
>  
> -usb3h0: usb3 at 500000 {
> +node1 {
>  	interrupt-parent = <&icu>;
>  	interrupts = <ICU_GRP_NSR 106 IRQ_TYPE_LEVEL_HIGH>;
>  };
> -- 
> 2.14.1
> 
