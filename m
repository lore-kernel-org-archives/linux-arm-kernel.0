From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Jan 2015 12:36:13 +0000
Subject: [PATCH 0/6] ARM: mvebu: mvebu-mbus and I/O coherency fixes
In-Reply-To: <20150110205721.6b3f71f8@free-electrons.com>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150110163001.GA5392@lunn.ch>
 <20150110175030.186ef929@free-electrons.com>
 <2707920.rUFmbmVqu6@wuerfel>
 <20150110205721.6b3f71f8@free-electrons.com>
Message-ID: <20150112123613.GG12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 10, 2015 at 08:57:21PM +0100, Thomas Petazzoni wrote:
> We will indeed need to do more extensive testing and review. However, I
> don't agree that this should prevent this patch from going to stable:
> the current situation in the kernel (and also past kernels) is known to
> be broken: DMA coherent mappings allocated by dma_alloc_coherent() are
> *not* coherent in the current situation. Writes made by the device to
> the memory are not guaranteed to be immediately visible to the CPU,
> unless an explicit I/O sync barrier is done, which obviously is never
> done for DMA coherent mappings since those are assumed by Linux to be
> coherent, and therefore not require any cache maintenance operation.

That's actually an incorrect statement.

On all ARMv6+ where DMA coherent memory is "normal memory, non-cached,
write combine" but because it's "normal memory", memory barriers are
required.  This is why we have the memory barriers in readl() and
writel().

Remember, DMA coherent memory is about avoiding effects from caching,
not about avoiding weakly ordered memory effects.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
