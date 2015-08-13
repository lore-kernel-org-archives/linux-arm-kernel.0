From: leilk.liu@mediatek.com (lei liu)
Date: Thu, 13 Aug 2015 10:11:59 +0800
Subject: [PATCH] spi: Mediatek: fix endian warnings
In-Reply-To: <CAOiHx=mrDhxkMd5WVTpayyyxXHUDRTELubErynN3qd-v5qpCfw@mail.gmail.com>
References: <1439289789-29026-1-git-send-email-leilk.liu@mediatek.com>
 <CAOiHx=mrDhxkMd5WVTpayyyxXHUDRTELubErynN3qd-v5qpCfw@mail.gmail.com>
Message-ID: <1439431919.21454.13.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

 This patch is applied, should I append a new patch or you rollback it?
Thanks.

On Wed, 2015-08-12 at 16:45 +0200, Jonas Gorski wrote:
> Hi,
> 
> On Tue, Aug 11, 2015 at 12:43 PM, Leilk Liu <leilk.liu@mediatek.com> wrote:
> > This patch fixes endian warnings detected by sparse:
> > - sparse: incorrect type in argument 1 (different base types)
> >           expected unsigned int [unsigned] val
> >           got restricted __le32 [usertype] <noident>
> > - sparse: incorrect type in argument 1 (different base types)
> >           expected unsigned int [unsigned] val
> >           got restricted __le32 [usertype] <noident>
> 
> This doesn't "fix" the warning, it only hides the warning and leaves
> the actual issue unfixed.
> 
> >
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  drivers/spi/spi-mt65xx.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> > index 4676b01..ae645fa 100644
> > --- a/drivers/spi/spi-mt65xx.c
> > +++ b/drivers/spi/spi-mt65xx.c
> > @@ -359,9 +359,11 @@ static void mtk_spi_setup_dma_addr(struct spi_master *master,
> >         struct mtk_spi *mdata = spi_master_get_devdata(master);
> >
> >         if (mdata->tx_sgl)
> > -               writel(cpu_to_le32(xfer->tx_dma), mdata->base + SPI_TX_SRC_REG);
> > +               writel((__force u32)cpu_to_le32(xfer->tx_dma),
> > +                      mdata->base + SPI_TX_SRC_REG);
> >         if (mdata->rx_sgl)
> > -               writel(cpu_to_le32(xfer->rx_dma), mdata->base + SPI_RX_DST_REG);
> > +               writel((__force u32)cpu_to_le32(xfer->rx_dma),
> > +                      mdata->base + SPI_RX_DST_REG);
> 
> The issue here is that writel already does a cpu_to_le32 conversion,
> so the extra cpu_to_le32 calls are actually bogus and need to be
> removed. Else it will do a double conversion on big endian systems,
> resulting in the data being written in big endian.
> 
> 
> Jonas
