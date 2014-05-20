From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 20 May 2014 18:21:06 +0200
Subject: [PATCH v4 03/20] arm64: GICv3 device tree binding documentation
In-Reply-To: <8761l031q7.fsf@approximate.cambridge.arm.com>
References: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>	<1400176719-31275-4-git-send-email-marc.zyngier@arm.com>	<537B6D9E.4000801@arm.com>
 <8761l031q7.fsf@approximate.cambridge.arm.com>
Message-ID: <537B80F2.3080102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2014 05:32 PM, Marc Zyngier wrote:

Hi Marc,

>
> On Tue, May 20 2014 at  3:58:38 pm BST, Andre Przywara <andre.przywara@arm.com> wrote:
>> On 05/15/2014 07:58 PM, Marc Zyngier wrote:
>>> Add the necessary documentation to support GICv3.
>>>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/gic-v3.txt | 79
>>> ++++++++++++++++++++++++
>>>  1 file changed, 79 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/arm/gic-v3.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/gic-v3.txt
>>> b/Documentation/devicetree/bindings/arm/gic-v3.txt
>>> new file mode 100644
>>> index 0000000..33cd05e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/gic-v3.txt
>>> @@ -0,0 +1,79 @@
>>> +* ARM Generic Interrupt Controller, version 3
>>> +
>>> +AArch64 SMP cores are often associated with a GICv3, providing Private
>>> +Peripheral Interrupts (PPI), Shared Peripheral Interrupts (SPI),
>>> +Software Generated Interrupts (SGI), and Locality-specific Peripheral
>>> +Interrupts (LPI).
>>> +
>>> +Main node required properties:
>>> +
>>> +- compatible : should at least contain  "arm,gic-v3".
>>> +- interrupt-controller : Identifies the node as an interrupt controller
>>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>>> +  interrupt source. Must be a single cell with a value of at least 3.
>>> +
>>> +  The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
>>> +  interrupts. Other values are reserved for future use.
>>> +
>>> +  The 2nd cell contains the interrupt number for the interrupt type.
>>> +  SPI interrupts are in the range [0-987]. PPI interrupts are in the
>>> +  range [0-15].
>>> +
>>> +  The 3rd cell is the flags, encoded as follows:
>>> +   bits[3:0] trigger type and level flags.
>>> +           1 = edge triggered
>>> +           4 = level triggered
>>> +
>>> +  Cells 4 and beyond are reserved for future use. When the 1st cell
>>> +  has a value of 0 or 1, cells 4 and beyond act as padding, and may be
>>> +  ignored. It is recommended that padding cells have a value of 0.
>>> +
>>> +- reg : Specifies base physical address(s) and size of the GIC
>>> +  registers, in the following order:
>>> +  - GIC Distributor interface (GICD)
>>> +  - GIC Redistributors (GICR), one range per redistributor region
>>> +  - GIC CPU interface (GICC)
>>> +  - GIC Hypervisor interface (GICH)
>>> +  - GIC Virtual CPU interface (GICV)
>>> +
>>> +  GICC, GICH and GICV are optional.
>>
>> I wonder if it should be noted here that a lack of these last three
>> regions denies GICv2 emulation support for KVM guests.
>
> Only the lack of the last one prevents KVM from emulating a GICv2. But
> that's a software support issue, and does not impact the hardware
> description (which is what we're doing in this patch).

But the lack of hardware vGICv2 compat support is a hardware feature.
Either the GIC(v3) hardware supports it or not. Currently I am
"guessing" this in my patch series based on the existence of these
addresses in the DT. Based on this bit I allow an instantiation of a
virtual GICv2 in the guest or require a GICv3.
I'd just like to see this documented.

> KVM can still use software emulation of GICv2 (just like we did back in
> the days...).

But KVM would need to know whether it can use the hardware emulation
bits or not. I am fine with deducing this from the existence of some
registers, but would like to see this officially stated here.

Cheers,
Andre.

>> It's probably not worth to introduce a special property for this v2
>> compat support, but if the lack of these registers is indicating that
>> fact, it should be added here.
>
> Absence of these ranges just indicates that the OS must be GICv3 aware
> to boot (i.e can't be GICv2 only).
> I don't think that how this
> information is used for guests is relevant to the DT documentation.
>
> Thanks,
>
>       M.
>


-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
