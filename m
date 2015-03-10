From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 Mar 2015 09:27:12 +0100
Subject: [PATCH v6 08/22] power_supply: ab8500: Use power_supply_*() API for
 accessing function attrs
In-Reply-To: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1425976046-20973-9-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace direct calls to power supply function attributes with wrappers.
Wrappers provide safe access in case of unregistering the power
supply (e.g. by removing the driver). Replace:
 - get_property -> power_supply_get_property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/ab8500_btemp.c    | 2 +-
 drivers/power/ab8500_charger.c  | 2 +-
 drivers/power/ab8500_fg.c       | 2 +-
 drivers/power/abx500_chargalg.c | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index d5683f503a4e..4d18464d6400 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -938,7 +938,7 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
 		enum power_supply_property prop;
 		prop = ext->properties[j];
 
-		if (ext->get_property(ext, prop, &ret))
+		if (power_supply_get_property(ext, prop, &ret))
 			continue;
 
 		switch (prop) {
diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index cee9b9e46825..f9eb7fff1d65 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -1957,7 +1957,7 @@ static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
 		enum power_supply_property prop;
 		prop = ext->properties[j];
 
-		if (ext->get_property(ext, prop, &ret))
+		if (power_supply_get_property(ext, prop, &ret))
 			continue;
 
 		switch (prop) {
diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 73bdb4dc4142..7a2e3ac44cf3 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -2200,7 +2200,7 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 		enum power_supply_property prop;
 		prop = ext->properties[j];
 
-		if (ext->get_property(ext, prop, &ret))
+		if (power_supply_get_property(ext, prop, &ret))
 			continue;
 
 		switch (prop) {
diff --git a/drivers/power/abx500_chargalg.c b/drivers/power/abx500_chargalg.c
index 0da4415cbc10..ac6f4a22f846 100644
--- a/drivers/power/abx500_chargalg.c
+++ b/drivers/power/abx500_chargalg.c
@@ -1001,7 +1001,7 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 	 * property because of handling that sysfs entry on its own, this is
 	 * the place to get the battery capacity.
 	 */
-	if (!ext->get_property(ext, POWER_SUPPLY_PROP_CAPACITY, &ret)) {
+	if (!power_supply_get_property(ext, POWER_SUPPLY_PROP_CAPACITY, &ret)) {
 		di->batt_data.percent = ret.intval;
 		capacity_updated = true;
 	}
@@ -1019,7 +1019,7 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 			ext->type == POWER_SUPPLY_TYPE_USB)
 			di->usb_chg = psy_to_ux500_charger(ext);
 
-		if (ext->get_property(ext, prop, &ret))
+		if (power_supply_get_property(ext, prop, &ret))
 			continue;
 		switch (prop) {
 		case POWER_SUPPLY_PROP_PRESENT:
-- 
1.9.1
