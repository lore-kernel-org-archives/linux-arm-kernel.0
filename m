From: B44548@freescale.com (Fu Chao-B44548)
Date: Wed, 7 Aug 2013 07:58:46 +0000
Subject: [PATCH v2 4/4] spi:Add Freescale DSPI driver for Vybrid VF610
 platform
In-Reply-To: <20130728184111.GG9858@sirena.org.uk>
References: <1374643943-3324-1-git-send-email-b44548@freescale.com>
 <1374643943-3324-5-git-send-email-b44548@freescale.com>
 <20130726072130.GA3029@pengutronix.de> <20130728184111.GG9858@sirena.org.uk>
Message-ID: <CC21DA4CC22BA845BF83A9324A91CE6209CF7F09@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Mark Brown [mailto:broonie at kernel.org] 
Sent: 2013?7?29? 2:41
To: Sascha Hauer
Cc: Fu Chao-B44548; linux-spi at vger.kernel.org; linux-arm-kernel at lists.infradead.org; grant.likely at linaro.org; Wang Huan-B18965; shawn.guo at linaro.org
Subject: Re: [PATCH v2 4/4] spi:Add Freescale DSPI driver for Vybrid VF610 platform

On Fri, Jul 26, 2013 at 09:21:30AM +0200, Sascha Hauer wrote:
> On Wed, Jul 24, 2013 at 01:32:23PM +0800, Chao Fu wrote:

Sascha, please delete unneeded context from your mails - it makes it much easier to find the new text.

> > +	tx_word = is_word_transfer(dspi);
> > +	/* If we are in word mode, but only have a single byte to transfer
> > +	 * then switch to byte mode temporarily.  Will switch back at the
> > +	 * end of the transfer. */

> Not sure if I understand this, but if you are in word mode then I 
> would consider it a bug when there's only one byte to transfer.

Yes, this is a definite bug - especially since SPI in word mode has a fixed word order on the bus.  The driver should never put the hardware into a word size other than that explicitly requested by the client and then it should insist on getting exact multiples of that word size.
[Chao Fu] This function(is_word_transfer(dspi)) can  judge a transfer is byte mode or double byte mode from register.
But I think this driver can transfer one byte.
1.Only one byte in a message in double byte mode:
	if (tx_word && (dspi->len == 1)) {
		dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
		set_8bit_transfer_mode(dspi);
		tx_word = 0;
	}
The driver will switch byte mode .
2.Transferring in double byte mode left a byte:
		if (tx_word) {
			if (dspi->len == 1)
				break;
We will break from this loop, transfer in next loop.

Sorry! This function name (is_word_transfer) may be not very clear. I will rename it.

> > +static int dspi_prepare_transfer_hw(struct spi_master *master) {
> > +	struct fsl_dspi *dspi = spi_master_get_devdata(master);
> > +
> > +	pm_runtime_get_sync(&dspi->pdev->dev);
> > +
> > +	return 0;
> > +}

I just posted a patch series which would allow you to have the core do this for you, please rebase on top of that.
