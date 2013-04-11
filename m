From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 11 Apr 2013 21:23:22 +0400
Subject: [PATCH] GPIO: gpio-generic: Remove kfree() from bgpio_remove call
Message-ID: <1365701002-17292-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory for basic-mmio-gpio driver is allocated by resource managed
function, so using kfree() call in bgpio_remove is wrong.
This patch eliminates this kfree() call.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/gpio/gpio-generic.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
index 42d4706..d2196bf 100644
--- a/drivers/gpio/gpio-generic.c
+++ b/drivers/gpio/gpio-generic.c
@@ -390,11 +390,7 @@ static int bgpio_setup_direction(struct bgpio_chip *bgc,
 
 int bgpio_remove(struct bgpio_chip *bgc)
 {
-	int err = gpiochip_remove(&bgc->gc);
-
-	kfree(bgc);
-
-	return err;
+	return gpiochip_remove(&bgc->gc);
 }
 EXPORT_SYMBOL_GPL(bgpio_remove);
 
-- 
1.8.1.5
