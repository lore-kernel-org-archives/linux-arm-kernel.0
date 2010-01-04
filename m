From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jan 2010 16:20:14 +0000
Subject: [PXA320] dmac_flush_range and burst on SMEMC
In-Reply-To: <354684.99618.qm@web23301.mail.ird.yahoo.com>
References: <354684.99618.qm@web23301.mail.ird.yahoo.com>
Message-ID: <20100104162014.GA14533@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 09:00:15AM +0000, Patrick wrote:
> I am using a PXA320 with a FPGA connected on the VLIO memory bus. For
> faster transfer between the PXA and the FPGA I would like to use burst
> (supported by the SMEMC in VLIO).
> 
> I was using a 2.6.26 kernel and burst was working very fine. I was using
> ioremap_cached and after a loop of iowrite32 and a call to dmac_flush_range
> to start the burst. It was working fine.

Note that this kind of abuse eventually runs into problems.  Just because
dmac_flush_range() seems to do what you want, that doesn't mean it will
always do so.

As an example, its counterparts, dmac_inv_range() and dmac_clean_range()
will be removed in the next kernel version, because they need to be changed
in order to support ARMv6 and ARMv7 CPUs with their speculative prefetching.

I need the freedom to change the backend interfaces of the major APIs
to ensure that the ARM kernel can continue to run on newer ARM CPUs.
Abusing the backend interfaces makes that job much harder without
causing breakage - and the more people who abuse the backend interfaces
the more likely I'm just going to turn around and say "tough, eat the
breakage, it's your problem".

Consider that when we get ARM CPUs which have DMA coherent caches, all
the dmac_* functions will become no-ops for those CPUs - which means if
you're using them for non-DMA purposes, suddenly they stop having the
effect you want them to.

> I have migrated to a 2.6.28 kernel with the same driver code. All the
> data writed by the loop of iowrite32 is lost and only the last burst is
> writed using PIO and no burst. It's like if dmac_flush_range is not
> working and flush no cash at all.

Nothing's changed with dmac_flush_range()... yet.  What you may be
experiencing is the effect of the L2 cache - Xscale3 CPUs have an L2
cache, and this isn't touched by dmac_flush_range().  outer_flush_range()
will do this, but note that it takes physical addresses.

> Do you have any idea ? Should I use another function than dmac_flush_range ?

I'm afraid we don't have any interfaces for operating on ioremapped
memory.

I think what you actually want to be doing is using ioremap_wc() to get
a write combining mapping, rather than a fully cached mapping, and using
dmb() to provide memory barriers.

(On dmb(), I think we should actually start moving ARMv6 and Xscale3 over
to using write combining mappings for DMA memory and the like, and using
proper mb(),rmb(),wmb() barriers, so that we don't end up with drivers
directly using our own dmb(),dsb(),isb().)
