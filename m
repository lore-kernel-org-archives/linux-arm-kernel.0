From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Nov 2015 10:54:20 +0000
Subject: [PATCH] ARM:dma-mapping: Handle DMA_BIDIRECTIONAL in
 _dma_page_cpu_to_dev()
In-Reply-To: <20151104103913.GC5405@arm.com>
References: <1446631008-5854-1-git-send-email-sanjeev_sharma@mentor.com>
 <20151104103913.GC5405@arm.com>
Message-ID: <20151104105420.GL8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 10:39:13AM +0000, Will Deacon wrote:
> On Wed, Nov 04, 2015 at 03:26:48PM +0530, Sanjeev Sharma wrote:
> > _dma_page_cpu_to_dev() treat DMA_BIDIRECTIONAL similar to DMA_TO_DEVICE
> > which means that destination buffer is device memory,means cpu may have
> > written some data to source buffer and data may be in cache line.For
> > cleaner operation we need to call outer_flush_range() which will
> > clean and invalidate outer cache lines.
> 
> Why isn't the clean sufficient in this case? We're mapping the buffer
> to the device, so we clean the dirty lines in the CPU caches and make
> them visible to the device. If the CPU later wants to read the buffer
> (i.e. after the device has DMA'd into it), you'll need to map the
> buffer to the CPU, which will perform the invalidation of the CPU caches.

Indeed.  bidirectional mode is already handled prefectly well by this
code.  No patches are required.

(I never received the original email.)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
