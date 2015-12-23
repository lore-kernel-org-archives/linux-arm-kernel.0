From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 23 Dec 2015 11:58:36 +0100
Subject: [PATCH 3/6] regulator: lp872x: Remove warning about invalid DVS GPIO
In-Reply-To: <1450868319-20513-1-git-send-email-contact@paulk.fr>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
Message-ID: <1450868319-20513-4-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some devices don't hook the DVS pin to a GPIO but to ground or VCC.
In those cases, it is not a problem to have no DVS GPIO.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/regulator/lp872x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index 19d7584..21c49d8 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -738,10 +738,8 @@ static int lp872x_init_dvs(struct lp872x *lp)
 		goto set_default_dvs_mode;
 
 	gpio = dvs->gpio;
-	if (!gpio_is_valid(gpio)) {
-		dev_warn(lp->dev, "invalid gpio: %d\n", gpio);
+	if (!gpio_is_valid(gpio))
 		goto set_default_dvs_mode;
-	}
 
 	pinstate = dvs->init_state;
 	ret = devm_gpio_request_one(lp->dev, gpio, pinstate, "LP872X DVS");
-- 
1.9.1
