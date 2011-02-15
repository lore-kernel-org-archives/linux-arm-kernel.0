From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 13:32:32 +0000
Subject: [RFC] ARM: dma-mapping: outer cache is invalidated twice
In-Reply-To: <AANLkTi=rZJq0CPQD0Q1HMgih7UP0Tqoh9sPEYb2NEV_X@mail.gmail.com>
References: <AANLkTi=rZJq0CPQD0Q1HMgih7UP0Tqoh9sPEYb2NEV_X@mail.gmail.com>
Message-ID: <20110215133232.GI4152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 02:14:55PM +0100, Per Forlin wrote:
> outer_inv_range () is called twice for DMA_FROM_DEVICE.
> The first time to "get rid of potential writebacks" and the second
> time to "get rid of any stale speculative prefetches"

Correct.

> outer_inv_range() is a rather expensive operation. In the first case
> isn't it enough to just call cache_sync()?

No.  If the CPU speculatively fetches data from the DMA buffer after
it's been mapped for DMA, it will bring data into the L2 cache.  This
data may or may not be up to date with the DMA buffer contents once
DMA has completed.

As there is no way to know, we have to invalidate the L2 cache (and the
L1 cache) after the DMA has completed to avoid any possibility of data
corruption.
