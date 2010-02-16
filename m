From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Feb 2010 09:39:46 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201002161007.20576.oliver@neukum.org>
References: <20100208065519.GE1290@ucw.cz>
	<201002160922.47072.oliver@neukum.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7DBB@dbde02.ent.ti.com>
	<201002161007.20576.oliver@neukum.org>
Message-ID: <20100216093946.GA13884@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2010 at 10:07:20AM +0100, Oliver Neukum wrote:
> Am Dienstag, 16. Februar 2010 09:55:55 schrieb Shilimkar, Santosh:
> > > Would you care to elaborate on the exact nature of the bug you are fixing?
> > On the OMAP4 (ARM cortex-a9) platform, the enumeration fails because control
> > transfer buffers are corrupted. On our platform, we use PIO mode for control 
> > transfers and DMA for bulk transfers.
> > 
> > The current stack performs dma cache maintenance even for the PIO transfers
> > which leads to the corruption issue. The control buffers are handled by CPU 
> > and they already coherent from CPU point of view.
> 
> How does the mapping corrupt buffers? It might impact performance, but why
> do you see corruption?

On map, buffers are cleaned if they're being used for DMA_TO_DEVICE and
DMA_BIDIRECTIONAL, or invalidated in the case of DMA_FROM_DEVICE.

However, because ARM CPUs can now speculatively prefetch, just leaving it
at that results in corruption of buffers used for DMA.  So we have to
invalidate DMA_FROM_DEVICE and DMA_BIDIRECTIONAL buffers on unmap to
ensure coherency with DMA operations.

If the CPU writes to a DMA_FROM_DEVICE buffer between map and unmap, the
writes can sit in the cache, and on unmap, they will be discarded.

Cleaning the cache on unmap is not an option; that too can lead to DMA
buffer corruption in the DMA case.

USB and associated host driver must abide by the DMA API buffer
ownership rules otherwise the result will be data corruption; either
that or USB/host driver people need to have a discussion with the
DMA API authors to remove this sensible "restriction".
