From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 1 Aug 2016 14:22:26 +0100
Subject: [PATCH 2/2] soc: nxp: Add a RCPM driver
In-Reply-To: <1470044943-3814-2-git-send-email-chenhui.zhao@nxp.com>
References: <1470044943-3814-1-git-send-email-chenhui.zhao@nxp.com>
 <1470044943-3814-2-git-send-email-chenhui.zhao@nxp.com>
Message-ID: <579F4D12.4000004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/16 10:49, Chenhui Zhao wrote:
> The NXP's QorIQ Processors based on ARM Core have a RCPM module
> (Run Control and Power Management), which performs all device-level
> tasks associated with power management.
> 
> This patch mainly implements the wakeup sources configuration before
> entering LPM20, a low power state of device-level. The devices can be
> waked up by specified sources, such as Flextimer, GPIO and so on.
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> ---
>  drivers/soc/fsl/Makefile     |   1 +
>  drivers/soc/fsl/pm/Makefile  |   1 +
>  drivers/soc/fsl/pm/ls-rcpm.c | 144 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 146 insertions(+)
>  create mode 100644 drivers/soc/fsl/pm/Makefile
>  create mode 100644 drivers/soc/fsl/pm/ls-rcpm.c
> 
> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> index 203307f..b5adbaf 100644
> --- a/drivers/soc/fsl/Makefile
> +++ b/drivers/soc/fsl/Makefile
> @@ -4,3 +4,4 @@
>  
>  obj-$(CONFIG_QUICC_ENGINE)		+= qe/
>  obj-$(CONFIG_CPM)			+= qe/
> +obj-$(CONFIG_SUSPEND)			+= pm/
> diff --git a/drivers/soc/fsl/pm/Makefile b/drivers/soc/fsl/pm/Makefile
> new file mode 100644
> index 0000000..e275d63
> --- /dev/null
> +++ b/drivers/soc/fsl/pm/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_ARCH_LAYERSCAPE) += ls-rcpm.o
> diff --git a/drivers/soc/fsl/pm/ls-rcpm.c b/drivers/soc/fsl/pm/ls-rcpm.c
> new file mode 100644
> index 0000000..c5f2b97
> --- /dev/null
> +++ b/drivers/soc/fsl/pm/ls-rcpm.c
> @@ -0,0 +1,144 @@
> +/*
> + * Run Control and Power Management (RCPM) driver
> + *
> + * Copyright 2016 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +#define pr_fmt(fmt) "RCPM: %s: " fmt, __func__
> +
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/suspend.h>
> +
> +/* So far there are not more than two registers */
> +#define RCPM_IPPDEXPCR0		0x140
> +#define RCPM_IPPDEXPCR1		0x144
> +#define RCPM_IPPDEXPCR(x)	(RCPM_IPPDEXPCR0 + 4 * x)
> +#define RCPM_WAKEUP_CELL_MAX_SIZE	2
> +
> +/* it reprents the number of the registers RCPM_IPPDEXPCR */
> +static unsigned int rcpm_wakeup_cells;
> +static void __iomem *rcpm_reg_base;
> +static u32 ippdexpcr[RCPM_WAKEUP_CELL_MAX_SIZE];
> +
> +static inline void rcpm_reg_write(u32 offset, u32 value)
> +{
> +	iowrite32be(value, rcpm_reg_base + offset);
> +}
> +
> +static inline u32 rcpm_reg_read(u32 offset)
> +{
> +	return ioread32be(rcpm_reg_base + offset);
> +}
> +
> +static void rcpm_wakeup_fixup(struct device *dev, void *data)
> +{
> +	struct device_node *node = dev ? dev->of_node : NULL;
> +	u32 value[RCPM_WAKEUP_CELL_MAX_SIZE + 1];
> +	int ret;
> +	int i;
> +
> +	if (!dev || !node || !device_may_wakeup(dev))
> +		return;
> +
> +	/*
> +	 * Get the values in the "rcpm-wakeup" property.
> +	 * Refer to Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> +	 */
> +	ret = of_property_read_u32_array(node, "rcpm-wakeup",
> +					 value, rcpm_wakeup_cells + 1);
> +	if (ret)
> +		return;
> +
> +	pr_debug("wakeup source: the device %s\n", node->full_name);

This looks absolutely dreadful. You are parsing every node for each
device, and apply a set-in-stone configuration.

The normal way to handle this is by making this device an interrupt
controller, and honour the irq_set_wake API. This has already been done
on other FSL/NXP hardware (see the iMX GPC stuff).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
