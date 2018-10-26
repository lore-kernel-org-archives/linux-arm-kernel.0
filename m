From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 26 Oct 2018 12:08:55 +0530
Subject: [PATCH v2 06/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
In-Reply-To: <20181025184556.GA19597@bogus>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-7-lokeshvutla@ti.com> <20181025184556.GA19597@bogus>
Message-ID: <bf6c5c14-5f35-7d6b-10c9-36a1cbe22e09@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Friday 26 October 2018 12:15 AM, Rob Herring wrote:
> On Thu, Oct 18, 2018 at 09:10:13PM +0530, Lokesh Vutla wrote:
>> Add the DT binding documentation for Interrupt router driver.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>> Changes since v1:
>> - Drop dependency on GIC
>> - Updated supported interrupt types.
>>
>>   .../interrupt-controller/ti,sci-intr.txt      | 81 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 82 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> new file mode 100644
>> index 000000000000..276bb4f0ad12
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> @@ -0,0 +1,81 @@
>> +Texas Instruments K3 Interrupt Router
>> +=====================================
>> +
>> +The Interrupt Router (INTR) module provides a mechanism to mux M
>> +interrupt inputs to N interrupt outputs, where all M inputs are selectable
>> +to be driven per N output. There is one register per output (MUXCNTL_N) that
>> +controls the selection.
>> +
>> +
>> +                                 Interrupt Router
>> +                             +----------------------+
>> +                             |  Inputs     Outputs  |
>> +        +-------+            | +------+             |
>> +        | GPIO  |----------->| | irq0 |             |       Host IRQ
>> +        +-------+            | +------+             |      controller
>> +                             |    .        +-----+  |      +-------+
>> +        +-------+            |    .        |  0  |  |----->|  IRQ  |
>> +        | INTA  |----------->|    .        +-----+  |      +-------+
>> +        +-------+            |    .          .      |
>> +                             | +------+      .      |
>> +                             | | irqM |    +-----+  |
>> +                             | +------+    |  N  |  |
>> +                             |             +-----+  |
>> +                             +----------------------+
>> +
>> +Configuration of these MUXCNTL_N registers is done by a system controller
>> +(like the Device Memory and Security Controller on K3 AM654 SoC). System
>> +controller will keep track of the used and unused registers within the Router.
>> +Driver should request the system controller to get the range of GIC IRQs
>> +assigned to the requesting hosts. It is the drivers responsibility to keep
>> +track of Host IRQs.
>> +
>> +Communication between the host processor running an OS and the system
>> +controller happens through a protocol called TI System Control Interface
>> +(TISCI protocol). For more details refer:
>> +Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> +
>> +TISCI Interrupt Router Node:
>> +----------------------------
>> +- compatible:		Must be "ti,sci-intr".
>> +- interrupt-controller:	Identifies the node as an interrupt controller
>> +- #interrupt-cells:	Specifies the number of cells needed to encode an
>> +			interrupt source. The value should be 3.
>> +			First cell should contain the TISCI device ID of source
>> +			Second cell should contain the interrupt source offset
>> +			within the device
>> +			Third cell specifies the trigger type as defined
>> +			in interrupts.txt in this directory. Only level
>> +			sensitive trigger types are supported.
>> +- interrupt-parent:	phandle of irq parent for TISCI intr.
> 
> This is implied and could be in a parent node.

okay, will drop it in next version.

> 
>> +- ti,sci:		Phandle to TI-SCI compatible System controller node.
>> +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
>> +- ti,sci-rm-range-girq:	TISCI subtype id representing the host irqs assigned
>> +			to this interrupt router.
> 
> These need a better explanation and there's still some questions on v1
> asked of me that I tried to answer.

Before I jump into the details, I would like to provide a brief on TISCI 
resource management:

- Host_id: Typically it is the representation of the host processing entities 
(example: A53 cores running in a VM) as identified by the TISCI.[1]
- Device_id: Each Device in SoC is uniquely identified by TISCI using an ID.
- Each device has Resources like interrupts, DMA channels etc. A simple example 
would be Interrupt Router and GIC($subject). There are n physical GIC interrupts 
connected to Interrupt Router. Such resources are are uniquely identified by 
TISCI using a type ID.[2]

For the sake of simplicity lets consider an Interrupt Router(IR) to which GIC 
line 32-63 are connected. Considering Isolation for each VM in picture, TISCI 
allows for a certain range within [32-63] to be assigned to a specific Host_ID. 
This is mainly to provide the ability for OSs running in virtual machines to be 
able to independently communicate with the firmware without the need going 
through a hypervisor.

- Now for Linux to know the GIC irq range that can be used by this Interrupt 
router, IR driver should send a message to system-controller using TISCI 
protocol with the resource type as parameter.
- For configuring the IRQ,(i.e. attaching an input to IR to a GIC irq), IR 
driver should send a message to system-controller using TISCI protocol with 
gic-device-id and an irq from the provided range as parameters.

For covering the above two scenarios, ti,sci-dst-id and ti,sci-rm-range-girq is 
introduced in DT.

[1] http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am6x/hosts.html
[2] http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am6x/resasg_types.html

> 
>> +
>> +Example:
>> +--------
>> +The following example demonstrates both interrupt router node and the consumer
>> +node(main gpio) on the AM654 SoC:
>> +
>> +main_intr: interrupt-controller at 1 {
>> +	compatible = "ti,sci-intr";
>> +	interrupt-controller;
>> +	interrupt-parent = <&gic>;
>> +	#interrupt-cells = <3>;
>> +	ti,sci = <&dmsc>;
>> +	ti,sci-dst-id = <56>;
>> +	ti,sci-rm-range-girq = <0x1>;
>> +};
>> +
>> +main_gpio0:  main_gpio0 at 600000 {
> 
> gpio at ...

Sure, will fix it in next version.

Thanks and regards,
Lokesh
