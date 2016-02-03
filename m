From: wxt@rock-chips.com (Caesar Wang)
Date: Wed,  3 Feb 2016 12:12:43 +0800
Subject: [PATCH 4/8] thermal: rockchip: fix calculation error for code_to_temp
In-Reply-To: <1454472767-5767-1-git-send-email-wxt@rock-chips.com>
References: <1454472767-5767-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1454472767-5767-5-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Elaine Zhang <zhangqing@rock-chips.com>

the calculation use a global table, not their own table.
so adapt the table to the correct one.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 433085a..5c58d48 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -411,7 +411,7 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
 	 * temperature between 2 table entries is linear and interpolate
 	 * to produce less granular result.
 	 */
-	num = table.id[mid].temp - v2_code_table[mid - 1].temp;
+	num = table.id[mid].temp - table.id[mid - 1].temp;
 	num *= abs(table.id[mid - 1].code - code);
 	denom = abs(table.id[mid - 1].code - table.id[mid].code);
 	*temp = table.id[mid - 1].temp + (num / denom);
-- 
1.9.1
