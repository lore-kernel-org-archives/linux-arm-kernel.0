From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 May 2013 13:40:17 -0700
Subject: [RFC/PATCH 2/2] gpio/omap: Use of_node->id_entry directly
In-Reply-To: <1369255217-29764-1-git-send-email-sboyd@codeaurora.org>
References: <1369255217-29764-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1369255217-29764-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the driver core is assigning the of_device_id that
matches to the of_node before calling probe we can skip this
duplicate search and just use of_node->id_entry directly.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/gpio/gpio-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 2050891..04ae7e7 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1083,8 +1083,6 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 	irq_set_handler_data(bank->irq, bank);
 }
 
-static const struct of_device_id omap_gpio_match[];
-
 static int omap_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1094,7 +1092,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct gpio_bank *bank;
 
-	match = of_match_device(of_match_ptr(omap_gpio_match), dev);
+	match = pdev->dev.of_node->id_entry;
 
 	pdata = match ? match->data : dev->platform_data;
 	if (!pdata)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
