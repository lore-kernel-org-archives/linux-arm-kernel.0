From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 26 Jan 2018 13:17:22 +0000
Subject: [PATCH v5 2/2] staging: fsl-mc: Move irqchip code out of staging
In-Reply-To: <20180126125127.26439-3-bogdan.purcareata@nxp.com>
References: <20180126125127.26439-1-bogdan.purcareata@nxp.com>
 <20180126125127.26439-3-bogdan.purcareata@nxp.com>
Message-ID: <31df6b54-a115-85fb-b66f-9345c97df9cf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/18 12:51, Bogdan Purcareata wrote:
> Now that the fsl-mc bus core infrastructure is out of staging, the
> remaining irqchip glue code used (irq-gic-v3-its-fsl-mc-msi.c) goes
> to drivers/irqchip.
> 
> Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
> [rebased, add dpaa2_eth and dpio #include updates]
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> [rebased, split irqchip to separate patch]
> Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Notes:
>     -v5:
>       - split irqchip glue code to separate patch (GregKH)
>     -v4 - v1:
>       - no change
> 
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c        | 100 +++++++++++++++++++++
>  drivers/staging/fsl-mc/bus/Makefile                |   3 +-
>  .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c | 100 ---------------------
>  4 files changed, 102 insertions(+), 102 deletions(-)
>  create mode 100644 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
>  delete mode 100644 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index d2df34a..641d8a4 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
>  obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
>  obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o
>  obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+= irq-gic-v3-its-pci-msi.o
> +obj-$(CONFIG_FSL_MC_BUS)		+= irq-gic-v3-its-fsl-mc-msi.o
>  obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
>  obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
>  obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
> diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
> new file mode 100644
> index 0000000..b365fbb
> --- /dev/null
> +++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Freescale Management Complex (MC) bus driver MSI support
> + *
> + * Copyright (C) 2015-2016 Freescale Semiconductor, Inc.
> + * Author: German Rivera <German.Rivera@freescale.com>
> + *
> + */
> +
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/irq.h>
> +#include <linux/msi.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/fsl/mc.h>
> +
> +static struct irq_chip its_msi_irq_chip = {
> +	.name = "ITS-fMSI",
> +	.irq_mask = irq_chip_mask_parent,
> +	.irq_unmask = irq_chip_unmask_parent,
> +	.irq_eoi = irq_chip_eoi_parent,
> +	.irq_set_affinity = msi_domain_set_affinity
> +};
> +
> +static int its_fsl_mc_msi_prepare(struct irq_domain *msi_domain,
> +				  struct device *dev,
> +				  int nvec, msi_alloc_info_t *info)
> +{
> +	struct fsl_mc_device *mc_bus_dev;
> +	struct msi_domain_info *msi_info;
> +
> +	if (!dev_is_fsl_mc(dev))
> +		return -EINVAL;
> +
> +	mc_bus_dev = to_fsl_mc_device(dev);
> +	if (!(mc_bus_dev->flags & FSL_MC_IS_DPRC))
> +		return -EINVAL;
> +
> +	/*
> +	 * Set the device Id to be passed to the GIC-ITS:
> +	 *
> +	 * NOTE: This device id corresponds to the IOMMU stream ID
> +	 * associated with the DPRC object (ICID).
> +	 */
> +#ifdef GENERIC_MSI_DOMAIN_OPS
> +	info->scratchpad[0].ul = mc_bus_dev->icid;
> +#endif

I'd really like to avoid this kind of condition in irqchip drivers.
Either the architecture you're targeting this at can deal with it, and
you can compile this driver, or it doesn't, and you really shouldn't
offer it. And given that this thing is 100% specific to the ARM GICv3
ITS, you should really have a dependency on it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
