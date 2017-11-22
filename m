From: colin.king@canonical.com (Colin King)
Date: Wed, 22 Nov 2017 17:16:18 +0000
Subject: [PATCH] rtc: sun6i: ensure rtc is kfree'd on error
Message-ID: <20171122171618.2460-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

The error return path on clk_data allocation failure does not kfree
the allocated rtc object. Fix this with a kfree of rtc on the error
exit path.

Detected by CoverityScan, CID#1452264 ("Resource Leak")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rtc/rtc-sun6i.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 3d2216ccd860..5bc28eed1adf 100644
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
2.14.1
