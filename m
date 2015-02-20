From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Feb 2015 10:41:56 +0000
Subject: lpi-parent?
In-Reply-To: <CALRxmdDejPBREBL8WY=drW+nmHSVPX9A3WmbW=t+FOpHvbeV2g@mail.gmail.com>
References: <CALRxmdDejPBREBL8WY=drW+nmHSVPX9A3WmbW=t+FOpHvbeV2g@mail.gmail.com>
Message-ID: <54E70F74.2070005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stuart,

On 19/02/15 02:16, Stuart Yoder wrote:
> On Mon, Nov 24, 2014 at 8:35 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Add the documentation for the bindings describing the GICv3 ITS.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  Documentation/devicetree/bindings/arm/gic-v3.txt | 39 ++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/gic-v3.txt b/Documentation/devicetree/bindings/arm/gic-v3.txt
>> index 33cd05e..ddfade4 100644
>> --- a/Documentation/devicetree/bindings/arm/gic-v3.txt
>> +++ b/Documentation/devicetree/bindings/arm/gic-v3.txt
>> @@ -49,11 +49,29 @@ Optional
>>    occupied by the redistributors. Required if more than one such
>>    region is present.
>>
>> +Sub-nodes:
>> +
>> +GICv3 has one or more Interrupt Translation Services (ITS) that are
>> +used to route Message Signalled Interrupts (MSI) to the CPUs.
>> +
>> +These nodes must have the following properties:
>> +- compatible : Should at least contain  "arm,gic-v3-its".
>> +- msi-controller : Boolean property. Identifies the node as an MSI controller
>> +- reg: Specifies the base physical address and size of the ITS
>> +  registers.
>> +
>> +The main GIC node must contain the appropriate #address-cells,
>> +#size-cells and ranges properties for the reg property of all ITS
>> +nodes.
>> +
>>  Examples:
>>
>>         gic: interrupt-controller at 2cf00000 {
>>                 compatible = "arm,gic-v3";
>>                 #interrupt-cells = <3>;
>> +               #address-cells = <2>;
>> +               #size-cells = <2>;
>> +               ranges;
>>                 interrupt-controller;
>>                 reg = <0x0 0x2f000000 0 0x10000>,       // GICD
>>                       <0x0 0x2f100000 0 0x200000>,      // GICR
>> @@ -61,11 +79,20 @@ Examples:
>>                       <0x0 0x2c010000 0 0x2000>,        // GICH
>>                       <0x0 0x2c020000 0 0x2000>;        // GICV
>>                 interrupts = <1 9 4>;
>> +
>> +               gic-its at 2c200000 {
>> +                       compatible = "arm,gic-v3-its";
>> +                       msi-controller;
>> +                       reg = <0x0 0x2c200000 0 0x200000>;
>> +               };
>>         };
>>
>>         gic: interrupt-controller at 2c010000 {
>>                 compatible = "arm,gic-v3";
>>                 #interrupt-cells = <3>;
>> +               #address-cells = <2>;
>> +               #size-cells = <2>;
>> +               ranges;
>>                 interrupt-controller;
>>                 redistributor-stride = <0x0 0x40000>;   // 256kB stride
>>                 #redistributor-regions = <2>;
>> @@ -76,4 +103,16 @@ Examples:
>>                       <0x0 0x2c060000 0 0x2000>,        // GICH
>>                       <0x0 0x2c080000 0 0x2000>;        // GICV
>>                 interrupts = <1 9 4>;
>> +
>> +               gic-its at 2c200000 {
>> +                       compatible = "arm,gic-v3-its";
>> +                       msi-controller;
>> +                       reg = <0x0 0x2c200000 0 0x200000>;
>> +               };
>> +
>> +               gic-its at 2c400000 {
>> +                       compatible = "arm,gic-v3-its";
>> +                       msi-controller;
>> +                       reg = <0x0 0x2c400000 0 0x200000>;
>> +               };
> 
> Marc,
> 
> Is there a binding definition for how other nodes specify which
> gic-its node they are
> associated with.
> 
> In some proof of concept kernel code we are using the property "lpi-parent"
> to specify the association of a bus node (that uses message interrupts)
> to the GIC ITS:
> 
>     lpi-parent = <&its>;
> 
> I am not remember at all if that property came as a suggestion from some
> side discussion with you or if we just made that up.  Wanted to see what
> your thoughts were on how to do this.

I don't think I suggested this. But if you need to describe this
relation, why not use 'msi-parent' instead? That would seem to fit what
you want to describe.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
