From: petr.cvek@tul.cz (Petr Cvek)
Date: Thu, 17 Sep 2015 06:58:47 +0200
Subject: [PATCH v3 12/26] ARM: pxa: magician: Rename charger cable detection
 EGPIOs
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Message-ID: <55FA4887.9060404@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch renames EGPIOs, which are used for the charging cable presence
and type detection. Old names did not correspond with an observed
functionality (on board_id 0x3a). The behavior is not:

- AC charger
- USB charger
- Cable detection

, but:

- AC/USB type
- Cable detection1
- Cable detection2

This patch fixes a possible typo in the bit offset for the cable detection
EGPIO declaration, too.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/include/mach/magician.h | 11 ++++++++---
 arch/arm/mach-pxa/magician.c              |  8 ++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/magician.h b/arch/arm/mach-pxa/include/mach/magician.h
index f0e08f8..41371ca 100644
--- a/arch/arm/mach-pxa/include/mach/magician.h
+++ b/arch/arm/mach-pxa/include/mach/magician.h
@@ -107,8 +107,13 @@
 
 /* input */
 
-#define EGPIO_MAGICIAN_CABLE_STATE_AC	MAGICIAN_EGPIO(4, 0)
-#define EGPIO_MAGICIAN_CABLE_STATE_USB	MAGICIAN_EGPIO(4, 1)
+/* USB or AC charger type */
+#define EGPIO_MAGICIAN_CABLE_TYPE	MAGICIAN_EGPIO(4, 0)
+/*
+ * Vbus is detected
+ * FIXME behaves like (6,3), may differ for host/device
+ */
+#define EGPIO_MAGICIAN_CABLE_VBUS	MAGICIAN_EGPIO(4, 1)
 
 #define EGPIO_MAGICIAN_BOARD_ID0	MAGICIAN_EGPIO(5, 0)
 #define EGPIO_MAGICIAN_BOARD_ID1	MAGICIAN_EGPIO(5, 1)
@@ -118,6 +123,6 @@
 
 #define EGPIO_MAGICIAN_EP_INSERT	MAGICIAN_EGPIO(6, 1)
 /* FIXME behaves like (4,1), may differ for host/device */
-#define EGPIO_MAGICIAN_CABLE_INSERTED	MAGICIAN_EGPIO(6, 4)
+#define EGPIO_MAGICIAN_CABLE_INSERTED	MAGICIAN_EGPIO(6, 3)
 
 #endif /* _MAGICIAN_H_ */
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index bf0760e..b645288 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -579,7 +579,7 @@ static struct resource gpio_vbus_resource = {
 
 static struct gpio_vbus_mach_info gpio_vbus_info = {
 	.gpio_pullup	= GPIO27_MAGICIAN_USBC_PUEN,
-	.gpio_vbus	= EGPIO_MAGICIAN_CABLE_STATE_USB,
+	.gpio_vbus	= EGPIO_MAGICIAN_CABLE_VBUS,
 };
 
 static struct platform_device gpio_vbus = {
@@ -598,17 +598,17 @@ static struct platform_device gpio_vbus = {
 
 static int power_supply_init(struct device *dev)
 {
-	return gpio_request(EGPIO_MAGICIAN_CABLE_STATE_AC, "CABLE_STATE_AC");
+	return gpio_request(EGPIO_MAGICIAN_CABLE_TYPE, "Cable USB/AC type");
 }
 
 static int magician_is_ac_online(void)
 {
-	return gpio_get_value(EGPIO_MAGICIAN_CABLE_STATE_AC);
+	return gpio_get_value(EGPIO_MAGICIAN_CABLE_TYPE);
 }
 
 static void power_supply_exit(struct device *dev)
 {
-	gpio_free(EGPIO_MAGICIAN_CABLE_STATE_AC);
+	gpio_free(EGPIO_MAGICIAN_CABLE_TYPE);
 }
 
 static char *magician_supplicants[] = {
-- 
1.7.12.1
