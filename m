From: contact@paulk.fr (Paul Kocialkowski)
Date: Fri,  5 Feb 2016 19:42:18 +0100
Subject: [PATCH v2 1/4] regulator: lp872x: Remove warning about invalid DVS
 GPIO
In-Reply-To: <1454697741-8687-1-git-send-email-contact@paulk.fr>
References: <1454697741-8687-1-git-send-email-contact@paulk.fr>
Message-ID: <1454697741-8687-2-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some devices don't hook the DVS pin to a GPIO but to ground or VCC.
In those cases, it is not a problem to have no DVS GPIO provided, as the current
code will already switch to software-only DVS selection:

When the DVS GPIO is invalid, lp872x_init_dvs jumps to the set_default_dvs_mode
label, which instructs the chip not to use the DVS pin at all and do it all in
software instead (by clearing the LP8720_EXT_DVS_M bit in the
LP872X_GENERAL_CFG register).

That is reflected later in the code, when setting the bucks (the DVS pin only
applies to the bucks) by checking for the LP8720_EXT_DVS_M bit on the
LP872X_GENERAL_CFG register (in lp872x_select_buck_vout_addr) to decide whether
to use software or hardware DVS selection.

Thus, there is no need to print a warning when the DVS GPIO is invalid.

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
