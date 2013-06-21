From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 21 Jun 2013 12:16:41 +0200
Subject: [PATCHv3 04/11] of: pci: add registry of MSI chips
In-Reply-To: <1371660979-21588-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130621101640.GD12441@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 06:56:12PM +0200, Thomas Petazzoni wrote:
> This commit adds a very basic registry of msi_chip structures, so that
> an IRQ controller driver can register an msi_chip, and a PCIe host
> controller can find it, based on a 'struct device_node'.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/of/of_pci.c    | 22 ++++++++++++++++++++++
>  include/linux/msi.h    |  2 ++
>  include/linux/of_pci.h |  4 ++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 42c687a..ca12db8 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -89,3 +89,25 @@ int of_pci_parse_bus_range(struct device_node *node, struct resource *res)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_parse_bus_range);
> +
> +static LIST_HEAD(msi_chip_list);
> +static DEFINE_MUTEX(msi_chip_mutex);

Should all of this code perhaps be conditionalized by an #ifdef PCI_MSI?

> +
> +void of_msi_chip_add(struct msi_chip *chip)
> +{
> +	mutex_lock(&msi_chip_mutex);
> +	list_add(&chip->link, &msi_chip_list);
> +	mutex_unlock(&msi_chip_mutex);
> +}

Since eventually we may want to use these functions from modules, maybe
they should be exported?

Also isn't this missing an of_msi_chip_remove() counterpart?

> +struct msi_chip *of_msi_chip_find_by_node(struct device_node *of_node)

Most other functions of this type are named of_find_*_by_node(), so for
consistency it'd be better to call this of_find_msi_chip_by_node().

> +{
> +	struct msi_chip *c;
> +	list_for_each_entry(c, &msi_chip_list, link) {
> +		if (c->of_node == of_node &&
> +		    of_property_read_bool(c->of_node, "msi-controller"))

Perhaps it would be more efficient to put this check within the
of_msi_chip_add() function?

> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index e3a137d..8b930c3 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -74,6 +74,8 @@ void default_restore_msi_irqs(struct pci_dev *dev, int irq);
>  struct msi_chip {
>  	struct module *owner;
>  	struct device *dev;
> +	struct device_node *of_node;

I know there's no easier way to do this, but I think we need to find a
way to clean this up at some point. There's no point in storing the OF
node in two places.

> +	struct list_head link;

I'd prefer this to be named "list" for consistency.

> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 7a04826..6e88189 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -2,6 +2,7 @@
>  #define __OF_PCI_H
>  
>  #include <linux/pci.h>
> +#include <linux/msi.h>
>  
>  struct pci_dev;
>  struct of_irq;
> @@ -13,4 +14,7 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
>  int of_pci_get_devfn(struct device_node *np);
>  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
>  
> +void of_msi_chip_add(struct msi_chip *chip);
> +struct msi_chip *of_msi_chip_find_by_node(struct device_node *of_node);

Since these will be exported and conditionalized on PCI_MSI as suggested
above, maybe they should get a dummy implementation if (!OF || !PCI_MSI)
so that drivers don't have to conditionally call them?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/7f5bbf19/attachment.sig>
