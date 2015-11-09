From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Nov 2015 12:00:17 +0000
Subject: [PATCH] ARM:dma-mapping: Handle DMA_BIDIRECTIONAL in
 _dma_page_cpu_to_dev()
In-Reply-To: <FDC088D3B5555644AE135ED28A7ABDE98636BE5D@EU-MBX-02.mgc.mentorg.com>
References: <1446631008-5854-1-git-send-email-sanjeev_sharma@mentor.com>
 <20151104103913.GC5405@arm.com>
 <20151104105420.GL8644@n2100.arm.linux.org.uk>
 <FDC088D3B5555644AE135ED28A7ABDE98636B41D@EU-MBX-02.mgc.mentorg.com>
 <CAGUYZuQDiH_xzinEJ952rw9GuA9oUQSNASaNdOE1x_i97XCBrw@mail.gmail.com>
 <20151109100804.GA24936@arm.com>
 <FDC088D3B5555644AE135ED28A7ABDE98636BE5D@EU-MBX-02.mgc.mentorg.com>
Message-ID: <20151109120017.GY8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 10:15:34AM +0000, Sharma, Sanjeev wrote:
> It may cause the following issue.
> 1.we create the buffer with cache, and in some cases, the cache may be dirty.
> 2.then we call the sync_for_device function with flag DMA_BIDIRECTIONAL to
> avoid some cache problems.

This is wrong.  Please read the DMA-API document on proper use of these
functions.  Enable CONFIG_DMA_API_DEBUG as well.

> 3. however __dma_page_cpu_to_dev() just see DMA_BIDIRECTIONAL the same as 
> DMA_TO_DEVICE, which means the kernel will not invalid the cache if we use
> the flag DMA_BIDIRECTIONAL.
> 4.since the dirty cache is not invalid, the dirty content may be showed on
> the buffer in the future rendering.

This is again wrong.  __dma_page_cpu_to_dev() with DMA_BIDIRECTIONAL will
_clean_ the cache, which means it will push out all the dirty content
in the cache.  However, it leaves the data in the cache in case we want
to read it later (for the FROM_DEVICE.)

It is _invalid_ to read from the mapping while the device owns it, and
as Cortex CPUs speculatively prefetch, you can end up with new cach
lines allocated in this memory region.  So, before reading the memory,
you _must_ either unmap the DMA buffer, or call dma_sync_for_cpu().
Either of those two functions will then invalidate the cache for a
DMA_BIDIRECTIONAL mapping, allowing you to safely read the data.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
