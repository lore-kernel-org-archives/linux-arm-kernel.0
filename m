From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 22 Jan 2014 15:31:17 -0700
Subject: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
In-Reply-To: <20140122221237.GA30763@localhost>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
 <20140122164904.GB27273@localhost>
 <20140122173417.GT18269@obsidianresearch.com>
 <52E02AB6.7040104@gmail.com>
 <20140122205213.GW18269@obsidianresearch.com>
 <20140122221237.GA30763@localhost>
Message-ID: <20140122223117.GX18269@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 07:12:38PM -0300, Ezequiel Garcia wrote:
> On Wed, Jan 22, 2014 at 01:52:13PM -0700, Jason Gunthorpe wrote:
> > > Clearing BRIDGE_CAUSE will only clear all currently pending upstream
> > > IRQs, of course. If WDT IRQ will be re-raised right after that in
> > > BRIDGE_CAUSE depends on the actual HW implementation, i.e. we do no
> > > clear the causing IRQ itself but just what it raised in BRIDGE_CAUSE.
> > 
> > Which is why it makes no sense to clear it one time at kernel start.
> > 
> 
> So, it seems we need to handle irq_startup(), as you suggested.
> I've just tested the attached patch, and it's working fine: the driver's
> probe() fully stops the watchdog, and then request_irq() acks and
> pending interrupts, through the added irq_startup().
> 
> How does it look?

Looks sane to me.

I looked some more and there are other drivers (eg irq-metag-ext) that
take this same approach.

Sebastian:
I looked at the irq-orion driver a bit more and noticed this:

        ret = irq_alloc_domain_generic_chips(domain, nrirqs, 1, np->name,
                             handle_level_irq, clr, 0, IRQ_GC_INIT_MASK_CACHE);
                           ^^^^^^^^^^^^^^^^^^^^^
Shouldn't it be handle_edge_irq? Otherwise who is calling irq_ack? How
does this work at all? :)

Jason
