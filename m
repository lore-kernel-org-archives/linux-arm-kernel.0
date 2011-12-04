From: mst@redhat.com (Michael S. Tsirkin)
Date: Sun, 4 Dec 2011 12:47:09 +0200
Subject: [PATCH-RFC 04/10] arm: switch to GENERIC_PCI_IOMAP
In-Reply-To: <1415bf8cf7d98d05b7d189e913efb7f9668846ac.1322163031.git.mst@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
 <1415bf8cf7d98d05b7d189e913efb7f9668846ac.1322163031.git.mst@redhat.com>
Message-ID: <20111204104709.GF15464@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 10:17:42PM +0200, Michael S. Tsirkin wrote:
> arm copied pci_iomap from generic code, probably to avoid
> pulling the rest of iomap.c in.  Since that's in
> a separate file now, we can reuse the common implementation.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Sorry to nag, any ACKs/NACKs on the arm part?
I intend to send this to Linus if there are no
objections. Thanks!

>  arch/arm/Kconfig          |    1 +
>  arch/arm/include/asm/io.h |    2 +-
>  arch/arm/mm/iomap.c       |   21 ---------------------
>  3 files changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 44789ef..2ebf66b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -30,6 +30,7 @@ config ARM
>  	select HAVE_SPARSE_IRQ
>  	select GENERIC_IRQ_SHOW
>  	select CPU_PM if (SUSPEND || CPU_IDLE)
> +	select GENERIC_PCI_IOMAP
>  	help
>  	  The ARM series is a line of low-power-consumption RISC chip designs
>  	  licensed by ARM Ltd and targeted at embedded applications and
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 065d100..9275828 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -27,6 +27,7 @@
>  #include <asm/byteorder.h>
>  #include <asm/memory.h>
>  #include <asm/system.h>
> +#include <asm-generic/pci_iomap.h>
>  
>  /*
>   * ISA I/O bus memory addresses are 1:1 with the physical address.
> @@ -306,7 +307,6 @@ extern void ioport_unmap(void __iomem *addr);
>  
>  struct pci_dev;
>  
> -extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen);
>  extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
>  
>  /*
> diff --git a/arch/arm/mm/iomap.c b/arch/arm/mm/iomap.c
> index 430df1a..e62956e 100644
> --- a/arch/arm/mm/iomap.c
> +++ b/arch/arm/mm/iomap.c
> @@ -35,27 +35,6 @@ EXPORT_SYMBOL(pcibios_min_mem);
>  unsigned int pci_flags = PCI_REASSIGN_ALL_RSRC;
>  EXPORT_SYMBOL(pci_flags);
>  
> -void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
> -{
> -	resource_size_t start = pci_resource_start(dev, bar);
> -	resource_size_t len   = pci_resource_len(dev, bar);
> -	unsigned long flags = pci_resource_flags(dev, bar);
> -
> -	if (!len || !start)
> -		return NULL;
> -	if (maxlen && len > maxlen)
> -		len = maxlen;
> -	if (flags & IORESOURCE_IO)
> -		return ioport_map(start, len);
> -	if (flags & IORESOURCE_MEM) {
> -		if (flags & IORESOURCE_CACHEABLE)
> -			return ioremap(start, len);
> -		return ioremap_nocache(start, len);
> -	}
> -	return NULL;
> -}
> -EXPORT_SYMBOL(pci_iomap);
> -
>  void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
>  {
>  	if ((unsigned long)addr >= VMALLOC_START &&
> -- 
> 1.7.5.53.gc233e
