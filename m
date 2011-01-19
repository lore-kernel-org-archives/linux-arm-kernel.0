From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 19 Jan 2011 23:29:51 +0800
Subject: A few questions on imx-sdma
In-Reply-To: <20110118132244.GP9041@pengutronix.de>
References: <20110118194259.GB2833@S2101-09.ap.freescale.net>
	<20110118132244.GP9041@pengutronix.de>
Message-ID: <20110119152950.GA11435@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 02:22:44PM +0100, Sascha Hauer wrote:
> On Wed, Jan 19, 2011 at 03:43:00AM +0800, Shawn Guo wrote:
> > Hi Sascha,
> > 
> > I got a few questions when studying imx-sdma.  Can you please help me
> > understand?
> > 
> > * In function sdma_prep_slave_sg, we always get "sdmac->flags = 0;"
> > at line 889.  What's the code blow at line 934 for?
> > 
> > 	if (sdmac->flags & IMX_DMA_SG_LOOP) {
> > 		param |= BD_INTR;
> > 		if (i + 1 == sg_len)
> > 			param |= BD_WRAP;
> > 	}
> 
> A leftover from the days we did not have the prep_cyclic callback and
> implemented sound dma as a looped sg chain. The above can be removed.
> 
> > 
> > * We have sdmac->status set to DMA_ERROR in err_out of function 
> > sdma_prep_dma_cyclic.  Would it be good for us to do the same for
> > function sdma_prep_slave_sg.  Otherwise, sdmac->status stays at
> > DMA_IN_PROGRESS, which will make the function return immediately
> > next time it gets called?
> 
> yes
> 
> > 
> > * It seems the only use of sdmac->status is to check if the channel
> > is DMA_IN_PROGRESS when "prep" functions get called.  Is it a worth
> > to check DMA_ERROR or DMA_SUCCESS for every single buffer descriptor
> > (BD) in interrupt handler?
> > 
> > * In handler mxc_sdma_handle_channel_normal, callback function gets
> > called and last_completed get assigned the cookie no matter
> > sdmac->status is DMA_SUCCESS or DMA_ERROR.  How would dma client know
> > if this tx succeeded or failed?
> 
> Looking at it we should probably just return sdmac->status in
> sdma_tx_status.
> 
OK.  In that case, I assume that DMA_SUCCESS sdma_handle_channel_loop
should be changed to DMA_IN_PROGRESS, as the success of one period
does not really mean the success of the tx.

> > 
> > * Related to question above, dma client can call function
> > dma_async_is_tx_complete to know if the tx succeeded or failed by
> > manipulating cookie.  But is there any way for client to know the
> > failure in loop (cyclic) case?  In this case, client gets no way to
> > query tx status, however any period (BD) in the cyclic could fail.
> > Currently, we always do callback in cyclic handler whether status is
> > DMA_ERROR or DMA_SUCCESS, and the client (i.e. imx audio driver)
> > always assumes the callback means a successful period.  But what if
> > one period in the cyclic fails?
> 
> I guess the driver should call dma_async_is_tx_complete, assuming this
> function is fixed in the sdma driver.
> 
> > 
> > * Regarding to cyclic case again, is DMA_TERMINATE_ALL
> > (down to function sdma_disable_channel) the only way for client to
> > stop the tx?  I do not know the exact behavior of sdma when STATSTOP
> > bit gets set.  But if it's in the middle of a BD transfer process,
> > will this bit setting possibly cause data corruption?
> 
> I don't know the exact behaviour either. I only know that the FSL kernel
> does this aswell (without polling whether the channel is actually
> disabled or something).
> 
I consulted the designer and was told that sdma will stop the channel
immediately once the current burst other than BD is done.  IOW,
the data transfered by the BD may get corrupted.

I will give it a try to send out a patch set to address these
concerns.

-- 
Regards,
Shawn
