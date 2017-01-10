From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 Jan 2017 16:37:53 -0800
Subject: [PATCH v2 04/12] driver: clk: imx: Add clock driver for imx6sll
In-Reply-To: <1482832070-22668-5-git-send-email-ping.bai@nxp.com>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-5-git-send-email-ping.bai@nxp.com>
Message-ID: <20170110003753.GM17126@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/27, Bai Ping wrote:
> diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
> new file mode 100644
> index 0000000..73758fe1
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx6sll.c
> @@ -0,0 +1,369 @@
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <dt-bindings/clock/imx6sll-clock.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>

Is this used?

> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>

Is this used?

> +#include <linux/types.h>
> +
> +#include "clk.h"
> +
> +#define CCM_ANALOG_PLL_BYPASS		(0x1 << 16)
> +#define BM_CCM_CCDR_MMDC_CH0_MASK	(0x2 << 16)
> +#define CCDR	0x4
> +#define xPLL_CLR(offset)		 (offset + 0x8)
> +
> +static const char *pll_bypass_src_sels[] = { "osc", "dummy", };

All these should be const char * const unless something is wrong.

> +static const char *pll1_bypass_sels[] = { "pll1", "pll1_bypass_src", };
> +static const char *pll2_bypass_sels[] = { "pll2", "pll2_bypass_src", };
> +static const char *pll3_bypass_sels[] = { "pll3", "pll3_bypass_src", };
> +static const char *pll4_bypass_sels[] = { "pll4", "pll4_bypass_src", };
> +static const char *pll5_bypass_sels[] = { "pll5", "pll5_bypass_src", };
> +static const char *pll6_bypass_sels[] = { "pll6", "pll6_bypass_src", };
[...]
> +	clks[IMX6SLL_CLK_USDHC3]	= imx_clk_gate2("usdhc3",	"usdhc3_podf",	 base + 0x80,	6);
> +
> +	/* mask handshake of mmdc */
> +	writel_relaxed(BM_CCM_CCDR_MMDC_CH0_MASK, base + CCDR);
> +
> +	for (i = 0; i < ARRAY_SIZE(clks); i++)
> +		if (IS_ERR(clks[i]))
> +			pr_err("i.MX6SLL clk %d: register failed with %ld\n", i, PTR_ERR(clks[i]));
> +
> +	clk_data.clks = clks;
> +	clk_data.clk_num = ARRAY_SIZE(clks);
> +	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +
> +	/* set perclk to from OSC */
> +	clk_set_parent(clks[IMX6SLL_CLK_PERCLK_SEL], clks[IMX6SLL_CLK_OSC]);

Can this be done with assigned-clocks in DT?

> +
> +	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
> +		clk_prepare_enable(clks[clks_init_on[i]]);

Critical clocks?

> +
> +	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
> +		clk_prepare_enable(clks[IMX6SLL_CLK_USBPHY1_GATE]);
> +		clk_prepare_enable(clks[IMX6SLL_CLK_USBPHY2_GATE]);

The phy driver can't enable these?

> +	}
> +
> +	/* Lower the AHB clock rate before changing the clock source. */
> +	clk_set_rate(clks[IMX6SLL_CLK_AHB], 99000000);
> +
> +	/* Change periph_pre clock to pll2_bus to adjust AXI rate to 264MHz */
> +	clk_set_parent(clks[IMX6SLL_CLK_PERIPH_CLK2_SEL], clks[IMX6SLL_CLK_PLL3_USB_OTG]);
> +	clk_set_parent(clks[IMX6SLL_CLK_PERIPH], clks[IMX6SLL_CLK_PERIPH_CLK2]);
> +	clk_set_parent(clks[IMX6SLL_CLK_PERIPH_PRE], clks[IMX6SLL_CLK_PLL2_BUS]);
> +	clk_set_parent(clks[IMX6SLL_CLK_PERIPH], clks[IMX6SLL_CLK_PERIPH_PRE]);
> +
> +	clk_set_rate(clks[IMX6SLL_CLK_AHB], 132000000);

assigned-clocks for rates now? Or perhaps we shouldn't be
exposing these as clks if they have some sort of complicated rate
sequence switch that we can't guarantee with the clk_ops we have
today.

> +}
> +
> +CLK_OF_DECLARE(imx6sll, "fsl,imx6sll-ccm", imx6sll_clocks_init);
> +

Please drop this extra newline.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
