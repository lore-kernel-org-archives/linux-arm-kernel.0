From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 19 Jun 2013 08:12:58 -0300
Subject: [PATCH v3 11/12] ARM: mvebu: Relocate Armada 370 PCIe device
 tree nodes
In-Reply-To: <201306182335.50722.arnd@arndb.de>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-12-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306182335.50722.arnd@arndb.de>
Message-ID: <20130619111257.GD16138@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Going through this a couple questions came out...

On Tue, Jun 18, 2013 at 11:35:50PM +0200, Arnd Bergmann wrote:
> On Tuesday 18 June 2013, Ezequiel Garcia wrote:
> > +
> > +                       ranges =
> > +                              <0x82000000 0 0x40000    0xffff0001 0x40000 0 0x00002000
> > +                               0x82000000 0 0x80000    0xffff0001 0x80000 0 0x00002000
> > +                               0x82000000 0 0xe0000000 0xffff0002 0          0 0x08000000
> > +                               0x81000000 0 0          0xffff0002 0x8000000  0 0x00100000>;
> 
> As pointed out on IRC, this is not a good representation of the memory space,
> since it requires a non-zero sys->mem_offset, and it conflicts with the straight
> mapping I suggested.
> 
> I think it should be
> 
>                                0x82000000 0 0xe0000000 0xffff0002 0  0xe0000000 0x08000000

So far, so good.

> 
> if we want to encode the aperture in the ranges property here, i.e. have
> a 1:1 mapping between PCI memory space and MBUS space, and in mbus,
> you need the corresponding
> 
> -                           0xffff0002 0 0xe0000000 0x8100000
> +                           0xffff0002 0xe0000000 0xe0000000 0x8100000

... I obviously got something wrong, but I thought you said that
this change allowed to *not* have any mbus-node ranges translation.

> 
> so that mbus actually translates the right addresses. You could also
> have the PCI memory space start at 0, which would mean
> 
>                                0x82000000 0 0 0xffff0002 0  0 0x08000000
> 
> and
> 
>                               0xffff0002 0 0xe0000000 0x8100000

Mmm.. and why is this option acceptable?

> 
> Note that the driver doesn't actually handle the generic case correctly, you would
> need to apply this patch
>

This patch does not apply. I tried to understand what you did, but I'm
confused by the fact I don't need to apply any patch to make it work
on my boxes, using your proposed ranges translations.

> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 13a633b..aa674f4 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -790,6 +790,7 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
>  		}
>  		if (restype == IORESOURCE_MEM) {
>  			of_pci_range_to_resource(&range, np, &pcie->mem);
> +			sys->mem_offset = range.cpu_addr - range.pci_addr;
>  			pcie->mem.name = "MEM";
>  		}
>  	}
> 
> to deal with the generic case where the bus address is different from the
> CPU address.
> 

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
