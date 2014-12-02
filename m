From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Dec 2014 10:16:12 +0100
Subject: [PATCH v6 2/8] dma-mapping: replace set_arch_dma_coherent_ops
 with arch_setup_dma_ops
In-Reply-To: <CAL_JsqLtN3euwXHM4BzYxkXsgE=Dmn05aXzL+kr_8x23voneZA@mail.gmail.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <1417453034-21379-3-git-send-email-will.deacon@arm.com>
 <CAL_JsqLtN3euwXHM4BzYxkXsgE=Dmn05aXzL+kr_8x23voneZA@mail.gmail.com>
Message-ID: <18789666.A0Z8YWCnk0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 16:58:09 Rob Herring wrote:
> > @@ -178,28 +180,21 @@ static void of_dma_configure(struct device *dev)
> >         if (!dev->dma_mask)
> >                 dev->dma_mask = &dev->coherent_dma_mask;
> >
> > -       /*
> > -        * if dma-coherent property exist, call arch hook to setup
> > -        * dma coherent operations.
> > -        */
> > -       if (of_dma_is_coherent(dev->of_node)) {
> > -               set_arch_dma_coherent_ops(dev);
> > -               dev_dbg(dev, "device is dma coherent\n");
> > -       }
> > -
> > -       /*
> > -        * if dma-ranges property doesn't exist - just return else
> > -        * setup the dma offset
> > -        */
> >         ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
> >         if (ret < 0) {
> > -               dev_dbg(dev, "no dma range information to setup\n");
> > -               return;
> > +               dma_addr = offset = 0;
> > +               size = dev->coherent_dma_mask;
> 
> It looks like size is not used.

Catalin has proposed a patch for handling the size right, but it's
still under discussion.

	Arnd
