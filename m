From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 20 Jun 2017 06:49:32 -0700
Subject: [PATCH v5 4/7] drivers: dma-coherent: Introduce default DMA pool
In-Reply-To: <1495621472-9323-5-git-send-email-vladimir.murzin@arm.com>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <1495621472-9323-5-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20170620134932.GB31496@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 11:24:29AM +0100, Vladimir Murzin wrote:
> This patch introduces default coherent DMA pool similar to default CMA
> area concept. To keep other users safe code kept under CONFIG_ARM.

I don't see a CONFIG_ARM in the code, although parts of it are added
under CONFIG_OF_RESERVED_MEM.

But overall this code look a bit odd to me.  As far as I can tell
the dma-coherent.c code is for the case where we have a special
piece of coherent memory close to a device.

If you're allocating out of the global allocator the memory should
come from the normal dma_ops ->alloc allocator - and also take
the attrs into account (e.g. for DMA_ATTR_NON_CONSISTENT or
DMA_ATTR_NO_KERNEL_MAPPING requests you don't need coherent memory)
