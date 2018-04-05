From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 5 Apr 2018 11:19:13 +0200
Subject: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
In-Reply-To: <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-4-ssuloev@orpaltech.com>
 <20180404065048.n76r3ytuznd6fqsl@flea>
 <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
Message-ID: <20180405091913.ky4dnmszoobn2xry@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2018 at 02:35:14PM +0300, Sergey Suloev wrote:
> On 04/04/2018 09:50 AM, Maxime Ripard wrote:
> > On Tue, Apr 03, 2018 at 06:44:46PM +0300, Sergey Suloev wrote:
> > > There is no need to handle 3/4 empty interrupt as the maximum
> > > supported transfer length in PIO mode is equal to FIFO depth,
> > > i.e. 128 bytes for sun6i and 64 bytes for sun8i SoCs.
> > > 
> > > Changes in v3:
> > > 1) Restored processing of 3/4 FIFO full interrupt.
> > > 
> > > Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> > > ---
> > >   drivers/spi/spi-sun6i.c | 41 +++++++++++++++++------------------------
> > >   1 file changed, 17 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> > > index 78acc1f..c09ad10 100644
> > > --- a/drivers/spi/spi-sun6i.c
> > > +++ b/drivers/spi/spi-sun6i.c
> > > @@ -207,7 +207,10 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
> > >   static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
> > >   {
> > > -	return SUN6I_MAX_XFER_SIZE - 1;
> > > +	struct spi_master *master = spi->master;
> > > +	struct sun6i_spi *sspi = spi_master_get_devdata(master);
> > > +
> > > +	return sspi->fifo_depth;
> > Doesn't that effectively revert 3288d5cb40c0 ?
> > 
> > Why do you need to do so?
>
> Need what?

Why do you need to revert that change.

> Change is supposed to restrict max transfer size for PIO mode otherwise it
> will fail.
> The maximum transfer length = FIFO depth for PIO mode.

The point of that patch was precisely to allow to send more data than
the FIFO. You're breaking that behaviour without any justification,
and this is not ok.

> > 
> > >   }
> > >   static int sun6i_spi_prepare_message(struct spi_master *master,
> > > @@ -255,8 +258,14 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
> > >   	int ret = 0;
> > >   	u32 reg;
> > > -	if (tfr->len > SUN6I_MAX_XFER_SIZE)
> > > -		return -EINVAL;
> > > +	/* A zero length transfer never finishes if programmed
> > > +	   in the hardware */
> > Improper comment style here. Please make sure to run checkpatch before
> > sending your patches.
> ok
> > 
> > > +	if (!tfr->len)
> > > +		return 0;
> > Can that case even happen?
> Not sure, just for safety.
> > 
> > > +	/* Don't support transfer larger than the FIFO */
> > > +	if (tfr->len > sspi->fifo_depth)
> > > +		return -EMSGSIZE;
> > You're changing the return type, why?
> As? a more appropriate one

The fact that it's more appropriate should be justified.

> > 
> > >   	reinit_completion(&sspi->done);
> > >   	sspi->tx_buf = tfr->tx_buf;
> > > @@ -278,8 +287,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
> > >   	 */
> > >   	trig_level = sspi->fifo_depth / 4 * 3;
> > >   	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
> > > -			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS) |
> > > -			(trig_level << SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS));
> > > +			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS));
> > >   	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
> > > @@ -343,11 +351,8 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
> > >   	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
> > >   	/* Enable the interrupts */
> > > -	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
> > >   	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC |
> > >   					 SUN6I_INT_CTL_RF_RDY);
> > > -	if (tx_len > sspi->fifo_depth)
> > > -		sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TF_ERQ);
> > This would also need to be explained in your commit log.
> What exactly and in what way ?

You should explain, at least:
A) What is the current behaviour
B) Why that is a problem, or what problem does it cause
C) What solution you implement and why you think it's justified

> > 
> > >   	/* Start the transfer */
> > >   	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
> > > @@ -376,7 +381,9 @@ out:
> > >   static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
> > >   {
> > >   	struct sun6i_spi *sspi = dev_id;
> > > -	u32 status = sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
> > > +	u32 status;
> > > +
> > > +	status = sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
> > Why is this change needed?
> A minor one, for readability.

That's arguable, and you should have a single logical change per
patch. So this doesn't belong in this one.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180405/d15b0174/attachment-0001.sig>
