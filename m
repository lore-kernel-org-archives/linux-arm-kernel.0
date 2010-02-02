From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:24 -0800
Subject: [PATCH 12/16] ARM: LPC32XX: Watchdog reset type and sparse fixes
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-13-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Changed the type used with the watchdog reset writel() function
to use void __iomem *

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/common.c |    7 ++++---
 arch/arm/mach-lpc32xx/common.h |    2 ++
 arch/arm/mach-lpc32xx/irq.c    |    1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 2a97ce0..1efa3d1 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -36,7 +36,8 @@
 #include <mach/platform.h>
 #include "common.h"
 
-#define WDT_IOBASE io_p2v(LPC32XX_WDTIM_BASE)
+#define WDT_IOACCESS(x)	(__force void __iomem *)\
+	io_p2v(LPC32XX_WDTIM_BASE + (x))
 
 /*
  * Watchdog timer
@@ -135,8 +136,8 @@ void lpc32xx_watchdog_reset(void)
 		LPC32XX_CLKPWR_TIMER_CLK_CTRL(CLKPWR_IOBASE));
 
 	/* Instand assert of RESETOUT_N with pulse length 1mS */
-	writel(13000, WDT_IOBASE + 0x18);
-	writel(0x70, WDT_IOBASE + 0xC);
+	writel(13000, WDT_IOACCESS(0x18));
+	writel(0x70, WDT_IOACCESS(0xC));
 }
 
 /*
diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
index 08fdfba..42c758e 100644
--- a/arch/arm/mach-lpc32xx/common.h
+++ b/arch/arm/mach-lpc32xx/common.h
@@ -73,4 +73,6 @@ extern void lpc32xx_get_uid(u32 devid[4]);
 extern void printascii(const char *);
 #endif
 
+extern void lpc32xx_watchdog_reset(void);
+
 #endif
diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
index 3266856..a3ea5cc 100644
--- a/arch/arm/mach-lpc32xx/irq.c
+++ b/arch/arm/mach-lpc32xx/irq.c
@@ -30,6 +30,7 @@
 #include <mach/irqs.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
+#include "common.h"
 
 /*
  * Default value represeting the Activation polarity of all internal
-- 
1.6.6
