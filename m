From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Jul 2011 12:14:36 +0100
Subject: [PATCH v8 14/14] ARM: gic: add gic_ppi_map_on_cpu()
In-Reply-To: <20110711101750.GE3239@n2100.arm.linux.org.uk>
References: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
	<1309855755-6261-15-git-send-email-marc.zyngier@arm.com>
	<20110708195708.GR4812@n2100.arm.linux.org.uk>
	<20110710161038.46770f08@taxman.wild-wind.fr.eu.org>
	<20110710153759.GI4812@n2100.arm.linux.org.uk>
	<20110710183039.GJ4812@n2100.arm.linux.org.uk>
	<4E1AC7C5.9020909@arm.com>
	<20110711101750.GE3239@n2100.arm.linux.org.uk>
Message-ID: <4E1ADB1C.80504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/11 11:17, Russell King - ARM Linux wrote:
> On Mon, Jul 11, 2011 at 10:52:05AM +0100, Marc Zyngier wrote:
>> You won't be surprised if I say that I prefer your first version. The
>> second one, while much simpler, keeps the additional low level entry
>> point (gic_call_ppi), and has to do its own accounting.
>>
>> But more than that. MSM timers are implemented using the same code on
>> both UP and SMP, with or without GIC. which means we have to request the
>> interrupt using the same API. Your first version would work in that case
>> (gic_ppi_map() on a non-PPI should return the same number).
> 
> Who says gic_request_ppi() will exist on systems without GIC?  Or
> even gic_ppi_map()?
> 
> Let me make the point plain: no driver must EVER use gic_ppi_map().
> No driver must EVER call request_irq() any other genirq function for
> a PPI interrupt directly.  They must all be wrapped in suitable
> containers to bind the current thread to the current CPU.  Not doing
> so will lead to failures due to the wrong CPUs registers being hit.

I didn't suggest using request_irq() on a PPI. I suggested using
gic_request_ppi() on a normal IRQ number (which is ugly but would work).

If gic_request_ppi() is not available for non GIC setups, then at least
the MSM timer code must be fixed.

>>> There's also the question about whether we should pass in the desired CPU
>>> number to these too, in case we have a requirement to ensure that we get
>>> the PPI on a specific CPU, or whether we only care about the _current_
>>> CPU we happen to be running on.
>>
>> As long as we tie mapping and interrupt request together, there is no
>> reason to offer that functionality. But DT may need to resolve the
>> mappings independently (while creating the platform devices), and the
>> driver would then request the mapped PPI. In that case, we need to
>> ensure we're running on the right CPU.
> 
> You still don't get the issue.  Really you don't.  And you don't seem
> to get DT either.
> 
> DT has precisely nothing to do with this, and should never have anything
> to do with this kind of mapping.  Mapping a PPI + CPU to a _Linux_ IRQ
> number is a _Linux_ specific operation.  It's not something that will
> be acceptable to be represented in DT.  What DT describes is the
> _hardware_.  So, if DT wants to describe a PPI, then DT should describe
> PPI N on CPU N.

And that's exactly what it does:
http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg05026.html

What I was trying to explain (and obviously failed to) is that the
_Linux_ DT _code_ will try to resolve the PPI number and convert it to a
_Linux_ IRQ number. Unless of course you don't encode it as an interrupt
at all, which seems to be what you're aiming for.

> However, the basis of my argument is that this has got precisely nothing
> to do with the mapping of PPIs to IRQ numbers.  It's about the using
> unique IRQ numbers to describe an IRQ which can _only_ be accessed on one
> particular CPU.
> 
> The PPIs are really not standard interrupts.  Trying to treat them as such
> means that all the standard genirq interfaces will need to be _wrapped_ to
> ensure that they're bound to the particular CPU that you're interested in.
> 
> The reason for that is to ensure that you hit the right hardware registers
> for the IRQ number you're passing in.  Using my previous example, it's no
> good if you pass in IRQ9 (PPI2 CPU1) but end up hitting IRQ11's (PPI2 CPU3)
> registers instead.

I've understood that loud and clear.

> Plus, someone will have to audit drivers even more carefully to ensure that
> they're not trying to use the standard request_irq() (or any other of the
> genirq interfaces) with PPI interrupt numbers.  Who's going to do that?
> 
> So, I believe your patches are fundamentally misdesigned on a technical
> level, are fragile, and therefore are not suitable for integration into
> mainline.


-- 
Jazz is not dead. It just smells funny...
