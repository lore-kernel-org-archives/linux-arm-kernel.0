From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Aug 2015 22:05:09 +0200
Subject: [PATCH v5 1/2] usb: make xhci platform driver use 64 bit or 32
 bit DMA
In-Reply-To: <CADaLNDn4SvW3hvi7H0c_z2xgVSgRHLOK06xMyTYJd+ddFqc7Nw@mail.gmail.com>
References: <CADaLNDkU14GCPZE_zNt_9kMSsUdywyNp1QCiWpokXQgbfRS0qw@mail.gmail.com>
 <20150808092252.GJ7557@n2100.arm.linux.org.uk>
 <CADaLNDn4SvW3hvi7H0c_z2xgVSgRHLOK06xMyTYJd+ddFqc7Nw@mail.gmail.com>
Message-ID: <1643536.i8Q5EFEN01@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 08 August 2015 13:31:02 Duc Dang wrote:
> >
> > If we know that pdev->dev.dma_mask will always be initialised at this
> > point, then the above change is fine.  If not, it's introducing a
> > regression - dma_set_mask_and_coherent() will fail if pdev->dev.dma_mask
> > is NULL (depending on the architectures implementation of dma_set_mask()).
> >
> > Prefixing the above change with the two lines I mention above would
> > ensure equivalent behaviour.  Even if we do want to get rid of this,
> > I'd advise to do it as a separate patch after this change, which can
> > be independently reverted if there's problems with its removal.
> >
> Hi Russell,
> 
> I will add the 2 lines you mentioned back to next version of the
> patch. It is safer to do it that way as I do not see
> pdev->dev.dma_mask gets initialized before the call
> dma_set_mask_and_coherent  inside this xhci_plat.c file.

It would be good to add a WARN_ON() to the case where dma_mask
is a NULL pointer at the least. That way, we will at least
find out if there are some broken platforms that do not correctly
initialize the mask pointer.

	Arnd
