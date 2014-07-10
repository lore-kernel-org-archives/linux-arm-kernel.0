From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Jul 2014 15:14:16 +0200
Subject: [PATCH 3/3] arm64: Use include/asm-generic/io.h
In-Reply-To: <20140710110034.GI16137@arm.com>
References: <1404918699-17284-1-git-send-email-thierry.reding@gmail.com>
 <1404918699-17284-3-git-send-email-thierry.reding@gmail.com>
 <20140710110034.GI16137@arm.com>
Message-ID: <201407101514.16530.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 July 2014, Catalin Marinas wrote:
> > @@ -235,8 +155,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
> >  #define ioremap_wc(addr, size)               __ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
> >  #define iounmap                              __iounmap
> >  
> > -#define ARCH_HAS_IOREMAP_WC
> > -#include <asm-generic/iomap.h>
> > +#include <asm-generic/io.h>
> 
> We don't currently have PCIe support in mainline for arm64 but what I
> had in mind with the generic iomap is that functions like ioread32_rep
> first check whether the address is an IO address or a memory one and
> calls the insl or mmio_insl accordingly. With your generic
> implementation, this check disappears.
> 
> The question is whether this functionality would still be needed.

I think it's much better not to have that check on architectures that have a memory
mapped I/O space like arm64. The main advantage is that ioread32() is just a trivial
alias for readl(). The only reason for needing generic_iomap is architectures that
do something very different for I/O ports.

	Arnd
