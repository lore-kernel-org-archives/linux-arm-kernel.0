From: balbi@ti.com (Felipe Balbi)
Date: Fri, 25 Apr 2014 15:10:42 -0500
Subject: [PATCH v2 03/18] usb: host: xhci-plat: Add support for the
 Armada 38x
In-Reply-To: <5392399.GiPjM0CIZ0@wuerfel>
References: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
 <1398434836-18908-4-git-send-email-gregory.clement@free-electrons.com>
 <5392399.GiPjM0CIZ0@wuerfel>
Message-ID: <20140425201042.GK29632@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 25, 2014 at 10:01:51PM +0200, Arnd Bergmann wrote:
> On Friday 25 April 2014 16:07:01 Gregory CLEMENT wrote:
> > @@ -148,6 +149,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
> >         if (ret)
> >                 return ret;
> >  
> > +       if (of_device_is_compatible(pdev->dev.of_node, "marvell,armada-380-xhci"))
> > +               xhci_mvebu_mbus_init_quirk(pdev);
> > +
> >         /* Initialize dma_mask and coherent_dma_mask to 32-bits */
> >         ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> >         if (ret)
> 
> I think you're doing it the wrong way around: You have a specialized

no, it's the correct way around.

> version of the generic xhci-plat driver. The normal way to handle this
> is to have a loadable module that contains all the Armada specific
> code and that registers a platform_driver. In the probe() function of

no, that'll cause too much duplication of boilerplate code. I asked him
to write it as a quirk because then we won't end up with and xhci
platform_driver for each of the ARM licensees when all they have are
small quirks here and there.

Imagine if you had one PCI driver for each possible XHCI PCI controller
out there.

It's pointless maintainenance burden.

> that driver, you can do the platform specific setup and then call
> the generic xhci_plat_probe() function, which of course has to
> be provided using EXPORT_SYMBOL_GPL.

yeah, that sucks. Exposing a probe() function like that. I rather have
probe() actually *probe* for the HW differences.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140425/b16b9ba2/attachment.sig>
