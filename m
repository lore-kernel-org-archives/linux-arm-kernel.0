From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Jun 2015 23:06:50 +0100
Subject: [PATCH 7/9] gpio: gpio-tegra: fix race in installing chained IRQ
 handler
Message-ID: <E1Z4z0M-0002Sl-Ti@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a race where a pending interrupt could be received and the handler
called before the handler's data has been setup, by converting to
irq_set_chained_handler_and_data().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Depends on patch 1.

 drivers/gpio/gpio-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 1741981d53c8..56dcc8ed98de 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -515,8 +515,8 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 	for (i = 0; i < tegra_gpio_bank_count; i++) {
 		bank = &tegra_gpio_banks[i];
 
-		irq_set_chained_handler(bank->irq, tegra_gpio_irq_handler);
-		irq_set_handler_data(bank->irq, bank);
+		irq_set_chained_handler_and_data(bank->irq,
+						 tegra_gpio_irq_handler, bank);
 
 		for (j = 0; j < 4; j++)
 			spin_lock_init(&bank->lvl_lock[j]);
-- 
2.1.0
