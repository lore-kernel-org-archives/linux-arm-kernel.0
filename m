From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 20 Apr 2016 10:37:56 -0400
Subject: [PATCH v2 2/2] i2c: s3c2410: Check clk_prepare_enable() return value
In-Reply-To: <1461163076-5959-1-git-send-email-javier@osg.samsung.com>
References: <1461163076-5959-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1461163076-5959-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_prepare_enable() function can fail so check the return
value and propagate the error in case of a failure.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes in v2:
- Don't print the errno code since that's already printed by the
  core when probe fails. Suggested by Krzysztof Kozlowski.

 drivers/i2c/busses/i2c-s3c2410.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 13f67df65c45..8a9ea0c1e41d 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1196,7 +1196,12 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 
 	/* initialise the i2c controller */
 
-	clk_prepare_enable(i2c->clk);
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "I2C clock enable failed\n");
+		return ret;
+	}
+
 	ret = s3c24xx_i2c_init(i2c);
 	clk_disable(i2c->clk);
 	if (ret != 0) {
-- 
2.5.5
