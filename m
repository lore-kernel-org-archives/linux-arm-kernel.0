From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 5 Apr 2013 09:37:03 +0200
Subject: [PATCH v3 07/12] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <515DF096.2000703@wwwdotorg.org>
References: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
 <1365000318-28256-8-git-send-email-thierry.reding@avionic-design.de>
 <515DF096.2000703@wwwdotorg.org>
Message-ID: <20130405073703.GB15848@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 04, 2013 at 03:28:54PM -0600, Stephen Warren wrote:
[...]
> > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> 
> > +Required properties:
> 
> > +- interrupts: the interrupt outputs of the controller
> > +- interrupt-names: list of names to identify interrupts
> 
> The specification part of this file should define which interrupt
> outputs must be included in this list, and the order they must appear in
> the list.

Okay, I can add such a description similar to what you propose below for
the clocks and clock-names properties. Something like this:

- interrupts: A list of interrupt outputs of the controller. Must contain an
  entry for each entry in the interrupt-names property.
- interrupt-names: Must include the following entries:
  "intr": The Tegra interrupt that is asserted for controller interrupts
  "msi": The Tegra interrupt that is asserted when an MSI is received

Would that be acceptable?

I should probably update the reg properties in a similar way. Maybe like
so:

- reg: A list of physical base address and length for each set of controller
  registers. Must contain an entry for each entry in the reg-names property.
- reg-names: Must include the following entries:
  "pads": PADS registers
  "afi": AFI registers
  "cs": configuration space region

> I believe that the entries in the interrupts property must
> have a defined order, so I'm not sure whether interrupt-names is useful
> here?

Actually the interrupt-names property is there specifically so that the
order doesn't matter. The driver uses platform_get_irq_byname(), using
"intr" and "msi" respectively so that they don't have to appear in a
specific order. I did this so that it is more in line with properties
such as clocks and reg.

> > +- ranges: describes the translation of addresses for root ports
> 
> Shouldn't there be some discussion re: how the range are expected to be
> set up so that everything works? We shouldn't expect people to just
> blindly copy the example without any way of understanding it.

Possibly. I wouldn't like to go too much into the details, though, since
the ranges property is not only rather complex but also well documented
in other places. But I could add some explanation about which entries
are expected and how they work together. In this case even order is
important. The port register entries need to be listed before the
non-prefetchable memory window entry, otherwise the ranges parser gets
confused. How does the following sound?

- ranges: Describes the translation of addresses for root ports and standard
  PCI regions. The entries must be 6 cells each, where the first three cells
  correspond to the address as described for the #address-cells property
  above, the fourth cell is the physical CPU address to translate to and the
  fifth and six cells are as described for the #size-cells property above.
  - The first two entries are expected to translate the addresses for the root
    port registers, which are referenced by the assigned-addresses property of
    the root port nodes (see below).
  - The remaining entries setup the mapping for the standard I/O, memory and
    prefetchable PCI regions. The first cell determines the type of region
    that is setup:
    - 0x81000000: I/O memory region
    - 0x82000000: non-prefetchable memory region
    - 0xc2000000: prefetchable memory region
  Please refer to the standard PCI bus binding document for a more detailed
  explanation.

> > +- clocks: the clock inputs of the controller
> > +- clock-names: list of names to identify clocks
> 
> The specification part of this file should define which clocks are
> required, and not rely on the example below to do this. I would suggest
> re-writing this as:
> 
> - clocks : Must contain an entry for each entry in clock-names.
> - clock-names : Must include the following entries:
>   "pex" (The Tegra clock of that name)
>   "afi" (The Tegra clock of that name)
>   "pcie_xclk" (The Tegra clock of that name)
>   "pll_e" (The Tegra clock of that name)

Okay, sounds good. Although the Tegra clocks are named somewhat
differently. "pex" is named "pcie" and "pcie_xclk" is "unassigned" (!)
according to the nvidia,tegra20-car.txt binding document. Perhaps I
should update the binding document to replace unassigned with pcie_xclk
for clock 74. And maybe rename pex in the PCIe binding to pcie to match
the CAR binding?

> > +Root ports are defined as subnodes of the PCIe controller node.
> > +
> > +Required properties:
> ...
> > +- ranges: sub-ranges distributed from the PCIe controller node
> 
> Here, I think it's worth mentioning that an empty ranges is all that's
> required.

Yes, that's a good idea.

> > +Board DTS:
> > +
> > +	pcie-controller {
> > +		status = "okay";
> > +
> > +		vdd-supply = <&pci_vdd_reg>;
> > +		pex-clk-supply = <&pci_clk_reg>;
> > +
> > +		/* root port 00:01.0 */
> > +		pci at 1,0 {
> > +			status = "okay";
> 
> Is it worth putting a comment here stating that the explicit devices
> included below in this example are entirely optional?

Would it be acceptable to annotate the 01:00.0 bridge with "optional"?
Like so:

	pcie-controller {
		...
		pci at 1,0 {
			...
			/* bridge 01:00.0 (optional) */
			pci at 0,0 {
				...
			};
		};
	};

Alternatively I could add something like below:

---snip---

Note that devices on the PCI bus are dynamically discovered using PCI's bus
enumeration and therefore don't need corresponding device nodes in DT. However
if a device on the PCI bus provides a non-probeable bus such as I2C or SPI,
device nodes need to be added in order to allow the bus' children to be
instantiated at the proper location in the operating system's device tree (as
illustrated by the optional nodes in the example above).

---snip---

Maybe I'll just do both.

> > diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
> > deleted file mode 100644
> 
> Hmmm. Is this patch meant to include a change to tegra20-harmony.dtsi to
> hook up all the regulators through device tree? Same for TrimSlice?

As discussed above I think it'd be preferrable, in order to keep
dependencies simpler, to separate the changes into different patches.
Aside from the oddity on Harmony I don't think there's anything that
prevents that.

> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> 
> I think the creation of those files should be a separate patch, and
> hopefully get into 3.10 to remove any dependencies. Otherwise, 3 or 4
> different patches are all going to try and do the same thing. Didn't the
> Marvell series split out the creation of drivers/pci/host/ into a
> separate patch that's suitable for this, and could go into 3.10?

At the time when I wrote the patch to move the driver to drivers/pci,
there were no other drivers so I didn't think it necessary to split out
those changes. I had also been overly optimistic that the patches could
be merged at that point. Meanwhile there are a few more drivers that
will go into that directory, so yes they should go into a separate patch
like Thomas has done. If that makes it into 3.10, all the better.

> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> 
> I'll review that file separately later.

Okay, thanks for reviewing.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130405/43bd0056/attachment.sig>
