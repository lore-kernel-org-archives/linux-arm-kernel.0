From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 16:54:25 +0100
Subject: [PATCH] char: nwbutton: avoid unused variable warning
Message-ID: <1453737270-1959897-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_NWBUTTON_REBOOT is disabled, we get a warning about
an unused variable:

drivers/char/nwbutton.c:37:12: warning: 'reboot_count' defined but not used [-Wunused-variable]
 static int reboot_count = NUM_PRESSES_REBOOT; /* Number of presses to reboot */

Using if(IS_ENABLED()) instead of #ifdef around the user makes the
code nicer to read and avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/nwbutton.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/nwbutton.c b/drivers/char/nwbutton.c
index 76c490fa0511..0e184426db98 100644
--- a/drivers/char/nwbutton.c
+++ b/drivers/char/nwbutton.c
@@ -129,10 +129,9 @@ static void button_consume_callbacks (int bpcount)
 
 static void button_sequence_finished (unsigned long parameters)
 {
-#ifdef CONFIG_NWBUTTON_REBOOT		/* Reboot using button is enabled */
-	if (button_press_count == reboot_count)
+	if (IS_ENABLED(CONFIG_NWBUTTON_REBOOT) &&
+	    button_press_count == reboot_count)
 		kill_cad_pid(SIGINT, 1);	/* Ask init to reboot us */
-#endif /* CONFIG_NWBUTTON_REBOOT */
 	button_consume_callbacks (button_press_count);
 	bcount = sprintf (button_output_buffer, "%d\n", button_press_count);
 	button_press_count = 0;		/* Reset the button press counter */
-- 
2.7.0
