From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 4 Jul 2011 21:51:43 +0200
Subject: [PATCH 6/7] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <20110704170217.GH28042@ponder.secretlab.ca>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<201107041859.11548.heiko@sntech.de>
	<20110704170217.GH28042@ponder.secretlab.ca>
Message-ID: <201107042151.44075.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag 04 Juli 2011, 19:02:17 schrieb Grant Likely:
> On Mon, Jul 04, 2011 at 06:59:11PM +0200, Heiko St?bner wrote:
> > Am Montag 04 Juli 2011, 18:42:51 schrieb Grant Likely:
> > > On Mon, Jul 04, 2011 at 09:18:34PM +0900, Kukjin Kim wrote:
> > > > +#if defined(CONFIG_DMADEV_PL330)
> > > > +			memset(&slave_config, 0, sizeof(slave_config));
> > > > +			slave_config.direction = DMA_TO_DEVICE;
> > > > +			slave_config.src_addr = xfer->tx_dma;
> > > > +			slave_config.dst_addr =
> > > > +				sdd->sfr_start + S3C64XX_SPI_TX_DATA;
> > > > +			slave_config.dst_addr_width = sdd->cur_bpw / 8;
> > > > +			dmaengine_slave_config(sdd->tx_chan, &slave_config);
> > > > +
> > > > +			sg_init_table(&tx_sg, 1);
> > > > +			sg_set_page(&tx_sg, pfn_to_page(PFN_DOWN(xfer-
>tx_dma)),
> > > > +				xfer->len, offset_in_page(xfer->tx_dma));
> > > > +			sg_dma_len(&tx_sg) =  xfer->len;
> > > > +			sg_dma_address(&tx_sg) = xfer->tx_dma;
> > > > +			sdd->tx_desc =
> > > > +				sdd->tx_chan->device->device_prep_slave_sg(
> > > > +				sdd->tx_chan, &tx_sg, 1, DMA_TO_DEVICE,
> > > > +				DMA_PREP_INTERRUPT);
> > > > +			sdd->tx_desc->callback = s3c64xx_spi_dma_txcb;
> > > > +			sdd->tx_desc->callback_param = sdd;
> > > > +			dmaengine_submit(sdd->tx_desc);
> > > > +			dma_async_issue_pending(sdd->tx_chan);
> > > > +#else
> > > > 
> > > >  			s3c2410_dma_config(sdd->tx_dmach, sdd->cur_bpw / 8);
> > > >  			s3c2410_dma_enqueue(sdd->tx_dmach, (void *)sdd,
> > > >  			
> > > >  						xfer->tx_dma, xfer->len);
> > > >  			
> > > >  			s3c2410_dma_ctrl(sdd->tx_dmach, S3C2410_DMAOP_START);
> > > > 
> > > > +#endif
> > > 
> > > Hmmm, this is not pretty.  The driver behaviour is entirely different
> > > depending on if CONFIG_DMADEV_PL330 is enabled?  When we get to
> > > multiplatform kernels, is this going to break on some hardware?
> > > 
> > > > @@ -802,8 +951,13 @@ static void s3c64xx_spi_work(struct work_struct
> > > > *work)
> > > > 
> > > >  	spin_unlock_irqrestore(&sdd->lock, flags);
> > > >  	
> > > >  	/* Free DMA channels */
> > > > 
> > > > +#if defined(CONFIG_DMADEV_PL330)
> > > > +	dma_release_channel(sdd->tx_chan);
> > > > +	dma_release_channel(sdd->rx_chan);
> > > > +#else
> > > > 
> > > >  	s3c2410_dma_free(sdd->tx_dmach, &s3c64xx_spi_dma_client);
> > > >  	s3c2410_dma_free(sdd->rx_dmach, &s3c64xx_spi_dma_client);
> > > > 
> > > > +#endif
> > > 
> > > Wow.  A lot of #ifdefs here.  It does not look multiplatform friendly
> > > at all.  Are the s3c2410_dma functions obsolete when DMADEV_PL330 is
> > > selected?  If so, can they be removed entirely, or are they required
> > > to support certain hardware?
> > 
> > The spi_s3c64xx driver can also support the SPI controller of the
> > S3C2416/S3C2443 line of SoCs.
> > As I'm currently working on a S3C2416 based project, my small wish from
> > the sidelines would be to not break this support with whatever solution
> > you will decide on :-) .
> 
> I will not merge a patch that either breaks a platform, or requires
> a compile time either/or choice of device support (enabling support
> for one device should not break support for another).

The patch above seems to contain the support for both SoCs (i.e. s3c2410_dma_* 
for S3C2416 etc), so it wouldn't break the support.
But this form will definitly break future multiplatform kernels when the 2416 
and some variant using the DMADEV_PL330 are selected at the same time.

The 2416/2443 seem to be the first Samsung-SoCs to have a SPI-controller of 
this type. Implementing the DMA engine stuff for these SoCs would obviously 
solve the ifdef-problem but I don't know if this is possible to do.


Heiko
