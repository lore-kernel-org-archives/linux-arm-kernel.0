From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Apr 2015 11:01:35 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <55409A89.5070008@topic.nl>
References: <5538DD02.6050401@topic.nl> <2757951.K585xX1rYN@wuerfel>
 <55409A89.5070008@topic.nl>
Message-ID: <4351847.Ycu9R2FQB8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 April 2015 10:47:05 Mike Looijmans wrote:
> On 23-04-15 14:32, Arnd Bergmann wrote:
> > On Thursday 23 April 2015 13:52:34 Mike Looijmans wrote:
> >> Can anyone here offer some advise on this?
> >>
> >
> > The problem you are experiencing is a direct result of using hardware
> > without cache-coherency from user space. There is no software workaround
> > for this: If you want data to be cacheable *and* avoid doing manual cache
> > flushes each time data is passed between user space and hardware, you have
> > to use hardware that is cache-coherent.
> >
> > You mentioned that you are using 'Zynq', which supports cache-coherent
> > DMA using the 'accelerator coherency port'. If you are able to connect
> > your device to that port, it should work, otherwise you should consider
> > using a different platform.
> 
> I tried as you suggested, and used the ACP instead of the HP to connect the 
> logic to the CPU.
> 
> Without any further changes, this passes all tests with the exact same 
> performance numbers. The reason for that is that the driver/DMA framework is 
> unaware of the "coherency" hardware and still uses the manual cache 
> flush/invalidate routines, so I figured out that adding a "dma-coherent" 
> property to the devicetree node changes that.

Correct.

> However, with "dma-coherent" set for my driver, the system locks up at random 
> points in the tests. Simple memory transfer tests fail with data mismatches 
> (probably stale cache results). Running DMA tests usually results in the 
> system completely locking up at some point.
> Normal register read/write access is done through the AXI bus directly, not 
> using the ACP at all.
> 
> Is the ACP hardware broken, is there some extra things my driver needs to be 
> aware of, or is there something else I need to do here?

You still need to synchronize MMIO register accesses with write buffers,
as the readl() and writel() functions do in the kernel.

In particular, after you have written a buffer to memory from the CPU,
you will need to do an outer_sync() before the MMIO write that triggers
the DMA. This is still much cheaper than doing the cache flush though.

On the inbound side, you normally need an MMIO read followed by a dsb
instruction to ensure that data is visible in the cache after you have
received an interrupt from the device. Again that is what readl()
does, but it won't be implied if you do the MMIO from user space.

Another possible problem would be if the driver mmaps the buffer in
uncached mode to user space. This is something your kernel driver has
to get right, it won't be handled automatically by setting the
"dma-coherent" property in DT.

There could of course be some other problem either in your FPGA code,
in your driver, or in your user space. I would not assume that the zynq
ACP itself is broken though.

	Arnd
