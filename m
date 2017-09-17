From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Sun, 17 Sep 2017 13:43:10 +0100
Subject: [PATCH] rtc: sun6i: fix memory leak
Message-ID: <1505652190-4942-1-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If 'clk_data' is not allocated we returned but we failed to free 'rtc'.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/rtc/rtc-sun6i.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 3d2216c..5bc28ee 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -201,8 +201,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 
 	clk_data = kzalloc(sizeof(*clk_data) + (sizeof(*clk_data->hws) * 2),
 			   GFP_KERNEL);
-	if (!clk_data)
+	if (!clk_data) {
+		kfree(rtc);
 		return;
+	}
 
 	spin_lock_init(&rtc->lock);
 
-- 
2.7.4
