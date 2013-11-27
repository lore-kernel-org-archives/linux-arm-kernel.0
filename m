From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 27 Nov 2013 17:38:43 +0100 (CET)
Subject: [Q] PL011 DMA Rx, using ste_dma40
Message-ID: <Pine.LNX.4.64.1311271646070.8821@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I'm trying to get a PL011 UART to work in DMA mode with an alternative 
DMAC. Transmission works, reception is more problematic. I can receive a 
complete page of data (4096 bytes), but nothing below that triggers a 
reception. Is this expected if no polling is used, as configured by the 
dma_rx_poll_timeout platform parameter, or should it work, triggered by 
the Rx timeout UART interrupt?

Looking at the amba-pl011 UART driver it seems, that it expects an Rx FIFO 
timeout IRQ to trigger if fewer than a full Rx DMA buffer bytes of data 
are received along the lines of pl011_dma_rx_irq(). Such an Rx FIFO 
timeout interrupt should be raised by the UART if a timeout occurs after 
fewer that an Rx threshold bytes are received in the UART FIFO. However, 
as soon as any data is received by the UART the DMA request line is 
toggled, which causes the DMAC to immediately read the bytes out of the 
UART, so, no timeout is occurring.

How is it working in the original set up with ste_dma40 compatible DMACs? 
Or is reception of < 4096 bytes of data, using DMA only working with 
polling, for which there's currently no DT binding?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
