From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 May 2018 15:57:03 +0100
Subject: [PATCH v3 3/3] arm64: Force swiotlb bounce buffering for
 non-coherent DMA with large CWG
In-Reply-To: <20180512123829.GA8024@lst.de>
References: <20180511135547.34521-1-catalin.marinas@arm.com>
 <20180511135547.34521-4-catalin.marinas@arm.com>
 <20180512123829.GA8024@lst.de>
Message-ID: <20180514145703.celnlobzn3uh5tc2@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 12, 2018 at 02:38:29PM +0200, Christoph Hellwig wrote:
> On Fri, May 11, 2018 at 02:55:47PM +0100, Catalin Marinas wrote:
> > On systems with a Cache Writeback Granule (CTR_EL0.CWG) greater than
> > ARCH_DMA_MINALIGN, DMA cache maintenance on sub-CWG ranges is not safe,
> > leading to data corruption. If such configuration is detected, the
> > kernel will force swiotlb bounce buffering for all non-coherent devices.
> 
> Per the previous discussion I understand that so far this is a
> purely theoretical condition. 

That's what we think, at least for publicly available hardware.

> Given that I'd rather avoid commiting this patch and just refuse too
> boot in this case.

I'll keep it to a WARN_TAINT() for now. Given that the warn triggers
only when cache_line_size() > ARCH_DMA_MINALIGN and we keep this
constant unchanged (128), it shouldn't be much different from our
current assumptions and no-one complained of DMA corruption so far.

> In a merge window or two I plan to have a noncoherent flag in struct
> device, at which point we can handle this entirely in common code.

Sounds ok, looking forward to this.

Thanks.

-- 
Catalin
