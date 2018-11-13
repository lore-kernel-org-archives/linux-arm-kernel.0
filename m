From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 13 Nov 2018 13:05:01 +0530
Subject: [RFC PATCH v3 10/13] soc: ti: Add MSI domain support for K3
 Interrupt Aggregator
In-Reply-To: <20181106084105.32483-11-lokeshvutla@ti.com>
References: <20181106084105.32483-1-lokeshvutla@ti.com>
 <20181106084105.32483-11-lokeshvutla@ti.com>
Message-ID: <2fa1ab94-b577-539b-1070-258e39add9f1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 06/11/18 2:11 PM, Lokesh Vutla wrote:
> With the system coprocessor managing the range allocation of the
> inputs to Interrupt Aggregator, it is difficult to represent
> the device IRQs from DT.
> 
> The suggestion is to use MSI in such cases where devices wants
> to allocate and group interrupts dynamically.
> 
> Create a MSI domain bus layer that allocates and frees MSIs for
> a device.
> 
> APIs that are implemented are as follows:
> - inta_msi_create_irq_domain() that creates a MSI domain
> - inta_msi_domain_alloc_group_irqs() that creates MSIs for the
>    specified device and source indexes. All these are expected to
>    be grouped by the parent interrupt controller to MSI domain.
> - inta_msi_domain_free_group_irqs() frees the grouped irqs.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>


	This is the initial implementation of MSI layer for the Interrupt Aggregator 
driver.
In case if you have forgotten how the INTA is integrated with TISCI, below is 
the explanation:

Device Index-x               Device Index-y
          |                                     |
          |                                     |
                           ....
            \                                  /
             \                               /
              \  (global events)  /
          +---------------------------+
           |                                   |
           |              INTA              |
           |                                   |
          +---------------------------+
                         |   (vint)
                         |
                        \|/
          +---------------------------+
           |                                   |
           |             INTR              |
           |                                   |
          +---------------------------+
                         |
                         |
                        \|/ (gic irq)
          +---------------------------+
           |                                   |
           |             GIC                |
           |                                   |
          +---------------------------+


Now in the above diagram, Device indexes, global events, vints, gic irqs are 
managed dynamically in the available ranges for the current host. When a message 
is sent to
system co-processor with the parameters(dev_id, dev_index, global_event, vint, 
gic_irq), it will:
- Program the device index to global event.
- Program the global event to vint in INTA (Grouping allowed if needed)
- Program the vint to gic irq in INTR

All the above configuration is done by sending a single message to system 
co-processor using TISCI protocol.

Coming to software configuration:
- gic irq range is managed by INTR driver as there can be devices other than 
INTA attached to INTR.
- Global event range and vint range is managed by INTA driver.

Now that device indexes are also managed dynamically by their respective 
drivers, MSIs are being used for allocation of Linux interrupts. This series 
tries to implement this allocation sequence using MSIs. I am mainly concerned 
about the prepare and the unprepare part. Parent interrupts to INTA are 
allocated and released using this prepare and unprepare callbacks. This might be 
wrong but I couldn't find a right place for it. Also, compose and write_msi_msg 
are no ops in this case as msi_msg addr and data are not used.

Please take a look at this RFC series and provide your feedback.

Thanks and regards,
Lokesh



> ---
> - May be the same functionaly can be included in platform msi. But I would
>    like to get a feedback on the approach.
> 
> Changes since v1:
> - New patch
> 
>   drivers/soc/ti/Kconfig             |   6 ++
>   drivers/soc/ti/Makefile            |   1 +
>   drivers/soc/ti/k3_inta_msi.c       | 163 +++++++++++++++++++++++++++++
>   include/linux/irqdomain.h          |   1 +
>   include/linux/msi.h                |   6 ++
>   include/linux/soc/ti/k3_inta_msi.h |  21 ++++
>   6 files changed, 198 insertions(+)
>   create mode 100644 drivers/soc/ti/k3_inta_msi.c
>   create mode 100644 include/linux/soc/ti/k3_inta_msi.h
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index be4570baad96..7640490c2a6a 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -73,4 +73,10 @@ config TI_SCI_PM_DOMAINS
>   	  called ti_sci_pm_domains. Note this is needed early in boot before
>   	  rootfs may be available.
>   
> +config K3_INTA_MSI_DOMAIN
> +	bool
> +	select GENERIC_MSI_IRQ_DOMAIN
> +	help
> +	  Driver to enable Interrupt Aggregator specific MSI Domain.
> +
>   endif # SOC_TI
> diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
> index a22edc0b258a..152b195273ee 100644
> --- a/drivers/soc/ti/Makefile
> +++ b/drivers/soc/ti/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA)	+= knav_dma.o
>   obj-$(CONFIG_AMX3_PM)			+= pm33xx.o
>   obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
>   obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
> +obj-$(CONFIG_K3_INTA_MSI_DOMAIN)	+= k3_inta_msi.o
> diff --git a/drivers/soc/ti/k3_inta_msi.c b/drivers/soc/ti/k3_inta_msi.c
> new file mode 100644
> index 000000000000..0236d836d7f6
> --- /dev/null
> +++ b/drivers/soc/ti/k3_inta_msi.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Texas Instruments' K3 Interrupt Aggregator driver MSI support
> + *
> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + *	Lokesh Vutla <lokeshvutla@ti.com>
> + */
> +
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/msi.h>
> +#include <linux/soc/ti/k3_inta_msi.h>
> +
> +#ifdef GENERIC_MSI_DOMAIN_OPS
> +
> +#define TI_SCI_DEV_ID_MASK	0xffff
> +#define TI_SCI_DEV_ID_SHIFT	16
> +#define TI_SCI_IRQ_ID_MASK	0xffff
> +#define TI_SCI_IRQ_ID_SHIFT	0
> +
> +#define TO_HWIRQ(id, index)	(((id & TI_SCI_DEV_ID_MASK) << \
> +				 TI_SCI_DEV_ID_SHIFT) | \
> +				(index & TI_SCI_IRQ_ID_MASK))
> +static void inta_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
> +{
> +	arg->desc = desc;
> +	arg->hwirq = TO_HWIRQ(desc->inta.dev_id, desc->inta.msi_index);
> +}
> +#else
> +#define inta_msi_set_desc NULL
> +#endif
> +
> +static void inta_msi_update_dom_ops(struct msi_domain_info *info)
> +{
> +	struct msi_domain_ops *ops = info->ops;
> +
> +	BUG_ON(!ops);
> +
> +	if (ops->set_desc == NULL)
> +		ops->set_desc = inta_msi_set_desc;
> +}
> +
> +static void inta_msi_update_chip_ops(struct msi_domain_info *info)
> +{
> +	struct irq_chip *chip = info->chip;
> +
> +	BUG_ON(!chip);
> +	if (!chip->irq_mask)
> +		chip->irq_mask = irq_chip_mask_parent;
> +	if (!chip->irq_unmask)
> +		chip->irq_unmask = irq_chip_unmask_parent;
> +	if (!chip->irq_eoi)
> +		chip->irq_eoi = irq_chip_eoi_parent;
> +	if (!chip->irq_set_affinity)
> +		chip->irq_set_affinity = msi_domain_set_affinity;
> +}
> +
> +struct irq_domain *inta_msi_create_irq_domain(struct fwnode_handle *fwnode,
> +					      struct msi_domain_info *info,
> +					      struct irq_domain *parent)
> +{
> +	struct irq_domain *domain;
> +
> +	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
> +		inta_msi_update_dom_ops(info);
> +	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
> +		inta_msi_update_chip_ops(info);
> +
> +	domain = msi_create_irq_domain(fwnode, info, parent);
> +	if (domain)
> +		irq_domain_update_bus_token(domain, DOMAIN_BUS_K3_INTA_MSI);
> +
> +	return domain;
> +}
> +EXPORT_SYMBOL_GPL(inta_msi_create_irq_domain);
> +
> +static struct msi_desc *inta_msi_alloc_desc(struct device *dev, u32 dev_id,
> +					    u32 index)
> +{
> +	struct msi_desc *msi_desc;
> +
> +	msi_desc = alloc_msi_entry(dev, 1, NULL);
> +	if (!msi_desc) {
> +		dev_err(dev, "Failed to allocate msi entry\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	msi_desc->inta.msi_index = index;
> +	msi_desc->inta.dev_id = dev_id;
> +	INIT_LIST_HEAD(&msi_desc->list);
> +	list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
> +
> +	return msi_desc;
> +}
> +
> +void inta_msi_domain_free_group_irqs(struct device *dev, u32 *arr_index,
> +				     int nr_irqs)
> +{
> +	struct irq_domain *msi_domain;
> +	struct msi_desc *desc, *tmp;
> +	unsigned int i, virq = 0;
> +
> +	msi_domain = dev_get_msi_domain(dev);
> +
> +	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
> +		for (i = 0; i < nr_irqs; i++) {
> +			if (desc->inta.msi_index == arr_index[i]) {
> +				msi_domain_free_irq(desc);
> +				/* HACK to get parent IRQ. Any elegant solution? */
> +				if (!virq)
> +					virq = desc->msg.data;
> +				list_del(&desc->list);
> +				free_msi_entry(desc);
> +			}
> +		}
> +	}
> +
> +	msi_domain_unprepare_irqs(msi_domain, nr_irqs, (void *)&virq);
> +}
> +EXPORT_SYMBOL_GPL(inta_msi_domain_free_group_irqs);
> +
> +int inta_msi_domain_alloc_group_irqs(struct device *dev, u32 dev_id,
> +				     int nr_irqs, u32 *arr_index)
> +{
> +	struct irq_domain *msi_domain;
> +	struct msi_desc *msi_desc;
> +	msi_alloc_info_t arg;
> +	int ret, i;
> +
> +	msi_domain = dev_get_msi_domain(dev);
> +	if (!msi_domain)
> +		return -EINVAL;
> +
> +	if (nr_irqs < 1)
> +		return -EINVAL;
> +
> +	ret = msi_domain_prepare_irqs(msi_domain, dev, nr_irqs, &arg);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		msi_desc = inta_msi_alloc_desc(dev, dev_id, arr_index[i]);
> +		if (IS_ERR(msi_desc)) {
> +			ret = PTR_ERR(msi_desc);
> +			goto cleanup;
> +		}
> +
> +		ret = msi_domain_alloc_irq(msi_domain, dev, msi_desc, &arg);
> +		if (ret) {
> +			dev_err(dev, "Failed to allocate IRQs\n");
> +			goto cleanup;
> +		}
> +	}
> +	return 0;
> +
> +cleanup:
> +	inta_msi_domain_free_group_irqs(dev, arr_index, i);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(inta_msi_domain_alloc_group_irqs);
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 068aa46f0d55..47bb695e1067 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -81,6 +81,7 @@ enum irq_domain_bus_token {
>   	DOMAIN_BUS_NEXUS,
>   	DOMAIN_BUS_IPI,
>   	DOMAIN_BUS_FSL_MC_MSI,
> +	DOMAIN_BUS_K3_INTA_MSI,
>   };
>   
>   /**
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 1e37aa569a3c..acc2873bb197 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -47,6 +47,11 @@ struct fsl_mc_msi_desc {
>   	u16				msi_index;
>   };
>   
> +struct inta_msi_desc {
> +	u16	dev_id;
> +	u16	msi_index;
> +};
> +
>   /**
>    * struct msi_desc - Descriptor structure for MSI based interrupts
>    * @list:	List head for management
> @@ -106,6 +111,7 @@ struct msi_desc {
>   		 */
>   		struct platform_msi_desc platform;
>   		struct fsl_mc_msi_desc fsl_mc;
> +		struct inta_msi_desc inta;
>   	};
>   };
>   
> diff --git a/include/linux/soc/ti/k3_inta_msi.h b/include/linux/soc/ti/k3_inta_msi.h
> new file mode 100644
> index 000000000000..42c6202f044d
> --- /dev/null
> +++ b/include/linux/soc/ti/k3_inta_msi.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Texas Instruments' K3 INTA MSI helper
> + *
> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + *	Lokesh Vutla <lokeshvutla@ti.com>
> + */
> +
> +#ifndef __INCLUDE_LINUX_K3_INTA_MSI_H
> +#define __INCLUDE_LINUX_K3_INTA_MSI_H
> +
> +#include <linux/msi.h>
> +
> +struct irq_domain *inta_msi_create_irq_domain(struct fwnode_handle *fwnode,
> +					      struct msi_domain_info *info,
> +					      struct irq_domain *parent);
> +int inta_msi_domain_alloc_group_irqs(struct device *dev, u32 dev_id,
> +				     int nr_irqs, u32 *arr_index);
> +void inta_msi_domain_free_group_irqs(struct device *dev, u32 *arr_index,
> +				     int nr_irqs);
> +#endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */
> 
