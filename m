From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Oct 2009 22:18:33 +0100
Subject: coherent memory should be ARMv6's Device Memory?
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BB47FD79@dbde02.ent.ti.com>
References: <ede8cc2f231dda80cc85839cb94ec565.squirrel@www.codeaurora.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BB47FD79@dbde02.ent.ti.com>
Message-ID: <1256246313.5076.12.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-10-22 at 02:05 +0530, Shilimkar, Santosh wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> > arm-kernel-bounces at lists.infradead.org] On Behalf Of
> > adharmap at codeaurora.org
> > Sent: Thursday, October 22, 2009 1:20 AM
> > To: linux-arm-kernel at lists.infradead.org
> > Subject: coherent memory should be ARMv6's Device Memory?
> > 
> > The current implementation of __dma_alloc  on ARMv7 based cpu
> > returns
> > Strongly Ordered Memory. On my uniprocessor  hardware the strongly
> > ordered
> > memory causes the reads after a DMA_FROM_DEVICE transfer to be slow.
> > I
> > think __dma_alloc returns StronglyOrdered memory on all v6 and v7
> > variants
> > where arch_is_coherent is false.
> > 
> > In my opinion, coherent memory should be changed from Strongly
> > Ordered
> > Memory to device memory for the following reasons
> > 1. Device and Strongly Ordered are both non-cacheable and hence
> > shareable
> > and coherent.
> > 2. There are no speculative fetches from Device and StronglyOrdered
> > 3. The Program order is guaranteed for access to Device and Strongly
> > Order
> > memory
> > 4. Device accesses don't insert a "dmb" after each accesses and
> > hence are
> > faster
> > 
> > I am thinking of changing the pgprot_uncached to pgprot_device  in
> > dma_alloc_coherent in dma-mapping.c.
> 
> Just think about the DMA usage where DMA don't see the same copy in
> the memory because some data is still there in the Write buffer. This
> means which such a memory you always need to have DWB / DSB to ensure
> that your DMA sees correct copy. Effectively you are taking away the
> buffering advantage because DMA needs it that way.

It depends on the amount of data you write, the CPU may optimise
accesses to device or normal uncached memory much better than SO memory
(which looks pretty much like having a DSB after every access).

-- 
Catalin
