From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Nov 2013 20:30:42 +0000
Subject: [Q] PL011 DMA Rx, using ste_dma40
In-Reply-To: <Pine.LNX.4.64.1311271646070.8821@axis700.grange>
References: <Pine.LNX.4.64.1311271646070.8821@axis700.grange>
Message-ID: <20131127203042.GS16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 05:38:43PM +0100, Guennadi Liakhovetski wrote:
> I'm trying to get a PL011 UART to work in DMA mode with an alternative 
> DMAC. Transmission works, reception is more problematic. I can receive a 
> complete page of data (4096 bytes), but nothing below that triggers a 
> reception. Is this expected if no polling is used, as configured by the 
> dma_rx_poll_timeout platform parameter, or should it work, triggered by 
> the Rx timeout UART interrupt?

Yes, there's a very basic hardware design error here.

The PL011 does, as you've noticed, have a Rx timeout interrupt.  This
timeout interrupt only fires if you leave data in the Rx FIFO.

This means that when you use DMA, for the hardware to operate correctly,
you must _not_ have the DMA engine fully empty the Rx FIFO, otherwise
interactive use is impossible.

I wrote about this when I looked at DMA on the ARM Realview boards.
I came to the conclusion that was just better to completely ignore the
hardware DMA side of PL011 and just use PIO.
