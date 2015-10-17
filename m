From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Oct 2015 13:49:25 +0200
Subject: [PATCH v4] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <1445066538-24638-1-git-send-email-bharatku@xilinx.com>
References: <1445066538-24638-1-git-send-email-bharatku@xilinx.com>
Message-ID: <5705956.6YyKSO4LdH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 October 2015 12:52:18 Bharat Kumar Gogada wrote:
> +       "msi_1, msi_0": interrupt asserted when msi is recieved

Better avoid underscores in DT, use "msi0" instead of "msi_0".

> +- interrupt-map-mask and interrupt-map: standard PCI properties to define the
> +       mapping of the PCI interface to interrupt numbers.
> +- ranges: ranges for the PCI memory regions (I/O space region is not
> +       supported by hardware)
> +       Please refer to the standard PCI bus binding document for a more
> +       detailed explanation
> +- msi-controller: indicates that this is MSI controller node
> +- msi-parent:  MSI parent of the root complex itself
> +- pcie_intc: Interrupt controller device node for Legacy interrupts
> +       - interrupt-controller: identifies the node as an interrupt controller
> +       - #interrupt-cells: should be set to 1
> +       - #address-cells: specifies the number of cells needed to encode an
> +               address. The value must be 0.

The name doesn't match: below, the name is "legacy-interrupt-controller",
not "pcie_intc". I suppose it should really be "interrupt-controller"
anyway.

> +
> +Example:
> +++++++++
> +
> +nwl_pcie: pcie at fd0e0000 {
> +       #address-cells = >;
> +       #size-cells = <2>;
> +       compatible = "xlnx,nwl-pcie-2.11";
> +       #interrupt-cells = <1>;
> +       msi-controller;
> +       device_type = "pci";
> +       interrupt-parent = <&gic>;
> +       interrupts = < 0 118 4
> +                      0 116 4
> +                      0 115 4          // MSI_1 [63...32]
> +                      0 114 4 >;       // MSI_0 [31...0]

Better write these as tuples:

	interrupts = <0 118 4>, <0 116 4>, <0 115 4>, <0 114 4>;

And maybe reverse the order? It looks that might be what the
soc integration person had in mind.

Also, what is interrupt <0 117 4>? Is that connected here as well?
Better list it as well then, even if you don't use it.

> +       interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +       interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1
> +                        0x0 0x0 0x0 0x2 &pcie_intc 0x2
> +                        0x0 0x0 0x0 0x3 &pcie_intc 0x3
> +                        0x0 0x0 0x0 0x4 &pcie_intc 0x4>;

> +       msi-parent = <&nwl_pcie>;
> +       reg = <0x0 0xfd0e0000 0x1000
> +              0x0 0xfd480000 0x1000
> +              0x0 0xE0000000 0x1000000>;

Same grouping for reg and interrupt-map as above for interrupts.

> +       reg-names = "breg", "pcireg", "cfg";
> +       ranges = <0x02000000 0x00000000 0xE1000000 0x00000000 0xE1000000 0 0x0F000000>;

No I/O space or prefetcheable memory?

	Arnd
