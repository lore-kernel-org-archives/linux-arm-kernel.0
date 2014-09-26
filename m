From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 26 Sep 2014 10:09:49 +0200
Subject: [PATCH v2 03/22] MSI: Remove the redundant irq_set_chip_data()
In-Reply-To: <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
Message-ID: <20140926080949.GF31106@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 11:14:13AM +0800, Yijing Wang wrote:
> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
> use irq chip_data to save the msi_chip pointer. They
> already call irq_set_chip_data() in their own MSI irq map
> functions. So irq_set_chip_data() in arch_setup_msi_irq()
> is useless.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/msi.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 51d7e62..50f67a3 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -41,14 +41,13 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  	if (err < 0)
>  		return err;
>  
> -	irq_set_chip_data(desc->irq, chip);
> -
>  	return 0;
>  }
>  
>  void __weak arch_teardown_msi_irq(unsigned int irq)
>  {
> -	struct msi_chip *chip = irq_get_chip_data(irq);
> +	struct msi_desc *entry = irq_get_msi_desc(irq);
> +	struct msi_chip *chip = entry->dev->bus->msi;
>  
>  	if (!chip || !chip->teardown_irq)
>  		return;
> -- 
> 1.7.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/3837e85c/attachment.sig>
