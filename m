From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon,  1 Feb 2016 16:18:40 +0800
Subject: [PATCH] soc: rockchip: power-domain: fix err handle while probing
Message-ID: <1454314720-6391-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we fail to probe the driver, we should not directly break
from the for_each_available_child_of_node since it calls of_node_get
while iterating. This patch add of_node_put to fix the unbalanced
call pair.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/soc/rockchip/pm_domains.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 534c589..4a65c5b 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -419,6 +419,7 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 		if (error) {
 			dev_err(dev, "failed to handle node %s: %d\n",
 				node->name, error);
+			of_node_put(node);
 			goto err_out;
 		}
 	}
-- 
2.3.7
