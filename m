From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 21 Aug 2014 14:25:22 +0200
Subject: [PATCH 4/9] ARM: zynq: PM: Enable DDR self-refresh and clock stop
In-Reply-To: <1408567315-28479-5-git-send-email-soren.brinkmann@xilinx.com>
References: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408567315-28479-5-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <57cd5124-bd1d-47b9-b467-647937c15fff@BN1BFFO11FD052.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2014 10:41 PM, Soren Brinkmann wrote:
> The DDR controller can detect idle periods and leverage low power
> features like self-refresh and clock stop.
> When new requests occur, the DDRC resumes normal operation.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/mach-zynq/Makefile |  2 +-
>  arch/arm/mach-zynq/common.c |  1 +
>  arch/arm/mach-zynq/common.h |  2 ++
>  arch/arm/mach-zynq/pm.c     | 84 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-zynq/pm.c
> 
> diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
> index 1b25d92ebf22..820dff6e1eba 100644
> --- a/arch/arm/mach-zynq/Makefile
> +++ b/arch/arm/mach-zynq/Makefile
> @@ -3,7 +3,7 @@
>  #
>  
>  # Common support
> -obj-y				:= common.o slcr.o
> +obj-y				:= common.o slcr.o pm.o
>  CFLAGS_REMOVE_hotplug.o		=-march=armv6k
>  CFLAGS_hotplug.o 		=-Wa,-march=armv7-a -mcpu=cortex-a9
>  obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 3cb7c198615a..6bd13e5ce6b7 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -101,6 +101,7 @@ static int __init zynq_get_revision(void)
>  static void __init zynq_init_late(void)
>  {
>  	zynq_core_pm_init();
> +	zynq_pm_late_init();
>  }
>  
>  /**
> diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
> index 596ef0b5067c..87945fa2a179 100644
> --- a/arch/arm/mach-zynq/common.h
> +++ b/arch/arm/mach-zynq/common.h
> @@ -40,6 +40,8 @@ extern void __iomem *zynq_scu_base;
>  /* Hotplug */
>  extern void zynq_platform_cpu_die(unsigned int cpu);
>  
> +int zynq_pm_late_init(void);
> +
>  static inline void zynq_core_pm_init(void)
>  {
>  	/* A9 clock gating */
> diff --git a/arch/arm/mach-zynq/pm.c b/arch/arm/mach-zynq/pm.c
> new file mode 100644
> index 000000000000..19955917aac8
> --- /dev/null
> +++ b/arch/arm/mach-zynq/pm.c
> @@ -0,0 +1,84 @@
> +/*
> + * Zynq power management
> + *
> + *  Copyright (C) 2012 - 2014 Xilinx
> + *
> + *  S?ren Brinkmann <soren.brinkmann@xilinx.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.

IRC this paragraph is not necessary and can be just removed.

> + */
> +
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include "common.h"
> +
> +/* register offsets */
> +#define DDRC_CTRL_REG1_OFFS		0x60
> +#define DDRC_DRAM_PARAM_REG3_OFFS	0x20
> +
> +/* bitfields */
> +#define DDRC_CLOCKSTOP_MASK	BIT(23)
> +#define DDRC_SELFREFRESH_MASK	BIT(12)
> +
> +static void __iomem *ddrc_base;
> +
> +/**
> + * zynq_pm_ioremap() - Create IO mappings
> + * @comp:	DT compatible string
> + * Returns a pointer to the mapped memory or NULL.
> + *
> + * Remap the memory region for a compatible DT node.
> + */

[linux]$ ./scripts/kernel-doc -man -v arch/arm/mach-zynq/pm.c > /dev/null
Info(arch/arm/mach-zynq/pm.c:38): Scanning doc for
Warning(arch/arm/mach-zynq/pm.c:45): No description found for return value of 'zynq_pm_ioremap'

> +static void __iomem *zynq_pm_ioremap(const char *comp)
> +{
> +	struct device_node *np;
> +	void __iomem *base = NULL;
> +
> +	np = of_find_compatible_node(NULL, NULL, comp);
> +	if (np) {
> +		base = of_iomap(np, 0);
> +		of_node_put(np);
> +	} else {
> +		pr_warn("%s: no compatible node found for '%s'\n", __func__,
> +				comp);
> +	}
> +
> +	return base;
> +}
> +
> +int __init zynq_pm_late_init(void)

kernel doc will be nice to have here.

> +{
> +	u32 reg;
> +
> +	ddrc_base = zynq_pm_ioremap("xlnx,zynq-ddrc-a05");
> +	if (!ddrc_base) {
> +		pr_warn("%s: Unable to map DDRC IO memory.\n", __func__);
> +	} else {
> +		/*
> +		 * Enable DDRC self-refresh and clock stop features. The HW
> +		 * takes care of entering/exiting the correct modes depending
> +		 * on activity state.
> +		 */
> +		reg = readl(ddrc_base + DDRC_CTRL_REG1_OFFS);
> +		reg |= DDRC_SELFREFRESH_MASK;
> +		writel(reg, ddrc_base + DDRC_CTRL_REG1_OFFS);
> +
> +		reg = readl(ddrc_base + DDRC_DRAM_PARAM_REG3_OFFS);
> +		reg |= DDRC_CLOCKSTOP_MASK;
> +		writel(reg, ddrc_base + DDRC_DRAM_PARAM_REG3_OFFS);
> +	}
> +
> +	return 0;

You are not using this return value that's why I would just remove it and
change function return type to void.

Thanks,
Michal

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/d75b1b67/attachment-0001.sig>
