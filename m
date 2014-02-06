From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 12:23:40 +0000
Subject: [PATCH 3/6] irqchip: gic: use writel instead of dsb +
 writel_relaxed
In-Reply-To: <20140206121350.GQ26035@mudshark.cambridge.arm.com>
References: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
 <1391686253-13436-3-git-send-email-will.deacon@arm.com>
 <20140206114559.GK29446@arm.com>
 <20140206115121.GN26035@mudshark.cambridge.arm.com>
 <20140206115430.GN29446@arm.com>
 <20140206115739.GP26035@mudshark.cambridge.arm.com>
 <20140206120035.GQ29446@arm.com>
 <20140206121350.GQ26035@mudshark.cambridge.arm.com>
Message-ID: <20140206122340.GC32520@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 12:13:50PM +0000, Will Deacon wrote:
> On Thu, Feb 06, 2014 at 12:00:35PM +0000, Catalin Marinas wrote:
> > On Thu, Feb 06, 2014 at 11:57:39AM +0000, Will Deacon wrote:
> > > On Thu, Feb 06, 2014 at 11:54:30AM +0000, Catalin Marinas wrote:
> > > > On Thu, Feb 06, 2014 at 11:51:21AM +0000, Will Deacon wrote:
> > > > > On Thu, Feb 06, 2014 at 11:45:59AM +0000, Catalin Marinas wrote:
> > > > > > On Thu, Feb 06, 2014 at 11:30:50AM +0000, Will Deacon wrote:
> > > > > > > -	/* this always happens on GIC0 */
> > > > > > > -	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> > > > > > > +	writel(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> > > > > > 
> > > > > > That's heavier than a dsb() since with outer caches on ARM we also get
> > > > > > an outer_sync() call.
> > > > > 
> > > > > Yes, which I think we actually need in this case, since we're trying to make
> > > > > normal writes visible to a CPU before a device write hits the GIC.
> > > > 
> > > > If they are all in the inner shareable domain and with the caches
> > > > enabled, we don't need to flush the outer cache (as in the PL310 case
> > > > which is common to all CPUs; other saner outer caches propagate the
> > > > barrier ;). The outer_sync is needed when the memory accesses are
> > > > non-cacheable and we need to drain both the CPU write-buffer and the
> > > > PL310 one.
> > > > 
> > > > For our case here, we only need to ensure the visibility of writes on a
> > > > CPU to another but assuming SMP and caches enabled, so DSB is enough.
> > > 
> > > Hmm, but we *do* use this for boot and need to ensure that any mailboxes are
> > > visible. Maybe we have enough cacheflushing/barriers for that already, but
> > > I'm really uncomfortable making this a simple dsb(ishst).
> > 
> > For boot we explicitly flush the caches for the shared data, so we don't
> > need this. The dsb() here is for standard smp_call_* etc. We didn't have
> > outer_sync() before, so you are slightly changing the functionality here
> > (arguably, ishst is relaxing the requirements but I'm not worried about
> > this, I consider that's the standard use-case for this function).
> 
> Ok, so if we assume that a dsb(ishst) is sufficient because the CPU we're
> talking to is either (a) coherent in the inner-shareable domain or (b)
> incoherent, and we flushed everything to PoC, then why wouldn't a dmb(ishst)
> work?

Because you want to guarantee the ordering between a store to Normal
Cacheable memory vs store to Device for the IPI (see the mailbox example
in the Barrier Litmus section ;)). The second is just a slave access, DMB
guarantees observability from the master access perspective.

-- 
Catalin
