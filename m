From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu,  9 Feb 2017 00:16:13 +0000
Subject: [PATCH -next] rtc: sun6i: Fix return value check in
 sun6i_rtc_clk_init()
Message-ID: <20170209001613.21665-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function of_io_request_and_map() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/rtc/rtc-sun6i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 08510ca..39cbc12 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -202,7 +202,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	spin_lock_init(&rtc->lock);
 
 	rtc->base = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (!rtc->base) {
+	if (IS_ERR(rtc->base)) {
 		pr_crit("Can't map RTC registers");
 		return;
 	}
