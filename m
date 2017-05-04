From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 4 May 2017 19:51:10 +0200 (CEST)
Subject: [PATCH] staging: vc04_services: Fix bulk cache maintenance
In-Reply-To: <d0edaf52-45e2-6fda-bb86-1a9b5e1a5425@raspberrypi.org>
References: <d0edaf52-45e2-6fda-bb86-1a9b5e1a5425@raspberrypi.org>
Message-ID: <139394270.264573.1493920270267@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Phil Elwell <phil@raspberrypi.org> hat am 4. Mai 2017 um 11:58 geschrieben:
> 
> 
> vchiq_arm supports transfers less than one page and at arbitrary
> alignment, using the dma-mapping API to perform its cache maintenance
> (even though the VPU drives the DMA hardware). Read (DMA_FROM_DEVICE)
> operations use cache invalidation for speed, falling back to
> clean+invalidate on partial cache lines, with writes (DMA_TO_DEVICE)
> using flushes.
> 
> If a read transfer has ends which aren't page-aligned, performing cache
> maintenance as if they were whole pages can lead to memory corruption
> since the partial cache lines at the ends (and any cache lines before or
> after the transfer area) will be invalidated. This bug was masked until
> the disabling of the cache flush in flush_dcache_page().
> 
> Honouring the requested transfer start- and end-points prevents the
> corruption.
> 
> Fixes: cf9caf192988 ("staging: vc04_services: Replace dmac_map_area with dmac_map_sg")
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

In order to clarify the context of this issue:

http://lists.infradead.org/pipermail/linux-rpi-kernel/2017-April/006149.html
