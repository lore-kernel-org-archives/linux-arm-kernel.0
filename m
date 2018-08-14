From: justinpopo6@gmail.com (justinpopo6 at gmail.com)
Date: Tue, 14 Aug 2018 16:31:57 -0700
Subject: [PATCH] gpio: brcmstb: allow 0 width GPIO banks
Message-ID: <1534289517-1805-1-git-send-email-justinpopo6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Justin Chen <justinpopo6@gmail.com>

Sometimes we have empty banks within the GPIO block. This commit allows
proper handling of 0 width GPIO banks. We handle 0 width GPIO banks by
incrementing the bank and number of GPIOs, but not initializing them.
This will mean a call into the non-existent GPIOs will return an error.

Also remove banks and GPIO information from the dev_info print. This
information is misleading since the incremented banks and gpio_base do
not reflect the actual GPIOs that got initialized. We leave this
information out since it is already printed with dev_dbg.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 16c7f9f..8658910 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -664,6 +664,18 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		struct brcmstb_gpio_bank *bank;
 		struct gpio_chip *gc;
 
+		/*
+		 * If bank_width is 0, then there is an empty bank in the
+		 * register block. Special handling for this case.
+		 */
+		if (bank_width == 0) {
+			dev_dbg(dev, "Width 0 found: Empty bank @ %d\n",
+					num_banks);
+			num_banks++;
+			gpio_base += MAX_GPIO_PER_BANK;
+			continue;
+		}
+
 		bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
 		if (!bank) {
 			err = -ENOMEM;
@@ -740,8 +752,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 			goto fail;
 	}
 
-	dev_info(dev, "Registered %d banks (GPIO(s): %d-%d)\n",
-			num_banks, priv->gpio_base, gpio_base - 1);
+	dev_info(dev, "Brcmstb GPIO registered\n");
 
 	if (priv->parent_wake_irq && need_wakeup_event)
 		pm_wakeup_event(dev, 0);
-- 
2.7.4
