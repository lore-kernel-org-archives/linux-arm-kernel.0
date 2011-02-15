From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Feb 2011 16:43:40 +0000
Subject: [PATCH] ARM: Improve the L2 cache performance when PL310 is used
In-Reply-To: <AANLkTi=zUei0tNVObW18+bRd0f7oLSEoDMFTd+3=7JSZ@mail.gmail.com>
References: <20100309101248.7359.60873.stgit@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C47A6ADF@dbde02.ent.ti.com>
	<AANLkTi=zUei0tNVObW18+bRd0f7oLSEoDMFTd+3=7JSZ@mail.gmail.com>
Message-ID: <1297788220.28844.3.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-02-15 at 11:29 +0000, Srinidhi Kasagar wrote:
> Just curious to know, why the spinlock surrounding
> l2x0_cache_sync still exists?  I see that
> Catalin's first version adds void lock for PL310
> as they are atomic.

On PL310, range operations and the cache sync don't need the spinlock.
However, TI pushed optimisations to use "all" operations for large
ranges. These operations are background and you need to use a cache sync
until completed. You also need locks around since starting other
operations while a background one is active is unpredictable.

-- 
Catalin
