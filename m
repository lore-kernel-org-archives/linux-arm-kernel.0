From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Jul 2012 06:30:36 +0000
Subject: [PATCH 3/7] MTD: pxa3xx-nand: add devicetree bindings
In-Reply-To: <201207260259.51511.marek.vasut@gmail.com>
References: <1343233066-15397-1-git-send-email-zonque@gmail.com>
 <1343233066-15397-4-git-send-email-zonque@gmail.com>
 <201207260259.51511.marek.vasut@gmail.com>
Message-ID: <201207260630.36924.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 July 2012, Marek Vasut wrote:
> > -     r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> > -     if (r == NULL) {
> > -             dev_err(&pdev->dev, "no resource defined for data DMA\n");
> > -             ret = -ENXIO;
> > -             goto fail_put_clk;
> > -     }
> > -     info->drcmr_dat = r->start;
> > +     /*
> > +      * This is a dirty hack to make this driver work from devicetree
> > +      * bindings. It can be removed once we have a prober DMA controller
> > +      * framework for DT.
> > +      */
> > +     if (pdev->dev.of_node && cpu_is_pxa3xx()) {
> > +             info->drcmr_dat = 97;
> > +             info->drcmr_cmd = 99;
> 
> cpu_is_() stuff should begone ... besides, what are these numbers here?

They are the numbers from the DMA resource. It's ugly but I think reasonable
to do this here. We will clean it up soon, once the bindings are in place.

I did notice though the the two "info->drcmr_dat = r->start" assignments in
the non-DT case are removed here. I think that's a bug.

	Arnd
