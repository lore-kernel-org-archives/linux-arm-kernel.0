From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 May 2014 18:33:40 +0100
Subject: [PATCH v3] arm64: enable EDAC on arm64
In-Reply-To: <20140423170445.GI5649@arm.com>
References: <1398096556-26799-1-git-send-email-robherring2@gmail.com>
 <20140422102455.GD7484@arm.com>
 <CAL_JsqKS_NZbxq_nFBnsQvj51TtraEeFm0aY=j=N3DwJ+bTL6g@mail.gmail.com>
 <20140422132624.GC9820@arm.com>
 <CAL_JsqJEwUu0ooEcL+hniD8vxjBW5571ea3u3JmPN3x1MfXW3w@mail.gmail.com>
 <20140422160100.GH9820@arm.com>
 <CAL_Jsq+pcK4XvSyahaK8zoxNMWrebqsU+funBqzR9MBfK2ABYA@mail.gmail.com>
 <20140423170445.GI5649@arm.com>
Message-ID: <20140509173340.GO7950@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 06:04:45PM +0100, Will Deacon wrote:
> On Tue, Apr 22, 2014 at 05:29:52PM +0100, Rob Herring wrote:
> > On Tue, Apr 22, 2014 at 11:01 AM, Will Deacon <will.deacon@arm.com> wrote:
> > > Looking at the edac_mc_scrub_block code, atomic_scrub is always called with
> > > a normal, cacheable mapping (kmap_atomic) so that doesn't help us (although
> > > it means the exclusives will at least succeed).
> > >
> > > The problem of speculative reads by the CPU could be solved by unmapped the
> > > DMA buffer when we transfer the ownership over to the device (instead of
> > > invalidating it after the transfer). However, I'm now slightly confused as
> > > to how atomic_scrub fixes errors reported at any cache level higher than
> > > L1. Do we need cache-flushing to ensure that the exclusive-store propagates
> > > to the point of failure?
> > 
> > The whole point of scrubbing is to stop repeated error reporting of
> > correctable errors. For example, you do a write to memory and the ECC
> > code is added to it. Suppose the data stored in the memory gets
> > corrupted either on the write or some time later you get a bit flip in
> > the memory cell. Then when the data is read from memory, the memory
> > controller will detect the error, correct it, and trigger and ECC
> > correctable error interrupt. It will do this every time you read that
> > memory location because the error occurred on the write. The only way
> > to clear the error is re-writing memory.
> 
> Thanks for the explanation.
> 
> > As long as that cache line is dirty, no reads from that memory location
> > will occur as other readers will get the line from other cores, the L2, or
> > the line will get pushed out to memory first.
> 
> Agreed, if all of the readers are coherent.

Just to get things moving on this patch, do we agree that it is only safe
for coherent DMA? If so, do we merge it on the grounds that people
needing EDAC only use it with DMA-coherent memory? The comment for
atomic_scrub should be updated to state coherent DMA only.

We could check the dma_ops in atomic_scrub but I don't think it's worth
it.

-- 
Catalin
