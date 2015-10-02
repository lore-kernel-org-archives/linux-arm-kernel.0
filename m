From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 03 Oct 2015 00:12:25 +0200
Subject: [PATCH] arm-soc: Add Sigma Designs Tango4 port
In-Reply-To: <560EFDB3.9010305@free.fr>
References: <560EAA7C.3070302@free.fr> <5124277.UR9sg1IOHT@wuerfel>
 <560EFDB3.9010305@free.fr>
Message-ID: <11113740.WL812ZaRcZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 October 2015 23:57:07 Mason wrote:
> On 02/10/2015 23:11, Arnd Bergmann wrote:
> > On Friday 02 October 2015 22:53:11 Mason wrote:

> > The line you have there is not needed, but it would be nice to have
> > a link to the data sheet (if available) and some information about
> > what SoCs they are.
> 
> I'll ask, but I'm afraid there is no public documentation :-(
> 
> Is this the place to state that Tango4 SoCs are based on
> ARM Cortex A9 MPCore? (Whereas Tango3 was based on MIPS.)

Yes.


> >> (Why doesn't arm do it like mips, with per-manufacturer folders?)
> > 
> > Historic mistake on our side, and it's become too hard to fix now
> > without breaking hundreds of patches that people are trying to
> > get merged.
> 
> OK. And even new platforms are not put in a separate folder?
> (For consistency, I imagine.)

Right.

> >>>> diff --git a/arch/arm/boot/dts/tango4.dtsi b/arch/arm/boot/dts/tango4.dtsi
> >>>> new file mode 100644
> >>>> index 000000000000..7336fcc3ac1d
> >>>> --- /dev/null
> >>>> +++ b/arch/arm/boot/dts/tango4.dtsi
> >>>> @@ -0,0 +1,117 @@
> >>>> +#include <dt-bindings/interrupt-controller/irq.h>
> >>>> +
> >>>> +/ {
> >>>> +	compatible = "sigma,tango4-soc";
> >>>
> >>> Move the root compatible strings into the board specific file,
> >>> and add the name of the machine as a more specific one.
> >>
> >> I don't understand this.
> > 
> > The compatible list should list both generic and specific names
> > if applicable. For an SoC based platform, that almost always
> > translates into board name, soc name and sometimes soc family name.
> 
> In my case,
> board name = vantage-1172
> soc name would be the specific package? "SMP8758"
> soc family name would be tango4? or just tango? tangox?
> 
> Note1: the same DT should work on "SMP8756" (single core Tango4)
> Note2: Mans is using a slightly different package (SMP8759 IIUC)

As many of them as you find reasonable. I don't know if the 'x' in
tangox is just a wildcard of if that is the official name of the SoC
line. If it's a wildcard, don't put it into a compatible string.

It could be something like

	compatible = "sigma,tango4-smp8758-vantage-1172", "sigma,tango4-vantage-1172",
			"sigma,tango4", "sigma,tango";

> >>>> +		eth0: eth0 {
> >>>> +			compatible = "sigma,smp8640-emac";
> >>>> +			reg = <0x26000 0x800>;
> >>>> +			interrupts = <38 4>;
> >>>> +			interrupt-parent = <&irq0>;
> >>>> +			mac-address = [ 00 16 e8 02 08 42 ];
> >>>> +			clocks = <&sysclk>;
> >>>> +		};
> >>>> +
> >>>> +		intc: intc at e000 {
> >>>> +			compatible = "sigma,tango-intc";
> >>>> +			reg = <0x6e000 0x1000>;
> >>>> +			interrupt-parent = <&gic>;
> >>>> +			interrupt-controller;
> >>>> +			#address-cells = <1>;
> >>>> +			#size-cells = <1>;
> >>>> +
> >>>> +			irq0: irq0 at 000 {
> >>>> +				reg = <0x000 0x100>;
> >>>> +				interrupt-controller;
> >>>> +				#interrupt-cells = <2>;
> >>>> +				interrupts = <0 2 4>;
> >>>> +			};
> >>>
> >>> You are missing a ranges property that describes what address
> >>> space these addresses are in.
> >>
> >> ranges; is not hierarchically inherited?
> > 
> > 'ranges;' would be wrong here, as the interrupt controller is
> > not a bus. If you have no ranges property, the bus is interpreted
> > as having its own address space with no relation to the parent bus
> > (e.g. an I2C bus uses addresses that are not memory mapped).
> > 
> > Just list the addresses that are actually decoded by child
> > devices here.
> 
> Sorry, I really don't understand the "ranges" property.
> I used "subsections" like "clocks" and "soc" to group related
> nodes together, not because they require special handling
> for address translation, or some other need.
> 
> I mean the gic is at physical address 0x20000600, and
> the UART is at physical address 0x10700. I was going to
> say there is nothing different, but that's not completely
> accurate. Talking to the GIC doesn't leave the CPU, while
> talking to the UART goes over the global bus.
> 
> But the interrupt-controller is no different than the
> UART or eth. Why does this one need special care and
> not the others?

The intc at e000 (interrupt-controller at 6e000 really) node has child nodes, the
other devices are leaf nodes.

If you want to interpret the "reg" property of the irq0 at 000
(interrupt-controller at 0) node, you need to know how the 000 translates
into an address of the root bus.

I assume you meant to write

	ranges = <0 0x6e000 0x300>;

to say that address 0x000 of the child node is at address 0x6e000 of the parent
bus.

> >>>> diff --git a/arch/arm/boot/dts/vantage-1172.dts b/arch/arm/boot/dts/vantage-1172.dts
> >>>> new file mode 100644
> >>>> index 000000000000..56f6babe7093
> >>>> --- /dev/null
> >>>> +++ b/arch/arm/boot/dts/vantage-1172.dts
> >>>> @@ -0,0 +1,8 @@
> >>>> +/dts-v1/;
> >>>> +
> >>>> +#include "tango4.dtsi"
> >>>> +
> >>>> +&eth0 {
> >>>> +	phy-connection-type = "rgmii";
> >>>> +	max-speed = <1000>;
> >>>> +};
> >>>
> >>> You should normally have /chosen and /aliases nodes here as well.
> >>
> >> Sigh. I don't know what they are for.
> >> http://devicetree.org/Device_Tree_Usage#Special_Nodes
> >>
> >> So with aliases, I don't need to define labels in the .dtsi?
> > 
> > labels are always optional, you can write the aliases node using
> > either labels or open-coded paths, like
> 
> I meant: in the .dtsi I wrote e.g eth0: eth0 (making an eth0
> label) just so I could write &eth0 in the .dts
> If I define the eth0 alias, I don't need the label anymore?
> Sorry for these dumb questions. In my head, DT is really a
> mess of arbitrary rules (thus hard to follow).

The aliases are mainly useful when something else refers to them.
uart drivers tend to use them to pick the right minor device numbers,
but a lot of other drivers don't look at them.

The stdout-path property can use the alias.

> > /aliases {
> > 	serial0 = &uart_3;
> > 	serial1 = "/soc/serial at 10700";
> > };
> >  
> >> "Typically the chosen node is left empty in .dts source files and populated at boot time."
> >> Should I put my current bootargs there?
> > 
> > I would put only the stdout-path property in there, as long as you can
> > boot with any bootargs.
> 
> I'm pretty sure I have to specify the amount of memory Linux
> can use. (I do that on the command line now.)
> My current boot command is:
> ip=dhcp root=/dev/nfs rdinit=/none console=ttyS0,115200 mem=640M debug

The mem= and console= arguments should not be needed here and go through
other nodes (/memory/reg and /chosen/stdout-path). "debug" should not
be part of this normally, and the rootfs should be set by the bootloader
according to its configuration.

> >>>> diff --git a/arch/arm/mach-tangox/Kconfig b/arch/arm/mach-tangox/Kconfig
> >>>> new file mode 100644
> >>>> index 000000000000..152cdd487056
> >>>> --- /dev/null
> >>>> +++ b/arch/arm/mach-tangox/Kconfig
> >>>> @@ -0,0 +1,12 @@
> >>>> +# Tango3 was based on MIPS 74kf. Tango4 is based on ARM Cortex A9 MPCore.
> >>>> +
> >>>> +config ARCH_TANGOX
> >>>> +	bool "Sigma Designs Tango4 (SMP87xx)" if ARCH_MULTI_V7
> >>>> +	select ARCH_HAS_HOLES_MEMORYMODEL
> >>>> +	select ARM_ERRATA_754322
> >>>> +	select ARM_ERRATA_764369 if SMP
> >>>> +	select ARM_GIC
> >>>> +	select GENERIC_IRQ_CHIP
> >>>> +	select HAVE_ARM_SCU
> >>>> +	select HAVE_ARM_TWD
> >>>> +	select SERIAL_8250_RT288X if SERIAL_8250
> >>>
> >>> Do not 'select' the uart driver, that can just be part of the defconfig
> >>> file.
> >>
> >> Do you mean I should provide a defconfig with my patch?
> >>
> >> Picking SERIAL_8250 but not SERIAL_8250_RT288X makes the kernel
> >> panic. Doesn't that qualify for selecting it? (I don't understand
> >> the rationale behind most conventions in kernel dev.)
> > 
> > Add it to multi_v7_defconfig
> 
> OK. And I can make a tango4_defconfig too, right?

I'd make a tangox_defconfig, if there is (or will likely be) a tango5 that
is compatible enough to work with the same kernel. We try to have only
one defconfig per vendor, to keep the amount of our own testing on defconfig
files reasonable.

	Arnd
