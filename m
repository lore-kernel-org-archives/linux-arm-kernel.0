From: manabian@gmail.com (Joachim Eastwood)
Date: Wed,  6 May 2015 19:11:21 +0200
Subject: [PATCH] pinctrl: lpc18xx: create pin cap lookup helper
Message-ID: <1430932281-3432-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both pconf_get_pin and pconf_set_pin needs to lookup pin cap based
on the pin number. Create a common helper function that both
functions can use that also handles the case where no pin number is
found in the pins array.

This also fixes a small bug in pconf_get_pin where pconf_get_i2c0
would use the pins array index rather than the pin number.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hi Linus,

Patch is based on your linux-pinctrl devel branch.
Since it's a new driver feel free to squash it with the initial commit.

regards,
Joachim Eastwood

 drivers/pinctrl/pinctrl-lpc18xx.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
index 15fe1e2535c2..0facb7e64fef 100644
--- a/drivers/pinctrl/pinctrl-lpc18xx.c
+++ b/drivers/pinctrl/pinctrl-lpc18xx.c
@@ -729,6 +729,18 @@ static int lpc18xx_pconf_get_pin(enum pin_config_param param, int *arg, u32 reg,
 	return 0;
 }
 
+static struct lpc18xx_pin_caps *lpc18xx_get_pin_caps(unsigned pin)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(lpc18xx_pins); i++) {
+		if (lpc18xx_pins[i].number == pin)
+			return lpc18xx_pins[i].drv_data;
+	}
+
+	return NULL;
+}
+
 static int lpc18xx_pconf_get(struct pinctrl_dev *pctldev, unsigned pin,
 			     unsigned long *config)
 {
@@ -737,14 +749,11 @@ static int lpc18xx_pconf_get(struct pinctrl_dev *pctldev, unsigned pin,
 	struct lpc18xx_pin_caps *pin_cap;
 	int ret, arg = 0;
 	u32 reg;
-	int i;
 
-	for (i = 0; i < ARRAY_SIZE(lpc18xx_pins); i++) {
-		if (lpc18xx_pins[i].number == pin)
-			pin = i;
-	}
+	pin_cap = lpc18xx_get_pin_caps(pin);
+	if (!pin_cap)
+		return -EINVAL;
 
-	pin_cap = lpc18xx_pins[pin].drv_data;
 	reg = readl(scu->base + pin_cap->offset);
 
 	if (pin_cap->type == TYPE_I2C0)
@@ -905,12 +914,10 @@ static int lpc18xx_pconf_set(struct pinctrl_dev *pctldev, unsigned pin,
 	int ret;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(lpc18xx_pins); i++) {
-		if (lpc18xx_pins[i].number == pin)
-			break;
-	}
+	pin_cap = lpc18xx_get_pin_caps(pin);
+	if (!pin_cap)
+		return -EINVAL;
 
-	pin_cap = lpc18xx_pins[i].drv_data;
 	reg = readl(scu->base + pin_cap->offset);
 
 	for (i = 0; i < num_configs; i++) {
-- 
1.8.0
