From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 11 Jul 2017 16:07:22 +0200
Subject: i.MX 6 and PCIe DMA issues
In-Reply-To: <04e1d18a504a477b84f5a9ec661dc9ae@MEN-EX01.intra.men.de>
References: <04e1d18a504a477b84f5a9ec661dc9ae@MEN-EX01.intra.men.de>
Message-ID: <20170711140722.GI21118@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I was suspecting the caches to be the root of my issue, but I was
> not able to resolve the issue with calls to flush_cache_all(), which
> I suppose should have invalidated the entire cache.

Flush and invalidate are different operations. flush_cache_all() will
not invalidate.

How are your RX buffers aligned. It is good to ensure that your
buffers don't share cache lines. What could be happening is that you
are reading the tail end of one buffer which is bringing into cache
the head of the next buffer, if they share cache lines.

Also, ARMv7 processors can do speculative reads, so you must get your
dma_sync_single_for_cpu() and dma_sync_single_for_device() correct.

    Andrew
