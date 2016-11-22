From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Tue, 22 Nov 2016 11:41:53 +0530
Subject: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix continuous selection format
In-Reply-To: <59ac10adfe92916770aa30146e958887@agner.ch>
References: <cover.1479706671.git.maitysanchayan@gmail.com>
 <1317eff8a40789c47311c219d9cfb4105863bd9f.1479706671.git.maitysanchayan@gmail.com>
 <59ac10adfe92916770aa30146e958887@agner.ch>
Message-ID: <20161122061153.GA2484@Sanchayan-Arch.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-11-21 15:15:41, Stefan Agner wrote:
> On 2016-11-20 21:54, Sanchayan Maity wrote:
> > Current DMA implementation was not handling the continuous selection
> > format viz. SPI chip select would be deasserted even between sequential
> > serial transfers. Use the cs_change variable and correctly set or
> > reset the CONT bit accordingly for case where peripherals require
> > the chip select to be asserted between sequential transfers.
> > 
> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > ---
> >  drivers/spi/spi-fsl-dspi.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> > index b1ee1f5..41422cd 100644
> > --- a/drivers/spi/spi-fsl-dspi.c
> > +++ b/drivers/spi/spi-fsl-dspi.c
> > @@ -261,6 +261,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
> >  	dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
> >  					SPI_PUSHR_PCS(dspi->cs) |
> >  					SPI_PUSHR_CTAS(0);
> > +	if (!dspi->cs_change)
> > +		dspi->dma->tx_dma_buf[i] |= SPI_PUSHR_CONT;
> >  	dspi->tx += tx_word + 1;
> >  
> >  	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
> 
> Other transfer mode use:
> 
> if ((dspi->cs_change) && (!dspi->len))                                  
>                                                            
>         dspi_pushr &= ~SPI_PUSHR_CONT;
> 
> which indicates that they only clear SPI_PUSHR_CONT at the very end of a
> transfer... The DMA code currently deselects after every DMA transfer if
> dspi->cs_change is set.
> 
> Maybe we should use the helper dspi_data_to_pushr to fill the DMA buffer
> and _clear_ SPI_PUSHR_CONT if necessary like the other transfer modes
> do... Then we can use the for loop to fill the complete buffer and get
> rid of some code dupplication.
> 
> I see that dspi_data_to_pushr does move len too, which we did not in the
> DMA case. dspi->len gets incremented only on successful DMA transfer in
> dspi_dma_xfer. However, I wonder if that is not even a bug: We increment
> dspi->tx always, but len only on success. This makes len go off sync
> with regards to the tx pointer which does not help anybody. So lets get
> rid of the update code in dspi_dma_xfer
> 

Thanks for the feedback. Using dspi_data_to_pushr really cleans up that
tx path very nicely. Why didn't I see it. Will send a follow up patch
soon after testing again.

- Sanchayan.
