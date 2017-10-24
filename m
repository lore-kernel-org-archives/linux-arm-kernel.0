From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Oct 2017 14:04:33 -0500
Subject: [RFC 05/12] dt-bindings: mtd: add Marvell NAND controller
 documentation
In-Reply-To: <20171018143629.29302-6-miquel.raynal@free-electrons.com>
References: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
 <20171018143629.29302-6-miquel.raynal@free-electrons.com>
Message-ID: <20171024190433.r5xy25eqdesz7jjs@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 04:36:22PM +0200, Miquel Raynal wrote:
> Document the bindings for the legacy and the new bindings relative to
> Marvell NAND controller driver rework.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  .../devicetree/bindings/mtd/marvell-nand.txt       | 95 ++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/marvell-nand.txt b/Documentation/devicetree/bindings/mtd/marvell-nand.txt
> new file mode 100644
> index 000000000000..ea99f426c03f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/marvell-nand.txt
> @@ -0,0 +1,95 @@
> +Marvell NAND Flash Controller (NFC)
> +
> +Required properties:
> +C'est faux, t'en a rajout? un y a pas longtps :).
> +Je conseille de mettre ?a sous forme de liste, genre

Humm.

> +
> +- compatible: can be one of the following:
> +    * "marvell,armada-8k-nand-controller"
> +    * "marvell,armada370-nand-controller"
> +    * "marvell,pxa3xx-nand-controller"
> +    * "marvell,armada-8k-nand" (deprecated)
> +    * "marvell,armada370-nand" (deprecated)
> +    * "marvell,pxa3xx-nand" (deprecated)
> +- reg: shall contain registers location and length for data and reg.

2 regions?

> +- #address-cells: shall be set to 1. Encode the nand CS.
> +- #size-cells: shall be set to 0.
> +- interrupts: shall define the nand controller interrupt.
> +- clocks: shall reference nand controller clocks.

How many clocks?

> +- marvell,system-controller: Set to retrieve the syscon node that handles
> +  NAND controller related registers (only required with the
> +  "marvell,armada-8k-nand[-controller]" compatibles).
> +
> +Optional properties:
> +- dmas: shall reference DMA channel associated to the NAND controller.
> +- dma-names: shall be "rxtx".
> +
> +Optional children nodes:
> +Children nodes represent the available NAND chips.
> +
> +Required properties:
> +- reg: shall contain the native Chip Select ids (0-3)
> +- marvell,rb: shall contain the native Ready/Busy ids (0-1)
> +
> +Optional properties:
> +- marvell,nand-keep-config: orders the driver not to take the timings
> +  from the core and leaving them completely untouched. Bootloader
> +  timings will then be used.
> +- marvell,nand-enable-arbiter: only useful for PXA platforms, will
> +  enable bus arbiter between NFC and DFI bus (must be enabled for
> +  NFC operation)

Why do you need this if it must be enabled?

> +- nand-on-flash-bbt: speed up the boot process by not discovering all
> +  the bad blocks at each boot and reading directly an on flash table.
> +- nand-ecc-mode: one of the supported ECC modes ("none", "soft",
> +  "hw"). If not specified, hardware ECC will be used.
> +- nand-ecc-algo: algorithm to use if previous choice was "soft"
> +  ("hamming" or "bch). This property may be added for hardware ECC for
> +  clarification but will be ignored by the driver because ECC mode is
> +  chosen depending on the page size and the strength required by the
> +  NAND chip. This value may be overwritten with the nand-ecc-strength
> +  property.
> +- nand-ecc-strength: desired ECC strength.
> +- nand-ecc-step-size: indication on the ECC step size. This has no
> +  effect and will be ignored by the driver when using hardware
> +  ECC. Because Marvell's NAND flash controller does use fixed strength
> +  (1-bit for Hamming, 16-bit for BCH), the step size will shrink or
> +  grown in order to fit the required strength and the value
> +  updated. Step sizes are not completely random for all and follow
> +  certain patterns described in AN-379, "Marvell SoC NFC ECC".

For standard properties, just reference nand.txt and add any 
constraints. Don't define what the property is again.

> +
> +See Documentation/devicetree/bindings/mtd/nand.txt for more details on
> +generic bindings.
> +
> +
> +Example:
> +nand_controller: nand-controller at d0000 {
> +	compatible = "marvell,armada370-nand-controller";
> +	reg = <0xd0000 0x54>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&coredivclk 0>;
> +	status = "okay";

Don't show status in examples.

> +
> +	nand at 0 {
> +		reg = <0>;
> +		marvell,rb = <0>;
> +		nand-ecc-mode = "hw";
> +		marvell,nand-keep-config;
> +		marvell,nand-enable-arbiter;
> +		nand-on-flash-bbt;
> +		nand-ecc-strength = <4>;
> +		nand-ecc-step-size = <512>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition at 0 {
> +				label = "Rootfs";
> +				reg = <0x00000000 0x40000000>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.11.0
> 
