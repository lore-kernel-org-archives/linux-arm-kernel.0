From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Wed,  6 Jul 2016 12:21:47 +0000
Subject: [PATCH -next] clk: sunxi: Fix return value check in
 sun8i_a23_mbus_setup()
Message-ID: <1467807707-32039-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function of_io_request_and_map() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should be
replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/clk/sunxi/clk-sun8i-mbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sun8i-mbus.c b/drivers/clk/sunxi/clk-sun8i-mbus.c
index 411d303..b200ebf 100644
--- a/drivers/clk/sunxi/clk-sun8i-mbus.c
+++ b/drivers/clk/sunxi/clk-sun8i-mbus.c
@@ -48,7 +48,7 @@ static void __init sun8i_a23_mbus_setup(struct device_node *node)
 		return;
 
 	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (!reg) {
+	if (IS_ERR(reg)) {
 		pr_err("Could not get registers for sun8i-mbus-clk\n");
 		goto err_free_parents;
 	}
