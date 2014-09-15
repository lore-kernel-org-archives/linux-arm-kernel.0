From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 15 Sep 2014 16:44:21 +0200
Subject: [PATCH v1 06/21] PCI/MSI: Refactor struct msi_chip to make it
 become more common
In-Reply-To: <1409911806-10519-7-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-7-git-send-email-wangyijing@huawei.com>
Message-ID: <1410792261.3314.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 05.09.2014, 18:09 +0800 schrieb Yijing Wang:
> Now there are a lot of __weak arch functions in MSI code.
> These functions make MSI driver complex. Thierry Reding Introduced
> a new MSI chip framework to configure MSI/MSI-X irq in ARM. Use
> the new MSI chip framework to refactor all other platform MSI
> arch code to eliminate weak arch MSI functions. This patch add
> .restore_irq() and .setup_irqs() to make it become more common.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

This change looks good to me:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/msi.c   |   15 +++++++++++++++
>  include/linux/msi.h |    3 +++
>  2 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 539c11d..d78d637 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -63,6 +63,11 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  {
>  	struct msi_desc *entry;
>  	int ret;
> +	struct msi_chip *chip;
> +
> +	chip = arch_find_msi_chip(dev);
> +	if (chip && chip->setup_irqs)
> +		return chip->setup_irqs(dev, nvec, type);
>  
>  	/*
>  	 * If an architecture wants to support multiple MSI, it needs to
> @@ -105,6 +110,11 @@ void default_teardown_msi_irqs(struct pci_dev *dev)
>  
>  void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
>  {
> +	struct msi_chip *chip = arch_find_msi_chip(dev);
> +
> +	if (chip && chip->teardown_irqs)
> +		return chip->teardown_irqs(dev);
> +
>  	return default_teardown_msi_irqs(dev);
>  }
>  
> @@ -128,6 +138,11 @@ static void default_restore_msi_irq(struct pci_dev *dev, int irq)
>  
>  void __weak arch_restore_msi_irqs(struct pci_dev *dev)
>  {
> +	struct msi_chip *chip = arch_find_msi_chip(dev);
> +
> +	if (chip && chip->restore_irqs)
> +		return chip->restore_irqs(dev);
> +
>  	return default_restore_msi_irqs(dev);
>  }
>  
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 5650848..92a51e7 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -72,7 +72,10 @@ struct msi_chip {
>  	struct list_head list;
>  
>  	int (*setup_irq)(struct pci_dev *dev, struct msi_desc *desc);
> +	int (*setup_irqs)(struct pci_dev *dev, int nvec, int type);
>  	void (*teardown_irq)(unsigned int irq);
> +	void (*teardown_irqs)(struct pci_dev *dev);
> +	void (*restore_irqs)(struct pci_dev *dev);
>  };
>  
>  #endif /* LINUX_MSI_H */

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
