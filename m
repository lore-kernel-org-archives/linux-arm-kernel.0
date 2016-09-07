From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 07 Sep 2016 13:24:07 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <12021424.cItk3A7CfE@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <5844875.KucAoPMrXi@wuerfel> <20160907063313.GA13903@b29397-desktop>
 <12021424.cItk3A7CfE@wuerfel>
Message-ID: <87inu8kny0.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Arnd Bergmann <arnd@arndb.de> writes:

[...]

> Regarding the DMA configuration that you mention in ci_hdrc_add_device(),
> I think we should replace 
>
>         pdev->dev.dma_mask = dev->dma_mask;
>         pdev->dev.dma_parms = dev->dma_parms;
>         dma_set_coherent_mask(&pdev->dev, dev->coherent_dma_mask);
>
> with of_dma_configure(), which has the chance to configure more than
> just those three, as the dma API might look into different aspects:
>
> - iommu specific configuration
> - cache coherency information
> - bus type
> - dma offset
> - dma_map_ops pointer
>
> We try to handle everything in of_dma_configure() at configuration
> time, and that would be the place to add anything else that we might
> need in the future.

There are a couple problems with this:

1) won't work for PCI-based systems.

DWC3 is used in production PCI-based HW and also in Synopsys HAPS DX
platform (FPGA that appears like a PCI card to host PC)


2) not very robust solution

of_dma_configure() will hardcode 32-bit DMA dmask for xhci-plat because
that's not created by DT. The only reason why this works at all is
because of the default 32-bit dma mask thing :-) So, how is it any
different than copying 32-bit dma mask from parent?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/f2ae3b10/attachment-0001.sig>
