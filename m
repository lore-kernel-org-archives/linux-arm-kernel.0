From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 23:36:48 +0100
Subject: alloc_safe_buffer/map_single problem related to ath9k on ARM
In-Reply-To: <769353EF-E030-494A-B1FE-7D6614B2C1AF@comcast.net>
References: <769353EF-E030-494A-B1FE-7D6614B2C1AF@comcast.net>
Message-ID: <20110919223648.GA28237@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 03:26:54PM -0700, B. J. wrote:
> The original problem is that, under network load over the WiFi, I get
> these messages:
> 
> ath9k 0000:00:02.0: alloc_safe_buffer: could not alloc dma memory (size=87)
> ath9k 0000:00:02.0: map_single: unable to map unsafe buffer cf733828!
> ath9k 0000:00:02.0: alloc_safe_buffer: could not alloc dma memory (size=174)
> ath9k 0000:00:02.0: map_single: unable to map unsafe buffer c7ea4c5e!
> ath9k 0000:00:02.0: alloc_safe_buffer: could not alloc dma memory (size=1484)
> ath9k 0000:00:02.0: map_single: unable to map unsafe buffer cf734028!
> 
> and eventually the system runs out of kernel memory and the OOM killer
> kicks in (yeah, so there's multiple problems here).

It shouldn't end up running out of memory - that implies there's a leak
somewhere.  And I think I know where it is - could you try this patch
please?  It won't solve the messages above but it should prevent the
resulting OOM.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 0a0a1e7..c3ff82f 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -324,6 +324,8 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 
 	if (addr)
 		*handle = pfn_to_dma(dev, page_to_pfn(page));
+	else
+		__dma_free_buffer(page, size);
 
 	return addr;
 }
