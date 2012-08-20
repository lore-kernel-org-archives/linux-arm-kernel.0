From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Aug 2012 13:51:16 +0100
Subject: [PATCH 0/3] New algorithm for ASID allocation and rollover
In-Reply-To: <201208191521.37460.arnd@arndb.de>
References: <1345049642-29704-1-git-send-email-will.deacon@arm.com>
 <201208191521.37460.arnd@arndb.de>
Message-ID: <20120820125116.GM25864@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for the interest!

On Sun, Aug 19, 2012 at 04:21:37PM +0100, Arnd Bergmann wrote:
> On Wednesday 15 August 2012, Will Deacon wrote:
> > After some discussion, it became apparent that tracking the ASIDs
> > currently active on the cores in the system means that, on rollover, we
> > can automatically reserve those that are in use without having to stop
> > the world.
> 
> Just a question for my general understanding of how this is done: How do
> you know if an ASID is active or not? Do you broadcast flush an address
> space completely when the struct mm goes away, or do you keep track of
> which CPUs had TLBs in an ASIC when it went away and then flush that ASID
> when you reuse it on that CPU?

Ok, I'll address these in turn:

1. We know if an ASID is active or not by updating the per-cpu active_asids
   variable when switching mm.

2. Flushing (TLB invalidation) only happens when all ASIDs are dirty. So
   when a struct mm is freed, its ASID remains `dirty' in the asid_map.
   Eventually, no more ASIDs can be allocated, so the flushing takes place
   then. All v7 CPUs broadcast this operation in hardware. At this point, we
   mark all the active ASIDs as dirty to prevent them being re-allocated to
   different tasks.

I did play with per-ASID TLB-flushing depending on ASID pressure but I
couldn't find any benchmarks that showed an improvement.

Cheers,

Will
