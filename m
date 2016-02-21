From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 21 Feb 2016 15:16:48 +0100
Subject: [PATCH] i2c: brcmstb: allocate correct amount of memory for regmap
Message-ID: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want the size of the struct, not of a pointer to it. To be future
proof, just dereference the pointer to get the desired type.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-brcmstb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 3711df1d452622..4a45408dd82060 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -586,8 +586,7 @@ static int brcmstb_i2c_probe(struct platform_device *pdev)
 	if (!dev)
 		return -ENOMEM;
 
-	dev->bsc_regmap = devm_kzalloc(&pdev->dev, sizeof(struct bsc_regs *),
-				       GFP_KERNEL);
+	dev->bsc_regmap = devm_kzalloc(&pdev->dev, sizeof(*dev->bsc_regmap), GFP_KERNEL);
 	if (!dev->bsc_regmap)
 		return -ENOMEM;
 
-- 
2.7.0
