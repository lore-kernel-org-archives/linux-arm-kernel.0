From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Realview/Versatile: remove useless TIMER_RELOAD
	calculations
References: <git-1267729916-b3b2e99b741f69ced39e5e0f96dbe3564d8b3a21@rmk-PC>
Message-ID: <git-1267729916-abadbdc1887fc6c586b05d17c2b22f00bade49c9@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Realview/Versatile copied the Integrator timer code, including the
calculations for ensuring that the reload value fits into the 16-bit
counter.  However, these platforms have a 32-bit counter which is
clocked at a slower rate.

The result is that the preprocessor conditions are never triggered:
TICKS_PER_uSEC = 1, mSEC_10 = 10000, which is 0x2710 - less than
0x10000.

So, remove the unnecessary complexity, reducing the TIMER_RELOAD
calculation to just:

	TICKS_PER_uSEC * mSEC_10

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-versatile/timer-sp.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-versatile/timer-sp.c b/arch/arm/plat-versatile/timer-sp.c
index 98722f4..d1dbef5 100644
--- a/arch/arm/plat-versatile/timer-sp.c
+++ b/arch/arm/plat-versatile/timer-sp.c
@@ -33,17 +33,7 @@
 /*
  * How long is the timer interval?
  */
-#define TIMER_INTERVAL	(TICKS_PER_uSEC * mSEC_10)
-#if TIMER_INTERVAL >= 0x100000
-#define TIMER_RELOAD	(TIMER_INTERVAL >> 8)
-#define TIMER_DIVISOR	(TIMER_CTRL_DIV256)
-#elif TIMER_INTERVAL >= 0x10000
-#define TIMER_RELOAD	(TIMER_INTERVAL >> 4)		/* Divide by 16 */
-#define TIMER_DIVISOR	(TIMER_CTRL_DIV16)
-#else
-#define TIMER_RELOAD	(TIMER_INTERVAL)
-#define TIMER_DIVISOR	(TIMER_CTRL_DIV1)
-#endif
+#define TIMER_RELOAD	(TICKS_PER_uSEC * mSEC_10)
 
 
 static void __iomem *clksrc_base;
