From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 17 May 2015 19:27:44 +0300
Subject: [PATCH v3 04/17] input: make LoCoMo keyboard driver support both
 poodle and collie
In-Reply-To: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1431880077-26321-5-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keyboards on collie and poodle differ only in wiring of 'Home' key.
Instead of complicating the driver with platform data, just check for
the machine for the time being. This will be converted to DTS property
sometime in the future.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/input/keyboard/locomokbd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index 1657bc0..b422608 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -33,6 +33,9 @@
 #include <linux/slab.h>
 #include <linux/mfd/locomo.h>
 
+/* There is one minor difference between mappings on poodle and collie */
+#include <asm/mach-types.h>
+
 #define KEY_ACTIVITY		KEY_F16
 #define KEY_CONTACT		KEY_F18
 #define KEY_CENTER		KEY_F15
@@ -45,7 +48,7 @@
 static const unsigned char
 locomokbd_keycode[LOCOMOKBD_NUMKEYS] = {
 	0, KEY_ESC, KEY_ACTIVITY, 0, 0, 0, 0, 0, 0, 0,				/* 0 - 9 */
-	0, 0, 0, 0, 0, 0, 0, KEY_MENU, KEY_HOME, KEY_CONTACT,			/* 10 - 19 */
+	0, 0, 0, 0, 0, 0, 0, KEY_MENU, 0, KEY_CONTACT,				/* 10 - 19 */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,						/* 20 - 29 */
 	0, 0, 0, KEY_CENTER, 0, KEY_MAIL, 0, 0, 0, 0,				/* 30 - 39 */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, KEY_RIGHT,					/* 40 - 49 */
@@ -278,6 +281,11 @@ static int locomokbd_probe(struct platform_device *dev)
 			locomokbd_keycode,
 			sizeof(locomokbd->keycode));
 
+	if (machine_is_collie())
+		locomokbd->keycode[18] = KEY_HOME;
+	else
+		locomokbd->keycode[3] = KEY_HOME;
+
 	for (i = 0; i < LOCOMOKBD_NUMKEYS; i++)
 		input_set_capability(input_dev, EV_KEY, locomokbd->keycode[i]);
 	input_set_capability(input_dev, EV_PWR, KEY_SUSPEND);
-- 
2.1.4
