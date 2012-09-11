From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Sep 2012 07:48:15 +0200
Subject: [PATCH] watchdog: ks8695: sink registers into driver
Message-ID: <1347342495-6990-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 70adc3f32adc2fb90b0107c020678588e4cf9f51
"ARM: ks8695: merge the timer header into the timer driver"
accidentally broke the ks8695 watchdog since it was using
the timer registers in watchdog mode.

Perform the same operation here: push the registers down
into the driver, so it is self-contained, and we can keep
depopulating the <mach/*> namespace.

Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Requesting an ACK from the watchdog maintainer so we can
merge this through the ARM SoC tree where the regression
was introduced.

And yes, the drive needs to take resources and ioremap(),
but that is another patch.
---
 drivers/watchdog/ks8695_wdt.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
index 59e75d9..c1a4d3b 100644
--- a/drivers/watchdog/ks8695_wdt.c
+++ b/drivers/watchdog/ks8695_wdt.c
@@ -24,7 +24,19 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <mach/hardware.h>
-#include <mach/regs-timer.h>
+
+#define KS8695_TMR_OFFSET	(0xF0000 + 0xE400)
+#define KS8695_TMR_VA		(KS8695_IO_VA + KS8695_TMR_OFFSET)
+
+/*
+ * Timer registers
+ */
+#define KS8695_TMCON		(0x00)		/* Timer Control Register */
+#define KS8695_T0TC		(0x08)		/* Timer 0 Timeout Count Register */
+#define TMCON_T0EN		(1 << 0)	/* Timer 0 Enable */
+
+/* Timer0 Timeout Counter Register */
+#define T0TC_WATCHDOG		(0xff)		/* Enable watchdog mode */
 
 #define WDT_DEFAULT_TIME	5	/* seconds */
 #define WDT_MAX_TIME		171	/* seconds */
-- 
1.7.11.4
