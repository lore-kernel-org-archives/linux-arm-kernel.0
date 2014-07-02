From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Jul 2014 14:38:04 +0200
Subject: [PATCH v8 3/9] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <1404240214-9804-4-git-send-email-Liviu.Dudau@arm.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <1404240214-9804-4-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <4751391.BGkeOrZGt8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some more detailed comments now

On Tuesday 01 July 2014 19:43:28 Liviu Dudau wrote:
> +/*
> + * Record the PCI IO range (expressed as CPU physical address + size).
> + * Return a negative value if an error has occured, zero otherwise
> + */
> +int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
> +{
> +#ifdef PCI_IOBASE
> +       struct io_range *res;

I was confused by the variable naming here: A variable named 'res' is
normally a 'struct resource'. Maybe better call this 'range'.

> +       resource_size_t allocated_size = 0;
> +
> +       /* check if the range hasn't been previously recorded */
> +       list_for_each_entry(res, &io_range_list, list) {
> +               if (addr >= res->start && addr + size <= res->start + size)
> +                       return 0;
> +               allocated_size += res->size;
> +       }

A spin_lock around the list lookup should be sufficient to get around
the race that Will mentioned.

> +       /* range not registed yet, check for available space */
> +       if (allocated_size + size - 1 > IO_SPACE_LIMIT)
> +               return -E2BIG;

It might be better to limit the size to 64K if it doesn't fit at first.


	Arnd
