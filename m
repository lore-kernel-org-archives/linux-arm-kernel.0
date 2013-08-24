From: shijie8@gmail.com (Huang Shijie)
Date: Sat, 24 Aug 2013 09:42:03 -0400
Subject: [PATCH V1 4/5] spi: Add Freescale QuadSpi driver
In-Reply-To: <20130823164442.GA30359@sirena.org.uk>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <1376885403-12156-5-git-send-email-b32955@freescale.com>
 <20130823164442.GA30359@sirena.org.uk>
Message-ID: <20130824134201.GA7572@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 05:44:42PM +0100, Mark Brown wrote:
> On Mon, Aug 19, 2013 at 12:10:02PM +0800, Huang Shijie wrote:
> 
> > +static int fsl_qspi_nor_do_one_msg(struct spi_master *master,
> > +		struct spi_message *m)
> > +{
> > +	struct fsl_qspi *q = spi_master_get_devdata(master);
> > +	struct spi_transfer *t;
> > +	int ret = 0;
> > +
> > +	list_for_each_entry(t, &m->transfers, transfer_list) {
> > +		if (t->rx_buf && t->tx_buf) {
> > +			dev_err(q->dev,
> > +				"Can't send and receive simultaneously\n");
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +
> > +		if (t->tx_buf) {
> > +			ret = fsl_qspi_nor_tx(q, t);
> > +			if (!ret)
> > +				m->actual_length += t->len;
> > +			continue;
> > +		}
> > +
> > +		if (t->rx_buf) {
> > +			ret = fsl_qspi_nor_rx(q, t);
> > +			if (!ret)
> > +				m->actual_length += t->len;
> > +		}
> > +	}
> 
> The driver should flag SPI_HALF_DUPLEX since it doesn't support
> simultaneous RX and TX.
> 
okay, i will add the flag in the next version.


thanks
Huang Shijie
