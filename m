From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 13 May 2010 14:42:31 +1000
Subject: Rampant ext3/4 corruption on 2.6.34-rc7 with VIVT ARM (Marvell
	88f5182)
In-Reply-To: <20100513121302Z.fujita.tomonori@lab.ntt.co.jp>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C545537F@dbde02.ent.ti.com>
	<20100512222154.GA6841@shareable.org>
	<1273704431.21352.136.camel@pasglop>
	<20100513121302Z.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <1273725751.21352.176.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-13 at 12:12 +0900, FUJITA Tomonori wrote:
> X86 OOSTORE uses a memory barrier dma_sync_single_for_device (seems
> that some mips archs also use it and do cache operations).
> 
> I think that the DMA-API says that
> 
> - dma_sync_single_for_device() makes sure the data ready for DMA.
> 
> - dma_sync_single_for_cpu() makes sure that drivers doesn't get the
>   stale data after DMA.
> 
> I guess, it means if an architecture need a memory barrier (not only
> cache operations) to guarantee the above, the architecture needs to
> take care of it. 

Right, but doing an indirect function pointer call for a memory barrier
in what can be a pretty hot code path doesn't sound like a great idea
if it can be avoided. I'd rather we define some inline that the arch
can stick in there if it wishes so.

Cheers,
Ben.
