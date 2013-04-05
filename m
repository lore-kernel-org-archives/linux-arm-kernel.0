From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Apr 2013 16:36:56 +0200
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <20130405155149.0b00a592@skate>
References: <20130405150200.7b6dee63@skate> <201304051517.26838.arnd@arndb.de>
 <20130405155149.0b00a592@skate>
Message-ID: <201304051636.56410.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Thomas Petazzoni wrote:
> On Fri, 5 Apr 2013 15:17:26 +0200, Arnd Bergmann wrote:
> > On Friday 05 April 2013, Thomas Petazzoni wrote:
> > I don't have a good solution. Maybe we can work around this with the
> > new preprocessor support by letting the board file provide a macro
> > with the actual size?
> 
> The thing is that we don't know how many NOR, FPGA and other device-bus
> devices the board will use. So you mean we should define a size of 0 by
> default (in which case no window would be created), and if a board
> overrides that with a non-zero value, then we would use that one?
> 
> I don't find the solution of using pre-processor magic to do that very
> pretty. The 'inheritance' property of the DT normally solves that
> nicely... but since we're encoding everything with ranges, it doesn't
> work very well.

Right.

> Maybe the 'ranges' property should not contain any static window
> definition at all, and instead some other DT properties would define
> the windows, and the 'ranges' property would be reconstructed by the
> mbus driver at initialization time? I admit I would really prefer if
> windows were described by name ("pcie0.0", "devbus-cs0", "bootrom")
> instead of by encoding the target/attribute values in the DT. This
> would make the DT a lot easier to read, understand and modify by people
> porting the kernel to new boards. But using a name is not possible in
> the 'ranges' property.

Yes, that is unfortunately something we cannot change any more.
Setting up a minimum number of windows from a different property
would be possible, but I don't see a strong reason to do that
instead of using the ranges property for it.

> > Another option would be to not map them by default but let the
> > mbus driver do as many mappings as possible at boot time based
> > on the devices that are actually present as children of the mbus
> > device and not marked as status="disabled".
> 
> So the 'ranges' property would be more or less empty? How would the
> mbus driver know the target/attribute values for each window?

I think ideally the ranges property would be completely empty
(absent actually, but that is a detail) at boot, and the mbus driver
would fill the ranges property as needed. I can see two ways to
do that:

a) The mbus driver does a for_each_child_of_node() loop to iterate
through its children and allocates a new physical address for each
"reg" property it finds on all devices that are not status="disabled".
Since the windows are all power-of-two pages in size, a simple
"first-fit" algorith should be just fine here. The definition of 
the mbus address space guarantees that the "reg" property has
all the information needed to do that mapping.

b) We explicitly make all devices under mbus aware of the fact that
they they are on mbus, and export a function that they have to call
to map the window, like

	phys_addr_t mbus_map_reg(struct device_node *dn, int index);

The mbus driver then allocates a free physical address (as in a)) and
maps the window based on the address referred to by the reg property.

We can add a convenience function that combines this with request_resource
and ioremap for drivers that would do those anyway.

> > Do you know which children of the mbus node (if any) we actually
> > need to access before initializing mbus?
> 
> I'm sorry but I don't understand this question. There's nothing to do
> to 'initialize mbus'. We can add/remove address decoding windows
> whenever we want.

Well, we have to set up the windows at one point during the boot process,
and we cannot access anything behind the windows until they are set up.

So if for instance the UART we use for DEBUG_LL is behind an MBUS window,
we cannot easily change its address. My question is which devices fall
into this category, if any.

> > >  * I am not sure to understand why the nand, crypto and pcie-controller
> > >    nodes are outside of the internal registers. Well, I understand it's
> > >    because those devices need a special address decoding window. But it
> > >    sounds strange because those devices also have internal registers
> > >    (which is why Jason used 'MAPDEF_INTERNAL + offset' in the reg
> > >    property).
> > > 
> > >    Is this really the desired DT binding?
> > 
> > I don't understant what "internal registers" mean in this context.
> 
> On Marvell HW, the physical address space is split in multiple windows:
> PCIe memory, PCIe I/O, mapping of NOR, mapping of FPGA, special
> memories like crypto-engine SRAM, etc. One very special window is
> called the 'internal registers window'. It is set up by the bootloader,
> and contains all the registers for all the devices: UART, PCIe
> interfaces, USB, SDIO, Ethernet, everything. All the 0xd00yyyyy
> addresses in the current Armada 370/XP .dts(i) are part of the internal
> registers window.

Ok, I see. Two follow-up questions:

Does the internal registers window contain the MMIO space of the mbus
device as well?

Do you expect that we always need just one window to map all the internal
registers, or would there be a reason to split it up into multiple windows
to reduce the amount of physical address space consumed?

> > I think it would be much nicer to express the specific mbus target using
> > the ranges properties of the device nodes in PCI. Maybe I'm missing what
> > the problem is here. 
> 
> Hum, this has already been discussed when doing the PCIe driver.
> 
> Basically it's not possible because the target/attribute values are per
> PCIe interface, while the ranges we need to PCIe are *global*. Since we
> don't know how much memory and I/O each PCIe interface will need, we
> can't provision the right windows statically in the DT. The windows are
> created dynamically by the PCIe driver depending on what gets
> enumerated on the downstream bus.
> 
> So in the DT we have *one* global range for PCIe memory and *one* global
> range for PCIe I/O.
> 
> But then, the PCIe driver needs to know for *each* PCIe interface what
> is the right target/attribute tuple to create a memory or I/O window
> for that particular interface.
> 
> Does that make sense?

I don't get it yet. I would assume that each PCIe port maps exactly to
one address window, which solves the problem you describe above very
nicely. We can do away with the fake "one range for memory" concept
and just let the mbus driver pick any physical address when we enable
or hot-plug one of the ports.

> > > I already have some basic code in the mvebu-mbus driver that parses the
> > > ranges = <...> property and creates the corresponding windows, it seems
> > > to work fine.
> > 
> > Ok, nice! So I guess the next step is to dynamically insert additional
> > ranges for devices that are only mapped at run time, right?
> 
> What would be the need of this? Nobody will ever read the 'ranges'
> property again at runtime, so why bother? Of course, if you need it for
> good DT-compliance, I'll do it, but I don't see the point of having
> kernel code to update a data structure that will never be read again by
> anybody else.

The ranges properties are required so a device driver can call of_iomap().
Without it, there is no way to convert an address in mbus space into a
CPU phys_addr_t.

	Arnd
