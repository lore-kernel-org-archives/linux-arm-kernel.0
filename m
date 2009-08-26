From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 26 Aug 2009 10:56:28 +0200
Subject: [PATCH] Make MMCI driver compile without gpiolib
Message-ID: <1251276988-27882-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent addition of optional gpiolib support to check if a
card was inserted or write protected was really not optional.
It needs this ifdef to become optional so that U300 compiles,
for example.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5eb86a8..a923ee2 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -619,6 +619,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	writel(0, host->base + MMCIMASK1);
 	writel(0xfff, host->base + MMCICLEAR);
 
+#ifdef CONFIG_GPIOLIB
 	if (gpio_is_valid(plat->gpio_cd)) {
 		ret = gpio_request(plat->gpio_cd, DRIVER_NAME " (cd)");
 		if (ret == 0)
@@ -637,6 +638,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 		else if (ret != -ENOSYS)
 			goto err_gpio_wp;
 	}
+#endif
 
 	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED, DRIVER_NAME " (cmd)", host);
 	if (ret)
-- 
1.6.2.1
