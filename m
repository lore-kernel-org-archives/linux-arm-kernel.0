From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 18 Jun 2013 16:48:44 -0600
Subject: [PATCH v2 2/8] PCI: Add registry of MSI chips
In-Reply-To: <1370536888-8871-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370536888-8871-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130618224844.GC16134@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 06:41:22PM +0200, Thomas Petazzoni wrote:
> This commit adds a very basic registry of msi_chip structures, so that
> an IRQ controller driver can register an msi_chip, and a PCIe host
> controller can find it, based on a 'struct device_node'.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/msi.c   | 25 +++++++++++++++++++++++++
>  include/linux/msi.h | 11 +++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 4dafac6..0f177ee 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -20,6 +20,7 @@
>  #include <linux/errno.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  
>  #include "pci.h"
>  
> @@ -70,6 +71,30 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
>  # define HAVE_DEFAULT_MSI_SETUP_IRQS
>  #endif
>  
> +#ifdef CONFIG_OF
> +static LIST_HEAD(msi_chip_list);
> +static DEFINE_MUTEX(msi_chip_mutex);
> +
> +void msi_chip_add(struct msi_chip *chip)
> +{
> +	mutex_lock(&msi_chip_mutex);
> +	list_add(&chip->link, &msi_chip_list);
> +	mutex_unlock(&msi_chip_mutex);
> +}
> +
> +struct msi_chip *msi_chip_find_by_of_node(struct device_node *of_node)
> +{
> +	struct msi_chip *c;
> +	list_for_each_entry(c, &msi_chip_list, link) {
> +		if (c->of_node == of_node &&
> +		    of_property_read_bool(c->of_node, "msi-controller"))
> +			return c;
> +	}
> +
> +	return NULL;
> +}
> +#endif

I don't really understand why the msi_chip_list lives here, since
nothing in drivers/pci/msi.c uses it.  Seems like maybe something
that could be in the OF code somewhere?

> +
>  #ifdef HAVE_DEFAULT_MSI_SETUP_IRQS
>  int default_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  {
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 4633529..a1a6084 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -61,6 +61,8 @@ int arch_msi_check_device(struct pci_dev* dev, int nvec, int type);
>  struct msi_chip {
>  	struct module *owner;
>  	struct device *dev;
> +	struct device_node *of_node;
> +	struct list_head link;
>  
>  	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
>  			 struct msi_desc *desc);
> @@ -69,4 +71,13 @@ struct msi_chip {
>  			    int nvec, int type);
>  };
>  
> +#if defined(CONFIG_PCI_MSI) && defined(CONFIG_OF)
> +void msi_chip_add(struct msi_chip *chip);
> +struct msi_chip *msi_chip_find_by_of_node(struct device_node *of_node);
> +#else
> +static inline void msi_chip_add(struct msi_chip *chip) {}
> +static inline struct msi_chip *
> +msi_chip_find_by_of_node(struct device_node *of_node) { return NULL; }
> +#endif
> +
>  #endif /* LINUX_MSI_H */
> -- 
> 1.8.1.2
> 
