From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 30 Apr 2013 14:12:15 +0100
Subject: [PATCH] mmc: mmci: Allow MMCI to request channels with
 information acquired from DT
In-Reply-To: <CACRpkdY+WtjnJGhVOCk3OZW+Z1maO0ru+Fc2wPR7OzWe+RMuJg@mail.gmail.com>
References: <1366801122-13302-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdY+WtjnJGhVOCk3OZW+Z1maO0ru+Fc2wPR7OzWe+RMuJg@mail.gmail.com>
Message-ID: <20130430131215.GA25256@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Apr 2013, Linus Walleij wrote:

> On Wed, Apr 24, 2013 at 12:58 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Currently, if DMA information isn't passed from platform data, then DMA
> > will not be used. This patch allows DMA information obtained though Device
> > Tree to be used as well.
> >
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: linux-mmc at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> (...)
> 
> I tried to test this patch, but:
>   CC      drivers/mmc/host/mmci.o
> /drivers/mmc/host/mmci.c: In function 'mmci_dma_setup':
> /drivers/mmc/host/mmci.c:307:51: error: 'dev' undeclared (first use in
> this function)
> /drivers/mmc/host/mmci.c:307:51: note: each undeclared identifier is
> reported only once for each function it appears in
> make[5]: *** [drivers/mmc/host/mmci.o] Error 1
> make[4]: *** [drivers/mmc/host] Error 2
> make[3]: *** [drivers/mmc] Error 2
> 
> Due to:
> 
> > @@ -304,10 +304,8 @@ static void mmci_dma_setup(struct mmci_host *host)
> >         const char *rxname, *txname;
> >         dma_cap_mask_t mask;
> >
> > -       if (!plat || !plat->dma_filter) {
> > -               dev_info(mmc_dev(host->mmc), "no DMA platform data\n");
> > -               return;
> > -       }
> > +       host->dma_rx_channel = dma_request_slave_channel(dev, "rx");
> > +       host->dma_tx_channel = dma_request_slave_channel(dev, "tx");
> 
> There is no "dev" here.

You've missed v2 again dude.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
