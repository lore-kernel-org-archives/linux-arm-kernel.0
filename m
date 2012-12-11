From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Dec 2012 10:43:49 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <1354917879-32073-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201212111043.50627.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 December 2012, Thomas Petazzoni wrote:
> The pcim_*() functions are used by the libata-sff subsystem, and this
> subsystem is used for many SATA drivers on ARM platforms that do not
> necessarily have I/O ports.

I think this one is wrong as the CONFIG_HAS_IOPORT does not refer to the
presence of PIO ports but to whether or not they provide an ioport_map
function. If there is no ioport_map(), devm_pci_iomap will fail to link
as far as I can tell.

	Arnd

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: linux-kernel at vger.kernel.org
> ---
>  lib/devres.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/devres.c b/lib/devres.c
> index 80b9c76..5639c3e 100644
> --- a/lib/devres.c
> +++ b/lib/devres.c
> @@ -195,6 +195,7 @@ void devm_ioport_unmap(struct device *dev, void __iomem *addr)
>  			       devm_ioport_map_match, (void *)addr));
>  }
>  EXPORT_SYMBOL(devm_ioport_unmap);
> +#endif /* CONFIG_HAS_IOPORT */
>  
>  #ifdef CONFIG_PCI
>  /*
> @@ -400,4 +401,3 @@ void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
>  }
>  EXPORT_SYMBOL(pcim_iounmap_regions);
>  #endif /* CONFIG_PCI */
> -#endif /* CONFIG_HAS_IOPORT */
