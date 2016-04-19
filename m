From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 19 Apr 2016 16:10:41 -0400
Subject: [PATCH 2/2] i2c: s3c2410: Check clk_prepare_enable() return value
In-Reply-To: <1461096641-19788-1-git-send-email-javier@osg.samsung.com>
References: <1461096641-19788-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1461096641-19788-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_prepare_enable() function can fail so check the return
value and propagate the error in case of a failure.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/i2c/busses/i2c-s3c2410.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 4b873fe9a75b..cb40a3af46e7 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1196,7 +1196,12 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 
 	/* initialise the i2c controller */
 
-	clk_prepare_enable(i2c->clk);
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "I2C clock enable failed (%d)\n", ret);
+		return ret;
+	}
+
 	ret = s3c24xx_i2c_init(i2c);
 	clk_disable(i2c->clk);
 	if (ret != 0) {
-- 
2.5.5
