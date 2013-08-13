From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 13 Aug 2013 22:20:19 +0200
Subject: [PATCH 10/18] spi: s3c64xx: Do not require legacy DMA API in case
 of S3C64XX
In-Reply-To: <20130813201816.GG6427@sirena.org.uk>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <20130813185547.GD6427@sirena.org.uk> <20130813201816.GG6427@sirena.org.uk>
Message-ID: <1686992.nQEd3xdoHn@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 of August 2013 21:18:16 Mark Brown wrote:
> On Tue, Aug 13, 2013 at 07:55:47PM +0100, Mark Brown wrote:
> > I'm still debugging what's going on here - the basic refcounting all
> > looks OK in the SPI driver, I can see it requesting and releasing with
> > the refcounts all going back to zero in the DMA driver as expected but
> > when we come back to the device later on dmaengine is deciding the
> > device is unavailable quite early on in the process.
> 
> The failure is happening because this check is failing:
> 
> 	/* devices with multiple channels need special handling as we need 
to
> 	 * ensure that all channels are either private or public.
> 	 */
> 	if (dev->chancnt > 1 && !dma_has_cap(DMA_PRIVATE, dev->cap_mask))
> 		list_for_each_entry(chan, &dev->channels, device_node) {
> 			/* some channels are already publicly allocated */
> 			if (chan->client_count) {
> 
> which is happening because dma1chan0 (which is on the same DMA
> controller as the SPI controller) and in fact every other DMA channel
> had references grabbed by the network stack dmaengine helpers which I'd
> enabled in config.  The fact that they do that is unhelpful, it renders
> the API mostly useless, but is nothing to do with this series.
> 
> Having tweaked the config everything appears to work so:
> 
> Tested-by: Mark Brown <broonie@linaro.org>
> 
> though the whole thing with the filter function is as I say a bit fun
> from a code review point of view.

I believe you just found another brokenness of current DMA channel 
matching.

Thanks for testing.

Best regards,
Tomasz
