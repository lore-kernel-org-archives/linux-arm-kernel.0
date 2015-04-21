From: axel.lin@ingics.com (Axel Lin)
Date: Tue, 21 Apr 2015 18:53:32 +0800
Subject: [PATCH] soc: mediatek: Fix off-by-one checking for rate_spi
Message-ID: <1429613612.5644.1.camel@ingics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If rate_spi is 26000000, current code set ck_mhz to 18 rather than 26.
Fix the off-by-one checking for rate_spi.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index db5be1e..e910e19 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -568,9 +568,9 @@ static int pwrap_init_reg_clock(struct pmic_wrapper *wrp)
 
 	rate_spi = clk_get_rate(wrp->clk_spi);
 
-	if (rate_spi > 26000000)
+	if (rate_spi >= 26000000)
 		ck_mhz = 26;
-	else if (rate_spi > 18000000)
+	else if (rate_spi >= 18000000)
 		ck_mhz = 18;
 	else
 		ck_mhz = 0;
-- 
2.1.0
