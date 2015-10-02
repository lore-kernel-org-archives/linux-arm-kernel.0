From: slash.tmp@free.fr (Mason)
Date: Fri, 2 Oct 2015 22:53:11 +0200
Subject: [PATCH] arm-soc: Add Sigma Designs Tango4 port
In-Reply-To: <1563018.pqIIbZENJL@wuerfel>
References: <560EAA7C.3070302@free.fr> <1563018.pqIIbZENJL@wuerfel>
Message-ID: <560EEEB7.909@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2015 21:56, Arnd Bergmann wrote:
> On Friday 02 October 2015 18:02:04 Mason wrote:
>> Add support for Tango4-based SoCs (SMP8756, SMP8758)
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> 
> Please write a proper changelog text here that tells us more about
> the patch than the subject line.

Sorry, I'm quite unimaginative. What kind of information do you
consider required?

>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -605,6 +605,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>>  dtb-$(CONFIG_MACH_SUN9I) += \
>>  	sun9i-a80-optimus.dtb \
>>  	sun9i-a80-cubieboard4.dtb
>> +dtb-$(CONFIG_ARCH_TANGOX) += \
>> +	vantage-1172.dtb
> 
> This file name should start with the name of the chip,
> e.g. 'tango4-vantage-1172.dtb', to make it easier to find.

OK.

(Why doesn't arm do it like mips, with per-manufacturer folders?)

>> diff --git a/arch/arm/boot/dts/tango4.dtsi b/arch/arm/boot/dts/tango4.dtsi
>> new file mode 100644
>> index 000000000000..7336fcc3ac1d
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/tango4.dtsi
>> @@ -0,0 +1,117 @@
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +/ {
>> +	compatible = "sigma,tango4-soc";
> 
> Move the root compatible strings into the board specific file,
> and add the name of the machine as a more specific one.

I don't understand this.

>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +
>> +		xtal_in_cnt {
>> +			compatible = "sigma,xtal_in_cnt";
>> +			reg = <0x10048 0x4>;
>> +			clocks = <&xtal>;
>> +		};
>> +
>> +		uart0 {
>> +			compatible = "ralink,rt2880-uart";
>> +			reg = <0x10700 0x100>;
>> +			clock-frequency = <7372800>;
>> +			reg-shift = <2>;
>> +/*			fifo-size = <16>; BROKEN */
>> +		};
> 
> Please use standard node names here, the uart should be
> named 'serial at 10700', the other names should be
> 'ethernet at 26000', 'interrupt-controller at 6e000' etc.

Where are the standard node names documented?

Can I still name labels freely?
Or is there a naming convention for labels?

Why is the base address duplicated? Can't the DTC figure
out the address from the reg property?

>> +		eth0: eth0 {
>> +			compatible = "sigma,smp8640-emac";
>> +			reg = <0x26000 0x800>;
>> +			interrupts = <38 4>;
>> +			interrupt-parent = <&irq0>;
>> +			mac-address = [ 00 16 e8 02 08 42 ];
>> +			clocks = <&sysclk>;
>> +		};
>> +
>> +		intc: intc at e000 {
>> +			compatible = "sigma,tango-intc";
>> +			reg = <0x6e000 0x1000>;
>> +			interrupt-parent = <&gic>;
>> +			interrupt-controller;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			irq0: irq0 at 000 {
>> +				reg = <0x000 0x100>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +				interrupts = <0 2 4>;
>> +			};
> 
> You are missing a ranges property that describes what address
> space these addresses are in.

ranges; is not hierarchically inherited?

>> +			irq1: irq1 at 100 {
>> +				reg = <0x100 0x100>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +				interrupts = <0 3 4>;
>> +			};
>> +
>> +			irq2: irq2 at 300 {
>> +				reg = <0x300 0x100>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +				interrupts = <0 4 4>;
>> +			};
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm/boot/dts/vantage-1172.dts b/arch/arm/boot/dts/vantage-1172.dts
>> new file mode 100644
>> index 000000000000..56f6babe7093
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/vantage-1172.dts
>> @@ -0,0 +1,8 @@
>> +/dts-v1/;
>> +
>> +#include "tango4.dtsi"
>> +
>> +&eth0 {
>> +	phy-connection-type = "rgmii";
>> +	max-speed = <1000>;
>> +};
> 
> You should normally have /chosen and /aliases nodes here as well.

Sigh. I don't know what they are for.
http://devicetree.org/Device_Tree_Usage#Special_Nodes

So with aliases, I don't need to define labels in the .dtsi?

"Typically the chosen node is left empty in .dts source files and populated at boot time."
Should I put my current bootargs there?

>> diff --git a/arch/arm/mach-tangox/Kconfig b/arch/arm/mach-tangox/Kconfig
>> new file mode 100644
>> index 000000000000..152cdd487056
>> --- /dev/null
>> +++ b/arch/arm/mach-tangox/Kconfig
>> @@ -0,0 +1,12 @@
>> +# Tango3 was based on MIPS 74kf. Tango4 is based on ARM Cortex A9 MPCore.
>> +
>> +config ARCH_TANGOX
>> +	bool "Sigma Designs Tango4 (SMP87xx)" if ARCH_MULTI_V7
>> +	select ARCH_HAS_HOLES_MEMORYMODEL
>> +	select ARM_ERRATA_754322
>> +	select ARM_ERRATA_764369 if SMP
>> +	select ARM_GIC
>> +	select GENERIC_IRQ_CHIP
>> +	select HAVE_ARM_SCU
>> +	select HAVE_ARM_TWD
>> +	select SERIAL_8250_RT288X if SERIAL_8250
> 
> Do not 'select' the uart driver, that can just be part of the defconfig
> file.

Do you mean I should provide a defconfig with my patch?

Picking SERIAL_8250 but not SERIAL_8250_RT288X makes the kernel
panic. Doesn't that qualify for selecting it? (I don't understand
the rationale behind most conventions in kernel dev.)

Regards.
