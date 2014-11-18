From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 18 Nov 2014 15:43:45 +0100
Subject: [PATCH] pinctrl: at91: enhance (debugfs) at91_gpio_dbg_show
Message-ID: <1416321825-17776-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthieu Crapet <mcrapet@gmail.com>

When a pin is configured as GPIO, print also direction (input or output).

Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/pinctrl/pinctrl-at91.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 354a81d40925..a6b29ebc3cc3 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1344,7 +1344,6 @@ static void at91_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	for (i = 0; i < chip->ngpio; i++) {
 		unsigned mask = pin_to_mask(i);
 		const char *gpio_label;
-		u32 pdsr;
 
 		gpio_label = gpiochip_is_requested(chip, i);
 		if (!gpio_label)
@@ -1353,11 +1352,13 @@ static void at91_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 		seq_printf(s, "[%s] GPIO%s%d: ",
 			   gpio_label, chip->label, i);
 		if (mode == AT91_MUX_GPIO) {
-			pdsr = readl_relaxed(pio + PIO_PDSR);
-
-			seq_printf(s, "[gpio] %s\n",
-				   pdsr & mask ?
-				   "set" : "clear");
+			seq_printf(s, "[gpio] ");
+			seq_printf(s, "%s ",
+				      readl_relaxed(pio + PIO_OSR) & mask ?
+				      "output" : "input");
+			seq_printf(s, "%s\n",
+				      readl_relaxed(pio + PIO_PDSR) & mask ?
+				      "set" : "clear");
 		} else {
 			seq_printf(s, "[periph %c]\n",
 				   mode + 'A' - 1);
-- 
2.1.3
