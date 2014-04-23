From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Apr 2014 18:04:45 +0100
Subject: [PATCH v3] arm64: enable EDAC on arm64
In-Reply-To: <CAL_Jsq+pcK4XvSyahaK8zoxNMWrebqsU+funBqzR9MBfK2ABYA@mail.gmail.com>
References: <1398096556-26799-1-git-send-email-robherring2@gmail.com>
 <20140422102455.GD7484@arm.com>
 <CAL_JsqKS_NZbxq_nFBnsQvj51TtraEeFm0aY=j=N3DwJ+bTL6g@mail.gmail.com>
 <20140422132624.GC9820@arm.com>
 <CAL_JsqJEwUu0ooEcL+hniD8vxjBW5571ea3u3JmPN3x1MfXW3w@mail.gmail.com>
 <20140422160100.GH9820@arm.com>
 <CAL_Jsq+pcK4XvSyahaK8zoxNMWrebqsU+funBqzR9MBfK2ABYA@mail.gmail.com>
Message-ID: <20140423170445.GI5649@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 05:29:52PM +0100, Rob Herring wrote:
> On Tue, Apr 22, 2014 at 11:01 AM, Will Deacon <will.deacon@arm.com> wrote:
> > Looking at the edac_mc_scrub_block code, atomic_scrub is always called with
> > a normal, cacheable mapping (kmap_atomic) so that doesn't help us (although
> > it means the exclusives will at least succeed).
> >
> > The problem of speculative reads by the CPU could be solved by unmapped the
> > DMA buffer when we transfer the ownership over to the device (instead of
> > invalidating it after the transfer). However, I'm now slightly confused as
> > to how atomic_scrub fixes errors reported at any cache level higher than
> > L1. Do we need cache-flushing to ensure that the exclusive-store propagates
> > to the point of failure?
> 
> The whole point of scrubbing is to stop repeated error reporting of
> correctable errors. For example, you do a write to memory and the ECC
> code is added to it. Suppose the data stored in the memory gets
> corrupted either on the write or some time later you get a bit flip in
> the memory cell. Then when the data is read from memory, the memory
> controller will detect the error, correct it, and trigger and ECC
> correctable error interrupt. It will do this every time you read that
> memory location because the error occurred on the write. The only way
> to clear the error is re-writing memory.

Thanks for the explanation.

> As long as that cache line is dirty, no reads from that memory location
> will occur as other readers will get the line from other cores, the L2, or
> the line will get pushed out to memory first.

Agreed, if all of the readers are coherent.

> I guess you could see an invalidate on DMA memory causing the scrub to get
> lost, but that doesn't really matter.  It would be harmless to get the
> error again other than making your error rate seem higher (which is
> something OEMs are very sensitive to). You are doing the invalidate so
> that DMA can write new data anyway.

Also agreed that the error-rate could be higher, but I still think there's
a corruption issue here as well.

To be clear:

 (1) The CPU maps a non-coherent, streaming DMA buffer for a device to
     populate (i.e. cache cleaning).

 (2) The device starts writing to the buffer

 (3) Whilst the device is writing, the CPU performs a speculative read
     from the buffer and an ECC error occurs. The error is corrected and
     the CPU gets a clean line, whilst an interrupt is pended at the GIC
     to inform the CPU about the error.

 (4) The CPU takes the interrupt and starts scrubbing the line. It issues
     the exclusive load but then...

 (5) The device writes the location in question. The error is cleared (not
     that we really care) and the memory location now contains new data

 (6) The CPU continues with its scrub, executing a successful
     exclusive-store of *stale* data back to the memory location, but
     allocating into L1.

 (7) Before the DMA completes, the line gets evicted from L1 and back to
     main memory, corrupting the DMA transfer.

So that's more serious that inflated reports -- we're turning a corrected
error into a data corruption.

Will
