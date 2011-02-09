From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 10 Feb 2011 05:02:14 +0800
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <20110209090915.GL9041@pengutronix.de>
References: <1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
	<19793.22067.960689.669543@ipc1.ka-ro>
	<20110209090915.GL9041@pengutronix.de>
Message-ID: <20110209210213.GB7417@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 09, 2011 at 10:09:15AM +0100, Sascha Hauer wrote:
> On Tue, Feb 08, 2011 at 03:41:55PM +0100, Lothar Wa?mann wrote:
> > Hi,
> >
> > > On Sat, Feb 05, 2011 at 10:08:12AM +0800, Shawn Guo wrote:
> > >> This patch adds dma support for Freescale MXS-based SoC i.MX23/28,
> > >> including apbh-dma and apbx-dma.
> > >>
> > >> * apbh-dma and apbx-dma are supported in the driver as two instances,
> > >>   and have to be filtered by dma clients via device id.  It becomes
> > >>   the convention that apbh-dma always gets registered prior to
> > >>   apbx-dma.
> > >>
> > >> * apbh-dma is different between mx23 and mx28, hardware version
> > >>   register is used to handle the differences.
> > >>
> > >> * Every the mxs dma channel is statically assigned to client device
> > >>   by soc design with fixed irq.  The irq number is being passed by
> > >>   alloc_chan function with mxs_dma_data, and client driver has to
> > >>   filter the correct channel by its channel id.
> > >>
> > >> * mxs-dma supports pio function besides data transfer.  The driver
> > >>   uses dma_data_direction DMA_NONE to identify the pio mode, and
> > >>   steals sgl and sg_len to get pio words and numbers from clients.
> > >>
> > >> * mxs dmaengine has some very specific features, like sense function
> > >>   and the special NAND support (nand_lock, nand_wait4ready).  These
> > >>   are too specific to implemented in generic dmaengine driver.
> > >>
> > >> * The parameter "flags" of prep functions is currently being used to
> > >>   pass wait4end flag from clients.
> > >>
> > >> * The driver refers to imx-sdma and only a single descriptor is
> > >>   statically assigned to each channel.
> > >>
> > >> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > >> ---
> > >>  arch/arm/mach-mxs/include/mach/dma.h |   16 +
> > >>  drivers/dma/Kconfig                  |    8 +
> > >>  drivers/dma/Makefile                 |    1 +
> > >>  drivers/dma/mxs-dma.c                |  702 ++++++++++++++++++++++++++++++++++
> > >>  4 files changed, 727 insertions(+), 0 deletions(-)
> > >>  create mode 100644 arch/arm/mach-mxs/include/mach/dma.h
> > >>  create mode 100644 drivers/dma/mxs-dma.c
> > >>
> > >> diff --git a/arch/arm/mach-mxs/include/mach/dma.h b/arch/arm/mach-mxs/include/mach/dma.h
> > >> new file mode 100644
> > >> index 0000000..429f431
> > >> --- /dev/null
> > >> +++ b/arch/arm/mach-mxs/include/mach/dma.h
> > >> +
> > >> +static struct dma_async_tx_descriptor *mxs_dma_prep_slave_sg(
> > >> +          struct dma_chan *chan, struct scatterlist *sgl,
> > >> +          unsigned int sg_len, enum dma_data_direction direction,
> > >> +          unsigned long flags)
> > >> +{
> > >> +  struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
> > >> +  struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> > >> +  struct mxs_dma_ccw *ccw;
> > >> +  struct scatterlist *sg;
> > >> +  int ret, i, j;
> > >> +  u32 *pio;
> > >> +
> > >> +  dev_dbg(mxs_dma->dev, "%s: channel %d\n", __func__, chan->chan_id);
> > >> +
> > >> +  if (mxs_chan->status == DMA_IN_PROGRESS)
> > >> +          return NULL;
> > >> +
> > >> +  mxs_chan->status = DMA_IN_PROGRESS;
> > >> +  mxs_chan->flags = 0;
> > >> +
> > >> +  dev_dbg(mxs_dma->dev, "%s: setting up %d entries\n", __func__, sg_len);
> > >> +
> > >> +  if (sg_len > ((direction == DMA_NONE) ? MXS_PIO_WORDS : NUM_CCW)) {
> > >> +          dev_err(mxs_dma->dev, "maximum number of sg exceeded: %d > %d\n",
> > >> +                          sg_len, NUM_CCW);
> > >> +          ret = -EINVAL;
> > >> +          goto err_out;
> > >> +  }
> > >> +
> > >> +  if (direction == DMA_NONE) {
> > >> +          ccw = &mxs_chan->ccw[0];
> > >> +          pio = (u32 *) sgl;
> > >> +
> > >> +          for (j = 0; j < sg_len;)
> > >> +                  ccw->pio_words[j++] = *pio++;
> > >> +
> > >> +          ccw->next = 0;
> > >> +          ccw->bits.chain = 0;
> > >> +          ccw->bits.irq = 1;
> > >> +          ccw->bits.dec_sem = 1;
> > >> +          ccw->bits.wait4end = flags;
> > >> +          ccw->bits.halt_on_terminate = 1;
> > >> +          ccw->bits.terminate_flush = 1;
> > >> +          ccw->bits.pio_num = sg_len;
> > >> +          ccw->bits.command = MXS_DMA_NO_XFER;
> > >
> > > Does this have a valid usecase? I would just return some error code
> > > here. pio_num and pio_words are unused in the driver and I don't think
> > > a dmaengine driver should have some kind of PIO fallback.
> > >
> > Actually 'PIO' is a misnomer here. It's the free scaled way of
> > implementing a simple feature (chained DMA with mixed transfer modes)
> > in a complicated and obfuscated way.
> >
> > What's behinde the 'PIO' transfers is programming controller registers
> > via DMA along with the actual DMA data transfer. DMA_NONE simply
> > means, that the DMA transfer does only the register programming but
> > does not transfer any payload. The 'pio_words' are the values that are
> > being written to consecutive locations of e.g. the SPI controller
> > register address space.
> > The programming is actually done by DMA, in any case.
> 
> OK, got it now.
> 
> The NAND programming example in the reference manual looks...
> interesting. So it's possible to program the DMA engine in a way that it
> autonomously sends commands to the NAND controller, reads blocks from
> NAND, polls for status, make branches depending on status bits...

This is what sense command does.  I scanned the dma client drivers
implemented in Freescale BSP and found only NAND driver uses it.
All others use pio and data transfer.

> This looks more like a DMA programming language.
> 
> I think it does not make much sense to try to implement these features
> in the dmaengine API. What the dmaengine offers is only a special
> usecase of what the controller provides. Also these features are so
> hardware specific that it won't make sense to extend the dmaengine API
> for them.
> 
> So what should we do? Not use these features at all? Create a bypass to
> the dmaengine API? Make the dmaengine driver a user of another, i.MX28
> specific driver which provides the additional features?
> 
My preference is not use these NAND specific features at all.  And
I think NAND driver can also be implemented with pio and data
commands only.

Regards,
Shawn
