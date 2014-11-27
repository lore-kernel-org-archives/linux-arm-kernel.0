From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Nov 2014 14:19:58 +0000
Subject: [PATCH 1/2] ARM: tegra: irq: fix buggy usage of irq_data irq field
In-Reply-To: <20141127120826.GA25222@ulmo>
References: <1417024532-5777-1-git-send-email-marc.zyngier@arm.com>
 <1417024532-5777-2-git-send-email-marc.zyngier@arm.com>
 <20141127082836.GA19323@ulmo> <5476EA0A.7090406@arm.com>
 <20141127120826.GA25222@ulmo>
Message-ID: <5477330E.7020404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/14 12:08, Thierry Reding wrote:
> On Thu, Nov 27, 2014 at 09:08:26AM +0000, Marc Zyngier wrote:
>> Hi Thierry,
>>
>> On 27/11/14 08:28, Thierry Reding wrote:
>>> On Wed, Nov 26, 2014 at 05:55:31PM +0000, Marc Zyngier wrote:
>>>> The crazy gic_arch_extn thing that Tegra uses contains multiple
>>>> references to the irq field in struct irq_data, and uses this
>>>> to directly poke hardware register.
>>>>
>>>> But irq is the *virtual* irq number, something that has nothing
>>>> to do with the actual HW irq (stored in the hwirq field). And once
>>>> we put the stacked domain code in action, the whole thing explodes,
>>>> as these two values are *very* different:
>>>
>>> Do you have follow-up patches to use stacked domains on Tegra? I tried
>>> to move this driver out to drivers/irqchip at some point and that caused
>>> a bit of pain because of gic_arch_extn and probe order. At the time I
>>> was told that work was in progress to provide a more generic solution
>>> that could replace gic_arch_extn, which I'm assuming this stacked domain
>>> code is.
>>
>> I'm working on that at the moment, and things look pretty good. The only
>> issue I have so far is that this piece of HW needs to become the
>> top-level interrupt-parent for all devices that are currently
>> interrupting on the GIC. So far, the only solution I have is a change in
>> the DT. But arguably, this should have been described in DT too...
> 
> I think I had discussed this with Arnd (Cc'ed) at some point but I can't
> find a link to the discussion (perhaps it was on IRC). The outcome I
> think was that from the CPU's perspective the GIC would still be the
> interrupt parent of the devices, whereas the LIC would become the
> interrupt parent of the GIC.
> 
> Admittedly, though, everytime I think about this I start feeling dizzy,
> so perhaps I'm mixing this up again.
> 
> Maybe a picture to clarify for my own sake how this works:
> 
> 	             /-----\     /-----\     /-----\
> 	   various --|     |     |     |     |     |
> 	  hardware --| LIC |-----| GIC |-----| CPU |
> 	interrupts --|     |     |     |  |  |     |
> 	             \-----/     \-----/  |  \-----/
> 	                |                 |
> 	             /-----\              |  /-----\
> 	             |     |              |  |     |
> 	             | AVP |              ---| CPU |
> 	             |     |              .  |     |
> 	             \-----/              .  \-----/
> 	                                  .
> 
> That is, interrupts are first routed to the LIC, which will primarily be
> used by the AVP. The LIC is also configured (and that's the part where
> gic_arch_extn comes into play) to forward interrupts to the GIC which
> will distribute them to the Cortex-AXs.
> 
> Therefore, from the CPU perspective, the interrupt-parent of devices
> should still be the GIC, since that's where the interrupt numbers will
> need to come from in order to set up interrupt handlers. For any of
> these interrupts GIC will need to program LIC so that they are forwarded
> and can be used to wake up CPUs.
> 
> Doesn't that simplify everything to just adding an interrupt-parent
> property to GIC referencing LIC?

Actually, this is exactly the opposite! ;-)

>From a DT perspective, all devices (except those using PPIs) are
connected to the LIC. Therefore, their interrupt parent has to be the
LIC, and I don't think there is a way out of that.

Now, the stacked domains give you a lot of flexibility, and that's what
we need to implement this:
- The LIC gets its own domain, and so does the GIC.
- For virq X, you get hwirq Y in the LIC domain, and hwirw Z in the GIC
domain. The don't have to be identical.

For example, take the interrupt associated to UARTD, which happens to be
SPI90. Its virq is 279, its hwirq in the LIC domain is 90, and 122 in
the GIC.

When the interrupt fires, the domain lookup at the GIC level will
convert 122 (GIC) to 279 (virq), and process the the interrupt going
through the stacked domains, each domain processing its view of the
interrupt. Much nicer.

If course, all of this mandates that the device appears to be attached
to the LIC, but I believe that it is what both your drawing and the TRM
describe.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
