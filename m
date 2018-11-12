From: pn@denx.de (Parthiban Nallathambi)
Date: Mon, 12 Nov 2018 11:53:34 +0100
Subject: [PATCH v2 1/3] dt-bindings: interrupt-controller: Actions
 external interrupt controller
In-Reply-To: <20180813043406.GA16275@Mani-XPS-13-9360>
References: <20180812122215.1079590-1-pn@denx.de>
 <20180812122215.1079590-2-pn@denx.de>
 <20180813043406.GA16275@Mani-XPS-13-9360>
Message-ID: <85137788-4d08-f2cb-5b50-b5e35dbff29e@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/13/18 6:34 AM, Manivannan Sadhasivam wrote:
> Hi Parthiban,
> 
> On Sun, Aug 12, 2018 at 02:22:13PM +0200, Parthiban Nallathambi wrote:
>> Actions Semi OWL family SoC's provides support for external interrupt
>> controller to be connected and controlled using SIRQ pins. S500, S700
>> and S900 provides 3 SIRQ lines and works independently for 3 external
>> interrupt controllers.
>>
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>   .../interrupt-controller/actions,owl-sirq.txt      | 46 ++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
>> new file mode 100644
>> index 000000000000..4b8437751331
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
>> @@ -0,0 +1,46 @@
>> +Actions Semi Owl SoCs SIRQ interrupt controller
>> +
>> +S500, S700 and S900 SoC's from Actions provides 3 SPI's from GIC,
>> +in which external interrupt controller can be connected. 3 SPI's
>> +45, 46, 47 from GIC are directly exposed as SIRQ. It has
>> +the following properties:
> 
> We should really document the driver here. What it does? and how the
> hierarchy is handled with GIC? etc...
> 
>> +
>> +- inputs three interrupt signal from external interrupt controller
>> +
>> +Required properties:
>> +
>> +- compatible: should be "actions,owl-sirq"
>> +- reg: physical base address of the controller and length of memory mapped.
> 
> ...length of memory mapped region?

Yes it is.

> 
>> +- interrupt-controller: identifies the node as an interrupt controller
>> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
>> +  source, should be 2.
>> +- actions,sirq-shared-reg: Applicable for S500 and S700 where SIRQ register
>> +  details are maintained at same offset/register.
>> +- actions,sirq-offset: register offset for SIRQ interrupts. When registers are
>> +  shared, all the three offsets will be same (S500 and S700).
>> +- actions,sirq-clk-sel: external interrupt controller can be either
>> +  connected to 32Khz or 24Mhz external/internal clock. This needs
> 
> Hertz should be specified as Hz.
> 
>> +  to be configured for per SIRQ line. Failing defaults to 32Khz clock.
> 
> What value needs to be specified for selecting 24MHz clock? You should
> mention the available options this property supports.

Ok, this property will be removed here and leave to default 24MHz for
all the SoC's.

> 
>> +
>> +Example for S900:
>> +
>> +sirq: interrupt-controller at e01b0000 {
>> +	compatible = "actions,owl-sirq";
>> +	reg = <0 0xe01b0000 0 0x1000>;
> 
> could be: reg = <0x0 0xe01b0000 0x0 0x1000>;

Agreed!

> 
>> +	interrupt-controller;
>> +	#interrupt-cells = <2>;
>> +	actions,sirq-clk-sel = <0 0 0>;
>> +	actions,sirq-offset = <0x200 0x528 0x52c>;
>> +};
>> +
>> +Example for S500 and S700:
>> +
>> +sirq: interrupt-controller at e01b0000 {
>> +	compatible = "actions,owl-sirq";
>> +	reg = <0 0xe01b0000 0 0x1000>;
> 
> For S500, reg base is 0xb01b0000.

Yes, agreed!

Thanks,
Parthi

> 
> Thanks
> Mani
> 
>> +	interrupt-controller;
>> +	#interrupt-cells = <2>;
>> +	actions,sirq-shared-reg;
>> +	actions,sirq-clk-sel = <0 0 0>;
>> +	actions,sirq-offset = <0x200 0x200 0x200>;
>> +};
>> -- 
>> 2.14.4
>>
>
