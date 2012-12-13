From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Dec 2012 12:19:39 +0000
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <20121212165833.6a35a6ec@skate>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111056.58970.arnd@arndb.de> <20121212165833.6a35a6ec@skate>
Message-ID: <201212131219.39764.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 December 2012, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Tue, 11 Dec 2012 10:56:58 +0000, Arnd Bergmann wrote:
> 
> > > In addition, this driver enumerates the different PCIe slots, and
> > > for those having a device plugged in, it allocates the necessary
> > > address decoding windows, using the new
> > > armada_370_xp_alloc_pcie_window() function from
> > > mach-mvebu/addr-map.c.
> > > 
> > > Signed-off-by: Thomas Petazzoni
> > > <thomas.petazzoni@free-electrons.com>
> > 
> > It seems that this is not following the IEEE PCI bindings, which will
> > cause problems as soon as you try to connect PCI cards with bridges
> > bto it.
> 
> [...]
> 
> > A PCI host controller should set #interrupt-cells=<1>, #size-cells=<2>
> > and #address-cells=<3>, and provide an interrupt map that describes
> > how the intA-intD lines for each slot are connected to the host
> > interrupts.
> 
> As the "RFC" suggested in the title, I was of course pretty sure that
> the DT binding was not correct. However, the reason I did the DT
> binding the way I did it is because I really don't understand how to
> map the DT binding visible at http://devicetree.org/MPC5200:PCI with
> the hardware we have. I'll need a little bit of guidance to understand
> how to map our hardware features to such a DT binding. So let me
> describe briefly how the Marvell PCIe stuff works, by taking example on
> the Armada XP.
> 
> Armada XP supports 10 PCIe interfaces, each of them can physically
> correspond to a PCIe slot on the board in which you can plug a PCIe
> device.
> 
> Each of those PCIe interfaces is associated to a range of registers
> inside the SoC that are used to see if the PCIe link is up or down on
> this interface, access the PCIe configuration space of the device
> connected on this interface, get the status of PCIe interrupts, etc.
> Those registers are available at physical addresses 0xD004000,
> 0xD0042000, 0xD0044000, 0xD0048000, 0xD004C000, 0xD008000,
> 0xD0082000, 0xD0084000, 0xD0088000, 0xD008C000 (one address = one PCIe
> interface). I need to ioremap() those registers in order to interact
> with the PCIe interface, and that's the reason why I have put these
> addresses in the reg = <...> property of the DT sub-nodes in my
> proposal.

Do those ten ports have a shared I/O space window, or does each one
have its own 64K? 

Similarly, how is the config space set up: Does each port have its own
config space with 256 buses, or is there a fixed (or variable) mapping
of bus numbers to ports?

> Then, to access the PCIe device memory and I/O BARs, there are no fixed
> addresses in the CPU physical address space. The Armada XP (and other
> earlier Marvell SoCs) have a number of configurable address decoding
> windows. Those windows allow the programmer to tell the CPU that a
> window of physical addresses starting at address X of size S points to
> device D (where device D can be "PCIe interface n?8"). So, in my
> driver, I set up one PCI memory window and one PCI I/O window per PCIe
> device dynamically depending on which PCIe interfaces actually have a
> device connected to them. Since those windows are limited in number,
> and the global physical address space is limited in size, we definitely
> do not want to have static mappings at fixed physical addresses
> hardcoded in the Device Tree.

But would it be possible to put the mapping in the device tree? When
you describe a particular board, you probably know which devices
are connected to it, so it could all be put in the device tree and
set up at boot time based on the values in there.

> That's my main problem: the DT binding at
> http://devicetree.org/MPC5200:PCI seems to assume that the PCIe memory
> and I/O BARs are accessible at fixed CPU physical addresses. This is
> definitely not the case on Armada XP: the CPU physical address for a
> given device will change from one boot to another depending on how many
> PCIe interfaces actually have a device plugged into them. And we
> clearly do not want to make those addresses fixed and static. If you
> could guide me on how the approach to make those standard DT bindings
> compatible with the specificities of the Marvell hardware, it'd be nice.

Setting up the windows at run-time sounds very complicated unless
you know exactly which physical addresses are available, so I think
you should at least have information in the device tree which addresses
could be used, in some form, but leave out the mapping for the buses
that you cannot yet assign based on the information in the dts file.

> Same thing for the "interrupt mapping" thing: the "unit interrupt
> specifier" is explained at http://devicetree.org/MPC5200:PCI as "The
> only missing part for now are the weird numbers int the PCI bus unit
> interrupt specifier. Now we have to look into the schematics[6] of the
> Lite5200b board. Here you can see that the IDSEL line of PCI slot 1 is
> tied to PCI address line 24 and the IDSEL line of PCI slot 2 to PCI
> address line 25[7]. The IDSEL lines are used to determine the PCI
> device number." Again, we don't have such hardcoded relation between a
> PCIe interface and "PCI address lines", so I really don't see how to
> use this "interrupt mapping" representation.
> 
> Unfortunately, for now, the binding at
> http://devicetree.org/MPC5200:PCI does not make any sense to me
> compared to the hardware that we have. I would definitely appreciate if
> someone could enlighten me on how to properly use such bindings,
> considering the specificities of the hardware we have.

As Jason alrready commented, the hardwiring of the lines does not apply
for PCIe, which uses interrupt messages, but the IntA mapping should still
be documented in the spec for the PCIe host.

	Arnd
