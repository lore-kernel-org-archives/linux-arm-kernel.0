From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Aug 2012 20:27:02 +0200
Subject: [PATCH 2/4] ARM: ks8695: use [readl|writel]_relaxed()
Message-ID: <1346264822-20347-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have no clue why __raw* macros are used here, but I strongly
suspect there is no good reason at all for this, so removing
another bad example.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ks8695/time.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-ks8695/time.c b/arch/arm/mach-ks8695/time.c
index 6427b7c..ae9dacc 100644
--- a/arch/arm/mach-ks8695/time.c
+++ b/arch/arm/mach-ks8695/time.c
@@ -67,11 +67,11 @@ static unsigned long ks8695_gettimeoffset (void)
 	 * interrupt.  We solve this by ensuring that the counter has not
 	 * reloaded between our two reads.
 	 */
-	elapsed = __raw_readl(KS8695_TMR_VA + KS8695_T1TC) + __raw_readl(KS8695_TMR_VA + KS8695_T1PD);
+	elapsed = readl_relaxed(KS8695_TMR_VA + KS8695_T1TC) + readl_relaxed(KS8695_TMR_VA + KS8695_T1PD);
 	do {
 		tick2 = elapsed;
-		intpending = __raw_readl(KS8695_IRQ_VA + KS8695_INTST) & (1 << KS8695_IRQ_TIMER1);
-		elapsed = __raw_readl(KS8695_TMR_VA + KS8695_T1TC) + __raw_readl(KS8695_TMR_VA + KS8695_T1PD);
+		intpending = readl_relaxed(KS8695_IRQ_VA + KS8695_INTST) & (1 << KS8695_IRQ_TIMER1);
+		elapsed = readl_relaxed(KS8695_TMR_VA + KS8695_T1TC) + readl_relaxed(KS8695_TMR_VA + KS8695_T1PD);
 	} while (elapsed > tick2);
 
 	/* Convert to number of ticks expired (not remaining) */
@@ -106,14 +106,14 @@ static void ks8695_timer_setup(void)
 	unsigned long tmcon;
 
 	/* disable timer1 */
-	tmcon = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
-	__raw_writel(tmcon & ~TMCON_T1EN, KS8695_TMR_VA + KS8695_TMCON);
+	tmcon = readl_relaxed(KS8695_TMR_VA + KS8695_TMCON);
+	writel_relaxed(tmcon & ~TMCON_T1EN, KS8695_TMR_VA + KS8695_TMCON);
 
-	__raw_writel(tmout / 2, KS8695_TMR_VA + KS8695_T1TC);
-	__raw_writel(tmout / 2, KS8695_TMR_VA + KS8695_T1PD);
+	writel_relaxed(tmout / 2, KS8695_TMR_VA + KS8695_T1TC);
+	writel_relaxed(tmout / 2, KS8695_TMR_VA + KS8695_T1PD);
 
 	/* re-enable timer1 */
-	__raw_writel(tmcon | TMCON_T1EN, KS8695_TMR_VA + KS8695_TMCON);
+	writel_relaxed(tmcon | TMCON_T1EN, KS8695_TMR_VA + KS8695_TMCON);
 }
 
 static void __init ks8695_timer_init (void)
@@ -138,12 +138,12 @@ void ks8695_restart(char mode, const char *cmd)
 		soft_restart(0);
 
 	/* disable timer0 */
-	reg = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
-	__raw_writel(reg & ~TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
+	reg = readl_relaxed(KS8695_TMR_VA + KS8695_TMCON);
+	writel_relaxed(reg & ~TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
 
 	/* enable watchdog mode */
-	__raw_writel((10 << 8) | T0TC_WATCHDOG, KS8695_TMR_VA + KS8695_T0TC);
+	writel_relaxed((10 << 8) | T0TC_WATCHDOG, KS8695_TMR_VA + KS8695_T0TC);
 
 	/* re-enable timer0 */
-	__raw_writel(reg | TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
+	writel_relaxed(reg | TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
 }
-- 
1.7.7.6
