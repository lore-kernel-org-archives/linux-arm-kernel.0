From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 25 Nov 2013 22:15:20 +0100
Subject: [PATCH v2 1/2] can: flexcan: use correct clock as base for bit rate
 calculation
In-Reply-To: <1385414121-21493-1-git-send-email-mkl@pengutronix.de>
References: <1385414121-21493-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1385414121-21493-2-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flexcan IP core uses the peripheral clock ("per") as basic clock for the
bit timing calculation. However the driver uses the the wrong clock ("ipg").
This leads to wrong bit rates if the rates on both clock are different.

This patch fixes the problem by using the correct clock for the bit rate
calculation.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index ae08cf1..aaed97b 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1020,13 +1020,13 @@ static int flexcan_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "no ipg clock defined\n");
 			return PTR_ERR(clk_ipg);
 		}
-		clock_freq = clk_get_rate(clk_ipg);
 
 		clk_per = devm_clk_get(&pdev->dev, "per");
 		if (IS_ERR(clk_per)) {
 			dev_err(&pdev->dev, "no per clock defined\n");
 			return PTR_ERR(clk_per);
 		}
+		clock_freq = clk_get_rate(clk_per);
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.8.4.2
