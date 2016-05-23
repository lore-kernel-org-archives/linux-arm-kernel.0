From: jchandra@broadcom.com (Jayachandran C)
Date: Mon, 23 May 2016 13:58:36 +0530
Subject: [PATCH V7 04/11] pci: Add new function to unmap IO resources.
In-Reply-To: <1462893601-8937-5-git-send-email-tn@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <1462893601-8937-5-git-send-email-tn@semihalf.com>
Message-ID: <CAKc_7PVYyGNY3fv_w0c+epBP+WyJB8DtnA6f_E-P6Cz2jqbpgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 8:49 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
> It is very useful to release I/O resources so that the same I/O resources
> can be allocated again (pci_remap_iospace), like in PCI hotplug removal
> scenario. Therefore this patch implements new pci_unmap_iospace call which
> unmaps I/O space as the symmetry to pci_remap_iospace.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/pci/pci.c   | 24 ++++++++++++++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bc0c914..ff97a0b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -25,6 +25,7 @@
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci_hotplug.h>
> +#include <linux/vmalloc.h>
>  #include <asm/setup.h>
>  #include <linux/aer.h>
>  #include "pci.h"
> @@ -3167,6 +3168,29 @@ int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>  #endif
>  }
>
> +/**
> + *     pci_unmap_iospace - Unmap the memory mapped I/O space
> + *     @res: resource to be unmapped
> + *
> + *     Unmap the CPU virtual address @res from virtual address space.
> + *     Only architectures that have memory mapped IO functions defined
> + *     (and the PCI_IOBASE value defined) should call this function.
> + */
> +void  pci_unmap_iospace(struct resource *res)
> +{
> +#if defined(PCI_IOBASE) && defined(CONFIG_MMU)
> +       unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
> +
> +       unmap_kernel_range(vaddr, resource_size(res));
> +#else
> +       /*
> +        * This architecture does not have memory mapped I/O space,
> +        * so this function should never be called.
> +        */
> +       WARN_ONCE(1, "This architecture does not support memory mapped I/O\n");
> +#endif
> +}

WARN is not needed here, since we would have already done it in
pci_remap_iospace.

Ideally, we should undo the pci_register_io_range as well, but
re-registering the same range seems to be fine.

JC.
