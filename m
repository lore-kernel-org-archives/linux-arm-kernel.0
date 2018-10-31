From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 31 Oct 2018 15:33:33 -0500
Subject: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
In-Reply-To: <da27ecc5-db32-cf3a-c194-962c44bc782f@arm.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
 <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
 <86va5ssrfm.wl-marc.zyngier@arm.com>
 <2369ea50-55db-c97b-5b43-99d572c97dc9@ti.com>
 <da27ecc5-db32-cf3a-c194-962c44bc782f@arm.com>
Message-ID: <ae3c35e0-6d92-10e3-c268-eb4338fbb233@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/31/18 1:21 PM, Marc Zyngier wrote:
> Hi Grygorii,
> 
> On 31/10/18 16:39, Grygorii Strashko wrote:
> 
> [...]
> 
>> I'd try to provide some additional information here.
>> (Sry, I'll still use term "events")
>>
>> As Lokesh explained in other mail on K3 SoC everything is generic and most
>> of resources allocated dynamicaly:
>> - generic DMA channels
>> - generic HW rings (used by DMA channel)
>> - generic events (assigned to the rings) and muxed to different cores/hosts
>>
>> So, when some driver would like to perform DMA transaction It's
>> required to build (configure) DMA channel by allocating different type of
>> resources and link them together to get finally working Data Movement path
>> (situation complicated by ti-sci firmware which policies resources between cores/hosts):
>> - get UDMA channel from available range
>> - get HW rings and attach them to the UDMA channel
>> - get event, assign it to the ring and mux it to the core/host through IA->IR-> chain
>>     (and this step is done by ti_sci_inta_register_event() - no DT as everything is dynamic).
>>
>> Next, how this is working now - ti_sci_inta_register_event():
>> - first call does similar things as regular DT irq mapping (end up calling irq_create_fwspec_mapping()
>>     and builds IRQ chain as below:
>>     linux_virq = ti_sci_inta_register_event(dev, <ringacc tisci_dev_id>,
>> 				<ringacc id>, 0, IRQF_TRIGGER_HIGH, false);
>>
>>                +---------------------+
>>                |         IA          |
>> +--------+   |            +------+ |        +--------+         +------+
>> | ring 1 +----->evtA+----->VintX +---------->   IR   +--------->  GIC +-->
>> +--------+   |            +------+ |        +--------+         +------+  Linux IRQ Y
>>      evtA      |                     |
>>                |                     |
>>                +---------------------+
>>
>> - second call updates only IA input part while keeping other parts of IRQ chain the same
>>     if valid <linux_virq> passed as input parameter:
>>     linux_virq = ti_sci_inta_register_event(dev, <ringacc tisci_dev_id>,
>> 				<ringacc id>, linux_virq, IRQF_TRIGGER_HIGH, false);
>>                +---------------------+
>>                |         IA          |
>> +--------+   |            +------+ |        +--------+         +------+
>> | ring 1 +----->evtA+--^-->VintX +---------->   IR   +--------->  GIC +-->
>> +--------+   |         |  +------+ |        +--------+         +------+  Linux IRQ Y
>>                |         |           |
>> +--------+   |         |           |
>> | ring 2 +----->evtB+--+           |
>> +--------+   |                     |
>>                +---------------------+
> 
> This is basically equivalent requesting a bunch of MSIs for a single
> device, and obtaining a set of corresponding interrupts. The fact that
> you end-up muxing them in the IA block is an implementation detail.
> 
>>
>>     As per above, irq-ti-sci-inta and tisci fw creates shared IRQ on HW layer by attaching
>>     events to already established IA->IR->GIC IRQ chain. Any Rings events will trigger
>>     Linux IRQ Y line and keep it active until Rings are not empty.
>>
>> Now why this was done this way?
>> Note. I'm not saying this is right, but it is the way we've done it as of now. And I hope MSI
>> will help to move forward, but I'm not very familiar with it.
>>
>> The consumer of this approach is K3 Networking driver, first of all, and
>> this approach allows to eliminate runtime overhead in Networking hot path and
>> provides possibility to implement driver's specific queues/rings handling policies
>> - like round-robin vs priority.
>>
>> CPSW networking driver doesn't need to know exact ring generated IRQ - it
> 
> Well, to fit the Linux model, you'll have to know. Events needs to be
> signalled as individual IRQs.

"
NAK. Either this fits in the standard model, or we adapt the standard
model to catter for your particular use case. But we don't define a new,
TI specific API.
"



> 
>> need to know if there is packet for processing, so current IRQ handling sequence we have (simplified):
>> - any ring evt -> IA -> IR -> GIC -> Linux IRQ Y
>>     handle_fasteoi_irq() -> cpsw_irq_handler -> disable_irq() -> napi_schedule()
> 
> Here, disable_irq() will only affect a single "event".

No. It will disable "Linux IRQ Y". On IA level there is no mask/unmask/ack functions for ring's events.
sum of rings events keeps "Linux IRQ Y" line physically active until all rings are serviced - empty.
once ring empty - corresponding event auto cleared.

> 
>>     ...
>>     soft_irq() -> cpsw_poll():
>> 	- [1] for each ring from Hi prio to Low prio
>> 	      [2] get packet
>> 	      [3] if (packet) process packet & goto [2]
>> 	          else goto [1]
>> 	       if (no more packets) goto [4]
>> 	  [4] enable_irq()
>>
>> As can be seen there is no intermediate IRQ dispatchers on IA/IR levels and no IRQs-per-rings,
>> and NAPI poll cycle allows to implement driver's specific rings handling policy.
>>
>> Next: depending on the use case following optimizations are possible:
>> 1) throughput: split all TX (or RX) rings on X groups, where X = num_cpus
>> and allocate assign IRQ to each group for Networking XPS/RPS/RSS.
>> For example, CPSW2G has 8 TX channels and so 8 completion rings, 4 CPUs:
>>    rings[0,1] -(IA/IR) - Linux IRQ 1
>>    rings[2,3] -(IA/IR) - Linux IRQ 2
>>    rings[4,5] -(IA/IR) - Linux IRQ 3
>>    rings[6,7] -(IA/IR) - Linux IRQ 4
>> each Linux IRQ assigned to separate CPU.
> 
> What you call "Linux IRQ" is what ends up being generated at the GIC
> level, and isn't the interrupt the driver will get. It will get an
> interrupt number which represent a single event. 

In current implementation the interrupt controller driver will not know what event was generated
when this ti_sci_inta_register_event() is used as this is responsibility of consumer driver
which required to get only one notification - packet received (GIC->Linux IRQ).

We need this to build fast IRQ handling path for networking -
GIC->Linux IRQ considered exclusive and no other event can be assigned to it except
as by using ti_sci_inta_register_event().
I think, it can be considered the same way as "reserved memory" - it exist, but linux
knows nothing about it, while consumer drivers still can have access to it.

ti_sci_inta_register_event() does mostly the same - it steals set of events from IA,
preforms some muxing inside HW and makes one GIC->Linux IRQ visible to Linux IRQ framework
- from Linux point of view allocated GIC->Linux IRQ is just regular irq and It
doesn't know internals (while consumer driver does).

We can't split or divide it on networking/non networking part due to fact that
all resources are dynamic, so ti-sci-inta + FW manages/own resources - and
ti_sci_inta_register_event() is entry point for IRQ resources allocation from
available ranges.

It's no too much different from OMAP CPSW device - just legacy CPSW IRQ generation
schema statically implemented in HW: 8 TX/RX CPPI channels, which are representing
8 linked lists of CPPI descriptor. Any change of linked lists state triggers
local CPSW CPPI IRQ which are summed to generate one (and only one) GIC->Linux IRQ.
It's responsibility of CPSW networking driver to handle CPPI channels in correct order.
And there is no chained IRQ controller implemented simply because of (a) runtime overhead
and (b) impossibility to implement priority handling.

Difference is that CPSW CPPI IRQs need to be asked while K3 AM6 it happens automatically
- and in K3 AM6 HW need to be configured dynamically based on allocated resources.

We absolutely need to
> maintain this 1:1 mapping between event and driver-visible interrupts.
> Whatever happens between the scenes is none of the driver problem.
> 
> In your "one interrupt, multiple events" paradigm, the whole IA thing
> would be conceptually part of your networking IP. I don't believe this
> is the case, and trawling the documentation seems to confirm this view.

not exactly - ti-sci-inta expected to work this way only when ti_sci_inta_register_event() is used.
Other allocation will follow standard Linux approach by "maintaining "1:1 mapping".

> 
>> 2) min latency:
>>    Ring X is used by RT application for TX/RX some traffic (using AF_XDP sockets for example)
>>    Ring X can be assigned with separate IRQ while other rings still grouped to
>>    produce 1 IRQ
>>    rings[0,6] - (IA/IR) - Linux IRQ 1
>>    rings[7] - (IA/IR) - Linux IRQ 2
>>    Linux IRQ 2 assigned to separate CPU where RT application is running.
>>
>> Hope above will help to clarify some K3 AM6 IRQ generation questions and
>> find the way to move forward.
> 
> Well, I'm convinced that we do not want a networking driver to be tied
> to an interrupt architecture, and that the two should be completely
> independent. But that's my own opinion. I can only see two solutions
> moving forward:
> 
> 1) You make the IA a real interrupt controller that exposes real
> interrupts (one per event), and write your networking driver
> independently of the underlying interrupt architecture.

And that's actually what is implemented IA is real interrupt controller which produces "1:1 mapping",
but it provides possibility to steal and mux IRQ event for non-standard purposes
- networking/ipc. IA is resource owner in this case as there is no way to preallocate/assign
resources statically.

> 
> 2) you make the IA an integral part of your network driver, not exposing
> anything outside of it, and limiting the interactions with the IR
> *through the standard IRQ API*. You duplicate this knowledge throughout
> the other client drivers.
> 
> I believe that (2) would be a massive design mistake as it locks the
> driver to a single of the HW (and potentially a single revision of the
> firmware) while (1) gives you the required level of flexibility by
> hiding the whole event "concept" at a single location.
> 
> Yes, (1) makes you rewrite your existing, out of tree drivers. Oh well...

-- 
regards,
-grygorii
