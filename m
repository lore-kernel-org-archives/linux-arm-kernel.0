From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 16:25:10 +0530
Subject: [PATCH 03/10 v3] Input: twl4030_keypad: Fix platform_get_irq's error
 checking
In-Reply-To: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Message-ID: <d5ca46d63a41f47411b94c6035d3b8c46bbe8503.1510999558.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              kp->irq is unsigned. use temporary int variable irq.
changes in v3 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 drivers/input/keyboard/twl4030_keypad.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index f9f98ef..d921238 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -341,6 +341,7 @@ static int twl4030_kp_probe(struct platform_device *pdev)
 	struct input_dev *input;
 	u8 reg;
 	int error;
+	int irq;
 
 	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
 	if (!kp)
@@ -388,11 +389,12 @@ static int twl4030_kp_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	kp->irq = platform_get_irq(pdev, 0);
-	if (!kp->irq) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
 		dev_err(&pdev->dev, "no keyboard irq assigned\n");
-		return -EINVAL;
+		return irq;
 	}
+	kp->irq = irq;
 
 	error = matrix_keypad_build_keymap(keymap_data, NULL,
 					   TWL4030_MAX_ROWS,
-- 
2.7.4
