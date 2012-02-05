From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sun, 05 Feb 2012 11:01:05 +1100
Subject: [PATCH v3 00/25] irq_domain generalization and refinement
In-Reply-To: <20120204221748.GN14129@n2100.arm.linux.org.uk>
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <20120204221748.GN14129@n2100.arm.linux.org.uk>
Message-ID: <1328400065.30631.9.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-02-04 at 22:17 +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 27, 2012 at 02:35:54PM -0700, Grant Likely wrote:
> > Hey everyone,
> > 
> > This patch series is ready for much wider consumption now.  I'd like
> > to get it into linux-next ASAP because there will be ARM board support
> > depending on it.  I'll wait a few days before I ask Stephen to pull
> > this in.
> 
> Grant,
> 
> Can you answer me this: does this irqdomain support require DT?

The original powerpc code this is based on didn't require it. It was an
explicit design decision and I remember insisting that Grant follows it,
but I haven't yet reviewed his last batch.

DT is orthogonal. You have "helpers" that use the DT to resolve the
domain of an interrupt source and do the mapping for you, but I made
sure that you call always still create domains and map interrupts using
explicit domain pointers & hw numbers.

(And I need them to deal with ancient broken device-tree's on some
platforms such as oldworld PowerMacs).

> The question comes up because OMAP has converted some of their support
> to require irq domain support for their PMICs, and it seems irq domain
> support requires DT.  This seems to have made the whole of OMAP
> essentially become a DT-only platform.

 .../...

> Now, here's the thing: I believe that IRQ domains - at least as far as
> the hwirq stuff - should be available irrespective of whether we have
> the rest of the IRQ domain support code in place, so that IRQ support
> code doesn't have to keep playing games to decode from the global
> space to the per-controller number space.
> 
> I believe that would certainly help the current OMAP problems, where
> the current lack of CONFIG_IRQ_DOMAIN basically makes the kernel oops
> on boot.
> 
> How we fix this regression for 3.4 I've no idea at present, I'm trying
> to work out what the real dependencies are for OMAP on this stuff.
> 
> Finally, do we need asm/irq.h in our asm/prom.h ?  That's causing
> fragility between DT and non-DT builds, because people are finding
> that their DT builds work without their mach/irqs.h includes but
> fail when built with non-DT.  The only thing which DT might need -
> at the most - is NR_IRQS, but I'd hope with things like irq domains
> it doesn't actually require it.

Cheers,
Ben.
