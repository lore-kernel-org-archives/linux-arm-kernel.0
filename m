From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 07 Apr 2012 09:37:50 +1000
Subject: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
In-Reply-To: <m24nsx9iz1.fsf@igel.home>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <20120402202848.1EB833E02A7@localhost>
 <20120402215524.GM24211@n2100.arm.linux.org.uk>
 <1333406005.30734.61.camel@pasglop>
 <20120402225223.GN24211@n2100.arm.linux.org.uk>
 <1333409927.30734.62.camel@pasglop> <m24nsx9iz1.fsf@igel.home>
Message-ID: <1333755470.3040.38.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-04-06 at 13:51 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Ok. Doesn't matter anyway, this shouldn't be the problem in this
> > specific case. IE. we shouldn't be setting that interrupt to NONE.
> 
> After removinge the call to irq_set_irq_type in mpic_host_map the irq
> problem disappears.
> 
> Instead of the irq_set_irq_type(,NONE) calls from mpic_host_map I see
> corresponding irq_set_irq_type(,LEVEL_LOW) calls now.

It's arguable that this irq_set_irq_type(,NONE) shouln't be there but
still ... it's been around for ever and things worked :-) So something
-else- is causing the problem and I'd like to understand what exactly.

(When I say arguable, I do mean it. There are some reasons to keep it
even if we agree that it's not "setting a default" but marking the
interrupt as somewhat disabled as Russell wants, that's fine with me, an
MPIC external interrupt should -always- have a proper type set before
being used).

First we need to fix that business with NR_IRQS/nr_irqs everywhere, then
if the problem persists, check why we aren't calling the proper
irq_set_irq_type() after the mapping is established (we should be).

Cheers,
Ben.
