From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Nov 2012 12:16:29 +0000
Subject: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch data
In-Reply-To: <50AA032F.1010102@ti.com>
References: <20121018222046.GA28541@animalcreek.com>
 <20121018225540.GB28061@n2100.arm.linux.org.uk>
 <20121018232405.GA29064@animalcreek.com>
 <20121018233335.GC28061@n2100.arm.linux.org.uk> <50814B83.7090203@ti.com>
 <20121117113159.GM3332@n2100.arm.linux.org.uk> <50AA032F.1010102@ti.com>
Message-ID: <20121119121629.GN3332@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:00:15AM +0100, Peter Ujfalusi wrote:
> When we have prefetch enabled we tend to resume after pause from a slightly
> off place than when the prefetch is disabled.

That is exactly what I was expecting would happen having read how the
DMA works.

With memory->device transfers, if you stop them (there is no pause), the
DMA hardware discards its buffers.  So if you allow it to prefetch data,
you're going to throw more data away when you stop it.

For device->memory transfers, at least it will write the contents back to
memory before stopping.
