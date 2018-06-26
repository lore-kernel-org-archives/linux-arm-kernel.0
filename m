From: toshi.kani@hpe.com (Kani, Toshi)
Date: Tue, 26 Jun 2018 15:25:39 +0000
Subject: [PATCH v3 0/3] fix free pmd/pte page handlings on x86
In-Reply-To: <20180626085449.GU28965@dhcp22.suse.cz>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
 <alpine.DEB.2.21.1806241516410.8650@nanos.tec.linutronix.de>
 <1529938470.14039.134.camel@hpe.com>
 <20180625175225.GQ28965@dhcp22.suse.cz>
 <1529961187.14039.206.camel@hpe.com>
 <20180626063521.GT28965@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806261043080.2204@nanos.tec.linutronix.de>
 <20180626085449.GU28965@dhcp22.suse.cz>
Message-ID: <1530026622.14039.269.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-06-26 at 10:54 +0200, Michal Hocko wrote:
> On Tue 26-06-18 10:45:11, Thomas Gleixner wrote:
> > On Tue, 26 Jun 2018, Michal Hocko wrote:
> > > On Mon 25-06-18 21:15:03, Kani Toshimitsu wrote:
> > > > Lastly, for the code maintenance, I believe this memory allocation keeps
> > > > the code much simpler than it would otherwise need to manage a special
> > > > page list.
> > > 
> > > Yes, I can see a simplicity as a reasonable argument for a quick fix,
> > > which these pile is supposed to be AFAIU. So this might be good to go
> > > from that perspective, but I believe that this should be changed in
> > > future at least.
> > 
> > So the conclusion is, that we ship this set of patches now to cure the
> > existing wreckage, right?
> 
> Joerg was suggesting some alternative but I got lost in the discussion
> to be honest so I might mis{interpret,remember}.

I've addressed his multiple comments in this series, but had to disagree
with his following suggestions:

1. Apply his revert patch first https://lkml.org/lkml/2018/4/26/636

Disagreed because this patch breaks the current ioremap() callers using
2MB mappings by failing pmd_free_pte_page().

2. Add a special page list, instead of memory alloc, in patch 3/3

Quoting his concerns about the memory allocation:
===
On Tue, May 29, 2018 at 04:10:24PM +0000, Kani, Toshi wrote:
> Can you explain why you think allocating a page here is a major
problem?

Because a larger allocation is more likely to fail. And if you fail the
allocation, you also fail to free more pages, which _is_ a problem. So
better avoid any allocations in code paths that are about freeing
memory.
===

Which I had replied as:
====
It only allocates a single page.  If it fails to allocate a single page,
this pud mapping request simply falls to pmd mappings, which is only as
bad as your suggested plain revert always does for both pud and pmd
mappings.  Also, this func is called from ioremap() when a driver
initializes its mapping.  If the system does not have a single page to
allocate, the driver has a much bigger issue to deal with than its
request falling back to pmd mappings.  Please also note that this func
is not called from free-memory path.
====

I have further summarized my reasons to keep the memory allocation in my
reply to Michal.  Another reason, which I forgot to mention, is that
ioremap() does not have an init interface to initialize a special page
list in architecture-specific way (and there is a good reason not to
have it).

> > Fine with that, but who will take care of reworking it proper? I'm
> > concerned that this will just go stale the moment the fixes hit the tree.
> 
> Yeah, this is why I usually try to push back hard because "will be fixed
> later" is similar to say "documentation will come later" etc...
> 
> A big fat TODO would be appropriate so it won't get forgotten at least.

I'd be happy to rework if we find a bug in the code.  But I do not think
we need to rework for the sake of possible future callers that nobody
knows for sure.  So, I will add the NOTE blow to clarify the pre-
requisite.
 
NOTE:
 - Callers must allow a single page allocation.

Thanks,
-Toshi
