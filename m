From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 25 Jul 2011 20:33:55 +0530
Subject: [PATCH 0/4] Fix CPU hotplug IRQ migration
In-Reply-To: <20110725144634.GC14955@n2100.arm.linux.org.uk>
References: <20110721151413.GD28942@n2100.arm.linux.org.uk>
	<4E290C05.7020209@ti.com> <4E2D69C7.4040609@ti.com>
	<20110725132353.GJ9653@n2100.arm.linux.org.uk>
	<4E2D7D58.8080309@ti.com>
	<20110725144634.GC14955@n2100.arm.linux.org.uk>
Message-ID: <4E2D85DB.8030902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/25/2011 8:16 PM, Russell King - ARM Linux wrote:
> On Mon, Jul 25, 2011 at 07:57:36PM +0530, Santosh Shilimkar wrote:
>> Will make you OMAP4 IRQ code available for this particular aspect and
>> may be we can take it from there. There are two main problems I am
>> seeing currently.
>>
>> 1)Which CPU gic_arch_extn_[mask/unmask] operate on?
>> Can we assume that whichever CPU the call being executed
>> should be the target CPU ? This might not be safe assumption
>> though. For the extn, there is no other way to know the target
>> CPU for mask/unmask of an IRQ
>
> This goes back to the mistake that was made with the initial set of
> GIC PPI patches.
>
> You can't assume anything about which CPU the mask/unmask functions end
> up running on.  Between code calling request_irq() and the relevant
> unmask function being called, we can end up scheduling, either because
> of a mutex being waited for or because of a preemption event.  That
> means we can end up on a different CPU to that which we started out
> on.
>
Thanks for confirming the same.

> So, the only thing you can do is remember the CPU number which it was
> last associated with - a simple 'unsigned int' should do in the
> extensions data structures, one per IRQ.
>
How do you build the per IRQ CPU association information?
The point is fist mask/unmask call itself can be happening from
a CPU which is not the target CPU for that IRQ.
We can do something like GIC init does. Mark all the IRQ's
to boot CPU, save this info and keep using it in mask/unmask.
This association can be changed by CPU hotplug or force IRQ
affinity setting and we take care of updating the stored
PER IRQ cpu association.

> However, my point is that doing this:
>
> 	gic_arch_extn.irq_set_affinity(d, cpumask_of(cpu), force);
>
> and then:
>
> 	cpu = cpumask_first(affinity);
>
> in the extensions code is a very long winded way of communicating a
> single CPU number down into the IRQ extension code.
Agree. As you suggested , the GIC code recompose a CPU mask
containing exactly one CPU and relaying that information with
some custom function might be more efficient.

Regards
Santosh
