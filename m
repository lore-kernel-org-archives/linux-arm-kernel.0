From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Sep 2011 11:46:34 +0200
Subject: [PATCH 3/6] arm/imx6q: add core drivers clock, gpc, mmdc and src
In-Reply-To: <1315303120-24203-4-git-send-email-shawn.guo@linaro.org>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110912094634.GP31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 05:58:37PM +0800, Shawn Guo wrote:
> It adds a number of core drivers support for imx6q, including clock,
> General Power Controller (gpc), Multi Mode DDR Controller(mmdc) and
> System Reset Controller (src).
> 
> Signed-off-by: Ranjani Vaidyanathan <ra5478@freescale.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
> new file mode 100644
> index 0000000..95fdd65
> --- /dev/null
> +++ b/arch/arm/mach-imx/src.c
> @@ -0,0 +1,52 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <asm/unified.h>
> +
> +#define SRC_SCR				0x000
> +#define SRC_GPR1			0x020
> +#define BP_SRC_SCR_CORE1_RST		14
> +#define BP_SRC_SCR_CORE1_ENABLE		22
> +
> +static void __iomem *src_base;
> +
> +void imx_enable_cpu(int cpu, bool enable)
> +{
> +	u32 mask, val;
> +
> +	mask = 1 << (BP_SRC_SCR_CORE1_ENABLE + cpu - 1);
> +	val = __raw_readl(src_base + SRC_SCR);
> +	val = enable ? val | mask : val & ~mask;
> +	__raw_writel(val, src_base + SRC_SCR);
> +}
> +
> +void imx_set_cpu_jump(int cpu, void *jump_addr)
> +{
> +	__raw_writel(BSYM(virt_to_phys(jump_addr)),
> +		     src_base + SRC_GPR1 + cpu * 8);
> +}
> +
> +static int __init imx_src_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-src");
> +	src_base = of_iomap(np, 0);
> +	WARN_ON(!src_base);
> +
> +	return 0;
> +}
> +early_initcall(imx_src_init);

What I'm concerned about is that we carefully removed all assumptions
about which SoC the code runs on in the past. Now with this patchset
many of them come back. Here we have a initcall without any check
whether we really run on i.MX6. Above we have a imx_enable_cpu function
but this is really a imx6 specific function. Nevertheless it is called
from generic code in arch/arm/mach-imx/platsmp.c.

We've been there before and it was hard to remove all the implicit
assumptions on which SoC we are on. Please do not reintroduce it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
