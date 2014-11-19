From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 16:06:31 +0100
Subject: [PATCH 1/2] ARM: cache-l2x0: clean up aurora cache handling
In-Reply-To: <20141119145015.GG4042@n2100.arm.linux.org.uk>
References: <1547660.4MUNEQsfAo@wuerfel>
 <20141119145015.GG4042@n2100.arm.linux.org.uk>
Message-ID: <4475865.jdxZMh688N@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014 14:50:15 Russell King - ARM Linux wrote:
> On Wed, Nov 19, 2014 at 03:40:12PM +0100, Arnd Bergmann wrote:
> > The aurora cache controller is the only remaining user of a couple
> > of functions in this file and are completely unused when that is
> > disabled, leading to build warnings:
> > 
> > arch/arm/mm/cache-l2x0.c:167:13: warning: 'l2x0_cache_sync' defined but not used [-Wunused-function]
> > arch/arm/mm/cache-l2x0.c:184:13: warning: 'l2x0_flush_all' defined but not used [-Wunused-function]
> > arch/arm/mm/cache-l2x0.c:194:13: warning: 'l2x0_disable' defined but not used [-Wunused-function]
> > 
> > With the knowledge that the code is now aurora-specific, we can
> > simplify it noticeably:
> > 
> > - The pl310 errata workarounds are not needed on aurora and can be removed
> > - The cache_wait() macro is never needed since this is not an l210/l220
> 
> How do we know?  You claim it's "not a L210/L220" but how do we actually
> know that we don't have to wait for the cache operation to complete?
>
> When this is built without L310 support, Aurora will wait for the cache
> operations to complete, but when built with L310 support, it won't.

I'll update the description to say:

- As confirmed by Thomas Petazzoni from the data sheet, the cache_wait()
  macro is never needed.

based on the previous email exchange. Thanks for pointing out that the
description doesn't reflect what we had discussed already.

> > - aurora_pa_range can keep the spinlock while syncing the cache
> 
> If the operations complete synchronously (in other words, the L2 cache
> doesn't accept another transaction until the cache operation has completed)
> the spinlocks should not be necessary.
> 
> They're necessary for some of the ARM caches which allow cache operations
> to run asynchronously (hence the wait stuff) but if you don't have the
> wait stuff as you imply above, they can't be asynchronous.

I think the spinlock is still needed, it now only protects this sequence:

                raw_spin_lock_irqsave(&l2x0_lock, flags);
                writel_relaxed(start, base + AURORA_RANGE_BASE_ADDR_REG);
                writel_relaxed(range_end - CACHE_LINE_SIZE, base + offset);
                writel_relaxed(0, base + AURORA_SYNC_REG);
                raw_spin_unlock_irqrestore(&l2x0_lock, flags);

without the lock, two concurrent processes might start writing into
AURORA_RANGE_BASE_ADDR_REG before the first one writes the operation
register.

	Arnd
