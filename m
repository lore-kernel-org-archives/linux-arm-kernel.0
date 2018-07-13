From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Fri, 13 Jul 2018 23:09:16 +0200
Subject: [PATCH/RFT 4/6] i2c: davinci: set SDA as output for recovery
In-Reply-To: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180713210920.3648-5-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows for sending STOP when generating pulses which is much more
robust because it will bring clients into a default state.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-davinci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index d945a2654c2f..478acf0870aa 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -874,7 +874,8 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 			r = PTR_ERR(rinfo->scl_gpiod);
 			goto err_unuse_clocks;
 		}
-		rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_IN);
+		rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda",
+						  GPIOD_OUT_HIGH_OPEN_DRAIN);
 		if (IS_ERR(rinfo->sda_gpiod)) {
 			r = PTR_ERR(rinfo->sda_gpiod);
 			goto err_unuse_clocks;
-- 
2.11.0
