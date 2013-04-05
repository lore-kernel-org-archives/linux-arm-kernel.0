From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Apr 2013 15:17:26 +0200
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <20130405150200.7b6dee63@skate>
References: <20130405150200.7b6dee63@skate>
Message-ID: <201304051517.26838.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Thomas Petazzoni wrote:

> ========================================================================
> 
> It raises the following questions:
> 
>  * The address decoding windows are in fact defined by the ranges =
>    <...> property of the mbus node. Here, in the example provided by
>    Jason, this ranges = <...> property is part of the SoC-level .dtsi.
>    However, some boards will have to add some board-specific windows
>    (adjusted to the size of their NOR, or FPGA, for example).
> 
>    As far as I know, we can 'extend' an existing property in a .dts
>    file, we have to completely overload it. So this means that boards
>    wanting to add an additional address decoding window will have to
>    copy/paste the 'ranges' property from the included .dtsi file and
>    add their own entry. This is of course possible, but it doesn't look
>    very nice: if a new window is added in the SoC-level .dtsi file for
>    some reason, this change will have to be replicated on all the
>    including .dts files that overload this ranges property.
> 
>    Is this the intended behavior?

I don't have a good solution. Maybe we can work around this with the
new preprocessor support by letting the board file provide a macro
with the actual size?

Another option would be to not map them by default but let the
mbus driver do as many mappings as possible at boot time based
on the devices that are actually present as children of the mbus
device and not marked as status="disabled".

Do you know which children of the mbus node (if any) we actually
need to access before initializing mbus?

>  * I am not sure to understand why the nand, crypto and pcie-controller
>    nodes are outside of the internal registers. Well, I understand it's
>    because those devices need a special address decoding window. But it
>    sounds strange because those devices also have internal registers
>    (which is why Jason used 'MAPDEF_INTERNAL + offset' in the reg
>    property).
> 
>    Is this really the desired DT binding?

I don't understant what "internal registers" mean in this context.

>  * Regarding the PCIe binding, Jason Gunthorpe suggests the use of a
>    'marvell,mbus-targets' attribute so that the PCIe driver knows what
>    target/attribute values to use to create the window. Currently, the
>    PCIe driver uses a name (like "pcie0.3") that it gives to the
>    mvebu-mbus driver, which then translates this name to the real
>    target/attribute values using per-SoC tables that associate names
>    (pcie0.3) with values (say 0x4 / 0x42).
> 
>    Is this marvell,mbus-targets really the suggested solution? This
>    would basically mean that the entire name -> value mapping tables of
>    the driver would ultimately become useless (note that I'm not
>    necessarily saying it is bad, I just want to check where we are
>    going before doing useless work). Of course, those tables would
>    remain at the beginning, once all platforms are converted to the
>    mvebu-mbus DT binding, which may take a bit of time since it requires
>    quite a lot of code movement in the .dtsi/.dts files.

I think it would be much nicer to express the specific mbus target using
the ranges properties of the device nodes in PCI. Maybe I'm missing what
the problem is here. 

> I already have some basic code in the mvebu-mbus driver that parses the
> ranges = <...> property and creates the corresponding windows, it seems
> to work fine.

Ok, nice! So I guess the next step is to dynamically insert additional
ranges for devices that are only mapped at run time, right?

	Arnd
