From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 23 Oct 2013 14:36:11 +0800
Subject: [PATCH] gpio: pl061: hook request if gpio-ranges avaiable
Message-ID: <1382510171-5937-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio-ranges property could binds gpio to pinctrl. But there may be some
gpios without pinctrl operation. So check whether gpio-ranges property
exists in device node first.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pl061.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index cb5510b..44a0ba1 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -306,8 +306,11 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 
 	spin_lock_init(&chip->lock);
 
-	chip->gc.request = pl061_gpio_request;
-	chip->gc.free = pl061_gpio_free;
+	/* Hook the request()/free() for pinctrl operation */
+	if (of_get_property(dev->of_node, "gpio-ranges", NULL)) {
+		chip->gc.request = pl061_gpio_request;
+		chip->gc.free = pl061_gpio_free;
+	}
 	chip->gc.direction_input = pl061_direction_input;
 	chip->gc.direction_output = pl061_direction_output;
 	chip->gc.get = pl061_get_value;
-- 
1.8.1.2
