From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:17 +0000
Subject: [PATCH 04/19] mfd: ab8500-core: Fix many warnings reported by
 Checkpatch
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: Block comments use a trailing */ on a separate line
+        * */

WARNING: Block comments use a trailing */ on a separate line
+        * bank on higher 8 bits and reg in lower */

WARNING: Block comments use a trailing */ on a separate line
+        * bank on higher 8 bits and reg in lower */

WARNING: suspect code indent for conditional statements (8, 24)
+       if (unlikely(*offset == 17))
+                       *offset = 24;

WARNING: suspect code indent for conditional statements (8, 24)
+       if (unlikely(*offset == 16))
+                       *offset = 25;

WARNING: suspect code indent for conditional statements (8, 24)
+       if ((i == 3) && (*offset >= 24))
+                       *offset += 2;

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
+               return -ENOSYS;

WARNING: static const char * array should probably be static const char * const
+       static const char *switch_off_status[] = {

WARNING: static const char * array should probably be static const char * const
+       static const char *turn_on_status[] = {

total: 0 errors, 9 warnings, 1867 lines checked

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index fefbe4c..4080f01 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -113,7 +113,7 @@
 #define AB8500_SWITCH_OFF_STATUS	0x00
 
 #define AB8500_TURN_ON_STATUS		0x00
-#define AB8505_TURN_ON_STATUS_2	0x04
+#define AB8505_TURN_ON_STATUS_2		0x04
 
 #define AB8500_CH_USBCH_STAT1_REG	0x02
 #define VBUS_DET_DBNC100		0x02
@@ -211,7 +211,7 @@ static int set_register_interruptible(struct ab8500 *ab8500, u8 bank,
 	/*
 	 * Put the u8 bank and u8 register together into a an u16.
 	 * The bank on higher 8 bits and register in lower 8 bits.
-	 * */
+	 */
 	u16 addr = ((u16)bank) << 8 | reg;
 
 	dev_vdbg(ab8500->dev, "wr: addr %#x <= %#x\n", addr, data);
@@ -243,8 +243,6 @@ static int get_register_interruptible(struct ab8500 *ab8500, u8 bank,
 	u8 reg, u8 *value)
 {
 	int ret;
-	/* put the u8 bank and u8 reg together into a an u16.
-	 * bank on higher 8 bits and reg in lower */
 	u16 addr = ((u16)bank) << 8 | reg;
 
 	mutex_lock(&ab8500->lock);
@@ -278,8 +276,6 @@ static int mask_and_set_register_interruptible(struct ab8500 *ab8500, u8 bank,
 	u8 reg, u8 bitmask, u8 bitvalues)
 {
 	int ret;
-	/* put the u8 bank and u8 reg together into a an u16.
-	 * bank on higher 8 bits and reg in lower */
 	u16 addr = ((u16)bank) << 8 | reg;
 
 	mutex_lock(&ab8500->lock);
@@ -449,12 +445,12 @@ static void update_latch_offset(u8 *offset, int i)
 {
 	/* Fix inconsistent ITFromLatch25 bit mapping... */
 	if (unlikely(*offset == 17))
-			*offset = 24;
+		*offset = 24;
 	/* Fix inconsistent ab8540 bit mapping... */
 	if (unlikely(*offset == 16))
-			*offset = 25;
+		*offset = 25;
 	if ((i == 3) && (*offset >= 24))
-			*offset += 2;
+		*offset += 2;
 }
 
 static int ab8500_handle_hierarchical_line(struct ab8500 *ab8500,
@@ -590,12 +586,12 @@ static int ab8500_irq_init(struct ab8500 *ab8500, struct device_node *np)
 
 	/* If ->irq_base is zero this will give a linear mapping */
 	ab8500->domain = irq_domain_add_simple(ab8500->dev->of_node,
-			num_irqs, 0,
-			&ab8500_irq_ops, ab8500);
+					       num_irqs, 0,
+					       &ab8500_irq_ops, ab8500);
 
 	if (!ab8500->domain) {
 		dev_err(ab8500->dev, "Failed to create irqdomain\n");
-		return -ENOSYS;
+		return -ENODEV;
 	}
 
 	return 0;
@@ -1549,7 +1545,7 @@ static struct attribute_group ab9540_attr_group = {
 
 static int ab8500_probe(struct platform_device *pdev)
 {
-	static const char *switch_off_status[] = {
+	static const char * const switch_off_status[] = {
 		"Swoff bit programming",
 		"Thermal protection activation",
 		"Vbat lower then BattOk falling threshold",
@@ -1558,7 +1554,7 @@ static int ab8500_probe(struct platform_device *pdev)
 		"Battery level lower than power on reset threshold",
 		"Power on key 1 pressed longer than 10 seconds",
 		"DB8500 thermal shutdown"};
-	static const char *turn_on_status[] = {
+	static const char * const turn_on_status[] = {
 		"Battery rising (Vbat)",
 		"Power On Key 1 dbF",
 		"Power On Key 2 dbF",
-- 
1.9.1
