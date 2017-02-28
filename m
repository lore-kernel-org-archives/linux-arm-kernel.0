From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 28 Feb 2017 07:35:15 +0100
Subject: [PATCH v3 05/25] clocksource: owl: Add S900 support
In-Reply-To: <20170228063535.32069-1-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
Message-ID: <20170228063535.32069-6-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Actions Semi S900 SoC provides four 32-bit timers, TIMER0/1/2/3,
but no 2Hz timers.

Deal with the S500 having less timers.

An S900 datasheet can be found in 96Boards documentation:
https://github.com/96boards/documentation/blob/master/ConsumerEdition/Bubblegum-96/HardwareDocs/SoC_bubblegum96.pdf

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3: new
 
 drivers/clocksource/owl-timer.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
index 1b1e26d..babbfd5 100644
--- a/drivers/clocksource/owl-timer.c
+++ b/drivers/clocksource/owl-timer.c
@@ -31,7 +31,7 @@
 #define OWL_Tx_CTL_INTEN	BIT(1)
 #define OWL_Tx_CTL_EN		BIT(2)
 
-#define OWL_MAX_Tx 2
+#define OWL_MAX_Tx 4
 
 struct owl_timer_info {
 	int timer_offset[OWL_MAX_Tx];
@@ -43,7 +43,8 @@ static void __iomem *owl_timer_base;
 
 static inline void __iomem *owl_timer_get_base(unsigned timer_nr)
 {
-	if (timer_nr >= OWL_MAX_Tx)
+	if (timer_nr >= OWL_MAX_Tx ||
+	    owl_timer_info->timer_offset[timer_nr] == -1)
 		return NULL;
 
 	return owl_timer_base + owl_timer_info->timer_offset[timer_nr];
@@ -126,10 +127,20 @@ static irqreturn_t owl_timer1_interrupt(int irq, void *dev_id)
 static const struct owl_timer_info s500_timer_info = {
 	.timer_offset[0] = 0x08,
 	.timer_offset[1] = 0x14,
+	.timer_offset[2] = -1,
+	.timer_offset[3] = -1,
+};
+
+static const struct owl_timer_info s900_timer_info = {
+	.timer_offset[0] = 0x08,
+	.timer_offset[1] = 0x14,
+	.timer_offset[2] = 0x30,
+	.timer_offset[3] = 0x3c,
 };
 
 static const struct of_device_id owl_timer_of_matches[] = {
 	{ .compatible = "actions,s500-timer", .data = &s500_timer_info },
+	{ .compatible = "actions,s900-timer", .data = &s900_timer_info },
 	{ }
 };
 
@@ -191,3 +202,4 @@ static int __init owl_timer_init(struct device_node *node)
 	return 0;
 }
 CLOCKSOURCE_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
+CLOCKSOURCE_OF_DECLARE(owl_s900, "actions,s900-timer", owl_timer_init);
-- 
2.10.2
