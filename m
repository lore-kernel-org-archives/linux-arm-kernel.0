From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 8 Jan 2015 21:00:08 +0800
Subject: [PATCH 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <1420559265-7333-3-git-send-email-p.zabel@pengutronix.de>
References: <1420559265-7333-1-git-send-email-p.zabel@pengutronix.de>
 <1420559265-7333-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20150108130003.GE4928@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 04:47:45PM +0100, Philipp Zabel wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Due to incorrect placement of the clock gate cell in the ldb_di[x]_clk tree,
> the glitchy parent mux of ldb_di[x]_clk can cause a glitch to enter the
> ldb_di_ipu_div divider. If the divider gets locked up, no ldb_di[x]_clk is
> generated, and the LVDS display will hang when the ipu_di_clk is sourced from
> ldb_di_clk.
> 
> To fix the problem, both the new and current parent of the ldb_di_clk should
> be disabled before the switch. This patch ensures that correct steps are
> followed when ldb_di_clk parent is switched in the beginning of boot. The
> glitchy muxes are then registered as read-only. The clock parent can be selected
> using the assigned-clocks and assigned-clock-parents properties of the ccm
> device tree node:
> 
> 	&clks {
> 		assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
> 				  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
> 		assigned-clock-parents = <&clks IMX6QDL_CLK_MMDC_CH1_AXI>,
> 					 <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>;
> 	};
> 
> Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Before I start reviewing the patch, I would like to know if there is a
formal errata for this issue, including the bug description, recommended
workaround, and affected i.MX6 variants etc.

Shawn
