From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 22 Jul 2013 22:54:33 +0200
Subject: [PATCH v5 02/20] clocksource: samsung_pwm_timer: Correct definition
 of AUTORELOAD bit
In-Reply-To: <1374278673-25615-4-git-send-email-tomasz.figa@gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <1374278673-25615-4-git-send-email-tomasz.figa@gmail.com>
Message-ID: <3872385.JQ2jXzack4@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PWM channel 4 has its autoreload bit located at different position. This
patch fixes the driver to account for that.

This fixes a problem with the clocksource hanging after it overflows because
it is not reloaded any more.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Changes since v4:
 - made the new definition more readable.

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 3fa5b07..89947c3 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -47,7 +47,11 @@
 #define TCON_START(chan)		(1 << (4 * (chan) + 0))
 #define TCON_MANUALUPDATE(chan)		(1 << (4 * (chan) + 1))
 #define TCON_INVERT(chan)		(1 << (4 * (chan) + 2))
-#define TCON_AUTORELOAD(chan)		(1 << (4 * (chan) + 3))
+#define _TCON_AUTORELOAD(chan)		(1 << (4 * (chan) + 3))
+#define _TCON_AUTORELOAD4(chan)		(1 << (4 * (chan) + 2))
+/* Position of autoreload bit of channel 4 (5 in TCON reg.) is different. */
+#define TCON_AUTORELOAD(chan)		\
+	((chan < 5) ? _TCON_AUTORELOAD(chan) : _TCON_AUTORELOAD4(chan))
 
 DEFINE_SPINLOCK(samsung_pwm_lock);
 EXPORT_SYMBOL(samsung_pwm_lock);
-- 
1.8.3.2
