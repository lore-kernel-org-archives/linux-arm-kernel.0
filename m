From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 14:19:30 +0100
Subject: [PATCH v8 1/6] dt-bindings: sram: describe option to reserve
 parts of the memory
In-Reply-To: <126672712.tufE5adZWC@phil>
References: <21117503.1c6iOkvYSr@phil> <126672712.tufE5adZWC@phil>
Message-ID: <201402251419.31151.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 February 2014, Heiko St?bner wrote:
> Some SoCs need parts of their sram for special purposes. So while being part
> of the peripheral, it should not be part of the genpool controlling the sram.
> 
> Therefore add the option to define reserved regions as subnodes of the
> sram-node similar to defining reserved global memory regions.

[adding Sachin Kamat to Cc, he just had the same issue]

> Originally
> Suggested-by: Rob Herring <robherring2@gmail.com>
> 
> Using subnodes for reserved regions
> Suggested-by: Grant Likely <grant.likely@linaro.org>
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
> ---
>  Documentation/devicetree/bindings/misc/sram.txt | 33 +++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/sram.txt b/Documentation/devicetree/bindings/misc/sram.txt
> index 4d0a00e..2d83758 100644
> --- a/Documentation/devicetree/bindings/misc/sram.txt
> +++ b/Documentation/devicetree/bindings/misc/sram.txt
> @@ -8,9 +8,42 @@ Required properties:
>  
>  - reg : SRAM iomem address range
>  
> +Reserving sram areas:
> +---------------------
> +
> +Each child of the sram node specifies a region of reserved memory. Each
> +child node should use a 'reg' property to specify a specific range of
> +reserved memory.
> +
> +Following the generic-names recommended practice, node names should
> +reflect the purpose of the node. Unit address (@<address>) should be
> +appended to the name.
> +
> +Required properties in the sram node:
> +
> +- #address-cells, #size-cells : should use the same values as the root node
> +- ranges : standard definition, should be empty

I think we should rather define the 'ranges' property to translate from
addresses within the sram to bus addresses.

> +Required properties in the area nodes:
> +
> +- reg : iomem address range
> +
> +Optional properties in the area nodes:
> +
> +- compatible : standard definition
> +

Is this enough? Normally we should define a list of "compatible" strings
that people can add to, but not have an anything-allowed option.

>  Example:
>  
>  sram: sram at 5c000000 {
>  	compatible = "mmio-sram";
>  	reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000 */
> +
> +	#adress-cells = <1>;
> +	#size-cells = <1>;
> +	ranges;
> +
> +	smp-sram at 5c000100 {
> +		compatible = "socvendor,smp-sram";
> +		reg = <0x5c000100 0x50>;
> +	};
>  };
