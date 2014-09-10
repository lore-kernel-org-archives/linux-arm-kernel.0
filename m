From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Sep 2014 16:52:16 +0100
Subject: [PATCH v5] spi: spi-imx: add DMA support
In-Reply-To: <20140910151759.GA31462@Robin-OptiPlex-780>
References: <1410312604-31949-1-git-send-email-b38343@freescale.com>
 <20140910102105.GR2601@sirena.org.uk>
 <20140910112258.GA30794@Robin-OptiPlex-780>
 <20140910114530.GD7960@sirena.org.uk>
 <20140910151759.GA31462@Robin-OptiPlex-780>
Message-ID: <20140910155216.GI7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 11:18:01PM +0800, Robin Gong wrote:
> On Wed, Sep 10, 2014 at 12:45:30PM +0100, Mark Brown wrote:

> > > Yes, you're right. I should use "transfer->tx_sg->sgl == NULL" or
> > > "transfer->rx_sg->sgl == NULL" instead of usedma flag in driver, right?

> > Right.

> But looks spi core framework can make sure every rx or tx transfer in sequence.
> If so, can_dma will never be called until this transfer finished
> (spi_pump_messages), and my usedma flag also never be modified until next
> transfer start. Please correct me if I am wrong, thanks.

Even if that were true currently this would still not be good code since
it would break in the face of SPI core changes.  In any case the
assumption isn't true for the current SPI core, the DMA mapping is done
for all transfers in a message before we start running them and it's
entirely likely that we will have patterns like a short PIO transfer
followed by a big data block.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140910/b45be854/attachment.sig>
