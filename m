From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Jan 2011 10:27:26 +0000
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <AANLkTi=HzzOkVmD9z=9uRdzHsaixFAfOv9BmxoY=u7uf@mail.gmail.com>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110130212856.GA32737@n2100.arm.linux.org.uk>
	<AANLkTi=HzzOkVmD9z=9uRdzHsaixFAfOv9BmxoY=u7uf@mail.gmail.com>
Message-ID: <20110131102726.GA8948@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 11:17:42AM +0100, Linus Walleij wrote:
> 2011/1/30 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > 8<----
> > Subject: [PATCH 1/2] ARM: mmci: complete the transaction on error
> >
> > When we encounter an error, make sure we complete the transaction
> > otherwise we'll leave the request dangling.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> > ?drivers/mmc/host/mmci.c | ? ?2 +-
> > ?1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index b6fd6dc..175a623 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -319,7 +319,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
> > ? ? ? ?if (status & MCI_DATABLOCKEND)
> > ? ? ? ? ? ? ? ?dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
> >
> > - ? ? ? if (status & MCI_DATAEND) {
> > + ? ? ? if (status & MCI_DATAEND || data->error) {
> > ? ? ? ? ? ? ? ?mmci_stop_data(host);
> 
> The hardware always sets the MCI_DATAEND bit if there is
> some error, so these flags always appear simultaneously, but
> it doesn't hurt to take some extra precaution, so

The hardware may do, but you won't see that here.  When we setup a
transfer, we do this:

        writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);

When we receive an interrupt:

                status = readl(host->base + MMCISTATUS);
                status &= readl(host->base + MMCIMASK0);

                if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|
                              MCI_RXOVERRUN|MCI_DATAEND|MCI_DATABLOCKEND) && data)
                        mmci_data_irq(host, data, status);

When we get to the end of a transfer:

        /*
         * If we run out of data, disable the data IRQs; this
         * prevents a race where the FIFO becomes empty before
         * the chip itself has disabled the data path, and
         * stops us racing with our data end IRQ.
         */
        if (host->size == 0) {
                mmci_set_mask1(host, 0);
                writel(readl(base + MMCIMASK0) | MCI_DATAENDMASK, base + MMCIMASK0);
        }

So, we'll only see DATAEND when we actually reach the end of a transfer.
If we error out before hand, we won't see it.
