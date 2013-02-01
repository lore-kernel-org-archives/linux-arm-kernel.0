From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 1 Feb 2013 14:10:52 +0000
Subject: [PATCHv2 for soc 3/4] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <20130201125417.GL23505@n2100.arm.linux.org.uk>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-4-git-send-email-dinguyen@altera.com>
 <510BA728.4060300@ti.com>
 <20130201121137.GC23869@e102568-lin.cambridge.arm.com>
 <20130201125417.GL23505@n2100.arm.linux.org.uk>
Message-ID: <20130201141052.GA25172@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 12:54:17PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 01, 2013 at 12:11:38PM +0000, Lorenzo Pieralisi wrote:
> > Well, on latest processors (A15, A7) caches are invalidated on reset unless
> > the chip is programmed to skip that on reset (ie L2 retained).
> > 
> > But it makes sense, for sure it should not be called v7_invalidate_l1,
> > but invalidate_louis, and instead of forcing level 0 we should be
> > reading LoUIS and invalidate up to that level as we do in the clean and
> > invalidate function.
> 
> No.  Think about it.  c7, c6, 2 _invalidates_ the cache.  That means any
> data contained within the cache is discarded.  Data is not written back.
> 
> If you do this down to the LoUIS, that includes all cache levels in the
> inner sharable domain.  The inner sharable domain includes the other CPUs
> in the system which may already be running (certainly the boot CPU will
> be running).

On all v7 ARM systems I know of LoUIS correspond to L1 and using LoUIS is a
plaster that works for current systems (where by LoUIS I mean all cache
levels down to but not inclusive of, LoUIS).

What you are saying is true for cpu_suspend code and hotplug as well, there we
are cleaning and invalidating down to the LoUIS, which might not be needed
since LoUIS does not mean that all cache levels included are _local_ to the
CPU.

There is no way on ARM systems to detect what cache levels are local to
a CPU, so we decided to use LoUIS for that, as a temporary solution to
avoid cluttering the code with DT bindings that link cache topology and
CPU topology.

And on all ARM systems in the mainline "operating on all levels down to
but not inclusive of LoUIS" is equivalent to cache levels local to a CPU,
if it is not I am missing something and I apologize.

> Are you _really_ sure you want to be invalidating _valid_ data held in
> caches in the inner sharable domain by other CPUs, rather than just the
> cache associated with the CPU which is being brought online?

We know that LoUIS corresponds to cache levels local to a CPU for now and we
know that it will fail as soon as there are caches in the inner shareability
domain that belong to multiple CPUs. Again, that's valid for the clean
and invalidate functions as well (though there it is an optimization
problem, here I agree is a validity issue and more serious).

There is no way to detect cache levels local to a CPU, I tried to do
that before posting the new LoUIS API, and all I can say is that we need
device tree bindings to do that cleanly, architecturally it is just not
detectable.

I am happy to discuss a way forward Russell, your concerns are correct,
we are aware of them and happy to improve the code to make it work
consistently.

Thanks,
Lorenzo
