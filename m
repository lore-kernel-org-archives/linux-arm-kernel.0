From: ping.bai@nxp.com (Jacky Bai)
Date: Tue, 10 Jan 2017 03:18:57 +0000
Subject: [PATCH v2 04/12] driver: clk: imx: Add clock driver for imx6sll
In-Reply-To: <20170110003753.GM17126@codeaurora.org>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-5-git-send-email-ping.bai@nxp.com>
 <20170110003753.GM17126@codeaurora.org>
Message-ID: <AM3PR04MB5307CB38AA904535AF8D80D87670@AM3PR04MB530.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +#include <dt-bindings/clock/imx6sll-clock.h>
> > +#include <linux/clk.h>
> > +#include <linux/clkdev.h>
> 
> Is this used?

Sorry, this should be removed.

> 
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> 
> Is this used?

I will remove it.

> 
> > +#include <linux/types.h>
> > +
> > +#include "clk.h"
> > +
> > +#define CCM_ANALOG_PLL_BYPASS		(0x1 << 16)
> > +#define BM_CCM_CCDR_MMDC_CH0_MASK	(0x2 << 16)
> > +#define CCDR	0x4
> > +#define xPLL_CLR(offset)		 (offset + 0x8)
> > +
> > +static const char *pll_bypass_src_sels[] = { "osc", "dummy", };
> 
> All these should be const char * const unless something is wrong.

If changed to 'const char * const', it vill has argument type mismatch error, as imx_clk_* wrapper function
has argument type 'const char *'. 

> 
> > +static const char *pll1_bypass_sels[] = { "pll1", "pll1_bypass_src",
> > +}; static const char *pll2_bypass_sels[] = { "pll2",
> > +"pll2_bypass_src", }; static const char *pll3_bypass_sels[] = {
> > +"pll3", "pll3_bypass_src", }; static const char *pll4_bypass_sels[] =
> > +{ "pll4", "pll4_bypass_src", }; static const char *pll5_bypass_sels[]
> > += { "pll5", "pll5_bypass_src", }; static const char
> > +*pll6_bypass_sels[] = { "pll6", "pll6_bypass_src", };
> [...]
> > +	clks[IMX6SLL_CLK_USDHC3]	= imx_clk_gate2("usdhc3",
> 	"usdhc3_podf",	 base + 0x80,	6);
> > +
> > +	/* mask handshake of mmdc */
> > +	writel_relaxed(BM_CCM_CCDR_MMDC_CH0_MASK, base + CCDR);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(clks); i++)
> > +		if (IS_ERR(clks[i]))
> > +			pr_err("i.MX6SLL clk %d: register failed with %ld\n", i,
> > +PTR_ERR(clks[i]));
> > +
> > +	clk_data.clks = clks;
> > +	clk_data.clk_num = ARRAY_SIZE(clks);
> > +	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> > +
> > +	/* set perclk to from OSC */
> > +	clk_set_parent(clks[IMX6SLL_CLK_PERCLK_SEL],
> clks[IMX6SLL_CLK_OSC]);
> 
> Can this be done with assigned-clocks in DT?

Ok, I will move it to assigned-clocks in DT.

> 
> > +
> > +	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
> > +		clk_prepare_enable(clks[clks_init_on[i]]);
> 
> Critical clocks?

Yes, these clocks must be always on. 

> 
> > +
> > +	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
> > +		clk_prepare_enable(clks[IMX6SLL_CLK_USBPHY1_GATE]);
> > +		clk_prepare_enable(clks[IMX6SLL_CLK_USBPHY2_GATE]);
> 
> The phy driver can't enable these?

The reason why we enable these two clks here is in below commit
commit a5120e89e7e187a91852896f586876c7a2030804
Author: Peter Chen <peter.chen@freescale.com>
Date:   Fri Jan 18 10:38:05 2013 +0800
      ARM i.MX6: change mxs usbphy clock usage

> 
> > +	}
> > +
> > +	/* Lower the AHB clock rate before changing the clock source. */
> > +	clk_set_rate(clks[IMX6SLL_CLK_AHB], 99000000);
> > +
> > +	/* Change periph_pre clock to pll2_bus to adjust AXI rate to 264MHz */
> > +	clk_set_parent(clks[IMX6SLL_CLK_PERIPH_CLK2_SEL],
> clks[IMX6SLL_CLK_PLL3_USB_OTG]);
> > +	clk_set_parent(clks[IMX6SLL_CLK_PERIPH],
> clks[IMX6SLL_CLK_PERIPH_CLK2]);
> > +	clk_set_parent(clks[IMX6SLL_CLK_PERIPH_PRE],
> clks[IMX6SLL_CLK_PLL2_BUS]);
> > +	clk_set_parent(clks[IMX6SLL_CLK_PERIPH],
> > +clks[IMX6SLL_CLK_PERIPH_PRE]);
> > +
> > +	clk_set_rate(clks[IMX6SLL_CLK_AHB], 132000000);
> 
> assigned-clocks for rates now? Or perhaps we shouldn't be exposing these as
> clks if they have some sort of complicated rate sequence switch that we can't
> guarantee with the clk_ops we have today.

These clks will be used by some peripherals, so we need to expose these clocks.
And the above parent and rate swith sequence is not very easy to be handled in assigned-clocks,
So we leave it in this place. 

> 
> > +}
> > +
> > +CLK_OF_DECLARE(imx6sll, "fsl,imx6sll-ccm", imx6sll_clocks_init);
> > +
> 
> Please drop this extra newline.
> 

Thanks, will remove in V3.

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux
> Foundation Collaborative Project
