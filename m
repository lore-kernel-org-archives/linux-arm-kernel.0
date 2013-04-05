From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 5 Apr 2013 15:51:49 +0200
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <201304051517.26838.arnd@arndb.de>
References: <20130405150200.7b6dee63@skate> <201304051517.26838.arnd@arndb.de>
Message-ID: <20130405155149.0b00a592@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Fri, 5 Apr 2013 15:17:26 +0200, Arnd Bergmann wrote:
> On Friday 05 April 2013, Thomas Petazzoni wrote:
> 
> > ========================================================================
> > 
> > It raises the following questions:
> > 
> >  * The address decoding windows are in fact defined by the ranges =
> >    <...> property of the mbus node. Here, in the example provided by
> >    Jason, this ranges = <...> property is part of the SoC-level .dtsi.
> >    However, some boards will have to add some board-specific windows
> >    (adjusted to the size of their NOR, or FPGA, for example).
> > 
> >    As far as I know, we can 'extend' an existing property in a .dts
> >    file, we have to completely overload it. So this means that boards
> >    wanting to add an additional address decoding window will have to
> >    copy/paste the 'ranges' property from the included .dtsi file and
> >    add their own entry. This is of course possible, but it doesn't look
> >    very nice: if a new window is added in the SoC-level .dtsi file for
> >    some reason, this change will have to be replicated on all the
> >    including .dts files that overload this ranges property.
> > 
> >    Is this the intended behavior?
> 
> I don't have a good solution. Maybe we can work around this with the
> new preprocessor support by letting the board file provide a macro
> with the actual size?

The thing is that we don't know how many NOR, FPGA and other device-bus
devices the board will use. So you mean we should define a size of 0 by
default (in which case no window would be created), and if a board
overrides that with a non-zero value, then we would use that one?

I don't find the solution of using pre-processor magic to do that very
pretty. The 'inheritance' property of the DT normally solves that
nicely... but since we're encoding everything with ranges, it doesn't
work very well.

Maybe the 'ranges' property should not contain any static window
definition at all, and instead some other DT properties would define
the windows, and the 'ranges' property would be reconstructed by the
mbus driver at initialization time? I admit I would really prefer if
windows were described by name ("pcie0.0", "devbus-cs0", "bootrom")
instead of by encoding the target/attribute values in the DT. This
would make the DT a lot easier to read, understand and modify by people
porting the kernel to new boards. But using a name is not possible in
the 'ranges' property.

> Another option would be to not map them by default but let the
> mbus driver do as many mappings as possible at boot time based
> on the devices that are actually present as children of the mbus
> device and not marked as status="disabled".

So the 'ranges' property would be more or less empty? How would the
mbus driver know the target/attribute values for each window?

> Do you know which children of the mbus node (if any) we actually
> need to access before initializing mbus?

I'm sorry but I don't understand this question. There's nothing to do
to 'initialize mbus'. We can add/remove address decoding windows
whenever we want.

> >  * I am not sure to understand why the nand, crypto and pcie-controller
> >    nodes are outside of the internal registers. Well, I understand it's
> >    because those devices need a special address decoding window. But it
> >    sounds strange because those devices also have internal registers
> >    (which is why Jason used 'MAPDEF_INTERNAL + offset' in the reg
> >    property).
> > 
> >    Is this really the desired DT binding?
> 
> I don't understant what "internal registers" mean in this context.

On Marvell HW, the physical address space is split in multiple windows:
PCIe memory, PCIe I/O, mapping of NOR, mapping of FPGA, special
memories like crypto-engine SRAM, etc. One very special window is
called the 'internal registers window'. It is set up by the bootloader,
and contains all the registers for all the devices: UART, PCIe
interfaces, USB, SDIO, Ethernet, everything. All the 0xd00yyyyy
addresses in the current Armada 370/XP .dts(i) are part of the internal
registers window.

> >  * Regarding the PCIe binding, Jason Gunthorpe suggests the use of a
> >    'marvell,mbus-targets' attribute so that the PCIe driver knows what
> >    target/attribute values to use to create the window. Currently, the
> >    PCIe driver uses a name (like "pcie0.3") that it gives to the
> >    mvebu-mbus driver, which then translates this name to the real
> >    target/attribute values using per-SoC tables that associate names
> >    (pcie0.3) with values (say 0x4 / 0x42).
> > 
> >    Is this marvell,mbus-targets really the suggested solution? This
> >    would basically mean that the entire name -> value mapping tables of
> >    the driver would ultimately become useless (note that I'm not
> >    necessarily saying it is bad, I just want to check where we are
> >    going before doing useless work). Of course, those tables would
> >    remain at the beginning, once all platforms are converted to the
> >    mvebu-mbus DT binding, which may take a bit of time since it requires
> >    quite a lot of code movement in the .dtsi/.dts files.
> 
> I think it would be much nicer to express the specific mbus target using
> the ranges properties of the device nodes in PCI. Maybe I'm missing what
> the problem is here. 

Hum, this has already been discussed when doing the PCIe driver.

Basically it's not possible because the target/attribute values are per
PCIe interface, while the ranges we need to PCIe are *global*. Since we
don't know how much memory and I/O each PCIe interface will need, we
can't provision the right windows statically in the DT. The windows are
created dynamically by the PCIe driver depending on what gets
enumerated on the downstream bus.

So in the DT we have *one* global range for PCIe memory and *one* global
range for PCIe I/O.

But then, the PCIe driver needs to know for *each* PCIe interface what
is the right target/attribute tuple to create a memory or I/O window
for that particular interface.

Does that make sense?

> > I already have some basic code in the mvebu-mbus driver that parses the
> > ranges = <...> property and creates the corresponding windows, it seems
> > to work fine.
> 
> Ok, nice! So I guess the next step is to dynamically insert additional
> ranges for devices that are only mapped at run time, right?

What would be the need of this? Nobody will ever read the 'ranges'
property again at runtime, so why bother? Of course, if you need it for
good DT-compliance, I'll do it, but I don't see the point of having
kernel code to update a data structure that will never be read again by
anybody else.

Thanks for your comments!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
