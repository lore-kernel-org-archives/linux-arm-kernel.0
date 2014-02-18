From: wangyijing@huawei.com (Yijing Wang)
Date: Tue, 18 Feb 2014 14:33:53 +0800
Subject: [PATCH] arm64: Add architecture support for PCI
In-Reply-To: <1391453028-23191-2-git-send-email-Liviu.Dudau@arm.com>
References: <1391453028-23191-1-git-send-email-Liviu.Dudau@arm.com>
 <1391453028-23191-2-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <5302FED1.80903@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +
> +#include <asm/pci-bridge.h>
> +
> +
> +/*
> + * Return the domain number for this bus
> + */
> +int pci_domain_nr(struct pci_bus *bus)
> +{
> +	struct pci_host_bridge *bridge = to_pci_host_bridge(bus->bridge);

Here bus is specific to root bus ? or, what about use find_pci_host_bridge() to get the pci_host_bridge
instead.

> +
> +	if (bridge)
> +		return bridge->domain_nr;
> +
> +	return 0;
> +}
> +
> +int pci_proc_domain(struct pci_bus *bus)
> +{
> +	return pci_domain_nr(bus);
> +}
> +
> +/*
> + * Called after each bus is probed, but before its children are examined
> + */
> +void pcibios_fixup_bus(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +	struct resource *res;
> +	int i;
> +
> +	if (bus->self != NULL) {

What about use !pci_is_root_bus() ?

> +		pci_read_bridge_bases(bus);
> +
> +		pci_bus_for_each_resource(bus, res, i) {
> +			if (!res || !res->flags || res->parent)
> +				continue;
> +
> +			/*
> +			 * If we are going to reassign everything, we can
> +			 * shrink the P2P resource to have zero size to
> +			 * save space
> +			 */
> +			if (pci_has_flag(PCI_REASSIGN_ALL_RSRC)) {
> +				res->flags |= IORESOURCE_UNSET;
> +				res->start = 0;
> +				res->end = -1;
> +				continue;
> +			}
> +		}
> +	}
> +
