From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 May 2015 22:20:17 +0800
Subject: [PATCH V8 4/6] ARM: imx: add imx7d clk tree support
In-Reply-To: <1431020158-13789-5-git-send-email-Frank.Li@freescale.com>
References: <1431020158-13789-1-git-send-email-Frank.Li@freescale.com>
 <1431020158-13789-5-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150511142009.GM9347@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 01:35:56AM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> Add i.MX7D clk tree support.
> 
> Enable all clock to bring up imx7.
> Clock framework need be modified a little since imx7d
> change clock design. otherwise system will halt and block the
> other part upstream.
> 
> All clock refine need wait for Dong Aisheng's patch
> clk: support clocks which requires parent clock on during operation
> Or other solution ready.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  drivers/clk/imx/Makefile                |   1 +
>  drivers/clk/imx/clk-imx7d.c             | 886 ++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk-pllv3.c             |  14 +-

The clk-pllv3.c change should be a separate patch goes before
clk-imx7d.c one.

>  drivers/clk/imx/clk.h                   |   9 +
>  include/dt-bindings/clock/imx7d-clock.h | 450 ++++++++++++++++
>  5 files changed, 1359 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/imx/clk-imx7d.c
>  create mode 100644 include/dt-bindings/clock/imx7d-clock.h
> 
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 8be0a1c..bef450f 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_SOC_IMX6Q)  += clk-imx6q.o
>  obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o
>  obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
>  obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
> +obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> new file mode 100644
> index 0000000..b8a6446
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -0,0 +1,886 @@
> +/*
> + * Copyright (C) 2014-2015 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <dt-bindings/clock/imx7d-clock.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/types.h>
> +
> +#include "clk.h"
> +
> +static struct clk *clks[IMX7D_END_CLK];

Could IMX7D_CLK_END be better?

[...]

> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index 641ebc5..db13ac9 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -24,12 +24,16 @@
>  
>  #define BM_PLL_POWER		(0x1 << 12)
>  #define BM_PLL_LOCK		(0x1 << 31)
> +#define BM_PLL_ENABLE		(0x1 << 13)
> +#define BM_PLL_BYPASS		(0x1 << 16)

How are these two being used?

> +#define ENET_PLL_POWER		(0x1 << 5)
>  
>  /**
>   * struct clk_pllv3 - IMX PLL clock version 3
>   * @clk_hw:	 clock source
>   * @base:	 base address of PLL registers
>   * @powerup_set: set POWER bit to power up the PLL
> + * @powerdown:   pll powerdown offset bit
>   * @div_mask:	 mask of divider bits
>   * @div_shift:	 shift of divider bits
>   *
> @@ -40,6 +44,7 @@ struct clk_pllv3 {
>  	struct clk_hw	hw;
>  	void __iomem	*base;
>  	bool		powerup_set;
> +	u32		powerdown;
>  	u32		div_mask;
>  	u32		div_shift;
>  };
> @@ -49,7 +54,7 @@ struct clk_pllv3 {
>  static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
>  {
>  	unsigned long timeout = jiffies + msecs_to_jiffies(10);
> -	u32 val = readl_relaxed(pll->base) & BM_PLL_POWER;
> +	u32 val = readl_relaxed(pll->base) & pll->powerdown;
>  
>  	/* No need to wait for lock when pll is not powered up */
>  	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
> @@ -293,6 +298,8 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
>  	if (!pll)
>  		return ERR_PTR(-ENOMEM);
>  
> +	pll->powerdown = BM_PLL_POWER;
> +
>  	switch (type) {
>  	case IMX_PLLV3_SYS:
>  		ops = &clk_pllv3_sys_ops;
> @@ -306,9 +313,14 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
>  	case IMX_PLLV3_AV:
>  		ops = &clk_pllv3_av_ops;
>  		break;
> +	case IMX_PLLV3_ENET_MX7:
> +		pll->powerdown = ENET_PLL_POWER;
>  	case IMX_PLLV3_ENET:
>  		ops = &clk_pllv3_enet_ops;
>  		break;
> +	case IMX_PLLV3_SYSV2:

How does IMX_PLLV3_SYSV2 differ from IMX_PLLV3_GENERIC?  I'm asking why
we need this IMX_PLLV3_SYSV2 new type at all.

> +		ops = &clk_pllv3_ops;
> +		break;
>  	default:
>  		ops = &clk_pllv3_ops;
>  	}
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 6bae537..9cc019e 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -39,6 +39,8 @@ enum imx_pllv3_type {
>  	IMX_PLLV3_USB_VF610,
>  	IMX_PLLV3_AV,
>  	IMX_PLLV3_ENET,
> +	IMX_PLLV3_ENET_MX7,
> +	IMX_PLLV3_SYSV2
>  };
>  
>  struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
> @@ -117,6 +119,13 @@ static inline struct clk *imx_clk_gate(const char *name, const char *parent,
>  			shift, 0, &imx_ccm_lock);
>  }
>  
> +static inline struct clk *imx_clk_gate_flags(const char *name, const char *parent,
> +		void __iomem *reg, u8 shift)

When you name the function imx_clk_gate_flags(), we really expect that
it takes 'flags' as an argument.

> +{
> +	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT,
> +			reg, shift, CLK_GATE_SET_TO_DISABLE, &imx_ccm_lock);
> +}
> +

Isn't imx_clk_gate_dis() just doing the same?

Shawn

>  static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
>  		void __iomem *reg, u8 shift)
>  {
