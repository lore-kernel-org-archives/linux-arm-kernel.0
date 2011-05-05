From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 5 May 2011 13:14:07 +0200
Subject: [PATCH 1/2] mmci: trigger card detect IRQs on falling and rising edges
Message-ID: <1304594047-19374-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Right now the card detect IRQ for MMCI is requested without any
flags which will give some default machine-specified IRQ
behaviour. However on the U300 rising+falling edges (such as can
be expected from a simple GPIO to generate when inserting/removing
a card) need to be requested explicitly.

Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 4941e06..6e27433 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1128,9 +1128,17 @@ static int __devinit mmci_probe(struct amba_device *dev,
 		else if (ret != -ENOSYS)
 			goto err_gpio_cd;
 
+		/*
+		 * A gpio pin that will detect cards when inserted and removed
+		 * will most likely want to trigger on the edges if it is
+		 * 0 when ejected and 1 when inserted (or mutatis mutandis
+		 * for the inverted case) so we request triggers on both
+		 * edges.
+		 */
 		ret = request_any_context_irq(gpio_to_irq(plat->gpio_cd),
-					      mmci_cd_irq, 0,
-					      DRIVER_NAME " (cd)", host);
+				mmci_cd_irq,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				DRIVER_NAME " (cd)", host);
 		if (ret >= 0)
 			host->gpio_cd_irq = gpio_to_irq(plat->gpio_cd);
 	}
-- 
1.7.3.2
