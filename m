From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 01:50:01 +0530
Subject: [PATCH 1/10 v2] Input: ep93xx_keypad: Fix platform_get_irq's error
 checking
Message-ID: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510949239.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2c:
               Return keypad->irq insted of -ENXIO.

 drivers/input/keyboard/ep93xx_keypad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index f77b295..01788a7 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -257,8 +257,8 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	}
 
 	keypad->irq = platform_get_irq(pdev, 0);
-	if (!keypad->irq) {
-		err = -ENXIO;
+	if (keypad->irq < 0) {
+		err = keypad->irq;
 		goto failed_free;
 	}
 
-- 
2.7.4
