From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 24 Sep 2015 02:19:57 +0100
Subject: [PATCH] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL PCIe
 Host Controller
In-Reply-To: <1440675860-21491-1-git-send-email-bharatku@xilinx.com>
References: <1440675860-21491-1-git-send-email-bharatku@xilinx.com>
Message-ID: <20150924011957.GA8472@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 12:44:20PM +0100, Bharat Kumar Gogada wrote:
> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> ---
>  .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   39 +
>  drivers/pci/host/Kconfig                           |    9 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pci-xilinx-nwl.c                  | 1038 ++++++++++++++++++++
>  4 files changed, 1087 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>  create mode 100644 drivers/pci/host/pci-xilinx-nwl.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
> new file mode 100644
> index 0000000..c554d6b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
> @@ -0,0 +1,39 @@
> +* Xilinx NWL PCIe Root Port Bridge DT description
> +
> +Required properties:
> +- compatible: Should contain "xlnx,nwl-pcie-2.11"
> +- #address-cells: Address representation for root ports, set to <3>
> +- #size-cells: Size representation for root ports, set to <2>
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +       interrupt source. The value must be 1.

This isn't in the example, and I cna't see why/how you would use this.

> +- reg: Should contain Bridge, PCIe Controller registers location and length

You need to define reg-names, given the example and driver rely on it.

> +- device_type: must be "pci"
> +- interrupts: Should contain NWL PCIe interrupt

You need to define interrupt-names, given the example and driver rely on it.

> +- ranges: ranges for the PCI memory regions (I/O space region is not
> +       supported by hardware)
> +       Please refer to the standard PCI bus binding document for a more
> +       detailed explanation
> +
> +Optional properties:
> +- xlnx,msi-fifo: To enable MSI FIFO mode

Why is this in the binding?

When should or shouldn't I set this?

I take it the root complex is its own MSI controller?

> +
> +Example:
> +++++++++
> +nwl_pcie: pcie at fd0e0000 {
> +       compatible = "xlnx,nwl-pcie-2.11";
> +       #address-cells = <3>;
> +       #size-cells = <2>;
> +       #interrupt-cells = <1>;
> +       device_type = "pci";
> +       interrupt-parent = <&gic>;
> +       interrupts = < 0 118 4
> +                      0 116 4
> +                      0 115 4          // MSI_1 [63...32]
> +                      0 114 4 >;       // MSI_0 [31...0]

Nit: please bracket list entires individually (that also applies to reg).

> +       interrupt-names = "misc", "intx", "msi_1", "msi_0";
> +       reg = <0x0 0xfd0e0000 0x1000
> +              0x0 0xfd480000 0x1000
> +              0x0 0xE0000000 0x1000000>;
> +       reg-names = "breg", "pcireg", "cfg";
> +       ranges = <0x02000000 0x00000000 0xE1000000 0x00000000 0xE1000000 0 0x0F000000>;
> +};

Thanks,
Mark.
