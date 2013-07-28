From: broonie@kernel.org (Mark Brown)
Date: Sun, 28 Jul 2013 19:41:11 +0100
Subject: [PATCH v2 4/4] spi:Add Freescale DSPI driver for Vybrid VF610
 platform
In-Reply-To: <20130726072130.GA3029@pengutronix.de>
References: <1374643943-3324-1-git-send-email-b44548@freescale.com>
 <1374643943-3324-5-git-send-email-b44548@freescale.com>
 <20130726072130.GA3029@pengutronix.de>
Message-ID: <20130728184111.GG9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 09:21:30AM +0200, Sascha Hauer wrote:
> On Wed, Jul 24, 2013 at 01:32:23PM +0800, Chao Fu wrote:

Sascha, please delete unneeded context from your mails - it makes it
much easier to find the new text.

> > +	tx_word = is_word_transfer(dspi);
> > +	/* If we are in word mode, but only have a single byte to transfer
> > +	 * then switch to byte mode temporarily.  Will switch back at the
> > +	 * end of the transfer. */

> Not sure if I understand this, but if you are in word mode then I would
> consider it a bug when there's only one byte to transfer.

Yes, this is a definite bug - especially since SPI in word mode has a
fixed word order on the bus.  The driver should never put the hardware
into a word size other than that explicitly requested by the client and
then it should insist on getting exact multiples of that word size.

> > +static int dspi_prepare_transfer_hw(struct spi_master *master)
> > +{
> > +	struct fsl_dspi *dspi = spi_master_get_devdata(master);
> > +
> > +	pm_runtime_get_sync(&dspi->pdev->dev);
> > +
> > +	return 0;
> > +}

I just posted a patch series which would allow you to have the core do
this for you, please rebase on top of that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130728/fb3f560b/attachment.sig>
