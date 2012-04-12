From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Apr 2012 09:50:14 +0800
Subject: [PATCH 25/40] ARM: imx: add common clock support for clk busy
In-Reply-To: <1334065553-7565-26-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-26-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120412015013.GA27730@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 03:45:38PM +0200, Sascha Hauer wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/Makefile   |    2 +-
>  arch/arm/mach-imx/clk-busy.c |  167 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/clk.h      |    8 ++
>  3 files changed, 176 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-imx/clk-busy.c
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 4d6be8d..ae0a779 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o pm-i
>  obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clock-mx51-mx53.o ehci-imx5.o pm-imx5.o cpu_op-mx51.o
>  
>  obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
> -			    clk-pfd.o
> +			    clk-pfd.o clk-busy.o
>  
>  # Support for CMOS sensor interface
>  obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
> diff --git a/arch/arm/mach-imx/clk-busy.c b/arch/arm/mach-imx/clk-busy.c
> new file mode 100644
> index 0000000..9450f0b
> --- /dev/null
> +++ b/arch/arm/mach-imx/clk-busy.c
> @@ -0,0 +1,167 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2012 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include "clk.h"
> +
> +static int clk_busy_wait(void __iomem *reg, u8 shift)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(10);
> +
> +	while (readl_relaxed(reg) & (1 << shift))
> +		if (time_after(jiffies, timeout))
> +			return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +struct clk_busy_divider {
> +	struct clk_hw hw;
> +	void __iomem *reg;
> +	u8 shift;
> +	struct clk_divider div;
> +	const struct clk_ops *div_ops;
> +};
It's not like a good way to inherit from struct clk_divider. Since we
already have struct clk_hw in struct clk_divider, why do you still 
duplicate hw here?
 
BRs
Richard
