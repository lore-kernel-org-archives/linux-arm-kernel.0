From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 04 Feb 2010 13:15:30 +0000
Subject: [RFC PATCH] ARM: Change the mandatory barriers implementation
In-Reply-To: <4B6A131B.1070005@codeaurora.org>
References: <4B6A131B.1070005@codeaurora.org>
Message-ID: <1265289330.28746.58.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-02-04 at 00:21 +0000, Abhijeet Dharmapurikar wrote:
> > The mandatory barriers (mb, rmb, wmb) are used even on uniprocessor
> > systems for things like ordering Normal Non-cacheable memory accesses
> > with DMA transfer (via Device memory writes). The current implementation
> > uses dmb() for mb() and friends but this is not sufficient. The DMB only
> > ensures the ordering of accesses with regards to a single observer
> > accessing the same memory. If a DMA transfer is started by a write to
> > Device memory, the data to be transfered may not reach the main memory
> > (even if mapped as Normal Non-cacheable) before the device receives the
> > notification to begin the transfer. The only barrier that would help in
> > this situation is DSB which would completely drain the write buffers.
> 
> On ARMv7, DMB guarantees that all accesses prior to DMB are observed by
> an observer if that observer sees any accesses _after_ the DMB. In this
> case, since DMA engine observes a write to itself( It is being written
> to and hence must observe the write) it should also see the writes to
> the buffers. A dmb() after the writes to buffer and before write to DMA
> engine should suffice.

I asked our processor architect for a clarification on the wording of
the DMB definition but the "all accesses" part most likely refer to
accesses to the same peripheral or memory block (but not together).
Intuitively, you can have a hardware configuration as below:

     CPU   Device
      |     | |
      +-----+ |      (1)
      |       |
    Buffer    |
      |       |
      +---+---+      (2)
          |
         RAM

The peripheral register write and memory write go on different paths. A
DMB may ensure the ordering at level (1) but there could be delays
before a write reaches the RAM and the peripheral would get the DMA
start notification before that. Only DSB would ensure the draining of
the buffer.

> Moreover an mb() could be in places where accesses to ARM's Device type
> memory need ordering and are 1kb apart. Such usages of mb() would result
> in a dsb() and could cause performance problems.

Note that accesses to Device memory are ordered relative to each-other
without any barrier. If you have weakly ordered I/O (not the ARM case),
there's mmiowb() for this.

If you need ordering between accesses to Normal memory and Device
memory, a DSB is needed, hence the definition of mb() to be a DSB (some
processors like Cortex-A8 implement DMB so that it drains the write
buffer but this is not always the case on other implementations).

Of course, there are situations when you only need ordering of Normal
memory accesses without any peripheral access and a DMB would be fine in
this situation. But so far Linux uses mb() for both situations, hence
I'm taking the less optimal approach for Normal-Normal ordering.

> Since you mention the write buffers this probably applies only to ARMv6.
> Correct me here, I think that dmb on ARMv6 should suffice too.

I can't guarantee. It depends on the processor implementation
(ARM11MPCore may have a different behaviour). Linux on ARM should pretty
much be architecturally generic.

-- 
Catalin
