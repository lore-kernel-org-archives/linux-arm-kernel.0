From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 10 Aug 2013 17:01:15 +0200
Subject: [PATCH v2 2/2] ARM: kirkwood: Add basic suspend-to-RAM support
In-Reply-To: <1376144839-1985-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1376144839-1985-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1376144839-1985-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130810150115.GB12476@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 11:27:19AM -0300, Ezequiel Garcia wrote:
> Implements suspend-to-RAM support in a standby-like fashion:
> when the SoC enters suspend state the memory PM units are disabled,
> the DDR is set in self-refresh mode, and the CPU is set in WFI.
> 
> Signed-off-by: Simon Guinot <sguinot@lacie.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Changes from v1:
> 
>   * Removed clock gating. Each peripheral is in charge of implementing
>     a proper suspend/resume path, including gateable clock handling.
> 
>  arch/arm/mach-kirkwood/Makefile                   |  1 +
>  arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  2 +
>  arch/arm/mach-kirkwood/pm.c                       | 69 +++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
>  create mode 100644 arch/arm/mach-kirkwood/pm.c
> 
> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> index 937d4e1..788db9c 100644
> --- a/arch/arm/mach-kirkwood/Makefile
> +++ b/arch/arm/mach-kirkwood/Makefile
> @@ -1,4 +1,5 @@
>  obj-y				+= common.o pcie.o
> +obj-$(CONFIG_PM)		+= pm.o
>  obj-$(CONFIG_KIRKWOOD_LEGACY)	+= irq.o mpp.o
>  obj-$(CONFIG_MACH_D2NET_V2)		+= d2net_v2-setup.o lacie_v2-common.o
>  obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
> diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
> index 91242c9..8b9d1c9 100644
> --- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
> +++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
> @@ -78,4 +78,6 @@
>  #define CGC_TDM			(1 << 20)
>  #define CGC_RESERVED		(0x6 << 21)
>  
> +#define MEMORY_PM_CTRL		(BRIDGE_VIRT_BASE + 0x118)
> +
>  #endif
> diff --git a/arch/arm/mach-kirkwood/pm.c b/arch/arm/mach-kirkwood/pm.c
> new file mode 100644
> index 0000000..364734c
> --- /dev/null
> +++ b/arch/arm/mach-kirkwood/pm.c
> @@ -0,0 +1,69 @@
> +/*
> + * Power Management driver for Marvell Kirkwood SoCs
> + *
> + * Copyright (C) 2013 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> + * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License,
> + * version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/suspend.h>
> +#include <linux/io.h>
> +#include <mach/bridge-regs.h>
> +
> +static void __iomem *ddr_operation_base;
> +
> +static void kirkwood_suspend_mem(void)
> +{
> +	u32 mem_pm_ctrl;
> +
> +	mem_pm_ctrl = readl(MEMORY_PM_CTRL);
> +
> +	/* Set peripherals to low-power mode */
> +	writel_relaxed(~0, MEMORY_PM_CTRL);
> +
> +	/* Set DDR in self-refresh */
> +	writel_relaxed(0x7, ddr_operation_base);
> +
> +	/*
> +	 * Set CPU in wait-for-interrupt state.
> +	 * This disables the CPU core clocks,
> +	 * the array clocks, and also the L2 controller.
> +	 */
> +	cpu_do_idle();
> +
> +	writel_relaxed(mem_pm_ctrl, MEMORY_PM_CTRL);
> +}
> +
> +static int kirkwood_suspend_enter(suspend_state_t state)
> +{
> +	switch (state) {
> +	case PM_SUSPEND_MEM:
> +		kirkwood_suspend_mem();
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static const struct platform_suspend_ops kirkwood_suspend_ops = {
> +	.enter = kirkwood_suspend_enter,
> +	.valid = suspend_valid_only_mem,
> +};
> +
> +static int __init kirkwood_pm_init(void)
> +{
> +	ddr_operation_base = ioremap(DDR_OPERATION_BASE, 4);
> +	suspend_set_ops(&kirkwood_suspend_ops);
> +	return 0;
> +}
> +arch_initcall(kirkwood_pm_init);

Hi Ezequiel

Does this work on a multi arch kernel? Should kirkwood_pm_init() be
checking it is actually running on a kirkwood? Or call
kirkwood_pm_init() from kirkwood_dt_init()?

Another issue is that the ddr_operation_base should probably be
accessed using your atomic_io_set_clear() function, since it is used
by the cpuidle drivers as well.

	   Andrew
