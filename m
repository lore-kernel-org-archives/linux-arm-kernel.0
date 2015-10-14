From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Oct 2015 09:55:34 +0100
Subject: [PATCH v5 1/3] initialize each mbigen device node as a interrupt
 controller.
In-Reply-To: <alpine.DEB.2.11.1510111335150.6097@nanos>
References: <1443605949-15396-1-git-send-email-majun258@huawei.com>
 <1443605949-15396-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1509302242220.4500@nanos> <5610D3BD.1040408@huawei.com>
 <alpine.DEB.2.11.1510091441200.6097@nanos> <5618D3EC.6050501@huawei.com>
 <20151010110942.52d34a4b@arm.com> <alpine.DEB.2.11.1510111150270.6097@nanos>
 <20151011120331.09093ffc@arm.com> <alpine.DEB.2.11.1510111335150.6097@nanos>
Message-ID: <561E1886.2050305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Sorry it took me so long to come back to you on that one, I really
needed to wrap my head around it.

On 11/10/15 17:45, Thomas Gleixner wrote:
> On Sun, 11 Oct 2015, Marc Zyngier wrote:
>> On Sun, 11 Oct 2015 11:54:49 +0200
>> Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>> On Sat, 10 Oct 2015, Marc Zyngier wrote:
>>>> On Sat, 10 Oct 2015 17:01:32 +0800
>>>> "majun (F)" <majun258@huawei.com> wrote:
>>>>> But there is a problem If i make the structure like you said.
>>>>>
>>>>> For example, my hardware structure likes below:
>>>>>
>>>>> uart ------> mbigen --> ITS-pMSI --> ITS --> GIC
>>>>>      virq1
>>>>>
>>>>> virq1 means the virq number allocted by irq_of_parse_and_map() function
>>>>> when system parse the uart dts node in initializing  stage.
>>>>>
>>>>> To create a ITS device, I need to call msi_domain_alloc_irqs() function
>>>>> in my mbigen alloc function.
>>>>>
>>>>> In this function, a new virq number(named as virq2 ) which different from
>>>>> virq1 is allocated.
>>>>> So, this is a big problem.
>>>>
>>>> I think I see what your problem is:
>>>> - The wired interrupt (uart -> mbigen) is allocated through DT (and
>>>>   must be available early, because of of_platform_populate),
>>>> - The MSI (mgigen -> ITS) is dynamic (and allocated much later,
>>>>   because the device model kicks in after irqchip init, and we cannot
>>>>   allocate MSIs without a device).
>>>
>>> Why do we need that wired interrupt at all? 
>>>
>>> We can make mbigen the 'msi-parent' of the device and let the
>>> msi_domain_ops::msi_prepare() callback figure out the actual wiring
>>> through device->fwnode.
>>
>> That's because the device behind the mbigen can't do any MSI at all.
>> Think of a 8250 uart, for example.
>>
>> If we make the mbigen the msi-parent of the uart, then we need to teach
>> the 8250 driver to request MSIs.
> 
> I really do not understand why of_platform_populate cares about
> interrupt allocations. That's outright stupid. We should care about
> that at device probe time, i.e. at the point where the driver is
> registered and probed if there is matching platform data. If we do it
> in of_platform_populate then we allocate interrupts even for devices
> which do not have a driver, i.e. we just waste memory.

This was introduce for a specific reason: being able to convert systems
from board files to DT without having to DT-ify drivers. Interrupt
numbers magically appear as part of the resource array, and everything
just works.

> 
> So we better teach a couple of drivers to handle that instead of
> inventing horrible workarounds.
> 
>> It also means that the DT doesn't represent the HW anymore (this
>> wired interrupt actually exists).
> 
> I think the abstraction here is wrong. If it would be correct, then
> PCI-MSI would be wrong. The MSI part of PCI is a MSI producer, mbigen
> is as well. Technically MSI is not integral part of the PCI device, it
> just happens to have it's configuration registers in the PCI
> configuration space of the device:

The main difference is that the MSI layer is actually specified in PCI.
Yes, the wire is conveniently hidden from us, but that's also because it
can be hidden: by construction, you have an MSI generator per device.

Mbigen breaks this rule: you can have an MSI generator that covers
multiple devices, or a single device that spans multiple generators.
Nothing that can't be overcome, but that makes things a bit ugly.

>     [PCI-BUS]------[Interrupt mode selector]
>     	      	|        |
>     	      	|        |
> 		------[Legacy irq gate]<-----
> 		|        |                  |
> 		|        |                  |---[Device interrupt]
> 		|        |                  |
> 		------[MSI unit]<------------
> 
> So you have a 'wire' from the device to the MSI unit, but we do not
> care about that 'wire'. All we care about are the MSI configuration
> registers. We find them via the PCI device which gives us the address
> of the PCI configuration space.
> 
> So now in the mbigen case this looks like this:
> 
>     [MSI-BUS] ----- [MBIGEN]<-------------------[Device interrupt]
> 
> Again, you have a 'wire' from the device to the MSI unit (MBIGEN) and
> we do not care about that 'wire' either. What we care about is how we
> find the MSI (mbigen) configuration registers for a particular
> device. So we need a DT/ACPI entry which describes those configuration
> registers and whatever supplementary information is required. That
> will make the mbigen driver extremly simple.

It makes mbigen simple indeed, but it also makes other parts more complex:

- mbigen needs to implement its own MSI layer (we cannot use the
platform one for that)

- it effectively becomes part of the ITS driver (it needs to pass the
device IDs down to the core ITS code instead of relying on the ITS
platform MSI code).

- this probably means introducing some new probing infrastructure so
that the device msi_domain field can be populated with the right domain
(I'm not sure the platform probing does the right thing in that case)

- drivers that aren't MSI aware need to be extended to talk to this new
MSI provider.

- drivers that already support MSI natively (like the ARM SMMUv3, see
http://www.spinics.net/lists/arm-kernel/msg452057.html) will have to be
hacked to also work with this new method.

To me, it feels like we're spreading the complexity across multiple
layers instead of keeping it localized. It also means that next time
some crazy HW dude comes up with a similar idea (and I have little doubt
this will happen sooner than later), we'll have to replicate the same
thing again (though we could put all that behind another abstraction layer).

I would have preferred a solution where the MSI domain is allowed to be
sandwiched between two non-MSI domains, and expose the top level
irqchip. This means fixing the following:

- Either find a way to prevent DT doing these early IRQ allocations
(this could be easily done by simply not registering the irqchip), or be
able to elegantly reuse them.

- Add an API allowing an MSI domain to be the parent of another domain.

Once we have this, we can use the platform MSI layer for the mbigen
without much complexity (well, not more that any other stacked irqchip,
the madness of the mbigen programming interface notwithstanding), and
drivers stay untouched. It would also give us a 'standard' way to deal
with the above HW dude. I'd be happy to prototype it.

Now, I'm not going to make that a religious affair. If you still think
I'm severely misguided, I'll stop arguing and we'll make it work
according to your plans.

You can now open fire! ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
