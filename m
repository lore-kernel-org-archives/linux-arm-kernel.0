From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 22 Sep 2010 00:06:37 -0300
Subject: Regarding hw irq to Linux irq mapping on ARM
In-Reply-To: <1285106546.30449.158.camel@pasglop>
References: <AANLkTi=6nCJnfLB1uc0uLGOvOm0CX_R=j-8GQWTzmmep@mail.gmail.com>
	<AANLkTimp7+BLNBwZyBiPS0JgB_mno+gp8+mK=VdOd3+_@mail.gmail.com>
	<1285106546.30449.158.camel@pasglop>
Message-ID: <AANLkTi=0sXNWcDsw0ddUeFdkLkVnD3tvM8XSXksDhXVd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 21, 2010 at 7:02 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2010-09-21 at 16:57 -0300, Grant Likely wrote:
>> I don't have any immediate plans, but this topic has come up a lot in
>> the last two weeks, so I guess I need to focus on it. ?:-) ?[cc'ing
>> devicetree-discuss and linux-arm-kernel as well as Lorenzo and Eric
>> since this is a conversation that should be had publically]
>>
>> > Can you share with me your thoughts on it?
>> > I have browsed through the power pc code for the same. But not sure
>> > the same approach is usable on ARM as well.
>>
>> I haven't thought deeply about the powerpc implementation of virqs to
>> determine if it is suitable for other architectures or not, but the
>> concept behind it is sound. ?We need a method of mapping controller
>> specific IRQ (or hw irq) numbers into the global Linux irq space
>> (referred to a virqs from this point on). ?First it requires a
>> per-controller reference which can be a pointer to a per-controller
>> data structure, or any other unique identifier. ?It could even be the
>> interrupt controller device tree node pointer. ?Just so long as there
>> is a reliable method to derive the virq from the controller reference
>> + hw irq number.
>
> I like keeping it somewhat orthogonal. See how I do that on powerpc.
> That way, you can still exploit it, map interrupts etc... even if your
> device-tree happens to be deficient or missing.

Good point.

> The main grief one could have with my scheme is the naming of irq_host
> which has confused people in the past. It should probably be irq_domain
> to make clear what it is. It generally have a 1:1 relationship to the
> irq_chip but there are cases where that isn't the case (essentially
> where you have multiple irq_chip per domain) for various reasons so it's
> better to keep those separate.

Maybe I'll look at crafting a patch to rename it to irq_domain.  It
will be a large patch (about 250 matches), but it would be worth it
for the clarity if the code gets generalized.

g.
