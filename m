From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 22 Jan 2016 12:11:25 +0100
Subject: [PATCH v3 0/3] i.MX6 LDB mux/divider glitch workaround
Message-ID: <1453461088-31549-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The previous version was broken for i.MX6S/DL since
disable_anatop_clocks() would try to check the parent of clk_periph_pre,
but it was called before clk_periph_pre was registered.
disable_anatop_clocks() then went on and failed to not disable the
memory clock.

So it appears there is a yet unreleased ERR009219, which I have not yet
seen, that supposedly describes the LDB mux glitch issue, and a draft
engineering bulletin EB821 that describes the clock switching procedure.
Shawn, do you have access to these documents?

Especially the comment explaining init_ldb_clks() should be double checked
against the erratum once available, as that contains my interpretation of
the original patch comment.

regards
Philipp

Changes since v2:
 - Fix DL/S support. disable_anatop_clocks() checks whether pll2_pfd2_396m
   is the parent of clk_periph_pre to avoid disabling the memory clock.
   For this to work, disable_anatop_clocks() must be called only after
   clk_periph_pre is registered.
 - Replace magic numbers with #defines
 - Improve the comment describing init_ldb_di_clks()
 - Improve selection checking and error messages

Fabio Estevam (1):
  ARM: imx6: Fix procedure to switch the parent of LDB_DI_CLK

Philipp Zabel (2):
  ARM: imx6: Mask mmdc_ch1 handshake for periph2_sel and
    mmdc_ch1_axi_podf
  ARM: imx6: Make the LDB_DI0 and LDB_DI1 clocks read-only.

 drivers/clk/imx/clk-imx6q.c | 294 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/clk/imx/clk.h       |   8 ++
 2 files changed, 292 insertions(+), 10 deletions(-)

-- 
2.7.0.rc3
