From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 27 Jul 2011 14:05:39 +0900
Subject: [PATCH V4 12/14] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <1311675280.24316.3.camel@vkoul-mobl4>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-13-git-send-email-boojin.kim@samsung.com>
	<1311592630.29703.13.camel@vkoul-mobl4>
	<003701cc4b76$c52963f0$4f7c2bd0$%kim@samsung.com>
	<1311675280.24316.3.camel@vkoul-mobl4>
Message-ID: <000301cc4c1a$d494bd40$7dbe37c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul Wrote:
> Sent: Tuesday, July 26, 2011 7:15 PM
> To: Boojin Kim
> Cc: vinod.koul at intel.com; 'Kukjin Kim'; 'Jassi Brar'; 'Grant Likely';
> linux-samsung-soc at vger.kernel.org; 'Mark Brown'; 'Dan Williams';
> linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH V4 12/14] spi/s3c64xx: Add support DMA engine API
>
> On Tue, 2011-07-26 at 18:31 +0900, Boojin Kim wrote:
> > Vinod Koul Wrote:
> > > Sent: Monday, July 25, 2011 8:17 PM
> > > To: Boojin Kim
> > > Cc: vinod.koul at intel.com; linux-arm-kernel at lists.infradead.org;
> linux-
> > > samsung-soc at vger.kernel.org; Kukjin Kim; Jassi Brar; Grant Likely;
> > > Mark Brown; Dan Williams
> > > Subject: Re: [PATCH V4 12/14] spi/s3c64xx: Add support DMA engine
> API
> > >
> > > On Mon, 2011-07-25 at 10:28 +0900, Boojin Kim wrote:
> > > > This patch adds to support DMA generic API to transfer raw
> > > > SPI data. Basiclly the spi driver uses DMA generic API if
> > > > architecture supports it. Otherwise, uses Samsung specific
> > > > S3C-PL330 APIs.
> > > >
> > > > Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> > > > Cc: Grant Likely <grant.likely@secretlab.ca>
> > > > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > > > ---
> > > >  drivers/spi/spi_s3c64xx.c |  141 ++++++++++++++++++++++---------
> ----
> > > ----------
> > > >  1 files changed, 69 insertions(+), 72 deletions(-)
> > > >
> > > > diff --git a/drivers/spi/spi_s3c64xx.c
> b/drivers/spi/spi_s3c64xx.c
> > > > index 8945e20..a4cf76a 100644
> > > > --- a/drivers/spi/spi_s3c64xx.c
> > > > +++ b/drivers/spi/spi_s3c64xx.c
> > > > @@ -172,6 +172,9 @@ struct s3c64xx_spi_driver_data {
> > > >  	unsigned                        state;
> > > >  	unsigned                        cur_mode, cur_bpw;
> > > >  	unsigned                        cur_speed;
> > > > +	unsigned			rx_ch;
> > > > +	unsigned			tx_ch;
> > > > +	struct samsung_dma_ops		*ops;
> > > >  };
> > > >
> > > >  static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
> > > > @@ -227,6 +230,38 @@ static void flush_fifo(struct
> > > s3c64xx_spi_driver_data *sdd)
> > > >  	writel(val, regs + S3C64XX_SPI_CH_CFG);
> > > >  }
> > > >
> > > > +static void s3c64xx_spi_dma_rxcb(void *data)
> > > > +{
> > > > +	struct s3c64xx_spi_driver_data *sdd
> > > > +		= (struct s3c64xx_spi_driver_data *)data;
> > > > +	unsigned long flags;
> > > > +
> > > > +	spin_lock_irqsave(&sdd->lock, flags);
> > > > +
> > > > +	sdd->state &= ~RXBUSY;
> > > > +	/* If the other done */
> > > > +	if (!(sdd->state & TXBUSY))
> > > > +		complete(&sdd->xfer_completion);
> > > > +
> > > > +	spin_unlock_irqrestore(&sdd->lock, flags);
> > > > +}
> > > > +
> > > > +static void s3c64xx_spi_dma_txcb(void *data)
> > > > +{
> > > > +	struct s3c64xx_spi_driver_data *sdd
> > > > +		= (struct s3c64xx_spi_driver_data *)data;
> > > > +	unsigned long flags;
> > > > +
> > > > +	spin_lock_irqsave(&sdd->lock, flags);
> > > > +
> > > > +	sdd->state &= ~TXBUSY;
> > > > +	/* If the other done */
> > > > +	if (!(sdd->state & RXBUSY))
> > > > +		complete(&sdd->xfer_completion);
> > > > +
> > > > +	spin_unlock_irqrestore(&sdd->lock, flags);
> > > > +}
> > > I don't see much diff in these two functions and you should be
> able to
> > > use a generic one which takes care of both TX and RX, does your
> > > callback
> > > data know if the channel is for TX or RX? If not then a helper to
> do
> > > above should take care well and making code simpler
> > I'm very agree with you.
> > But, I think it isn't deeply related to this patch series. So, I
> wish to make
> > and submit it after this patch series is finished.
> >
> Since you are reworking this driver would make sense to do now, it
> doesn't sound to be a big change.
Ok. I will follow your request.
I will make new patch for it and send it with V5 patchset.

>
> --
> ~Vinod Koul
> Intel Corp.
