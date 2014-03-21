From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 21 Mar 2014 13:18:17 +0100
Subject: [PATCH 1/2] clk: s2mps11: Fix possible NULL pointer dereference
Message-ID: <1395404297-12133-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If parent device does not have of_node set the s2mps11_clk_parse_dt()
returned NULL. This NULL was later passed to of_clk_add_provider() which
dereferenced it in pr_debug() call.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: <stable@vger.kernel.org>
---
 drivers/clk/clk-s2mps11.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 00a3abe103a5..27c83e45eaed 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -130,7 +130,7 @@ static struct device_node *s2mps11_clk_parse_dt(struct platform_device *pdev)
 	int i;
 
 	if (!iodev->dev->of_node)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	clk_np = of_find_node_by_name(iodev->dev->of_node, "clocks");
 	if (!clk_np) {
-- 
1.7.9.5
