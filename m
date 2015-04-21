From: axel.lin@ingics.com (Axel Lin)
Date: Tue, 21 Apr 2015 09:58:07 +0800
Subject: Question about checking rate_spi in pwrap_init_reg_clock
Message-ID: <1429581487.5994.1.camel@ingics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,
The implementation in pwrap_init_reg_clock seems has off-by-one bug.
If rate_spi is 26000000, current code set ck_mhz to 18 rather than 26.

I guess it needs below fix, but I'm not 100% sure as I don't have the datasheet.
Can someone confirm if this is a bug or not?


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
