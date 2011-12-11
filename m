From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 11 Dec 2011 16:05:48 +0100
Subject: [PATCH] SPI: add CSR SiRFprimaII SPI controller driver
In-Reply-To: <CAGsJ_4xeN5D47UbG-Xfr0NkvkcuYjP-LRUjumHz+OqTbH=y-_g@mail.gmail.com>
References: <1322797883-28915-1-git-send-email-Barry.Song@csr.com>
 <20111208131509.GA13430@pengutronix.de>
 <CAGsJ_4xeN5D47UbG-Xfr0NkvkcuYjP-LRUjumHz+OqTbH=y-_g@mail.gmail.com>
Message-ID: <20111211150548.GA30502@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> + ? ? writel(0, sspi->base + SPI_RXFIFO_OP); ?/* TX, RX FIFO stop */
> >> + ? ? writel(0, sspi->base + SPI_TXFIFO_OP);
> >> + ? ? writel(0, sspi->base + SPI_TX_RX_EN); ? /* RX, TX disable */
> >> + ? ? writel(0, sspi->base + SPI_INT_EN); ? ? /* Disable all interrupts */
> >
> > I'd think the comments after all those writel are stating the obvious :)
> 
> the last two are. but the first one can still be there by:
> /* TX, RX FIFO stop */
> writel(0, sspi->base + SPI_RXFIFO_OP);
> writel(0, sspi->base + SPI_TXFIFO_OP);

ACK. There are similar "obvious" ones in other places of the code, take care
you get them all, please.

> >> + ? ? mem_res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> >> + ? ? if (mem_res == NULL) {
> >> + ? ? ? ? ? ? dev_err(&dev->dev, "Unable to get IO resource\n");
> >> + ? ? ? ? ? ? ret = -ENOMEM;
> >> + ? ? ? ? ? ? goto free_master;
> >> + ? ? }
> >
> > devm_request_mem_region() is missing. Or use the new
> > devm_request_and_ioremap() function (although currently only available
> > in linux-next).
> 
> many drivers ignore the process to request mem region. if you like, i will add.

That doesn't make it "right", though. In fact, this flaw was one reason I wrote
devm_request_and_ioremap().

> i'd like to use devm_request_mem_region() + devm_ioremap() at first,
> then move to devm_request_and_ioremap() in next window.

Why? You could just pick the patch into your branch and mention the dependency,
so we will merge it after drivers/base.

> >> + ? ? spi_bitbang_stop(&sspi->bitbang);
> >> + ? ? clk_put(sspi->clk);
> >> + ? ? clk_disable(sspi->clk);
> >
> > First put then disable?
> clk_disable(sspi->clk);
> clk_put(sspi->clk);

That looks better :)

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111211/bee2df17/attachment.sig>
