From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 May 2016 11:36:21 +0200
Subject: [PATCH 1/2] Documentation: DT: bindings: Add Broadcom STB PCIe
 bindings
In-Reply-To: <1462238749-19715-2-git-send-email-f.fainelli@gmail.com>
References: <1462238749-19715-1-git-send-email-f.fainelli@gmail.com>
 <1462238749-19715-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <3271950.m2VfxN38UI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 May 2016 18:25:48 Florian Fainelli wrote:
> diff --git a/Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
> new file mode 100644
> index 000000000000..922317969ab5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
> @@ -0,0 +1,81 @@
> +Brcmstb PCIe Host Controller Device Tree Bindings
> +
> +Introduction:
> +
> +The brcmstb host controller closely follows the example set in
> +
> +	[1] http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge
> +
> +The rest of this document explains some added customizations and
> +offers an example Brcmstb PCIe host controller DT node.
> +
> +Required Properties:
> +  reg -- the register start address and length for the PCIe block.
> +      Additional start,length pairs may be specified for clock addresses.
> +  interrupts -- this must be specified but it is used indirectly.  Interrupt
> +      zero must be specified; the Brcmstb driver code uses this interrupt
> +      to determine the offset used for all interrupts, specifically, those
> +      listed in interrupt-map.

The description for "interrupts" is lacking. You don't mention here
what the interrupt names are supposed to be, how many interrupts there
are and which functions they are connected to.

> +  ranges -- See [1]; a specification of the outbound windows for the host
> +      controller.  Each outbound window is described by a 7-tuple:
> +          (3 entries) -- PCIe space start address (0th entry is ignored).

The "(0th entry is ignored)" makes no sense

> +          (2 entries) -- CPU/System start address

Strictly speaking, this is the address relative to the parent node, not to
the root. The binding for a device should not care about where in the DT
that device is located.

> +          (2 entries) -- Size of region.
> +      Due to hardware limitations, there may be a maximum of four windows
> +      specified.

I see that the example lists two separate non-prefetchable areas. It would
be good to mention what types of mappings are valid for this device, in
particular whether prefetchable, 64-bit or I/O space are possible.

I would also mention whether the ranges for this driver are meant to
describe what windows are set up by the boot loader, or whether they
describe the windows that the driver itself needs to set up.

> +  #interrupt-cells -- number of cells used to describe the interrupt.
> +  interrupt-map -- See [1]; each interrupt requires 7 entries, and
> +      currently all but the fifth entry (order 0) -- the interrupt
> +      number -- is ignored.  There must be four interrupts specified
> +      for the PCI's INTA, INTB, INTC, and INTD.

This does not describe the relevant properties, and the part it describes
looks wrong. I think you should just refer to the generic PCI binding
that describes how IRQs get mapped for the odd cases e.g. when you
have a PCIe-PCI bridge and a PCI slot IRQ line is connected to a GPIO.

Also, the '7' entries here only makes sense if #address-cells for the
parent is '2'.

> +Optional Properties:
> +  interrupt-names -- names of the interrupts listed in the interrupt map.
> +  clocks -- list of clock phandles.  If specified, this should list one
> +      clock.
> +  clock-names -- the "local" names of the clocks specified in 'clocks'.  Note
> +      that if the 'clocks' property is given, 'clock-names' is mandatory,
> +      and the name of the clock is expected to be "sw_pcie".

Replace underscores with dashes, as in "sw-pcie". What is "sw" anyway?

> +  brcm,ssc -- (boolean) indicates usage of spread-spectrum clocking.
> +  brcm,gen --  (integer) indicates desired generation of link:
> +      1 => 2.5 Gbps, 2 => 5.0 Gbps, 3 => 8.0 Gbps.

Shouldn't the link generation be probed automatically?

> +  supply-names -- the names of voltage regulators that the root
> +      complex should turn off/on/on on suspend/resume/boot.  This
> +      is a string list.
> +  supplies -- A collection of phandles to a regulator nodes, see
> +	Documentation/devicetree/bindings/regulator/ for specific
> +	bindings. The number and order of phandles must match
> +	exactly the number of strings in the "supply-names" property.

This does not follow the binding for regulators. Please change
this to match what others do.

> +Example Node:
> +
> +	pcie at f0460000 {
> +		reg = <0x0 0xf0460000 0x0 0x9310>;

		regs

> +		interrupts = <0x0 0x0 0x4>;
> +		compatible = "brcm,pci-plat-dev";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		ranges = <0x02000000 0x00000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x08000000
> +			  0x02000000 0x00000000 0x08000000 0x00000000 0xc8000000 0x00000000 0x08000000>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0xf800 0 0 7>;
> +		interrupt-map = <0 0 0 1 &intc 47 3
> +				 0 0 0 2 &intc 48 3
> +				 0 0 0 3 &intc 49 3
> +				 0 0 0 4 &intc 50 3>;

Please reformat the lists to look like

		ranges = <0x02000000 0x00000000 0x00000000  0x00000000 0xc0000000  0x00000000 0x08000000>
			  <0x02000000 0x00000000 0x08000000  0x00000000 0xc8000000  0x00000000 0x08000000>;
		interrupt-map = <0 0 0 1  &intc  47 3>,
				 <0 0 0 2  &intc  48 3>,
				 <0 0 0 3  &intc  49 3>,
				 <0 0 0 4  &intc  50 3>;


> +		interrupt-names = "pcie_0_inta",
> +				  "pcie_0_intb",
> +				  "pcie_0_intc",
> +				  "pcie_0_intd";

interrupt-names is misplaced here, you only have one entry in the "interrupts"
property, and is different from the "inta" in your interrupt-map.

	Arnd
