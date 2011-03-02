From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 02 Mar 2011 10:16:51 +0000
Subject: Store buffer and l2x0_cache_sync
In-Reply-To: <AANLkTi=CzrVuqA0V-_kRnLWOHVw7aOzDpuJfvSD9Vdhx@mail.gmail.com>
References: <AANLkTi=CzrVuqA0V-_kRnLWOHVw7aOzDpuJfvSD9Vdhx@mail.gmail.com>
Message-ID: <1299061011.2493.28.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-02 at 01:25 +0000, Colin Cross wrote:
> l2x0_cache_sync on a PL310 has no wait after the writel_relaxed to the
> L2X0_CACHE_SYNC register, because PL310 cache operations are atomic.
> Doesn't the cpu store buffer still need to be flushed after the
> register write, either with a dsb or a dummy read?

You usually need the PL310 flush/sync (Device writes) to be ordered with
other Device write (for starting DMA for example) but since both are
Device accesses, they are ordered by the processor already.

In general it depends on what the device does. A write to a device isn't
guaranteed to change its state, in which case a read back would be
needed (rather than a DSB). My understanding of the PL310 is that the
cache sync write stalls the CPU write buffer until the operation
completed. So subsequent device writes in the buffer would wait for the
cache sync.

-- 
Catalin
