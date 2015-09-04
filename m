From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 04 Sep 2015 17:36:41 +0100
Subject: Porting MIPS IRQ handler to ARM
In-Reply-To: <55E9C33A.2080801@free.fr> (Mason's message of "Fri, 04 Sep 2015
 18:13:46 +0200")
References: <55E5CED8.7000408@free.fr> <55E5D945.3040504@gmail.com>
 <55E722F2.50905@free.fr> <yw1xy4goyc3z.fsf@unicorn.mansr.com>
 <55E73971.8030406@free.fr> <55E9C33A.2080801@free.fr>
Message-ID: <yw1x8u8mxht2.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 02/09/2015 20:01, Mason wrote:
>
>> On 02/09/2015 19:17, M?ns Rullg?rd wrote:
>> 
>>> Use the latest DT from my tree.  It looks like you're missing some
>>> changes.
>> 
>> Indeed, my repo is not up-to-date. (I was vaguely worried that you'd
>> have made further changes that I'd have to revert when back-porting
>> to 3.14)
>> 
>> I'll try upgrading and report back.
>> 
>> By the way, did you write the DT from scratch?
>> 
>> Are there people walking this earth that can write device tree like C?
>
> No cigar :-(
>
> There's just too much DT syntax that flies light-years over my head.
> #address-cells, #size-cells, #interrupt-cells, ranges, aliases, etc.
> Basically, all I understand is /dts-v1/;
> (Anyone have links to good tutorials?)
>
> I've attached the current version I'm playing with (I tried to make it
> as small as possible). If some charitable soul spots an obvious problem...
> (Commented blocks have been tested uncommented, of course.)

What happens when you try to boot with this device tree?

> /dts-v1/;
>
> / {
> 	compatible = "sigma,tango4-soc";
>
> 	#address-cells = <1>;
> 	#size-cells = <1>;
>
> 	gic: interrupt-controller at 20001000 {
> 		compatible = "arm,cortex-a9-gic";
> 		interrupt-controller;
> 		#interrupt-cells = <3>;
> 		reg = <0x20001000 0x1000>,
> 		      <0x20000100 0x0100>;
> 	};
>
> 	soc {
> 		compatible = "simple-bus";
> /*		interrupt-parent = <&irqintc>;	*/
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		ranges;
>
> 		uart0: uart at 10700 {
> 			compatible = "ns16550a";
> 			reg = <0x10700 0x100>;
> 			clock-frequency = <7372800>;
> 			reg-shift = <2>;
> 			no-loopback-test;
> 		};
> 	};
>
> 	cpublock: cpublock {
> 		compatible = "simple-bus";
> 		reg = <0x60000 0x10000>;
> 		ranges = <0x0 0x60000 0x10000>;
> /*		interrupt-parent = <&irqintc>;	*/
> 		#address-cells = <1>;
> 		#size-cells = <1>;
>
> 		intc: intc at e000 {
> 			compatible = "sigma,tango-intc";
> 			reg = <0xe000 0x1000>;
> 			ranges = <0x0 0xe000 0x1000>;

Are you sure these addresses are correct?  Those are the values from
tango3.

> 			interrupt-parent = <&gic>;
> 			interrupt-controller;
> 			#address-cells = <1>;
> 			#size-cells = <1>;
>
> 			irqintc: irq at 000 {
> 				reg = <0x000 0x100>;
> 				interrupt-controller;
> 				#interrupt-cells = <2>;
> 				interrupts = <2>;

This "interrupts" specification is wrong for a source wired into the
GIC.  For the correct format, see the binding spec in
Documentation/devicetree/bindings/arm/gic.txt:

  The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
  interrupts.

  The 2nd cell contains the interrupt number for the interrupt type.
  SPI interrupts are in the range [0-987].  PPI interrupts are in the
  range [0-15].

  The 3rd cell is the flags, encoded as follows:
	bits[3:0] trigger type and level flags.
		1 = low-to-high edge triggered
		2 = high-to-low edge triggered (invalid for SPIs)
		4 = active high level-sensitive
		8 = active low level-sensitive (invalid for SPIs).
	bits[15:8] PPI interrupt cpu mask.  Each bit corresponds to each of
	the 8 possible cpus attached to the GIC.  A bit set to '1' indicated
	the interrupt is wired to that CPU.  Only valid for PPI interrupts.
	Also note that the configurability of PPI interrupts is IMPLEMENTATION
	DEFINED and as such not guaranteed to be present (most SoC available
	in 2014 seem to ignore the setting of this flag and use the hardware
	default value).

The correct values for these three fields should be available in your
datasheet.

> 				label = "IRQ";
> 			};
>
> /*
> 			fiqintc: fiq at 100 {
> 				reg = <0x100 0x100>;
> 				interrupt-controller;
> 				#interrupt-cells = <2>;
> 				interrupts = <3>;
> 				label = "FIQ";
> 			};
>
> 			iiqintc: iiq at 300 {
> 				reg = <0x300 0x100>;
> 				interrupt-controller;
> 				#interrupt-cells = <2>;
> 				interrupts = <4>;
> 				label = "IIQ";
> 			};
> */
> 		};
> 	};
>
> };

-- 
M?ns Rullg?rd
mans at mansr.com
