From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Mon, 30 Oct 2017 08:46:50 +0800
Subject: [PATCH] media: atmel-isc: Fix clock ID for clk_prepare/unprepare
Message-ID: <20171030004650.15571-1-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the clock ID to do the runtime pm should be ISC_ISPCK,
instead of ISC_MCK in clk_prepare(), clk_unprepare() and
isc_clk_is_enabled().

Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
---

 drivers/media/platform/atmel/atmel-isc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
index 2c40a7886542..9294ff0c7b83 100644
--- a/drivers/media/platform/atmel/atmel-isc.c
+++ b/drivers/media/platform/atmel/atmel-isc.c
@@ -598,7 +598,7 @@ static int isc_clk_prepare(struct clk_hw *hw)
 {
 	struct isc_clk *isc_clk = to_isc_clk(hw);
 
-	if (isc_clk->id == ISC_MCK)
+	if (isc_clk->id == ISC_ISPCK)
 		pm_runtime_get_sync(isc_clk->dev);
 
 	return isc_wait_clk_stable(hw);
@@ -610,7 +610,7 @@ static void isc_clk_unprepare(struct clk_hw *hw)
 
 	isc_wait_clk_stable(hw);
 
-	if (isc_clk->id == ISC_MCK)
+	if (isc_clk->id == ISC_ISPCK)
 		pm_runtime_put_sync(isc_clk->dev);
 }
 
@@ -657,12 +657,12 @@ static int isc_clk_is_enabled(struct clk_hw *hw)
 	struct isc_clk *isc_clk = to_isc_clk(hw);
 	u32 status;
 
-	if (isc_clk->id == ISC_MCK)
+	if (isc_clk->id == ISC_ISPCK)
 		pm_runtime_get_sync(isc_clk->dev);
 
 	regmap_read(isc_clk->regmap, ISC_CLKSR, &status);
 
-	if (isc_clk->id == ISC_MCK)
+	if (isc_clk->id == ISC_ISPCK)
 		pm_runtime_put_sync(isc_clk->dev);
 
 	return status & ISC_CLK(isc_clk->id) ? 1 : 0;
-- 
2.13.0
