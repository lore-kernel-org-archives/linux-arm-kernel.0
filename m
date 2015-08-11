From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 11 Aug 2015 18:26:20 +0100
Subject: [PATCH] ARM: l2c: fix support for HW coherent systems in PL310
 cache
In-Reply-To: <1439312743-6237-1-git-send-email-gregory.clement@free-electrons.com>
References: <1439312743-6237-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150811172620.GK23307@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 07:05:43PM +0200, Gregory CLEMENT wrote:
> From: Nadav Haklai <nadavh@marvell.com>
> 
> When a PL310 cache is used in a system that provides hardware
> coherency, the entire outer cache operations are useless, and can be
> skipped.  Moreover, on some systems, it is harmful as it causes
> deadlocks between the Marvell coherency mechanism, the Marvell PCIe
> controller and the Cortex-A9.
> 
> This commit extends a previous commit:
> 98ea2dba65932ffc456b6d7b11b8a0624e2f7b95 which added the io-coherent
> support for the PL310 cache by also disabling the outer cache flush
> range operation.
> 
> In the current kernel implementation, the outer cache flush range
> operation is triggered by the dma_alloc function.
> This operation can be take place during runtime and in some
> circumstances may lead to the PCIe/PL310 deadlock on Armada 375/38x
> SoCs.

While this may work around the issue for your specific SoC, I think a
better fix is in DMA alloc code to avoid flushing caches for coherent
devices. This would be the __dma_clear_buffer() implementation which
isn't aware of whether the device is coherent or not.

-- 
Catalin
