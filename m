From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Jul 2014 21:36:10 +0200
Subject: [PATCH v8 3/9] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <1404240214-9804-4-git-send-email-Liviu.Dudau@arm.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <1404240214-9804-4-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <8556461.i7qCGvGY5a@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 July 2014 19:43:28 Liviu Dudau wrote:
> +/*
> + * Record the PCI IO range (expressed as CPU physical address + size).
> + * Return a negative value if an error has occured, zero otherwise
> + */
> +int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
> +{
> +#ifdef PCI_IOBASE
> +       struct io_range *res;
> +       resource_size_t allocated_size = 0;
> +
> +       /* check if the range hasn't been previously recorded */
> +       list_for_each_entry(res, &io_range_list, list) {
> +               if (addr >= res->start && addr + size <= res->start + size)
> +                       return 0;
> +               allocated_size += res->size;
> +       }
> +
> +       /* range not registed yet, check for available space */
> +       if (allocated_size + size - 1 > IO_SPACE_LIMIT)
> +               return -E2BIG;
> +
> +       /* add the range to the list */
> +       res = kzalloc(sizeof(*res), GFP_KERNEL);
> +       if (!res)
> +               return -ENOMEM;
> +
> +       res->start = addr;
> +       res->size = size;
> +
> +       list_add_tail(&res->list, &io_range_list);
> +
> +       return 0;
> +#else
> +       return -EINVAL;
> +#endif
> +}
> +
>  unsigned long __weak pci_address_to_pio(phys_addr_t address)
>  {
> +#ifdef PCI_IOBASE
> +       struct io_range *res;
> +       resource_size_t offset = 0;
> +
> +       list_for_each_entry(res, &io_range_list, list) {
> +               if (address >= res->start &&
> +                       address < res->start + res->size) {
> +                       return res->start - address + offset;
> +               }
> +               offset += res->size;
> +       }
> +
> +       return (unsigned long)-1;
> +#else
>         if (address > IO_SPACE_LIMIT)
>                 return (unsigned long)-1;
>  
>         return (unsigned long) address;
> +#endif
>  }

This still conflicts with the other allocator you have in patch 9
for pci_remap_iospace: nothing guarantees that the mapping is the
same for both.

Also, this is a completely pointless exercise at this moment, because
nobody cares about the result of pci_address_to_pio on architectures
that don't already provide this function. If we ever get a proper
Open Firmware implementation that wants to put hardcoded PCI devices
into DT, we can add an implementation, but for now this seems overkill.

The allocator in pci_register_io_range seems reasonable, why not merge
this function with pci_remap_iospace() as I have asked you multiple
times before? Just make it return the io_offset so the caller can
put that into the PCI host resources.

	Arnd
