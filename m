From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Jun 2013 10:10:05 +0100
Subject: [RFC] arm: Remove sa1111 special case from mm setup code
In-Reply-To: <1371338108-26354-1-git-send-email-grant.likely@linaro.org>
References: <1371338108-26354-1-git-send-email-grant.likely@linaro.org>
Message-ID: <20130616091005.GP18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 12:15:08AM +0100, Grant Likely wrote:
> I don't think this special case is needed anymore. From what I can tell,
> setup_dma_zone() takes care of marking the region to be reserved for
> DMA, and that happens before arm_memblock_init() which calls
> arm_mm_memblock_reserve(). Therefore the mm setup should already know
> about the reserved region and it won't need to be explicitly reserved
> and then freed. That means the special case can be dropped from the
> common code.

No it doesn't.  setup_dma_zone is all about setting the high watermark
for GFP_DMA allocations.  It has nothing to do with _temoprarily_
reserving the low 1MB, ensuring that no other user can use any of that
precious SA1111 memory during the kernel boot.
