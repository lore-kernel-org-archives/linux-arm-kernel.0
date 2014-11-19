From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 16:10:16 +0100
Subject: [PATCH 1/2] ARM: cache-l2x0: clean up aurora cache handling
In-Reply-To: <4475865.jdxZMh688N@wuerfel>
References: <1547660.4MUNEQsfAo@wuerfel>
 <20141119145015.GG4042@n2100.arm.linux.org.uk> <4475865.jdxZMh688N@wuerfel>
Message-ID: <12419854.Yj2kZEItoO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014 16:06:31 Arnd Bergmann wrote:
> On Wednesday 19 November 2014 14:50:15 Russell King - ARM Linux wrote:
> > 
> > If the operations complete synchronously (in other words, the L2 cache
> > doesn't accept another transaction until the cache operation has completed)
> > the spinlocks should not be necessary.
> > 
> > They're necessary for some of the ARM caches which allow cache operations
> > to run asynchronously (hence the wait stuff) but if you don't have the
> > wait stuff as you imply above, they can't be asynchronous.
> 
> I think the spinlock is still needed, it now only protects this sequence:
> 
>                 raw_spin_lock_irqsave(&l2x0_lock, flags);
>                 writel_relaxed(start, base + AURORA_RANGE_BASE_ADDR_REG);
>                 writel_relaxed(range_end - CACHE_LINE_SIZE, base + offset);
>                 writel_relaxed(0, base + AURORA_SYNC_REG);
>                 raw_spin_unlock_irqrestore(&l2x0_lock, flags);
> 
> without the lock, two concurrent processes might start writing into
> AURORA_RANGE_BASE_ADDR_REG before the first one writes the operation
> register.

After taking another look, I do get your point. Yes, we only need the lock
across the first two operations, not for the third one, which can be done
outside of the lock. I'll change the patch accordingly.

	Arnd
