From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Sep 2015 14:30:13 +0900
Subject: [PATCH] clk: shmobile: mstp: Consider "zb_clk" suitable for power
 management
In-Reply-To: <cover.1443072085.git.horms+renesas@verge.net.au>
References: <cover.1443072085.git.horms+renesas@verge.net.au>
Message-ID: <e233d74c30f48108b7affb4e76bfc8f3c76b68ce.1443072085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Currently the CPG/MSTP Clock Domain code looks for MSTP clocks to power
manage a device.

Unfortunately, on R-Mobile APE6 (r8a73a4) and SH-Mobile AG5 (sh73a0),
the Bus State Controller (BSC) is not power-managed by an MSTP clock,
but by a plain CPG clock (zb_clk).  Add a special case to handle this,
so the clock is properly managed, and devices connected to the BSC work
as expected.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clk/shmobile/clk-mstp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index b1df7b2f1e97..a0a56e99882a 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -259,6 +259,10 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *domain, struct device *dev)
 					    "renesas,cpg-mstp-clocks"))
 			goto found;
 
+		/* BSC on r8a73a4/sh73a0 uses zb_clk instead of an mstp clock */
+		if (!strcmp(clkspec.np->name, "zb_clk"))
+			goto found;
+
 		of_node_put(clkspec.np);
 		i++;
 	}
-- 
2.1.4
