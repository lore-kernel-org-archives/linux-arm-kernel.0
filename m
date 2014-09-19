From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 19 Sep 2014 14:48:17 -0600
Subject: [PATCH v11 02/10] PCI: Introduce helper functions to deal with
 PCI I/O ranges.
In-Reply-To: <1411003825-21521-3-git-send-email-Liviu.Dudau@arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20140919204817.GF19374@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 02:30:17AM +0100, Liviu Dudau wrote:
> Some architectures do not have a simple view of the PCI I/O space
> and instead use a range of CPU addresses that map to bus addresses.
> For some architectures these ranges will be expressed by OF bindings
> in a device tree file.
> 
> This patch introduces a pci_register_io_range() helper function with
> a generic implementation that can be used by such architectures to
> keep track of the I/O ranges described by the PCI bindings. If the
> PCI_IOBASE macro is not defined that signals lack of support for PCI
> and we return an error.
> 
> In order to retrieve the CPU address associated with an I/O port, a
> new helper function pci_pio_to_address() is introduced. This will
> search in the list of ranges registered with pci_register_io_range()
> and return the CPU address that corresponds to the given port.
> 
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> ---
>  drivers/of/address.c       | 100 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_address.h |   2 +
>  2 files changed, 102 insertions(+)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index e371825..2373a92 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -5,6 +5,7 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/pci_regs.h>
> +#include <linux/slab.h>
>  #include <linux/string.h>
>  
>  /* Max address size we deal with */
> @@ -601,12 +602,111 @@ const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
>  }
>  EXPORT_SYMBOL(of_get_address);
>  
> +#ifdef PCI_IOBASE
> +struct io_range {
> +	struct list_head list;
> +	phys_addr_t start;
> +	resource_size_t size;
> +};
> +
> +static LIST_HEAD(io_range_list);
> +static DEFINE_SPINLOCK(io_range_lock);
> +#endif
> +
> +/*
> + * Record the PCI IO range (expressed as CPU physical address + size).
> + * Return a negative value if an error has occured, zero otherwise
> + */
> +int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
> +{
> +#ifdef PCI_IOBASE
> +	struct io_range *range;
> +	resource_size_t allocated_size = 0;
> +
> +	/* check if the range hasn't been previously recorded */
> +	spin_lock(&io_range_lock);
> +	list_for_each_entry(range, &io_range_list, list) {
> +		if (addr >= range->start && addr + size <= range->start + size)
> +			return 0;

This returns while holding io_range_lock.

> +		allocated_size += range->size;
> +	}
> +	spin_unlock(&io_range_lock);

I think this is racy; because you drop the lock between (1) checking
whether the range is already recorded and (2) adding the range to the list,
it's still possible for two callers to add the same range.

> +	/* range not registed yet, check for available space */
> +	if (allocated_size + size - 1 > IO_SPACE_LIMIT) {
> +		/* if it's too big check if 64K space can be reserved */
> +		if (allocated_size + SZ_64K - 1 > IO_SPACE_LIMIT)
> +			return -E2BIG;
> +
> +		size = SZ_64K;
> +		pr_warn("Requested IO range too big, new size set to 64K\n");
> +	}
> +
> +	/* add the range to the list */
> +	range = kzalloc(sizeof(*range), GFP_KERNEL);
> +	if (!range)
> +		return -ENOMEM;
> +
> +	range->start = addr;
> +	range->size = size;
> +
> +	spin_lock(&io_range_lock);
> +	list_add_tail(&range->list, &io_range_list);
> +	spin_unlock(&io_range_lock);
> +#endif
> +
> +	return 0;
> +}
