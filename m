From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:10:12 +0300
Subject: [PATCH 20/22] gpio: clps711x: Remove board support
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-21-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since board support for the CLPS711X platform was removed,
remove the board support from the driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/gpio/gpio-clps711x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
index cd3781e..52fd63f 100644
--- a/drivers/gpio/gpio-clps711x.c
+++ b/drivers/gpio/gpio-clps711x.c
@@ -20,8 +20,12 @@ static int clps711x_gpio_probe(struct platform_device *pdev)
 	void __iomem *dat, *dir;
 	struct gpio_chip *gc;
 	struct resource *res;
-	int err, id = np ? of_alias_get_id(np, "gpio") : pdev->id;
+	int err, id;
 
+	if (!np)
+		return -ENODEV;
+
+	id = of_alias_get_id(np, "gpio");
 	if ((id < 0) || (id > 4))
 		return -ENODEV;
 
@@ -63,7 +67,7 @@ static int clps711x_gpio_probe(struct platform_device *pdev)
 		break;
 	}
 
-	gc->base = id * 8;
+	gc->base = -1;
 	gc->owner = THIS_MODULE;
 	platform_set_drvdata(pdev, gc);
 
-- 
2.4.9
