From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 23 Aug 2018 13:51:40 -0500
Subject: [PATCH] rtc: sun6i: Use struct_size() in kzalloc()
Message-ID: <20180823185140.GA29028@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo { 
	int stuff;
        void *entry[];
};

instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/rtc/rtc-sun6i.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 2cd5a7b..fe07310 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -199,8 +199,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	if (!rtc)
 		return;
 
-	clk_data = kzalloc(sizeof(*clk_data) + (sizeof(*clk_data->hws) * 2),
-			   GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
 	if (!clk_data) {
 		kfree(rtc);
 		return;
-- 
2.7.4
