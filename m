From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 26 Mar 2013 15:14:00 +0100
Subject: [PATCH 05/11] ARM i.MX6q: set the LDB serial clock parent to the
 video PLL
In-Reply-To: <1364307246-9017-1-git-send-email-p.zabel@pengutronix.de>
References: <1364307246-9017-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1364307246-9017-6-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6q revision 1.1 and later, set the video PLL as parent for
the LDB clock branch. On revision 1.0, the video PLL is useless
due to missing dividers, so keep the default parent (mmdc_ch1_axi).

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index fbab4a9..5528656 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -465,6 +465,11 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[cko1], "cko1", NULL);
 	clk_register_clkdev(clk[arm], NULL, "cpu0");
 
+	if (imx6q_revision() != IMX_CHIP_REVISION_1_0) {
+		clk_set_parent(clk[ldb_di0_sel], clk[pll5_control3]);
+		clk_set_parent(clk[ldb_di1_sel], clk[pll5_control3]);
+	}
+
 	/*
 	 * The gpmi needs 100MHz frequency in the EDO/Sync mode,
 	 * We can not get the 100MHz from the pll2_pfd0_352m.
-- 
1.8.2.rc2
