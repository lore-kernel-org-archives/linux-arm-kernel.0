From: hannah@marvell.com (Hanna Hawa)
Date: Wed, 9 Aug 2017 09:29:25 +0300
Subject: [PATCH] arm64: dts: marvell: add Device Tree files for Armada-8KP
In-Reply-To: <6017865e-e0a4-a316-45da-924af7126f91@arm.com>
References: <1502195474-9585-1-git-send-email-hannah@marvell.com>
 <6017865e-e0a4-a316-45da-924af7126f91@arm.com>
Message-ID: <022fd386-a9a9-6f9d-27a9-3a63b5a81bbf@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/08/2017 04:06 PM, Marc Zyngier wrote:
> On 08/08/17 13:31, hannah at marvell.com wrote:
>> From: Hanna Hawa <hannah@marvell.com>
>>
>> This commit adds the base Device Tree files for the Armada 8KPlus.
>> The Armada 8KP SoCs include several hardware blocks, and this
>> commit only adds support for the AP810 block, that contains the CPU
>> core and basic peripherals.
>>
>> AP810 is a high-performance die, includes octal core application
>> processor based ARMv8-A architecture, two standard high speed DDR4
>> interface, and GIC-600 interrupt controller.
>> AP810 Built as part of Marvell?s MoChi AP family products.
>>
>> Armada-8080 (8KPlus family), include an AP810 block that contains
>> the CPU core and basic peripherals.
>>
>> This commit creates the following hierarchy:
>>  * armada-ap810-ap0.dtsi - definitions common to AP810
>>  	* armada-ap810-ap0-octa-core.dtsi - description of the octa cores
>> 		* armada-8080.dtsi - description of the 8080 SoC
>> 			* armada-8080-db.dts - description of the 8080 board
>>
>> Signed-off-by: Hanna Hawa <hannah@marvell.com>
>> ---
>>  .../devicetree/bindings/arm/marvell/armada-8kp.txt |  15 ++
>>  arch/arm64/boot/dts/marvell/Makefile               |   1 +
>>  arch/arm64/boot/dts/marvell/armada-8080-db.dts     |  67 +++++++++
>>  arch/arm64/boot/dts/marvell/armada-8080.dtsi       |  53 +++++++
>>  .../dts/marvell/armada-ap810-ap0-octa-core.dtsi    | 104 ++++++++++++++
>>  arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi  | 160 +++++++++++++++++++++
>>  6 files changed, 400 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-8kp.txt
>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-8080-db.dts
>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-8080.dtsi
>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi
>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
>
> [...]
>
>> +			gic: interrupt-controller at 3000000 {
>> +				compatible = "arm,gic-v3";
>> +				#interrupt-cells = <3>;
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				interrupt-controller;
>> +				interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>
> This is wrong. There is no such thing as an affinity mask for PPI on
> GICv3 (and 4 cpus seem unrelated in the context of this HW).
I'll fix it in V2
>
>> +				ranges;
>> +
>> +				reg = <0x3000000 0x10000>,     /* GICD */
>> +				      <0x3060000 0x100000>;    /* GICR */
>
> Where is the GICv2 compatibility region (GICV)that is provided by each
> A72 cores? It should be at PERIPHBASE+0x20000 (see
> http://infocenter.arm.com/help/topic/com.arm.doc.100095_0003_06_en/way1382452674438.html).
Currently virtualization out of our focus, I add GICV region & it not 
tested.
>
>> +
>> +				gic_its_ap0: interrupt-controller at 3040000 {
>> +					compatible = "arm,gic-v3-its";
>> +					msi-controller;
>> +					#msi-cells = <1>;
>> +					reg = <0x3040000 0x20000>;
>> +				};
>> +			};
>> +
>> +			timer {
>> +				compatible = "arm,armv8-timer";
>> +				interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +					     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +					     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +					     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>
> Same issue here.
I'll fix in V2

Thank you for reviewing

Thanks,
Hanna
>
> Thanks,
>
> 	M.
>
