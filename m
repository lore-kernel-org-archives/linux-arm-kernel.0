From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 25 Nov 2016 12:06:46 -0200
Subject: [PATCH] bus: imx-weim: Fix the "fsl,weim-cs-gpr" lookup method
Message-ID: <1480082806-8963-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Commit 1be81ea5860744520 ("ARM: dts: imx6: Add imx-weim parameters to
dtsi's") causes the following probe error when the weim node is not
present on the board dts (such as imx6q-sabresd):

imx-weim 21b8000.weim: Invalid 'ranges' configuration
imx-weim: probe of 21b8000.weim failed with error

As the "fsl,weim-cs-gpr" property changed the location from the individual
board dts "&weim" node to the common dtsi node we can no longer reach it
via syscon_regmap_lookup_by_phandle(), so use
syscon_regmap_lookup_by_compatible() instead, which will successfully
find the "fsl,weim-cs-gpr" property.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/bus/imx-weim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 4bd361d..9824c58 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -76,7 +76,7 @@ static int __init imx_weim_gpr_setup(struct platform_device *pdev)
 	int cs = 0;
 	int i = 0;
 
-	gpr = syscon_regmap_lookup_by_phandle(np, "fsl,weim-cs-gpr");
+	gpr = syscon_regmap_lookup_by_compatible("fsl,weim-cs-gpr");
 	if (IS_ERR(gpr)) {
 		dev_dbg(&pdev->dev, "failed to find weim-cs-gpr\n");
 		return 0;
-- 
2.7.4
