From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jul 2015 15:41:03 +0100
Subject: [PATCH] arm64: pci: add support for pci_mmap_page_range
In-Reply-To: <1437717263-11979-1-git-send-email-jerin.jacob@caviumnetworks.com>
References: <1437717263-11979-1-git-send-email-jerin.jacob@caviumnetworks.com>
Message-ID: <20150724144103.GC12569@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 06:54:23AM +0100, Jerin Jacob wrote:
> certain X11 servers and user space network drivers frameworks
> need PCI mmaped /sys/bus/pci/devices/B:D:F/resourceX file to access PCI bar
> address space from user space.
> 
> Signed-off-by: Jerin Jacob <jerin.jacob@caviumnetworks.com>
> ---
>  arch/arm64/include/asm/pci.h |  6 ++++++
>  arch/arm64/kernel/pci.c      | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index b008a72..e7afe8d 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -39,5 +39,11 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  }
>  #endif  /* CONFIG_PCI */
>  
> +#define HAVE_PCI_MMAP
> +
> +extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> +	enum pci_mmap_state mmap_state, int write_combine);
> +
> +
>  #endif  /* __KERNEL__ */
>  #endif  /* __ASM_PCI_H */
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 4095379..94b04c7 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -71,3 +71,23 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	return NULL;
>  }
>  #endif
> +
> +int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> +		enum pci_mmap_state mmap_state, int write_combine)
> +{
> +	/*
> +	* I/O space can be accessed via normal processor loads and stores on
> +	* this platform but for now we elect not to do this and portable
> +	* drivers should not do this anyway.
> +	*/
> +	if (mmap_state == pci_mmap_io)
> +		return -EINVAL;
> +
> +	if (write_combine)
> +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> +	else
> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +	       vma->vm_end - vma->vm_start, vma->vm_page_prot);
> +}

So pci_iomap_range chooses the memory attributes based on the BAR flags
(and even then it looks weird -- CACHEABLE => ioremap, else ioremap_nocache,
which is just the same as ioremap on arm64).

It would be good to understand (a) why this is different and (b) what
the consistent set of attributes should be.

Will
