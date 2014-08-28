From: b38343@freescale.com (Robin Gong)
Date: Thu, 28 Aug 2014 17:59:41 +0800
Subject: [PATCH v4] spi: spi-imx: add DMA support
In-Reply-To: <CAGUYZuQre3RAQy+qqwq5HthrjnT85V5RKu2xwXOC=gL6Yk33TQ@mail.gmail.com>
References: <1408752835-10995-1-git-send-email-b38343@freescale.com>
 <CAGUYZuQre3RAQy+qqwq5HthrjnT85V5RKu2xwXOC=gL6Yk33TQ@mail.gmail.com>
Message-ID: <20140828095939.GA13274@Robin-OptiPlex-780>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 11:12:08AM +0530, sanjeev sharma wrote:
> On Sat, Aug 23, 2014 at 5:43 AM, Robin Gong <b38343@freescale.com> wrote:
> 
> > +       /*
> > +        * Configure the DMA register: setup the watermark
> > +        * and enable DMA request.
> > +        */
> > +       if (spi_imx->dma_is_inited) {
> > +               dma = readl(spi_imx->base + MX51_ECSPI_DMA);
> > +
> > +               spi_imx->tx_wml = spi_imx_get_fifosize(spi_imx) / 2;
> > +               spi_imx->rx_wml = spi_imx_get_fifosize(spi_imx) / 2;
> > +               spi_imx->rxt_wml = spi_imx_get_fifosize(spi_imx) / 2;
> > +               rx_wml_cfg = spi_imx->rx_wml <<
> > MX51_ECSPI_DMA_RX_WML_OFFSET;
> > +               tx_wml_cfg = spi_imx->tx_wml <<
> > MX51_ECSPI_DMA_TX_WML_OFFSET;
> > +               rxt_wml_cfg = spi_imx->rxt_wml <<
> > MX51_ECSPI_DMA_RXT_WML_OFFSET;
> > +               dma = (dma & ~MX51_ECSPI_DMA_TX_WML_MASK
> > +                               & ~MX51_ECSPI_DMA_RX_WML_MASK
> > +                               & ~MX51_ECSPI_DMA_RXT_WML_MASK)
> > +                               | rx_wml_cfg | tx_wml_cfg | rxt_wml_cfg
> > +                               |(1 << MX51_ECSPI_DMA_TEDEN_OFFSET)
> > +                               |(1 << MX51_ECSPI_DMA_RXDEN_OFFSET)
> > +                               |(1 << MX51_ECSPI_DMA_RXTDEN_OFFSET);
> > +
> >
> 
> IMO, we should have an seperate function for dmactrl,rx_threshold &
> tx_threshold for better visiblity.
> 
>
I understood your concern, but I don't want to create one function only for
setting some bit fields of the register.
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
