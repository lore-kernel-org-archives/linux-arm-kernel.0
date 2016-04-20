From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 20 Apr 2016 10:37:55 -0400
Subject: [PATCH v2 1/2] i2c: s3c2410: Print errno code in error logs
Message-ID: <1461163076-5959-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver not always prints the error code in case of a failure but this
information can be very useful for debugging. So let's print if available.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Hello,

This patch and 2/2 were only build tested because I don't have access to
a board using this IP block. I just noticed these issues when comparing
the i2c-s3c2410 driver with i2c-exynos5 where I did some fixes recently.

I think the patches are simple enough that is safe to pick them but of
course testing will be highly appreciated.

Best regards,
Javier

Changes in v2:
- Don't print the errno code on probe since it's already printed by the
  core. Suggested by Krzysztof Kozlowski.

 drivers/i2c/busses/i2c-s3c2410.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 362a6de54833..13f67df65c45 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -944,7 +944,7 @@ static int s3c24xx_i2c_cpufreq_transition(struct notifier_block *nb,
 		i2c_unlock_adapter(&i2c->adap);
 
 		if (ret < 0)
-			dev_err(i2c->dev, "cannot find frequency\n");
+			dev_err(i2c->dev, "cannot find frequency (%d)\n", ret);
 		else
 			dev_info(i2c->dev, "setting freq %d\n", got);
 	}
@@ -995,7 +995,8 @@ static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
 
 		ret = gpio_request(gpio, "i2c-bus");
 		if (ret) {
-			dev_err(i2c->dev, "gpio [%d] request failed\n", gpio);
+			dev_err(i2c->dev, "gpio [%d] request failed (%d)\n",
+				gpio, ret);
 			goto free_gpio;
 		}
 	}
-- 
2.5.5
