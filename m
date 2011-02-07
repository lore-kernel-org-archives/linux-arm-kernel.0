From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Feb 2011 09:09:42 +0000
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <20110207082521.GI9041@pengutronix.de>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
	<1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
	<20110207082521.GI9041@pengutronix.de>
Message-ID: <20110207090942.GA31181@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 07, 2011 at 09:25:21AM +0100, Sascha Hauer wrote:
> > +		ccw->next = 0;
> > +		ccw->bits.chain = 0;
> > +		ccw->bits.irq = 1;
> > +		ccw->bits.dec_sem = 1;
> > +		ccw->bits.wait4end = flags;
> > +		ccw->bits.halt_on_terminate = 1;
> > +		ccw->bits.terminate_flush = 1;
> > +		ccw->bits.pio_num = sg_len;
> > +		ccw->bits.command = MXS_DMA_NO_XFER;
> 
> Does this have a valid usecase? I would just return some error code
> here. pio_num and pio_words are unused in the driver and I don't think
> a dmaengine driver should have some kind of PIO fallback.

DMA drivers must not perform PIO as a fallback - that's the job of
the driver using the DMA engine API.  The reason is that it buggers up
the DMA buffer ownership rules to the extent that data loss will occur
on ARMv6 and later CPUs.

Also note that the struct device to be used for mapping buffers with
the DMA engine is the dma_device's struct device, not the peripheral
device using the DMA engine.  The DMA engine device is what's
performing the DMA, not the peripheral device.
