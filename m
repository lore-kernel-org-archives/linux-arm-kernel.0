From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 15 Oct 2018 16:35:25 +0530
Subject: [PATCH 1/2] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
In-Reply-To: <20181006162929.u6uh4ffn6gm3incf@akan>
References: <20181006072812.15814-1-lokeshvutla@ti.com>
 <20181006072812.15814-2-lokeshvutla@ti.com>
 <20181006162929.u6uh4ffn6gm3incf@akan>
Message-ID: <c3dada07-d04f-a4c8-b8e3-bece678aea15@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob, DT maintainers,

On Saturday 06 October 2018 09:59 PM, Nishanth Menon wrote:
> On 12:58-20181006, Lokesh Vutla wrote:
>> Add the DT binding documentation for Interrupt router driver.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>   .../interrupt-controller/ti,sci-intr.txt      | 83 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 84 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> new file mode 100644
>> index 000000000000..681ca53cc5fb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> @@ -0,0 +1,83 @@
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
>> +        +-------+            |    .        |  0  |  |----->|  GIC  |
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
>> +track of GIC IRQs.
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
>> +			in interrupts.txt in this directory.
>> +- interrupt-parent:	phandle of irq parent for TISCI intr. The parent must
>> +			use the same interrupt-cells format as GIC.
>> +- ti,sci:		Phandle to TI-SCI compatible System controller node.
>> +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
>> +- ti,sci-rm-range-girq:	Tuple corresponding to unique TISCI resource type that
>> +			defines the dst host irq ranges assigned to this
>> +			interrupt router from this host context.
>> +			Tuple should be of format <type subtype>.
>> +
> 
> Rob, DT maintainers,
> 
> I'd like a feedback from DT maintainers on this 'range' topic.
> 
> TISCI Firmware [1] currently seems to define a type corresponding to a
> device ID[2]. in AM6 device, for example, this is different, however
> have a 1 to 1 correspondence. However, there is expectation that type will
> end up as device ID in a future SoC.
> 
> While this is subject to much debate internally, I'd like some feedback if this
> is OK from Device tree representation - it is true that Firmware does
> look at it as type, however in some future SoC, it could be that the
> values themselves may correspond one to one with a device id -> The
> original wish was that types might be something reusable across SoCs,
> but that is turning out to be more of a theoretical wish than any thing
> practical.
> 
> [1]http://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am6x/resasg_types.html
> [2]http://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am6x/devices.html

Any help on this topic?

Thanks and regards,
Lokesh

> 
