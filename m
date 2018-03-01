From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  1 Mar 2018 21:34:44 +0100
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <1519936484-23132-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Interrupt number 0 (returned by platform_get_irq()) might be a valid IRQ
so do not treat it as an error.  If interrupt 0 was configured, the driver
would exit the probe early, before finishing initialization, but with
0-exit status.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable at vger.kernel.org
Fixes: e0d1ec97853f ("i2c-s3c2410: Change IRQ to be plain integer.")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/i2c/busses/i2c-s3c2410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 5d97510ee48b..783a93404f47 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1178,7 +1178,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	 */
 	if (!(i2c->quirks & QUIRK_POLL)) {
 		i2c->irq = ret = platform_get_irq(pdev, 0);
-		if (ret <= 0) {
+		if (ret < 0) {
 			dev_err(&pdev->dev, "cannot find IRQ\n");
 			clk_unprepare(i2c->clk);
 			return ret;
-- 
2.7.4
