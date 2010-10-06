From: ww-ml@gmx.de (Wolfgang Wegner)
Date: Wed, 6 Oct 2010 11:31:34 +0200
Subject: Kirkwood DMA engine transfer to PCI memory space?
Message-ID: <20101006093134.GA32436@debian-wegner1.datadisplay.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I once more started an attempt to implement DMA transfer to the
PCI memory using the Kirkwood XOR (DMA) engine. The device is
an FPGA connected to PCIe via a 88SB2211 PCIe->PCI bridge.

That's my PCI device:
01:08.0 Class ff00: Device 1731:0101 (rev 10)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr+ DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
        Region 1: Memory@e4000000 (32-bit, non-prefetchable) [size=256]

I can write to the 64M buffer space via writel() or map the
buffer to userspace and then write to it, both successfully.

And this is my DMA transfer function, I guess its source should
be obvious (dma_async_memcpy_buf_to_buf() slightly castrated):

dma_cookie_t
dma_async_memcpy_buf_to_dev(struct dma_chan *chan, void *dest,
                        void *src, size_t len)
{
        struct dma_device *dev = chan->device;
        struct dma_async_tx_descriptor *tx;
        dma_addr_t dma_dest, dma_src;
        dma_cookie_t cookie;
        int cpu;
        unsigned long flags;

        dma_src = dma_map_single(dev->dev, src, len, DMA_TO_DEVICE);
#if 0
        dma_dest = dma_map_single(dev->dev, dest, len, DMA_FROM_DEVICE);
#else
        dma_dest = dest;
#endif
        flags = DMA_CTRL_ACK |
                DMA_COMPL_SRC_UNMAP_SINGLE |
                DMA_COMPL_DEST_UNMAP_SINGLE;
        tx = dev->device_prep_dma_memcpy(chan, dma_dest, dma_src, len, flags);

        if (!tx) {
                dma_unmap_single(dev->dev, dma_src, len, DMA_TO_DEVICE);
//                dma_unmap_single(dev->dev, dma_dest, len, DMA_FROM_DEVICE);
                return -ENOMEM;
        }

        tx->callback = NULL;
        cookie = tx->tx_submit(tx);

        cpu = get_cpu();
        per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
        per_cpu_ptr(chan->local, cpu)->memcpy_count++;
        put_cpu();

        return cookie;
}

When using a buffer obtained with dma_alloc_coherent() as the destination
the transfer works fine. When using the PCI memory address as the
destination, the transfer silently fails - the buffer simply does not
change contents, but I did not see any error condition either (cookie
is always non-negative).

Is there something obvious I am doing wrong? From Kirkwood documentation
I can not see a limitation of the XOR engine like being able to do
mem-mem transfers only, neither in the kernel code (which, however, I
did not yet completely understand).

Any hints would be appreciated!

Best regards,
Wolfgang
