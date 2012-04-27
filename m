From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 14:40:09 +0800
Subject: [PATCH 19/33] ARM i.MX: prepare for common clock framework
In-Reply-To: <1335367703-19929-20-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <1335367703-19929-20-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120427064007.GM2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 05:28:09PM +0200, Sascha Hauer wrote:
> - Add necessary #ifdefs for CONFIG_COMMON_CLOCK
> - Add a global spinlock to protect the CCM registers
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/clk.h                |   44 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-mxc/clock.c              |   11 ++++++++
>  arch/arm/plat-mxc/include/mach/clock.h |    4 +++
>  3 files changed, 59 insertions(+)
>  create mode 100644 arch/arm/mach-imx/clk.h
> 
> diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
> new file mode 100644
> index 0000000..00f2590
> --- /dev/null
> +++ b/arch/arm/mach-imx/clk.h
> @@ -0,0 +1,44 @@
> +#ifndef __MACH_IMX_CLK_H
> +#define __MACH_IMX_CLK_H
> +
> +#include <linux/spinlock.h>
> +#include <linux/clk-provider.h>
> +#include <mach/clock.h>
> +
> +struct clk *imx_clk_pllv1(const char *name, char *parent,
> +		void __iomem *base);
> +
> +static inline struct clk *imx_clk_fixed(const char *name, int rate)
> +{
> +	return clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rate);
> +}
> +
> +static inline struct clk *imx_clk_divider(const char *name, const char *parent,
> +		void __iomem *reg, u8 shift, u8 width)
> +{
> +	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
> +			reg, shift, width, 0, &imx_ccm_lock);
> +}
> +
> +static inline struct clk *imx_clk_gate(const char *name, const char *parent,
> +		void __iomem *reg, u8 shift)
> +{
> +	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
> +			shift, 0, &imx_ccm_lock);
> +}
> +
> +static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
> +		u8 shift, u8 width, const char **parents, int num_parents)
> +{
> +	return clk_register_mux(NULL, name, parents, num_parents, 0, reg, shift,

I think the fourth parameter should be CLK_SET_RATE_PARENT too, as mux
could also likely be in a clk_set_rate propagation path, saying it has
a parent clk who has .round_rate and .set_rate operations.

> +			width, 0, &imx_ccm_lock);
> +}
> +

-- 
Regards,
Shawn
