From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 1 Nov 2018 14:52:12 +0000
Subject: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
In-Reply-To: <ae3c35e0-6d92-10e3-c268-eb4338fbb233@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
 <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
 <86va5ssrfm.wl-marc.zyngier@arm.com>
 <2369ea50-55db-c97b-5b43-99d572c97dc9@ti.com>
 <da27ecc5-db32-cf3a-c194-962c44bc782f@arm.com>
 <ae3c35e0-6d92-10e3-c268-eb4338fbb233@ti.com>
Message-ID: <8bd930f3-a5c9-0490-d676-fb1e0f2f3ad8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/10/18 20:33, Grygorii Strashko wrote:
> 
> 
> On 10/31/18 1:21 PM, Marc Zyngier wrote:
>> Hi Grygorii,
>>
>> On 31/10/18 16:39, Grygorii Strashko wrote:
>>
>> [...]
>>
>>> I'd try to provide some additional information here.
>>> (Sry, I'll still use term "events")
>>>
>>> As Lokesh explained in other mail on K3 SoC everything is generic and most
>>> of resources allocated dynamicaly:
>>> - generic DMA channels
>>> - generic HW rings (used by DMA channel)
>>> - generic events (assigned to the rings) and muxed to different cores/hosts
>>>
>>> So, when some driver would like to perform DMA transaction It's
>>> required to build (configure) DMA channel by allocating different type of
>>> resources and link them together to get finally working Data Movement path
>>> (situation complicated by ti-sci firmware which policies resources between cores/hosts):
>>> - get UDMA channel from available range
>>> - get HW rings and attach them to the UDMA channel
>>> - get event, assign it to the ring and mux it to the core/host through IA->IR-> chain
>>>     (and this step is done by ti_sci_inta_register_event() - no DT as everything is dynamic).
>>>
>>> Next, how this is working now - ti_sci_inta_register_event():
>>> - first call does similar things as regular DT irq mapping (end up calling irq_create_fwspec_mapping()
>>>     and builds IRQ chain as below:
>>>     linux_virq = ti_sci_inta_register_event(dev, <ringacc tisci_dev_id>,
>>> 				<ringacc id>, 0, IRQF_TRIGGER_HIGH, false);
>>>
>>>                +---------------------+
>>>                |         IA          |
>>> +--------+   |            +------+ |        +--------+         +------+
>>> | ring 1 +----->evtA+----->VintX +---------->   IR   +--------->  GIC +-->
>>> +--------+   |            +------+ |        +--------+         +------+  Linux IRQ Y
>>>      evtA      |                     |
>>>                |                     |
>>>                +---------------------+
>>>
>>> - second call updates only IA input part while keeping other parts of IRQ chain the same
>>>     if valid <linux_virq> passed as input parameter:
>>>     linux_virq = ti_sci_inta_register_event(dev, <ringacc tisci_dev_id>,
>>> 				<ringacc id>, linux_virq, IRQF_TRIGGER_HIGH, false);
>>>                +---------------------+
>>>                |         IA          |
>>> +--------+   |            +------+ |        +--------+         +------+
>>> | ring 1 +----->evtA+--^-->VintX +---------->   IR   +--------->  GIC +-->
>>> +--------+   |         |  +------+ |        +--------+         +------+  Linux IRQ Y
>>>                |         |           |
>>> +--------+   |         |           |
>>> | ring 2 +----->evtB+--+           |
>>> +--------+   |                     |
>>>                +---------------------+
>>
>> This is basically equivalent requesting a bunch of MSIs for a single
>> device, and obtaining a set of corresponding interrupts. The fact that
>> you end-up muxing them in the IA block is an implementation detail.
>>
>>>
>>>     As per above, irq-ti-sci-inta and tisci fw creates shared IRQ on HW layer by attaching
>>>     events to already established IA->IR->GIC IRQ chain. Any Rings events will trigger
>>>     Linux IRQ Y line and keep it active until Rings are not empty.
>>>
>>> Now why this was done this way?
>>> Note. I'm not saying this is right, but it is the way we've done it as of now. And I hope MSI
>>> will help to move forward, but I'm not very familiar with it.
>>>
>>> The consumer of this approach is K3 Networking driver, first of all, and
>>> this approach allows to eliminate runtime overhead in Networking hot path and
>>> provides possibility to implement driver's specific queues/rings handling policies
>>> - like round-robin vs priority.
>>>
>>> CPSW networking driver doesn't need to know exact ring generated IRQ - it
>>
>> Well, to fit the Linux model, you'll have to know. Events needs to be
>> signalled as individual IRQs.
> 
> "
> NAK. Either this fits in the standard model, or we adapt the standard
> model to catter for your particular use case. But we don't define a new,
> TI specific API.
> "

And I stand by what I've written.

>>> need to know if there is packet for processing, so current IRQ handling sequence we have (simplified):
>>> - any ring evt -> IA -> IR -> GIC -> Linux IRQ Y
>>>     handle_fasteoi_irq() -> cpsw_irq_handler -> disable_irq() -> napi_schedule()
>>
>> Here, disable_irq() will only affect a single "event".
> 
> No. It will disable "Linux IRQ Y". On IA level there is no mask/unmask/ack functions for ring's events.
> sum of rings events keeps "Linux IRQ Y" line physically active until all rings are serviced - empty.
> once ring empty - corresponding event auto cleared.

You're missing the point I'm trying to make: either you can and we fit
it into the Linux model of an interrupt controller, or this thing is not
an interrupt controller at all. Either event can be individually masked,
and this can be modelled as an interrupt controller, and they cannot.

So if the IA cannot be represented as an interrupt controller and is so
specific to a particular device, move it out of the interrupt subsystem
and keep it private to your networking device.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
