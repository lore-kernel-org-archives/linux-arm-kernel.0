From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 May 2017 21:05:29 +0100
Subject: [PATCH] ARM: NOMMU: provide pgprot_device() macro
In-Reply-To: <1494843500-40124-1-git-send-email-vladimir.murzin@arm.com>
References: <1494843500-40124-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20170523200529.GF22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 11:18:20AM +0100, Vladimir Murzin wrote:
> NOMMU build leads to the following error:
> 
>   CC      drivers/pci/mmap.o
> drivers/pci/mmap.c: In function 'pci_mmap_resource_range':
> drivers/pci/mmap.c:60:3: error: implicit declaration of function 'pgprot_device' [-Werror=implicit-function-declaration]
>    vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
>    ^
> cc1: some warnings being treated as errors
> scripts/Makefile.build:302: recipe for target 'drivers/pci/mmap.o' failed
> make[2]: *** [drivers/pci/mmap.o] Error 1
> scripts/Makefile.build:561: recipe for target 'drivers/pci' failed
> make[1]: *** [drivers/pci] Error 2
> Makefile:1016: recipe for target 'drivers' failed
> make: *** [drivers] Error 2
> 
> Fix it with support of pgprot_device() macro for NOMMU.

Looks trivial enough...

> 
> Fixes: 00d2904ffeac ("ARM/PCI: Use generic pci_mmap_resource_range()")
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/include/asm/pgtable-nommu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
> index 302240c..a0d726a 100644
> --- a/arch/arm/include/asm/pgtable-nommu.h
> +++ b/arch/arm/include/asm/pgtable-nommu.h
> @@ -66,6 +66,7 @@
>  #define pgprot_noncached(prot)	(prot)
>  #define pgprot_writecombine(prot) (prot)
>  #define pgprot_dmacoherent(prot) (prot)
> +#define pgprot_device(prot)	(prot)
>  
>  
>  /*
> -- 
> 1.9.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
