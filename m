From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 8 Oct 2018 15:16:58 +0530
Subject: [PATCH 1/2] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
In-Reply-To: <86tvlztmt1.wl-marc.zyngier@arm.com>
References: <20181006072812.15814-1-lokeshvutla@ti.com>
 <20181006072812.15814-2-lokeshvutla@ti.com>
 <86tvlztmt1.wl-marc.zyngier@arm.com>
Message-ID: <8a05f735-01bd-5c2d-fcfa-dcc00adffd0b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Saturday 06 October 2018 03:32 PM, Marc Zyngier wrote:
> On Sat, 06 Oct 2018 08:28:11 +0100,
> Lokesh Vutla <lokeshvutla@ti.com> wrote:
>>
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
> 
> I would drop the GIC here, and replace it by "parent interrupt
> controller", as nothing here is GIC specific
> 
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
> 
> Are all trigger types supported?

Nope, only level interrupts are supported. Will fix it in v2.

> 
>> +- interrupt-parent:	phandle of irq parent for TISCI intr. The parent must
>> +			use the same interrupt-cells format as GIC.
> 
> Why that constraint? From what I can see, the two are fairly
> independent, and the constraint looks more of a Linux driver issue
> than a DT constraint.

Driver when calling irq_domain_alloc_irqs_parent(), the fwspec node that gets 
passed assumes that parent is gic. parameters are filled in with such 
assumption. Do you suggest anything to make it more generic?

> 
>> +- ti,sci:		Phandle to TI-SCI compatible System controller node.
>> +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
>> +- ti,sci-rm-range-girq:	Tuple corresponding to unique TISCI resource type that
>> +			defines the dst host irq ranges assigned to this
>> +			interrupt router from this host context.
>> +			Tuple should be of format <type subtype>.
>> +

Thanks a lot for the review. Also, I need a suggestion regarding one more 
interrupt controller(Interrupt Aggregator) on the same SoC controlled by 
TISCI_PROTOCOL.

The Interrupt Aggregator (INTA) provides a centralized machine
which handles the termination of system events to that they can
be coherently processed by the host(s) in the system. Integration looks 
something similar https://pastebin.ubuntu.com/p/T32vbrwsch/ .

Configuration of the Intmap registers that maps global events to vint is done
by a system controller (like the Device Memory and Security Controller on K3
AM654 SoC). Driver should request the system controller to get the range
of global events and vints assigned to the requesting host. Management
of these requested resources should be handled by driver and requests
system controller to map specific global event to vint, bit pair.

There can be cases such that IRQ routes can involve both INTR and INTA like below:
	IP ---> INTA ---> INTR ----> GIC.

In these cases TISCI involves only one message with parametes(source id, source 
offset, inta_id, dst id) for configuring IRQ route till the destination. Co 
processor will detect there is INTR in the IRQ path and configure that as well.

Right now I kind of differentiated this scenario in INTA driver by passing a 
flag(TI_SCI_EVENT) to INTR driver. If such flag comes, INTR driver should avoid 
calling ti_sci api for configuring. Do you think this is the right direction or 
do you suggest a better solution.

If I am not clear in the above description, I can post an RFC for INTA driver 
for continuing this discussion.

Thanks and regards,
Lokesh
