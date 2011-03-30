From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Mar 2011 10:27:58 +0200
Subject: [PATCHv7] ARM: mx51: Add support for low power suspend on MX51
In-Reply-To: <1301325297-24126-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1301325297-24126-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20110330082758.GT7285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2011 at 10:14:57AM -0500, Dinh.Nguyen at freescale.com wrote:
> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> 
> Adds initial low power suspend functionality to MX51.
> Supports "mem" and "standby" modes.
> 
> Tested on mx51-babbage.
> 
> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> ---
>  arch/arm/mach-mx5/Makefile  |    1 +
>  arch/arm/mach-mx5/pm-imx5.c |   73 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mx5/pm-imx5.c
> 
> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> index 0b9338c..d646feb 100644
> --- a/arch/arm/mach-mx5/Makefile
> +++ b/arch/arm/mach-mx5/Makefile
> @@ -6,6 +6,7 @@
>  obj-y   := cpu.o mm.o clock-mx51-mx53.o devices.o ehci.o system.o
>  obj-$(CONFIG_SOC_IMX50) += mm-mx50.o
>  
> +obj-$(CONFIG_PM) += pm-imx5.o
>  obj-$(CONFIG_CPU_FREQ_IMX)    += cpu_op-mx51.o
>  obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
>  obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
> diff --git a/arch/arm/mach-mx5/pm-imx5.c b/arch/arm/mach-mx5/pm-imx5.c
> new file mode 100644
> index 0000000..e4529af
> --- /dev/null
> +++ b/arch/arm/mach-mx5/pm-imx5.c
> @@ -0,0 +1,73 @@
> +/*
> + *  Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +#include <linux/suspend.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <asm/cacheflush.h>
> +#include <asm/tlbflush.h>
> +#include <mach/system.h>
> +#include "crm_regs.h"
> +
> +static struct clk *gpc_dvfs_clk;
> +
> +static int mx5_suspend_enter(suspend_state_t state)
> +{
> +	clk_enable(gpc_dvfs_clk);
> +	switch (state) {
> +	case PM_SUSPEND_MEM:
> +		mx5_cpu_lp_set(STOP_POWER_OFF);
> +		break;
> +	case PM_SUSPEND_STANDBY:
> +		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (state == PM_SUSPEND_MEM) {
> +		local_flush_tlb_all();
> +		flush_cache_all();
> +
> +		/*clear the EMPGC0/1 bits */
> +		__raw_writel(0, MXC_SRPG_EMPGC0_SRPGCR);
> +		__raw_writel(0, MXC_SRPG_EMPGC1_SRPGCR);
> +	}
> +	cpu_do_idle();
> +	clk_disable(gpc_dvfs_clk);
> +
> +	return 0;
> +}
> +
> +static int mx5_pm_valid(suspend_state_t state)
> +{
> +	return (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX);
> +}
> +
> +static const struct platform_suspend_ops mx5_suspend_ops = {
> +	.valid = mx5_pm_valid,
> +	.enter = mx5_suspend_enter,
> +};
> +
> +static int __init mx5_pm_init(void)
> +{
> +	if (gpc_dvfs_clk == NULL)
> +		gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");

This is only executed once, so gpc_dvfs_clk is always NULL here.

> +
> +	if (!IS_ERR(gpc_dvfs_clk)) {
> +		if (cpu_is_mx51())
> +			suspend_set_ops(&mx5_suspend_ops);

This code shall only be executed on an i.MX51, so why don't you make a
simple if (!cpu_is_mx51()) return 0; at the beginning of this function?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
