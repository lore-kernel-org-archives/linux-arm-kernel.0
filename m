From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Feb 2013 11:31:52 +0530
Subject: [PATCH v3 12/15] drivers/bus: add ARM CCI support
In-Reply-To: <1359445870-18925-13-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-13-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <510B5A50.3090003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013 01:21 PM, Nicolas Pitre wrote:
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
> On ARM multi-cluster systems coherency between cores running on
> different clusters is managed by the cache-coherent interconnect (CCI).
> It allows broadcasting of TLB invalidates and memory barriers and it
> guarantees cache coherency at system level.
>
> This patch enables the basic infrastructure required in Linux to
> handle and programme the CCI component. The first implementation is
> based on a platform device, its relative DT compatible property and
> a simple programming interface.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>   drivers/bus/Kconfig     |   4 ++
>   drivers/bus/Makefile    |   2 +
>   drivers/bus/arm-cci.c   | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/arm-cci.h |  30 ++++++++++++++
>   4 files changed, 143 insertions(+)
>   create mode 100644 drivers/bus/arm-cci.c
>   create mode 100644 include/linux/arm-cci.h
>
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 0f51ed687d..d032f74ff2 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -19,4 +19,8 @@ config OMAP_INTERCONNECT
>
>   	help
>   	  Driver to enable OMAP interconnect error handling driver.
> +
> +config ARM_CCI
> +       bool "ARM CCI driver support"
> +
>   endmenu
> diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
> index 45d997c854..55aac809e5 100644
> --- a/drivers/bus/Makefile
> +++ b/drivers/bus/Makefile
> @@ -6,3 +6,5 @@ obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
>
>   # Interconnect bus driver for OMAP SoCs.
>   obj-$(CONFIG_OMAP_INTERCONNECT)	+= omap_l3_smx.o omap_l3_noc.o
> +
> +obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> new file mode 100644
> index 0000000000..25ae156924
> --- /dev/null
> +++ b/drivers/bus/arm-cci.c
> @@ -0,0 +1,107 @@
> +/*
> + * ARM Cache Coherency Interconnect (CCI400) support
> + *
> + * Copyright (C) 2012-2013 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/arm-cci.h>
> +
> +#define CCI400_EAG_OFFSET       0x4000
> +#define CCI400_KF_OFFSET        0x5000
> +
> +#define DRIVER_NAME	"CCI"
> +struct cci_drvdata {
> +	void __iomem *baseaddr;
> +	spinlock_t lock;
> +};
> +
> +static struct cci_drvdata *info;
> +
> +void disable_cci(int cluster)
> +{
> +	u32 cci_reg = cluster ? CCI400_KF_OFFSET : CCI400_EAG_OFFSET;
> +	writel_relaxed(0x0, info->baseaddr	+ cci_reg);
> +
> +	while (readl_relaxed(info->baseaddr + 0xc) & 0x1)
0xc ? Is that a status register ? A define for the same would be
good. Rest of the patch looks fine.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
