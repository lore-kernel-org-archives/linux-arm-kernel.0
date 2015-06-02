From: majun258@huawei.com (majun (F))
Date: Tue, 2 Jun 2015 19:54:16 +0800
Subject: [PATCH 4/4]:dt-binding:Documents the mbigen bindings
In-Reply-To: <20150601100431.GC22406@leverpostej>
References: <55692C36.1000309@huawei.com> <20150601100431.GC22406@leverpostej>
Message-ID: <556D9968.6050903@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015/6/1 18:04, Mark Rutland ??:
> On Sat, May 30, 2015 at 04:19:18AM +0100, majun (F) wrote:
>> Add the mbigen msi interrupt controller bindings document
>>
>>
>> Signed-off-by: Ma Jun <majun258@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/arm/mbigen.txt |   51 ++++++++++++++++++++++
>>  1 files changed, 51 insertions(+), 0 deletions(-)
>>  create mode 100755 Documentation/devicetree/bindings/arm/mbigen.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mbigen.txt b/Documentation/devicetree/bindings/arm/mbigen.txt
>> new file mode 100755
>> index 0000000..d442b31
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/mbigen.txt
>> @@ -0,0 +1,51 @@
>> +Hisilicon mbigen device tree bindings.
>> +=======================================
>> +
>> +Mbigen means: message based interrupt generator.
>> +
>> +MBI is kind of msi interrupt only used on Non-PCI devices.
>> +
>> +To reduce the wired interrupt number connected to GIC,
>> +Hisilicon designed mbigen to collect and generate interrupt.
>> +
>> +
>> +Non-pci devices can connect to mbigen and gnerate the inteerrupt
>> +by wirtting ITS register.
> 
> Typos.
> 
>> +
>> +The mbigen and devices connect to mbigen have the following properties:
>> +
>> +
>> +Mbigen required properties:
>> +-------------------------------------------
>> +-compatible: Should be "hisilicon,mbi-gen"
>> +-msi-parent: should specified the ITS mbigen connected
>> +-interrupt controller: Identifies the node as an interrupt controller
>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>> +  interrupt source. The value is 2 for now.
> 
> The precise format of these cells needs to be specified, at this point
> in the binding document.
>
ok, i will fix this in next version

> Why do you say "The value is 2 for now"? Do you expect this to grow in
> future? If so, why?
> 
Because the hardware design will be changed in the near future, to compatible
with these chips, this value need to change either.

>> +- reg: Specifies the base physical address and size of the ITS
>> +  registers.
> 
> This doesn't sound right. This isn't the ITS, so it shouldn't refer to
> the ITS registers in this manner.
> 
> Does the mbigen not have its own set of registers?
> 
> Thanks,
> Mark.
> 
yes, you are right, it should be mbigen register.
>> +
>> +Examples:
>> +
>> +	mbigen_pa: interrupt-controller at 4c030000 {
>> +			compatible = "hisilicon,mbi-gen";
>> +			msi-parent = <&its_pa>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +			reg = <0x4c030000 0x10000>;
>> +		};
>> +
>> +Device connect to mbigen required properties:
>> +----------------------------------------------------
>> +-interrupt-parent: Specifies the mbigen node which device connected.
>> +-interrupts:specifies the interrupt source.The first cell is hwirq num, the
>> +  second number is trigger type.
>> +
>> +Examples:
>> +	usb0: ehci at a1000000 {
>> +		compatible = "generic-ehci";
>> +		interrupt-parent = <&mbigen_pa>;
>> +		reg = <0xa1000000 0x10000>;
>> +		interrupts = <20 4>;
>> +	};
>> +
>> -- 
>> 1.7.1
>>
>>
> 
> .
> 
