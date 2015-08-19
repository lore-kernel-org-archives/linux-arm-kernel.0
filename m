From: dhdang@apm.com (Duc Dang)
Date: Wed, 19 Aug 2015 14:28:33 -0700
Subject: [PATCH v5 1/2] usb: make xhci platform driver use 64 bit or 32
 bit DMA
In-Reply-To: <1643536.i8Q5EFEN01@wuerfel>
References: <CADaLNDkU14GCPZE_zNt_9kMSsUdywyNp1QCiWpokXQgbfRS0qw@mail.gmail.com>
 <20150808092252.GJ7557@n2100.arm.linux.org.uk>
 <CADaLNDn4SvW3hvi7H0c_z2xgVSgRHLOK06xMyTYJd+ddFqc7Nw@mail.gmail.com>
 <1643536.i8Q5EFEN01@wuerfel>
Message-ID: <CADaLNDmYt+k6Sw6q+t2-FA7muk=x6h_hfYV321B03qBPMD_=AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 15, 2015 at 1:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Saturday 08 August 2015 13:31:02 Duc Dang wrote:
> > >
> > > If we know that pdev->dev.dma_mask will always be initialised at this
> > > point, then the above change is fine.  If not, it's introducing a
> > > regression - dma_set_mask_and_coherent() will fail if pdev->dev.dma_mask
> > > is NULL (depending on the architectures implementation of dma_set_mask()).
> > >
> > > Prefixing the above change with the two lines I mention above would
> > > ensure equivalent behaviour.  Even if we do want to get rid of this,
> > > I'd advise to do it as a separate patch after this change, which can
> > > be independently reverted if there's problems with its removal.
> > >
> > Hi Russell,
> >
> > I will add the 2 lines you mentioned back to next version of the
> > patch. It is safer to do it that way as I do not see
> > pdev->dev.dma_mask gets initialized before the call
> > dma_set_mask_and_coherent  inside this xhci_plat.c file.
>
> It would be good to add a WARN_ON() to the case where dma_mask
> is a NULL pointer at the least. That way, we will at least
> find out if there are some broken platforms that do not correctly
> initialize the mask pointer.

Hi Arnd,

So the check will look like this, please let me know what do you think:
        if (!pdev->dev.dma_mask) {
                WARN_ON(1);
                /* Initialize dma_mask if the broken platform code has
not done so */
                pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
        }

>
>         Arnd




-- 
Regards,
Duc Dang.
