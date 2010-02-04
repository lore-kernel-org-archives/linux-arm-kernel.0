From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 4 Feb 2010 10:45:29 +0530
Subject: [RFC PATCH] ARM: Change the mandatory barriers implementation
In-Reply-To: <4B6A131B.1070005@codeaurora.org>
References: <20100203161434.15912.42697.stgit@pc1117.cambridge.arm.com>
	<4B6A131B.1070005@codeaurora.org>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C0B421AC@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Abhijeet Dharmapurikar
> Sent: Thursday, February 04, 2010 5:52 AM
> To: Catalin Marinas
> Cc: Daniel Walker; Russell King; Tony Lindgren; linux-arm-msm at vger.kernel.org; linux-
> kernel at vger.kernel.org; Larry Bassel; linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC PATCH] ARM: Change the mandatory barriers implementation
> 
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
This may be true if the DMA engine is an observer in the cluster. Without
coherence hardware, DMA won't see the correct data without draining the write
buffer. So DSB is necessary in DMA case at least.

Regards,
Santosh
