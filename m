From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 28 Oct 2012 18:46:03 +0300
Subject: [PATCH RESEND] ARM: pxa27x_keypad: clear pending interrupts on keypad
 config
Message-ID: <1351439163-9575-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bootloader can leave interrupt bit pending, and it confuses driver.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
Rebased against v3.7-rc2

 drivers/input/keyboard/pxa27x_keypad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 803ff6f..cad9d5d 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -368,6 +368,9 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
 	unsigned int mask = 0, direct_key_num = 0;
 	unsigned long kpc = 0;
 
+	/* clear pending interrupt bit */
+	keypad_readl(KPC);
+
 	/* enable matrix keys with automatic scan */
 	if (pdata->matrix_key_rows && pdata->matrix_key_cols) {
 		kpc |= KPC_ASACT | KPC_MIE | KPC_ME | KPC_MS_ALL;
-- 
1.7.12.4
