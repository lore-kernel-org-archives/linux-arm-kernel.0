From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 18 Apr 2016 11:35:53 +0800
Subject: [PATCH 1/9] thermal: rockchip: disable thermal->clk in err case
In-Reply-To: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1460950562-20652-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Lin <shawn.lin@rock-chips.com>

Disable thermal->clk when enabling pclk fails in
resume routine.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 1dbd862..f4c4bcd 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -979,8 +979,10 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 		return error;
 
 	error = clk_enable(thermal->pclk);
-	if (error)
+	if (error) {
+		clk_disable(thermal->clk);
 		return error;
+	}
 
 	rockchip_thermal_reset_controller(thermal->reset);
 
-- 
1.9.1
