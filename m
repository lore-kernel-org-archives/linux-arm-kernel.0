From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 Mar 2015 09:27:13 +0100
Subject: [PATCH v6 09/22] mfd: ab8500: Use power_supply_*() API for accessing
 function attrs
In-Reply-To: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1425976046-20973-10-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace direct calls to power supply function attributes with wrappers.
Wrappers provide safe access in case of unregistering the power
supply (e.g. by removing the driver). Replace:
 - get_property -> power_supply_get_property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/mfd/ab8500-sysctrl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index cfff0b643f1b..d4a4b24be7c6 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -49,7 +49,8 @@ static void ab8500_power_off(void)
 		if (!psy)
 			continue;
 
-		ret = psy->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &val);
+		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
+				&val);
 
 		if (!ret && val.intval) {
 			charger_present = true;
@@ -63,8 +64,8 @@ static void ab8500_power_off(void)
 	/* Check if battery is known */
 	psy = power_supply_get_by_name("ab8500_btemp");
 	if (psy) {
-		ret = psy->get_property(psy, POWER_SUPPLY_PROP_TECHNOLOGY,
-					&val);
+		ret = power_supply_get_property(psy,
+				POWER_SUPPLY_PROP_TECHNOLOGY, &val);
 		if (!ret && val.intval != POWER_SUPPLY_TECHNOLOGY_UNKNOWN) {
 			printk(KERN_INFO
 			       "Charger \"%s\" is connected with known battery."
-- 
1.9.1
