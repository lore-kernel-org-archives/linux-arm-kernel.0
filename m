From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Nov 2014 14:50:15 +0000
Subject: [PATCH 1/2] ARM: cache-l2x0: clean up aurora cache handling
In-Reply-To: <1547660.4MUNEQsfAo@wuerfel>
References: <1547660.4MUNEQsfAo@wuerfel>
Message-ID: <20141119145015.GG4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 03:40:12PM +0100, Arnd Bergmann wrote:
> The aurora cache controller is the only remaining user of a couple
> of functions in this file and are completely unused when that is
> disabled, leading to build warnings:
> 
> arch/arm/mm/cache-l2x0.c:167:13: warning: 'l2x0_cache_sync' defined but not used [-Wunused-function]
> arch/arm/mm/cache-l2x0.c:184:13: warning: 'l2x0_flush_all' defined but not used [-Wunused-function]
> arch/arm/mm/cache-l2x0.c:194:13: warning: 'l2x0_disable' defined but not used [-Wunused-function]
> 
> With the knowledge that the code is now aurora-specific, we can
> simplify it noticeably:
> 
> - The pl310 errata workarounds are not needed on aurora and can be removed
> - The cache_wait() macro is never needed since this is not an l210/l220

How do we know?  You claim it's "not a L210/L220" but how do we actually
know that we don't have to wait for the cache operation to complete?

When this is built without L310 support, Aurora will wait for the cache
operations to complete, but when built with L310 support, it won't.

> - aurora_pa_range can keep the spinlock while syncing the cache

If the operations complete synchronously (in other words, the L2 cache
doesn't accept another transaction until the cache operation has completed)
the spinlocks should not be necessary.

They're necessary for some of the ARM caches which allow cache operations
to run asynchronously (hence the wait stuff) but if you don't have the
wait stuff as you imply above, they can't be asynchronous.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
