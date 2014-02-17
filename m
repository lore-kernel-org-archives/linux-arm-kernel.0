From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 17 Feb 2014 16:57:11 +0000
Subject: [PATCH 02/18] arm64: GICv3 device tree binding documentation
In-Reply-To: <20140217012120.GC21070@cbox>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-3-git-send-email-marc.zyngier@arm.com>
 <20140217012120.GC21070@cbox>
Message-ID: <53023F66.8040709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/14 01:21, Christoffer Dall wrote:
> On Wed, Feb 05, 2014 at 01:30:34PM +0000, Marc Zyngier wrote:
>> Add the necessary documentation to support GICv3.
>>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  Documentation/devicetree/bindings/arm/gic-v3.txt | 81 ++++++++++++++++++++++++
>>  1 file changed, 81 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/gic-v3.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/gic-v3.txt b/Documentation/devicetree/bindings/arm/gic-v3.txt
>> new file mode 100644
>> index 0000000..93852f6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/gic-v3.txt
>> @@ -0,0 +1,81 @@
>> +* ARM Generic Interrupt Controller, version 3
>> +
>> +AArch64 SMP cores are often associated with a GICv3, providing private
>> +peripheral interrupts (PPI), shared peripheral interrupts (SPI),
>> +software generated interrupts (SGI), and locality-specific peripheral
>> +Interrupts (LPI).
> 
> Super-over-ridiculous-nit: capitalize the definitions, e.g. Private
> Peripheral Interrupts (PPI)

Sure.

>> +
>> +Main node required properties:
>> +
>> +- compatible : should at least contain  "arm,gic-v3".
>> +- interrupt-controller : Identifies the node as an interrupt controller
>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>> +  interrupt source. Must be a single cell with a value of at least 3.
>> +
>> +  The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
>> +  interrupts. Other values are reserved for future use.
>> +
>> +  The 2nd cell contains the interrupt number for the interrupt type.
>> +  SPI interrupts are in the range [0-987]. PPI interrupts are in the
>> +  range [0-15].
>> +
>> +  The 3rd cell is the flags, encoded as follows:
>> +	bits[3:0] trigger type and level flags.
>> +		1 = edge triggered
>> +		2 = edge triggered (deprecated, for compatibility with GICv2)
>> +		4 = level triggered
>> +		8 = level triggered (deprecated, for compatibility with GICv2)
>> +
>> +  Cells 4 and beyond are reserved for future use. Where the 1st cell
>> +  has a value of 0 or 1, cells 4 and beyond act as padding, and may be
>> +  ignored. It is recommended that padding cells have a value of 0.
> 
> another-super-nit: Saying "If the 1st cell" or "When the 1st cell"
> sounds more clear to me, but I may be wrong.

Works for me.

>> +
>> +- reg : Specifies base physical address(s) and size of the GIC
>> +  registers, in the following order:
>> +  - GIC Distributor interface (GICD)
>> +  - GIC Redistributors (GICR), one range per redistributor region
>> +  - GIC CPU interface (GICC)
>> +  - GIC Hypervisor interface (GICH)
>> +  - GIC Virtual CPU interface (GICV)
>> +
>> +  GICC, GICH and GICV are optional.
>> +
>> +- interrupts : Interrupt source of the VGIC maintenance interrupt.
>> +
>> +Optional
>> +
>> +- redistributor-stride : If using padding pages, specifies the stride
>> +  of consecutive redistributors. Must be a multiple of 64kB.
> 
> How is this going to be used?  What would the size of the padding then
> be?  I couldn't find anything about this in the specs.
> 
> Or does this mean the total size of the set of contiguous pages for each
> of the redistributors?  That seems to make the math in the example below
> work.

Indeed. This is to allow overriding of the size of a single
redistributor. The driver will follow the spec to the letter (two or
four 64k pages, depending on GICR_TYPER.VLPI), except when this
parameter is present.

>> +
>> +- #redistributor-regions: The number of independent contiguous regions
>> +  occupied by the redistributors. Required if more than one such
>> +  region is present.
>> +
>> +Examples:
>> +
>> +	gic: interrupt-controller at 2cf00000 {
>> +		compatible = "arm,gic-v3";
>> +		#interrupt-cells = <3>;
>> +		interrupt-controller;
>> +		reg = <0x0 0x2f000000 0 0x10000>,	// GICD
>> +		      <0x0 0x2f100000 0 0x200000>,	// GICR
>> +		      <0x0 0x2c000000 0 0x2000>,	// GICC
>> +		      <0x0 0x2c010000 0 0x2000>,	// GICH
>> +		      <0x0 0x2c020000 0 0x2000>;	// GICV
>> +		interrupts = <1 9 4>;
>> +	};
>> +
>> +	gic: interrupt-controller at 2c010000 {
>> +		compatible = "arm,gic-v3";
>> +		#interrupt-cells = <3>;
>> +		interrupt-controller;
>> +		redistributor-stride = 0x40000;		// 256kB stride
> 
> I raised the point in patch 1 about the stide value being read as a
> 64-bit value, which would imply that the example should be the
> following, I think:
> 
> +		redistributor-stride = <0x0 0x40000>;		// 256kB stride

Indeed. I'll fix this.

Thanks for the review,

	M.
-- 
Jazz is not dead. It just smells funny...
