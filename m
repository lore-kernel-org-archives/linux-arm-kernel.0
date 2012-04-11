From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 11 Apr 2012 11:13:54 +1000
Subject: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
In-Reply-To: <m2aa2n7mmw.fsf@igel.home>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <20120402202848.1EB833E02A7@localhost>
 <20120402215524.GM24211@n2100.arm.linux.org.uk>
 <1333406005.30734.61.camel@pasglop>
 <20120402225223.GN24211@n2100.arm.linux.org.uk>
 <1333409927.30734.62.camel@pasglop> <m24nsx9iz1.fsf@igel.home>
 <1333755470.3040.38.camel@pasglop> <m2aa2n7mmw.fsf@igel.home>
Message-ID: <1334106834.2984.17.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-04-07 at 14:27 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > It's arguable that this irq_set_irq_type(,NONE) shouln't be there but
> > still ... it's been around for ever and things worked :-) So something
> > -else- is causing the problem and I'd like to understand what exactly.
> 
> AFAICS before a09b659cd68c10ec6a30cb91ebd2c327fcd5bfe5
> irq_set_irq_type(,NONE) was actually a no-op.

So I'm still a bit baffled... ie, I understand some of what's happening
but not why it breaks things, I haven't yet managed to reproduce but I
haven't tried too hard just yet (was away from the HW) :

Basically, we end up setting the mpic to IRQ_TYPE_LEVEL_LOW as a result
of a request to set it to IRQ_TYPE_NONE, ie, we apply a "default"
setting instead of just setting it to "none" (in part because we don't
have a way in HW to disable the trigger completely. We then write that
into the irq_desc with irqd_set_trigger_type().

Then we return IRQ_SET_MASK_OK_NOCOPY, which means that the generic
__irq_set_trigger() code will read back what we've set in the desc and
adjust things accordingly, rather than writing the original value in,
ie, our descriptor ends up being effectively set to IRQ_TYPE_LEVEL_LOW
rather than IRQ_TYPE_NONE.

Later, when we actually try to set it to IRQ_TYPE_LEVEL_LOW as a result
of parsing the device-tree, we then hit the code
irq_create_of_mapping(), at the bottom, which will skip the call to
irq_set_irq_type() if we are trying to set it to the same type that it's
already set to....

But I don't see why that breaks anything, ie we -have- set things to
LEVEL_LOW as a result of IRQ_TYPE_NONE, which is the right setting, so
things should work despite the fact that we skip the second call.

Out of curiosity, can you try removing the check in irqdomain and always
apply the setting regardless of the previous value (ie, remove the check
of type against irqd_get_trigger at the end of irq_create_of_mapping),
see if that makes a difference ?

Cheers,
Ben.
