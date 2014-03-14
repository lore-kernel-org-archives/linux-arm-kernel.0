From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Mar 2014 18:05:28 +0100
Subject: [PATCH v7 2/6] pci: OF: Fix the conversion of IO ranges into IO
 resources.
In-Reply-To: <1394811272-1547-3-git-send-email-Liviu.Dudau@arm.com>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <1394811272-1547-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <201403141805.29204.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 March 2014, Liviu Dudau wrote:
> +int of_pci_range_to_resource(struct of_pci_range *range,
> +       struct device_node *np, struct resource *res)
> +{
> +       res->flags = range->flags;
> +       if (res->flags & IORESOURCE_IO) {
> +               unsigned long port = -1;
> +               int err = pci_register_io_range(range->cpu_addr, range->size);
> +               if (err)
> +                       return err;
> +               port = pci_address_to_pio(range->cpu_addr);
> +               if (port == (unsigned long)-1) {
> +                       res->start = (resource_size_t)OF_BAD_ADDR;
> +                       res->end = (resource_size_t)OF_BAD_ADDR;
> +                       return -EINVAL;
> +               }

The error handling is inconsistent here: in one case you set the resource
to OF_BAD_ADDR, in the other one you don't.

	Arnd
