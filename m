From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 26 Feb 2012 16:50:50 +0300
Subject: [PATCH] ARM: pxa27x_keypad: clear pending interrupts on keypad config
Message-ID: <1330264250-5883-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bootloader can leave interrupt bit pending, and it confuses driver.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/input/keyboard/pxa27x_keypad.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index eca6ae6..a5f198f 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -360,6 +360,9 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
 	unsigned int mask = 0, direct_key_num = 0;
 	unsigned long kpc = 0;
 
+	/* clear pending interrupt bit */
+	keypad_readl(KPC);
+
 	/* enable matrix keys with automatic scan */
 	if (pdata->matrix_key_rows && pdata->matrix_key_cols) {
 		kpc |= KPC_ASACT | KPC_MIE | KPC_ME | KPC_MS_ALL;
-- 
1.7.9.2
