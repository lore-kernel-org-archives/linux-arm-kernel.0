From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 14 Oct 2014 14:20:43 +0200
Subject: [PATCH 5/8] mfd: ab8500: Use power_supply_*() API for accessing
 function attrs
In-Reply-To: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
References: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1413289246-31650-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace direct calls to power supply function attributes with wrappers.
Wrappers provide safe access access in case of unregistering the power
supply (.e.g by removing the driver). Replace:
 - get_property -> power_supply_get_property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mfd/ab8500-sysctrl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 8e0dae59844d..93b2d2c32ca3 100644
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
