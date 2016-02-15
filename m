From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 15 Feb 2016 08:45:56 +0000
Subject: ARM GIC DT binding reg block mismatch? (Re: [PATCH v11 1/8]
 arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support)
In-Reply-To: <CAMuHMdU-q++XEgthKG=XOgnaq7TY899EsgMFHuWu4Skr5woLZg@mail.gmail.com>
References: <CAMuHMdU-q++XEgthKG=XOgnaq7TY899EsgMFHuWu4Skr5woLZg@mail.gmail.com>
Message-ID: <56C19044.6050604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/16 08:16, Geert Uytterhoeven wrote:
> Cc Marz Zyngier
> Cc Dirk Behme
> Cc devicetree
> Cc linux-renesas-soc
> Drop linux-sh
> 
> On Wed, Dec 9, 2015 at 9:23 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Tue, Nov 3, 2015 at 3:28 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>> On Wed, Oct 21, 2015 at 03:34:39PM +0200, Geert Uytterhoeven wrote:
>>>> On Thu, Oct 15, 2015 at 12:58 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>>>>> +           gic: interrupt-controller at 0xf1010000 {
>>>>>> +                     compatible = "arm,gic-400";
>>>>>> +                     #interrupt-cells = <3>;
>>>>>> +                     #address-cells = <0>;
>>>>>> +                     interrupt-controller;
>>>>>> +                     reg = <0x0 0xf1010000 0 0x1000>,
>>>>>> +                           <0x0 0xf1020000 0 0x2000>;
>>>>>> +                     interrupts = <GIC_PPI 9
>>>>>> +                                     (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
>>>>>> +             };
>>>>>
>>>>> No GICH and GICV?
>>>>
>>>> These seem to be defined in the "arm,gic-v3" DT bindings only, while this is
>>>> an "arm,gic-400" (GICD_IIDR 0x0200043b)?
>>>
>>> See the "GIC virtualization extensions (VGIC)" section in
>>> Documentation/devicetree/bindings/arm/gic.txt
>>
>> DDI0471B_gic400_r0p1_trm.pdf says:
>>
>>     Address range GIC-400 functional block
>>     A. 0x0000 - 0x0FFF Reserved
>>     B. 0x1000 - 0x1FFF Distributor
>>     C. 0x2000 - 0x3FFF CPU interfaces
>>     D. 0x4000 - 0x4FFF Virtual interface control block, for the processor that
>>                        is performing the access
>>     E. 0x5000 - 0x5FFF Virtual interface control block, for the processor
>>                        selected by address bits [11:9]
>>     F. 0x6000 - 0x7FFF Virtual CPU interfaces
>>
>> The DT binding document says:
>>   1. The  first region is the GIC distributor register base and size.
>>   2. The 2nd region is the GIC cpu interface register base and size.
>>   3. The first additional region is the GIC virtual interface control register
>>      base and size.
>>   4. The 2nd additional region is the GIC virtual cpu interface register base
>>      and size.
>>
>> Matching with the example:
>>
>>         interrupt-controller at 2c001000 {
>>                 compatible = "arm,cortex-a15-gic";
>>                 #interrupt-cells = <3>;
>>                 interrupt-controller;
>>                 reg = <0x2c001000 0x1000>,
>>                       <0x2c002000 0x1000>,
>>                       <0x2c004000 0x2000>,
>>                       <0x2c006000 0x2000>;
>>                 interrupts = <1 9 0xf04>;
>>         };
>>
>> This means:
>>   - reg entry 1. covers address range B,
>>   - reg entry 2. covers address range C,
>>   - reg entry 3. covers address ranges D _and_ E,
>>   - reg entry 4. covers address range F.
>>
>> On R-Car Gen3, the base addresses are:
>>
>>     Distributor             : 0xF101_0000
>>     CPU interfaces          : 0xF102_0000
>>     Virtual interfaces      : 0xF104_0000
>>     Virtual interfaces      : 0xF105_0000
>>     Virtual CPU interfaces  : 0xF106_0000
>>
>> Note the additional multiplication factor of 16 in the offsets relative to
>> the base address 0xf1000000 (e.g. 0x50000 instead of 0x5000).
>>
>> As address ranges D and E are merged in a single reg entry, how is the GIC
>> driver supposed to know about this multiplication factor?

The answer is very simple, the GIC driver doesn't give a damn about the
second part of the GICH region, because it is absolutely unusable for
any realistic use-case. Only the banked version of GICH is of any
relevance (the first 512 bytes, in essence).

Aligning the GIC regions on 64kB boundaries is documented in the SBSA
specification, independently of the GIC400 documentation.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
