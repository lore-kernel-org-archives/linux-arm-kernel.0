From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 1 Jun 2012 11:25:34 +0800
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <4FC816DF.4010801@gmail.com>
References: <4FC6E7CE.9090004@gmail.com>
 <CAHkRjk4suj4x-mJwvLeOYCNga_YvudNmnz7YxTSzFZ4Jj0iJ+w@mail.gmail.com>
 <4FC6FC38.8090904@gmail.com>
 <CAHkRjk4jJphxST86km4ybuVTGxAr-a=3Ag9cQpEysLYxBt-6WQ@mail.gmail.com>
 <4FC706DA.5040308@gmail.com> <20120531065603.GA2442@mbp>
 <4FC71C13.7090301@gmail.com> <4FC721DD.5020905@gmail.com>
 <CAHkRjk7qL1zDO4WD_LPh5v+v4aiU9Z1wHgMF3v=ykVUwKuw+YQ@mail.gmail.com>
 <4FC816DF.4010801@gmail.com>
Message-ID: <20120601032532.GA16273@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2012 at 02:11:59AM +0100, snakky.zhang at gmail.com wrote:
> On 2012?06?01? 00:04, Catalin Marinas wrote:
> > Rather than IPI we would better use the read-for-ownership trick like
> > in this patch to make flush_dcache_page global (no need for
> > write-for-ownership):
> 
> I think write for ownership is necessary for flush_dcache_xxx: Read
> guarantee local data cache get newest data, at the same time write
> guarantee the data can be flushed into memory.
> 
> See Section 7.1 of ARM11 MPCore. Processor Technical Reference 
> Manual(Revision: r2p0) P146/728:
> ======
> Clean Applies to write-back data caches. If the cache line targeted by
> the Clean operation contains stored data that has not yet been written
> out to main memory, it is written to main memory, and the line is
> marked as clean.
> ======
> 
> So I am afraid without the write action, the "clean & invalidate"
> action later will not write data back to main memory.

If there is a dirty cache line, it will be written to memory by the
clean&invalidate operation. If the data in the cache line is in a clean
state, it means that it is identical to the main memory (or L2 if
present).

With just a read, clean&invalidate would not invalidate (remove) the
cache lines from the other CPUs. Doing a write forces the cache line to
only be present on the current CPU (though automatically invalidating it
on the other CPUs).

> Another question here:  Why the flush_kern_dcache_xxx in
> arch/arm/mm/cache-v6 use "clean & invalidate" progress instead of
> "clean"? Seems clean is enough here.

I think in the context of VIPT caches clean would be enough.

> > http://dchs.spinics.net/lists/arm-kernel/msg125075.html
> >
> > (it may no longer apply, I haven't checked it for some time).
> >
> > That's the first thing. Secondly you still need preemption disable so
> > that it is not preempted between RFO and the actual cache cleaning.
>
> PREEMPT. :-)
> 
> Get it. But currently, I can't find anything related to ARMv6 MPCore
> conflict with PREEMPT. So if it is also necessary to add something in
> Documentation and related Kconfig to describe it and make sure PREEMPT
> can't been enabled on such CPUs?

Well, we either get it to work or, if not possible, we add a comment.
Let's try the former option first :)

-- 
Catalin
