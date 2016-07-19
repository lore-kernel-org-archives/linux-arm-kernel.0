From: weiyj_lk@163.com (Wei Yongjun)
Date: Tue, 19 Jul 2016 11:23:24 +0000
Subject: [PATCH -next] net: axienet: Fix return value check in axienet_probe()
Message-ID: <1468927404-32270-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function of_parse_phandle() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

Fixes: 46aa27df8853 ('net: axienet: Use devm_* calls')
Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 9c82993..36ee7ab 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1541,9 +1541,9 @@ static int axienet_probe(struct platform_device *pdev)
 
 	/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
 	np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
-	if (IS_ERR(np)) {
+	if (!np) {
 		dev_err(&pdev->dev, "could not find DMA node\n");
-		ret = PTR_ERR(np);
+		ret = -ENODEV;
 		goto free_netdev;
 	}
 	ret = of_address_to_resource(np, 0, &dmares);
