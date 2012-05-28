From: alexg@meprolight.com (Alex Gershgorin)
Date: Mon, 28 May 2012 15:13:31 +0300
Subject: [PATCH] ARM: i.MX: Keypad prepare/unprepare clock
Message-ID: <1338207211-14637-1-git-send-email-alexg@meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alex Gershgorin <alexg@meprolight.com>
---
 drivers/input/keyboard/imx_keypad.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 6ee7421..9d57945 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -378,7 +378,7 @@ static void imx_keypad_close(struct input_dev *dev)
 	imx_keypad_inhibit(keypad);
 
 	/* Disable clock unit */
-	clk_disable(keypad->clk);
+	clk_disable_unprepare(keypad->clk);
 }
 
 static int imx_keypad_open(struct input_dev *dev)
@@ -391,7 +391,7 @@ static int imx_keypad_open(struct input_dev *dev)
 	keypad->enabled = true;
 
 	/* Enable the kpp clock */
-	clk_enable(keypad->clk);
+	clk_prepare_enable(keypad->clk);
 	imx_keypad_config(keypad);
 
 	/* Sanity control, not all the rows must be actived now. */
@@ -581,7 +581,7 @@ static int imx_kbd_suspend(struct device *dev)
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-		clk_disable(kbd->clk);
+		clk_disable_unprepare(kbd->clk);
 
 	mutex_unlock(&input_dev->mutex);
 
@@ -603,7 +603,7 @@ static int imx_kbd_resume(struct device *dev)
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-		clk_enable(kbd->clk);
+		clk_prepare_enable(kbd->clk);
 
 	mutex_unlock(&input_dev->mutex);
 
-- 
1.7.0.4
