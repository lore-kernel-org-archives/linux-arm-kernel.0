From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 23 May 2013 19:31:26 +0200
Subject: [PATCH 4/6] i2c: stu300: do not request a specific clock name
In-Reply-To: <1369330288-14856-1-git-send-email-linus.walleij@stericsson.com>
References: <1369330288-14856-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369330288-14856-5-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

We have used the default clock associated with the block
for a long time, only heuristics in the clock system has
made this work anyway. This needs to be done away with as
we start probing this driver and its clocks exclusively
from the device tree.

Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Wolfram: seeking an ACK for this to take it through the
ARM SoC tree with the rest of my device tree clock patches
for U300.
---
 drivers/i2c/busses/i2c-stu300.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 1beaa05a..d1a6b20 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -868,7 +868,6 @@ stu300_probe(struct platform_device *pdev)
 	struct resource *res;
 	int bus_nr;
 	int ret = 0;
-	char clk_name[] = "I2C0";
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct stu300_dev), GFP_KERNEL);
 	if (!dev) {
@@ -877,8 +876,7 @@ stu300_probe(struct platform_device *pdev)
 	}
 
 	bus_nr = pdev->id;
-	clk_name[3] += (char)bus_nr;
-	dev->clk = devm_clk_get(&pdev->dev, clk_name);
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
 		dev_err(&pdev->dev, "could not retrieve i2c bus clock\n");
 		return PTR_ERR(dev->clk);
-- 
1.7.11.3
