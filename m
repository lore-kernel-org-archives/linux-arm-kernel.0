From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 16:25:09 +0530
Subject: [PATCH 02/10 v3] Input: omap4-keypad: Fix platform_get_irq's error
 checking
In-Reply-To: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Message-ID: <f317ec56b23b11b79284c29d12a7004575aa35db.1510999558.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
               Return irq insted of -EINVAL.
changes in v3 :
               Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 drivers/input/keyboard/omap4-keypad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 940d38b..9ad840c 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -251,9 +251,9 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
+	if (irq <= 0) {
 		dev_err(&pdev->dev, "no keyboard irq assigned\n");
-		return -EINVAL;
+		return irq;
 	}
 
 	keypad_data = kzalloc(sizeof(struct omap4_keypad), GFP_KERNEL);
-- 
2.7.4
