From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 May 2010 11:45:12 +0200
Subject: [PATCH] ARM: mx3: Fix a race condition in mxcmmc
In-Reply-To: <20100514100742.GK30801@buzzloop.caiaq.de>
References: <20100427075012.GB30801@buzzloop.caiaq.de>
	<20100427102442.GD30801@buzzloop.caiaq.de>
	<20100503112642.GI30807@buzzloop.caiaq.de>
	<20100508102405.GJ30801@buzzloop.caiaq.de>
	<20100514100742.GK30801@buzzloop.caiaq.de>
Message-ID: <20100517094512.GS31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 12:07:42PM +0200, Daniel Mack wrote:
> Sascha, any chance to get this in for the next merge window?

Applied to mxc-master. Sorry for the delay.

Sascha

> 
> Thanks,
> Daniel
> 
> On Sat, May 08, 2010 at 12:24:05PM +0200, Daniel Mack wrote:
> > Any comments on this one?
> > 
> > Thanks,
> > Daniel
> > 
> > On Mon, May 03, 2010 at 01:26:42PM +0200, Daniel Mack wrote:
> > > 
> > > On Tue, Apr 27, 2010 at 12:24:42PM +0200, Daniel Mack wrote:
> > > > From cefcdab08d1c9636c4a7290bc2bbe937d051bce4 Mon Sep 17 00:00:00 2001
> > > > From: Volker Ernst <volker.ernst@txtr.com>
> > > > Date: Mon, 26 Apr 2010 22:51:07 +0200
> > > > Subject: [PATCH] ARM: mx3: Fix a race condition in mxcmmc
> > > > 
> > > > This fixes a race condition regarding interrupt bits in the SDHC
> > > > controller driver code.
> > > > 
> > > > In case of PIO-transfer it does not clear SDHC-status bit#11/12
> > > > in the INT-handler anymore. INT-handler might be called during
> > > > an ongoing PIO-data-transfer (with some other INT-flag set) and
> > > > PIO-transfer depends on these bits being set to detect the end
> > > > of the data-transfer. This also means that at the end of PIO-
> > > > transfer that PIO-software has to clear these bits itself.
> > > > 
> > > > However in case of DMA-transfer these bits have to be cleared
> > > > in the INT-handler, because they are used to generate INTs then.
> > > > 
> > > > Works solid, no more problems here, can transfer big files.
> > > > 
> > > > Signed-off-by: Volker Ernst <volker.ernst@txtr.com>
> > > > Acked-by: Daniel Mack <daniel@caiaq.de>
> > > > Cc: Andy Green <andy@warmcat.com>
> > > > ---
> > > >  drivers/mmc/host/mxcmmc.c |   13 ++++++++++++-
> > > >  1 files changed, 12 insertions(+), 1 deletions(-)
> > > > 
> > > > diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> > > > index 2c53024..ec18e3b 100644
> > > > --- a/drivers/mmc/host/mxcmmc.c
> > > > +++ b/drivers/mmc/host/mxcmmc.c
> > > > @@ -489,6 +489,9 @@ static void mxcmci_datawork(struct work_struct *work)
> > > >  	struct mxcmci_host *host = container_of(work, struct mxcmci_host,
> > > >  						  datawork);
> > > >  	int datastat = mxcmci_transfer_data(host);
> > > > +
> > > > +	writel(STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE,
> > > > +		host->base + MMC_REG_STATUS);
> > > >  	mxcmci_finish_data(host, datastat);
> > > >  
> > > >  	if (host->req->stop) {
> > > > @@ -553,7 +556,8 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
> > > >  	u32 stat;
> > > >  
> > > >  	stat = readl(host->base + MMC_REG_STATUS);
> > > > -	writel(stat & ~STATUS_SDIO_INT_ACTIVE, host->base + MMC_REG_STATUS);
> > > > +	writel(stat & ~(STATUS_SDIO_INT_ACTIVE | STATUS_DATA_TRANS_DONE |
> > > > +			STATUS_WRITE_OP_DONE), host->base + MMC_REG_STATUS);
> > > >  
> > > >  	dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
> > > >  
> > > > @@ -561,6 +565,13 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
> > > >  	sdio_irq = (stat & STATUS_SDIO_INT_ACTIVE) && host->use_sdio;
> > > >  	spin_unlock_irqrestore(&host->lock, flags);
> > > >  
> > > > +#ifdef HAS_DMA
> > > > +	if (mxcmci_use_dma(host) &&
> > > > +	    (stat & (STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE)))
> > > > +		writel(STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE,
> > > > +			host->base + MMC_REG_STATUS);
> > > > +#endif
> > > > +
> > > >  	if (sdio_irq) {
> > > >  		writel(STATUS_SDIO_INT_ACTIVE, host->base + MMC_REG_STATUS);
> > > >  		mmc_signal_sdio_irq(host->mmc);
> > > > -- 
> > > > 1.7.0.3
> > > > 
> > > > 
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel at lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
