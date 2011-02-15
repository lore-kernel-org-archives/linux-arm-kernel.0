From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 14:12:53 +0000
Subject: [RFC] ARM: dma-mapping: outer cache is invalidated twice
In-Reply-To: <AANLkTi=Fs5+3yG-_4u0oU8WK4K4FU_8zN38H=RNcgRNU@mail.gmail.com>
References: <AANLkTi=rZJq0CPQD0Q1HMgih7UP0Tqoh9sPEYb2NEV_X@mail.gmail.com>
	<20110215133232.GI4152@n2100.arm.linux.org.uk>
	<20110215134134.GA17208@n2100.arm.linux.org.uk>
	<AANLkTi=Fs5+3yG-_4u0oU8WK4K4FU_8zN38H=RNcgRNU@mail.gmail.com>
Message-ID: <20110215141253.GJ4152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 02:54:21PM +0100, Per Forlin wrote:
> I don't fully understand this yet. I think you are right but I need a
> little help to get there myself.
> I agree, the cache (L1 and L2) must be invalidated after the DMA has completed.
> Before starting the DMA the write buffers must be drained (cache_sync).
> 
> Why invalidate the cache before starting the DMA?

Think about what happens if you have dirty cache lines in the DMA region.
These can be evicted when other cache lines are loaded, which will result
in them overwriting contents of memory.  If the DMA device has already
written to that memory, the result is data corruption.

So, the invalidate prior to DMA is to get rid of any dirty cache lines
which could be written back to memory.
