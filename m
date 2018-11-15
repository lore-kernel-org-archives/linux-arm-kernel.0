From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 15 Nov 2018 15:30:27 +0100
Subject: [PATCH v2 2/3] clk: imx6q: optionally get CCM inputs via standard
 clock handles
In-Reply-To: <20181115143028.19087-1-l.stach@pengutronix.de>
References: <20181115143028.19087-1-l.stach@pengutronix.de>
Message-ID: <20181115143028.19087-2-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When specifying external clock inputs to the CCM the current code
requires the clocks to be in a "clocks" child node of the DT root.
This is not really conformant with DT best practices.

To avoid the need to deviate from those best practices, allow the
clock inputs to be specified via standard clock handles. This is
in line with how drivers of the later CCM driver revisions on
newer i.MX SoCs handle this.

As we can't retroactively change the DT binding, allow this as an
option with a fallback to the old way of how this has been handled.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2: correct third clock name, as per review from Dong Aisheng
---
 .../devicetree/bindings/clock/imx6q-clock.txt |  3 +++
 drivers/clk/imx/clk-imx6q.c                   | 22 ++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
index e1308346e00d..13d36d4c6991 100644
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
@@ -13,6 +13,9 @@ Optional properties:
   management IC (PMIC) triggered via PMIC_STBY_REQ signal.
   Boards that are designed to initiate poweroff on PMIC_ON_REQ signal should
   be using "syscon-poweroff" driver instead.
+- clocks: list of clock specifiers, must contain an entry for each entry
+          in clock-names
+- clock-names: valid names are "osc", "ckil", "ckih1", "anaclk1" and "anaclk2"
 
 The clock consumer should specify the desired clock by having the clock
 ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6qdl-clock.h
diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 59f6a3e087db..bd53c403bcc1 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -414,12 +414,24 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	int ret;
 
 	clk[IMX6QDL_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
-	clk[IMX6QDL_CLK_CKIL] = imx_obtain_fixed_clock("ckil", 0);
-	clk[IMX6QDL_CLK_CKIH] = imx_obtain_fixed_clock("ckih1", 0);
-	clk[IMX6QDL_CLK_OSC] = imx_obtain_fixed_clock("osc", 0);
+	clk[IMX6QDL_CLK_CKIL] = of_clk_get_by_name(ccm_node, "ckil");
+	if (IS_ERR(clk[IMX6QDL_CLK_CKIL]))
+		clk[IMX6QDL_CLK_CKIL] = imx_obtain_fixed_clock("ckil", 0);
+	clk[IMX6QDL_CLK_CKIH] = of_clk_get_by_name(ccm_node, "ckih1");
+	if (IS_ERR(clk[IMX6QDL_CLK_CKIH]))
+		clk[IMX6QDL_CLK_CKIH] = imx_obtain_fixed_clock("ckih1", 0);
+	clk[IMX6QDL_CLK_OSC] = of_clk_get_by_name(ccm_node, "osc");
+	if (IS_ERR(clk[IMX6QDL_CLK_OSC]))
+		clk[IMX6QDL_CLK_OSC] = imx_obtain_fixed_clock("osc", 0);
+
 	/* Clock source from external clock via CLK1/2 PADs */
-	clk[IMX6QDL_CLK_ANACLK1] = imx_obtain_fixed_clock("anaclk1", 0);
-	clk[IMX6QDL_CLK_ANACLK2] = imx_obtain_fixed_clock("anaclk2", 0);
+	clk[IMX6QDL_CLK_ANACLK1] = of_clk_get_by_name(ccm_node, "anaclk1");
+	if (IS_ERR(clk[IMX6QDL_CLK_ANACLK1]))
+		clk[IMX6QDL_CLK_ANACLK1] = imx_obtain_fixed_clock("anaclk1", 0);
+
+	clk[IMX6QDL_CLK_ANACLK2] = of_clk_get_by_name(ccm_node, "anaclk2");
+	if (IS_ERR(clk[IMX6QDL_CLK_ANACLK2]))
+		clk[IMX6QDL_CLK_ANACLK2] = imx_obtain_fixed_clock("anaclk2", 0);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
 	anatop_base = base = of_iomap(np, 0);
-- 
2.19.1
