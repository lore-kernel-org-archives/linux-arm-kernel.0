From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Aug 2015 15:09:11 +0200
Subject: [PATCH v5 1/2] usb: make xhci platform driver use 64 bit or 32
 bit DMA
In-Reply-To: <CADaLNDmYt+k6Sw6q+t2-FA7muk=x6h_hfYV321B03qBPMD_=AA@mail.gmail.com>
References: <CADaLNDkU14GCPZE_zNt_9kMSsUdywyNp1QCiWpokXQgbfRS0qw@mail.gmail.com>
 <1643536.i8Q5EFEN01@wuerfel>
 <CADaLNDmYt+k6Sw6q+t2-FA7muk=x6h_hfYV321B03qBPMD_=AA@mail.gmail.com>
Message-ID: <1522889.9kdnRk8vHo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 August 2015 14:28:33 Duc Dang wrote:
> 
> Hi Arnd,
> 
> So the check will look like this, please let me know what do you think:
>         if (!pdev->dev.dma_mask) {
>                 WARN_ON(1);
>                 /* Initialize dma_mask if the broken platform code has
> not done so */
>                 pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
>         }

The condition can be written as 

	if (WARN_ON(!pdev->dev.dma_mask))

and I'd use dma_coerce_mask_and_coherent() instead of manually setting the
pointer, as an annotation for the fact that we are knowingly violating the
API here.

Those two points are just cosmetic though, aside from them, your code
above is what I had in mind.

Thanks,

	Arnd
