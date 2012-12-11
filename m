From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Dec 2012 10:56:58 +0000
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <1354917879-32073-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201212111056.58970.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 December 2012, Thomas Petazzoni wrote:
> This driver implements the hw_pci operations needed by the core ARM
> PCI code to setup PCI devices and get their corresponding IRQs, and
> the pci_ops operations that are used by the PCI core to read/write the
> configuration space of PCI devices.
> 
> In addition, this driver enumerates the different PCIe slots, and for
> those having a device plugged in, it allocates the necessary address
> decoding windows, using the new armada_370_xp_alloc_pcie_window()
> function from mach-mvebu/addr-map.c.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

It seems that this is not following the IEEE PCI bindings, which will
cause problems as soon as you try to connect PCI cards with bridges
bto it.

> diff --git a/Documentation/devicetree/bindings/pci/armada-370-xp-pcie.txt b/Documentation/devicetree/bindings/pci/armada-370-xp-pcie.txt
> new file mode 100644
> index 0000000..daf0775
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/armada-370-xp-pcie.txt
> @@ -0,0 +1,136 @@
> +* Marvell Armada 370/XP PCIe interfaces
> +
> +Mandatory properties:
> +- compatible: must be "marvell,armada-370-xp-pcie"
> +- status: either "disabled" or "okay"
> +- #address-cells, set to <1>
> +- #size-cells, set to <1>
> +- ranges: describes the association between the physical addresses of
> +  the PCIe registers for each PCIe interface with "virtual" addresses
> +  as seen by the sub-nodes. One entry per PCIe interface. Each entry
> +  must have 3 values: the "virtual" address seen by the sub-nodes, the
> +  real physical address of the PCIe registers, and the size.
> +
> +In addition, the Device Tree node must have sub-nodes describing each
> +PCIe interface, having the following mandatory properties:
> +- reg: the address and size of the PCIe registers (translated
> +  addresses according to the ranges property of the parent)
> +- interrupts: the interrupt number of this PCIe interface
> +- clocks: the clock associated to this PCIe interface
> +- marvell,pcie-port: the physical PCIe port number
> +- status: either "disabled" or "okay"
> +
> +and the following optional properties:
> +- marvell,pcie-lane: the physical PCIe lane number, for ports having
> +  multiple lanes. If this property is not found, we assume that the
> +  value is 0.

A PCI host controller should set #interrupt-cells=<1>, #size-cells=<2>
and #address-cells=<3>, and provide an interrupt map that describes how
the intA-intD lines for each slot are connected to the host interrupts.

	Arnd
