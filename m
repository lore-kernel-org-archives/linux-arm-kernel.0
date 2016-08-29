From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 12:26:26 +0100
Subject: [PATCH 5/8] ARM: sa1100/assabet: switch assabet IrDA to use gpiod APIs
In-Reply-To: <20160829112540.GF1041@n2100.armlinux.org.uk>
References: <20160829112540.GF1041@n2100.armlinux.org.uk>
Message-ID: <E1beKhu-0001HB-0j@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the IrDA code to use the gpiod APIs rather than platform data
with function callbacks.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index af5cea464a10..ba180eebd6ab 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -303,36 +303,18 @@ static struct resource assabet_flash_resources[] = {
 };
 
 
-/*
- * Assabet IrDA support code.
- */
-
-static int assabet_irda_set_power(struct device *dev, unsigned int state)
-{
-	static unsigned int bcr_state[4] = {
-		ASSABET_BCR_IRDA_MD0,
-		ASSABET_BCR_IRDA_MD1|ASSABET_BCR_IRDA_MD0,
-		ASSABET_BCR_IRDA_MD1,
-		0
-	};
-
-	if (state < 4)
-		ASSABET_BCR_frob(ASSABET_BCR_IRDA_MD1 | ASSABET_BCR_IRDA_MD0,
-				 bcr_state[state]);
-	return 0;
-}
-
-static void assabet_irda_set_speed(struct device *dev, unsigned int speed)
-{
-	if (speed < 4000000)
-		ASSABET_BCR_clear(ASSABET_BCR_IRDA_FSEL);
-	else
-		ASSABET_BCR_set(ASSABET_BCR_IRDA_FSEL);
-}
-
 static struct irda_platform_data assabet_irda_data = {
-	.set_power	= assabet_irda_set_power,
-	.set_speed	= assabet_irda_set_speed,
+};
+
+/* IrDA GPIO mappings */
+static struct gpiod_lookup_table assabet_irda_gpio_table = {
+	.dev_id = "sa11x0-ir",
+	.table = {
+		GPIO_LOOKUP("assabet", 3, "ir-fsel", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("assabet", 4, "ir-md0", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("assabet", 5, "ir-md1", GPIO_ACTIVE_HIGH),
+		{ },
+	},
 };
 
 static struct ucb1x00_plat_data assabet_ucb1x00_data = {
@@ -539,6 +521,8 @@ static const struct gpio_keys_platform_data assabet_keys_pdata = {
 
 static void __init assabet_init(void)
 {
+	gpiod_add_lookup_table(&assabet_irda_gpio_table);
+
 	/*
 	 * Ensure that the power supply is in "high power" mode.
 	 */
-- 
2.1.0
