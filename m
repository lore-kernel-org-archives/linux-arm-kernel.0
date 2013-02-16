From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Feb 2013 23:28:34 +0000
Subject: [PATCHv3 2/4] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <CAHp75VeCic+5_zyzFdtpw5dLxRaajD9zv6ZvSoDcHAD1EF=GSw@mail.gmail.com>
References: <1360952512-971558-1-git-send-email-arnd@arndb.de>
 <201302162221.32799.arnd@arndb.de>
 <CAHp75VeCic+5_zyzFdtpw5dLxRaajD9zv6ZvSoDcHAD1EF=GSw@mail.gmail.com>
Message-ID: <201302162328.35068.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 February 2013, Andy Shevchenko wrote:

> > @@ -1836,6 +1825,12 @@ static int dw_probe(struct platform_device *pdev)
> >
> >         dma_async_device_register(&dw->dma);
> >
> > +       if (pdev->dev.of_node)
> > +               err = of_dma_controller_register(pdev->dev.of_node,
> > +                                                dw_dma_xlate, dw);
> > +       if (err && err != -ENODEV)
> > +               dev_err(&pdev->dev, "could not register of_dma_controller\n");
> 
> I believe we may make it as
>  if (...of_node) {
>   err = ...register();
>   if (err...)
>     dev_err();
>  }

I thing the two are equivalent because we only get to the first if()
when err is 0. However, I agree that your version is a bit clearer,
so I'll change it.

> > --- a/drivers/dma/dw_dmac_regs.h
> > +++ b/drivers/dma/dw_dmac_regs.h
> 
> > @@ -211,9 +212,15 @@ struct dw_dma_chan {
> >         /* hardware configuration */
> >         unsigned int            block_size;
> >         bool                    nollp;
> > +       unsigned int            request_line;
> > +       struct dw_dma_slave     slave;
> > +
> 
> Do we really need an extra empty line here?

No, that was an accident.

> >         /* configuration passed via DMA_SLAVE_CONFIG */
> >         struct dma_slave_config dma_sconfig;
> > +
> > +       /* backlink to dw_dma */
> > +       struct dw_dma           *dw;
> 
> Seems it's not needed and came from rebase?

Probably. It certainly was not intentional.

	Arnd
