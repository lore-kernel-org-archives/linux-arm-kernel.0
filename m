From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 09 Apr 2014 13:55:09 +0100
Subject: [PATCH 4/8] imx-drm: imx-ldb: Use snprintf()
In-Reply-To: <20140409125354.GP16119@n2100.arm.linux.org.uk>
References: <20140409125354.GP16119@n2100.arm.linux.org.uk>
Message-ID: <E1WXs21-0002ax-Mg@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>
To: linux-arm-kernel at lists.infradead.org

Use snprintf() in order to fix the following static checker warning:

drivers/staging/imx-drm/imx-ldb.c:340 imx_ldb_get_clk() error: format string overflow. buf_size: 16 length: 18
probably 18 is theory and not real life, but 16 is based on
theory as well.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-ldb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index 301c4300aa55..0518a32520b4 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -332,12 +332,12 @@ static int imx_ldb_get_clk(struct imx_ldb *ldb, int chno)
 {
 	char clkname[16];
 
-	sprintf(clkname, "di%d", chno);
+	snprintf(clkname, sizeof(clkname), "di%d", chno);
 	ldb->clk[chno] = devm_clk_get(ldb->dev, clkname);
 	if (IS_ERR(ldb->clk[chno]))
 		return PTR_ERR(ldb->clk[chno]);
 
-	sprintf(clkname, "di%d_pll", chno);
+	snprintf(clkname, sizeof(clkname), "di%d_pll", chno);
 	ldb->clk_pll[chno] = devm_clk_get(ldb->dev, clkname);
 
 	return PTR_ERR_OR_ZERO(ldb->clk_pll[chno]);
-- 
1.8.3.1
