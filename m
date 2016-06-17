From: Jean-Philippe.Brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 17 Jun 2016 17:33:27 +0100
Subject: [PATCH v10 7/9] irqchip/gicv3-its: register the MSI global
 doorbell
In-Reply-To: <1465315288-5931-8-git-send-email-eric.auger@redhat.com>
References: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
 <1465315288-5931-8-git-send-email-eric.auger@redhat.com>
Message-ID: <20160617163327.GA26522@e106794-lin.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Tue, Jun 07, 2016 at 04:01:26PM +0000, Eric Auger wrote:
> This patch adds the registration of the MSI global doorbell in
> gicv3-its driver.
> 
> This will allow the msi layer to iommu_map this doorbell when
> requested.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 5eb1f9e..ed9dfce 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -29,6 +29,8 @@
>  #include <linux/of_platform.h>
>  #include <linux/percpu.h>
>  #include <linux/slab.h>
> +#include <linux/iommu.h>
> +#include <linux/msi-doorbell.h>
>  
>  #include <linux/irqchip.h>
>  #include <linux/irqchip/arm-gic-v3.h>
> @@ -1607,6 +1609,7 @@ static int __init its_probe(struct device_node *node,
>  
>  	if (of_property_read_bool(node, "msi-controller")) {
>  		struct msi_domain_info *info;
> +		phys_addr_t translater;
>  
>  		info = kzalloc(sizeof(*info), GFP_KERNEL);
>  		if (!info) {
> @@ -1614,10 +1617,21 @@ static int __init its_probe(struct device_node *node,
>  			goto out_free_tables;
>  		}
>  
> +		translater = its->phys_base + GITS_TRANSLATER;
> +		err = msi_doorbell_register_global(its, translater,
> +						sizeof(u32),
> +						IOMMU_WRITE | IOMMU_MMIO, true);

This doesn't work :(

First we have its_probe registering the global mapping with
doorbell->chip_data = its, which is a pointer to an its_node structure.

But when enabling MSIs for a device, its_irq_domain_alloc puts a pointer
to an *its_device* into irq_data->chip_data. This seems to be a
per-device structure, allocated by its_msi_prepare.

The following call to msi_doorbell_lookup won't ever succeed, because it
will compare its_node to its_device. I can't figure out how to fix it
cleanly at the moment.

Jean-Philippe

> +		if (err)  {
> +			kfree(info);
> +			goto out_free_tables;
> +		}
> +
> +
>  		inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
>  		if (!inner_domain) {
>  			err = -ENOMEM;
>  			kfree(info);
> +			msi_doorbell_unregister(its);
>  			goto out_free_tables;
>  		}
>  
> -- 
> 1.9.1
> 
