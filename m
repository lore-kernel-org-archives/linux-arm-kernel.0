From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 19 Nov 2018 11:40:36 +0000
Subject: [RESEND PATCH v3 1/2] dt-bindings: PCI: Add UniPhier PCIe host
 controller description
In-Reply-To: <1539667641-26024-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1539667641-26024-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1539667641-26024-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20181119114028.GA30042@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 02:27:20PM +0900, Kunihiko Hayashi wrote:
> Add DT bindings for PCIe controller implemented in UniPhier SoCs when
> configured in Root Complex (host) mode. This controller is based on
> the DesignWare PCIe core.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/uniphier-pcie.txt      | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> new file mode 100644
> index 0000000..46a2754
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> @@ -0,0 +1,81 @@
> +Socionext UniPhier PCIe host controller bindings
> +
> +This describes the devicetree bindings for PCIe host controller implemented
> +on Socionext UniPhier SoCs.
> +
> +UniPhier PCIe host controller is based on the Synopsys DesignWare PCI core.
> +It shares common functions with the PCIe DesignWare core driver and inherits
> +common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +
> +Required properties:
> +- compatible: Should be "socionext,uniphier-pcie".
> +- reg: Specifies offset and length of the register set for the device.
> +	According to the reg-names, appropriate register sets are required.
> +- reg-names: Must include the following entries:
> +    "dbi"    - controller configuration registers
> +    "link"   - SoC-specific glue layer registers
> +    "config" - PCIe configuration space
> +- clocks: A phandle to the clock gate for PCIe glue layer including
> +	the host controller.
> +- resets: A phandle to the reset line for PCIe glue layer including
> +	the host controller.
> +- interrupts: A list of interrupt specifiers. According to the
> +	interrupt-names, appropriate interrupts are required.
> +- interrupt-names: Must include the following entries:
> +    "dma" - DMA interrupt
> +    "msi" - MSI interrupt
> +
> +Optional properties:
> +- phys: A phandle to generic PCIe PHY. According to the phy-names, appropriate
> +	phys are required.
> +- phy-names: Must be "pcie-phy".
> +
> +Required sub-node:
> +- legacy-interrupt-controller: Specifies interrupt controller for legacy PCI
> +	interrupts.
> +
> +Required properties for legacy-interrupt-controller:
> +- interrupt-controller: identifies the node as an interrupt controller.
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +- interrupt-parent: Phandle to the parent interrupt controller.
> +- interrupts: An interrupt specifier for legacy interrupt.
> +
> +Example:
> +
> +	pcie: pcie at 66000000 {
> +		compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
> +		status = "disabled";
> +		reg-names = "dbi", "link", "config";
> +		reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
> +		      <0x2fff0000 0x10000>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		clocks = <&sys_clk 24>;
> +		resets = <&sys_rst 24>;
> +		num-lanes = <1>;
> +		num-viewport = <1>;
> +		bus-range = <0x0 0xff>;
> +		device_type = "pci";
> +		ranges =
> +		/* downstream I/O */
> +			<0x81000000 0 0x00000000  0x2ffe0000  0 0x00010000
> +		/* non-prefetchable memory */
> +			 0x82000000 0 0x00000000  0x20000000  0 0x0ffe0000>;
> +		#interrupt-cells = <1>;
> +		interrupt-names = "dma", "msi";
> +		interrupts = <0 224 4>, <0 225 4>;
> +		interrupt-map-mask = <0 0 0  7>;
> +		interrupt-map = <0 0 0  1  &pcie_intc 1>,	/* INTA */
> +				<0 0 0  2  &pcie_intc 2>,	/* INTB */
> +				<0 0 0  3  &pcie_intc 3>,	/* INTC */
> +				<0 0 0  4  &pcie_intc 4>;	/* INTD */

This is not correct and we must fix this concept for all DWC based host
bridges bindings. We are mapping INTX to inputs [0,1,2,3] of the host
bridge interrupt controllers and the binding should reflect that.

This should be the correct mapping:

		interrupt-map = <0 0 0  1  &pcie_intc 0>,	/* INTA */
				<0 0 0  2  &pcie_intc 1>,	/* INTB */
				<0 0 0  3  &pcie_intc 2>,	/* INTC */
				<0 0 0  4  &pcie_intc 3>;	/* INTD */

Lorenzo

> +
> +		pcie_intc: legacy-interrupt-controller {
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 226 4>;
> +		};
> +	};
> -- 
> 2.7.4
> 
