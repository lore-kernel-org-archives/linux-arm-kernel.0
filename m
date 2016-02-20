From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 19 Feb 2016 23:02:09 -0800
Subject: [v9,4/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <1455669974-1527-5-git-send-email-yong.wu@mediatek.com>
References: <1455669974-1527-5-git-send-email-yong.wu@mediatek.com>
Message-ID: <20160220070209.GA16577@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 08:46:13AM +0800, Yong Wu wrote:
> This patch adds support for mediatek m4u (MultiMedia Memory Management
> Unit).
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> drivers/iommu/Kconfig     |  16 +
>  drivers/iommu/Makefile    |   1 +
>  drivers/iommu/mtk_iommu.c | 732 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 749 insertions(+)
>  create mode 100644 drivers/iommu/mtk_iommu.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index a1e75cb..4922aa8 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -318,4 +318,20 @@ config S390_IOMMU
>  	help
>  	  Support for the IOMMU API for s390 PCI devices.
>  
> +config MTK_IOMMU
> +	bool "MTK IOMMU Support"
> +	depends on ARM || ARM64
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select IOMMU_API
> +	select IOMMU_DMA
> +	select IOMMU_IO_PGTABLE_ARMV7S
> +	select MEMORY
> +	select MTK_SMI
> +	help
> +	  Support for the M4U on certain Mediatek SOCs. M4U is MultiMedia
> +	  Memory Management Unit. This option enables remapping of DMA memory
> +	  accesses for the multimedia subsystem.
> +
> +	  If unsure, say N here.
> +
>  endif # IOMMU_SUPPORT
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 42fc0c2..44ae2e0 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o
>  obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
>  obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
>  obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
> +obj-$(CONFIG_MTK_IOMMU) += mtk_iommu.o
>  obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
>  obj-$(CONFIG_OMAP_IOMMU_DEBUG) += omap-iommu-debug.o
>  obj-$(CONFIG_ROCKCHIP_IOMMU) += rockchip-iommu.o
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> new file mode 100644
> index 0000000..60fe97b
> --- /dev/null
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -0,0 +1,732 @@
> +/*
> + * Copyright (c) 2015-2016 MediaTek Inc.
> + * Author: Yong Wu <yong.wu@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iommu.h>
> +#include <linux/iopoll.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_iommu.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <soc/mediatek/smi.h>
> +#include <dt-bindings/memory/mt8173-larb-port.h>
> +

Some missing includes:

linux/bug.h
	for WARN_ON()
linux/device.h
	for dev_xxx() error messages, dev_get_drvdata(), etc.
linux/err.h
	for error functions (IS_ERR, error definitions)
linux/slab.h
	for kzalloc() etc.
linux/spinlock.h
	for spinlock functions
asm/barrier.h
	for wmb()

Guenter
