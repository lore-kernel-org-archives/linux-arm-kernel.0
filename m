From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Aug 2010 09:56:04 +0100
Subject: [PATCH 1/5] ARM: add PrimeCell generic DMA to PL022 v9
In-Reply-To: <20100817044834.GA27060@angua.secretlab.ca>
References: <1281095419-15600-1-git-send-email-linus.walleij@stericsson.com>
	<20100817044834.GA27060@angua.secretlab.ca>
Message-ID: <20100817085603.GA20325@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 16, 2010 at 10:48:34PM -0600, Grant Likely wrote:
> > +	/* Map DMA buffers */
> > +	sglen = dma_map_sg(&pl022->adev->dev, pl022->sgt_rx.sgl,
> > +			   pl022->sgt_rx.nents, DMA_FROM_DEVICE);
> > +	if (sglen != pages)
> > +		goto err_rx_sgmap;
> > +
> > +	sglen = dma_map_sg(&pl022->adev->dev, pl022->sgt_tx.sgl,
> > +			   pl022->sgt_tx.nents, DMA_TO_DEVICE);
> > +	if (sglen != pages)
> > +		goto err_tx_sgmap;
> > +
> > +	/* Synchronize the TX scatterlist, invalidate buffers, caches etc */
> > +	dma_sync_sg_for_device(&pl022->adev->dev,
> > +			       pl022->sgt_tx.sgl,
> > +			       pl022->sgt_tx.nents,
> > +			       DMA_TO_DEVICE);

This is wrong.  Mapping a scatterlist already makes it available for
the device to use.  There's no point re-doing that work by using
the sync API.

Let's go over the DMA API one more time.

	CPU owns buffer, device must not access

dma_map_xx		buffer ownership transitions from CPU to device

	device owns buffer, CPU must not access

dma_sync_xx_for_cpu	buffer ownership transitions from device to CPU

	CPU owns buffer, device must not access

dma_sync_xx_for_device	buffer ownership transitions from CPU to device

	device owns buffer, CPU must not access

dma_unmap_xx		buffer ownership transitions from device to CPU

	CPU owns buffer, device must not access
