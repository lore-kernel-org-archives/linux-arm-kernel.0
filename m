From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Apr 2014 22:01:51 +0200
Subject: [PATCH v2 03/18] usb: host: xhci-plat: Add support for the Armada
 38x
In-Reply-To: <1398434836-18908-4-git-send-email-gregory.clement@free-electrons.com>
References: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
 <1398434836-18908-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <5392399.GiPjM0CIZ0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 April 2014 16:07:01 Gregory CLEMENT wrote:
> @@ -148,6 +149,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>  
> +       if (of_device_is_compatible(pdev->dev.of_node, "marvell,armada-380-xhci"))
> +               xhci_mvebu_mbus_init_quirk(pdev);
> +
>         /* Initialize dma_mask and coherent_dma_mask to 32-bits */
>         ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>         if (ret)

I think you're doing it the wrong way around: You have a specialized
version of the generic xhci-plat driver. The normal way to handle this
is to have a loadable module that contains all the Armada specific
code and that registers a platform_driver. In the probe() function of
that driver, you can do the platform specific setup and then call
the generic xhci_plat_probe() function, which of course has to
be provided using EXPORT_SYMBOL_GPL.

We have just spent a lot of effort converting the EHCI and OHCI drivers
to the more generic model, so we shouldn't do it the wrong way for
xhci. I just noticed that we already have this creeping into the 
xhci driver in the from of a common xhci_hcd_init() function calling
xhci_register_pci() and xhci_register_plat(). It would be good to
clean that up at the same time, it should only require exporting
a few symbols from xhci.c for use by the two front-ends.

	Arnd
