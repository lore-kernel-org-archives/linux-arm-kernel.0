From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Thu, 26 Jan 2017 22:35:37 +0200
Subject: [PATCH v2] arm64: dma-mapping: Fix dma_mapping_error() when
 bypassing SWIOTLB
In-Reply-To: <18eae1fb-4a3c-c230-4491-8d376468975c@arm.com>
References: <20170124225200.a7qioswpxzh6agvd@raspberrypi-2.musicnaut.iki.fi>
 <840027acb4750542003dff17b4a8902ba8972754.1485368348.git.robin.murphy@arm.com>
 <20170126125249.GG14167@arm.com>
 <18eae1fb-4a3c-c230-4491-8d376468975c@arm.com>
Message-ID: <20170126203537.d5mxdhmswfrihvoc@raspberrypi-3.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 26, 2017 at 03:20:47PM +0000, Robin Murphy wrote:
> hell, and having had a closer look I found another sweet nugget - if
> someone calls dma_alloc_coherent() in non-blocking context, for a
> sufficiently large order that the initial __get_free_pages() call from
> swiotlb_alloc_coherent() fails (hey, small-memory systems *are* going to
> suffer fragmentation), then we'll end up poking around in yet more
> uninitialised internals trying to allocate out of the non-existent
> bounce buffer.

I think this shouldn't happen anymore after 524dabe1c68e ("arm64: Fix
swiotlb fallback allocation").

A.
