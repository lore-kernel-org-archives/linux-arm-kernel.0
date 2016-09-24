From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 24 Sep 2016 23:00:40 +0200
Subject: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <05a573de-e963-6590-6ed3-55af97067d7a@gmail.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <1849232.KJrfRPHGN6@wuerfel> <05a573de-e963-6590-6ed3-55af97067d7a@gmail.com>
Message-ID: <2866656.cISrGNv8pP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, September 24, 2016 4:14:15 PM CEST zhichang wrote:
> 
> In V3, the outb is :
> 
> void outb(u8 value, unsigned long addr)
> {
>         if (!arm64_extio_ops || arm64_extio_ops->start > addr ||
>                         arm64_extio_ops->end < addr)
>                 writeb(value, PCI_IOBASE + addr);
>         else
>                 if (arm64_extio_ops->pfout)
>                         arm64_extio_ops->pfout(arm64_extio_ops->devpara,
>                                 addr + arm64_extio_ops->ptoffset, &value,
>                                 sizeof(u8), 1);
> }
> 
> here, arm64_extio_ops->ptoffset is the offset between the real legacy IO address
> and the logical IO address, similar to the offset of primary address and
> secondary address in PCI bridge.

Ok, though we can probably simplify this by making the assumption that
'ptoffset' is the negative of 'start', as the bus we register should
always start at port zero.

> But in V3, LPC driver call pci_address_to_pio to request the logical IO as PCI
> host bridge during its probing.

Right, so this still needs to be fixed.

	Arnd
