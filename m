From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 17 Oct 2013 14:01:35 +0400
Subject: [PATCH 1/3] ALSA: pxa: slightly refactor reset handling
Message-ID: <1382004097-6350-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA25x also shows some problems when using interrupts during reset
handling. Thus do not use interrupts on all pxa kinds (to detect codec
ready state). Instead use a common mdelay-loop on all platforms to
detect codecs becoming ready.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 sound/arm/pxa2xx-ac97-lib.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index e6f4633..99a4668 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -117,8 +117,7 @@ static inline void pxa_ac97_warm_pxa25x(void)
 {
 	gsr_bits = 0;
 
-	GCR |= GCR_WARM_RST | GCR_PRIRDY_IEN | GCR_SECRDY_IEN;
-	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
+	GCR |= GCR_WARM_RST;
 }
 
 static inline void pxa_ac97_cold_pxa25x(void)
@@ -129,8 +128,6 @@ static inline void pxa_ac97_cold_pxa25x(void)
 	gsr_bits = 0;
 
 	GCR = GCR_COLD_RST;
-	GCR |= GCR_CDONE_IE|GCR_SDONE_IE;
-	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
 }
 #endif
 
@@ -149,8 +146,6 @@ static inline void pxa_ac97_warm_pxa27x(void)
 
 static inline void pxa_ac97_cold_pxa27x(void)
 {
-	unsigned int timeout;
-
 	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
 	GCR &= ~GCR_COLD_RST;  /* then assert nCRST */
 
@@ -161,29 +156,20 @@ static inline void pxa_ac97_cold_pxa27x(void)
 	udelay(5);
 	clk_disable(ac97conf_clk);
 	GCR = GCR_COLD_RST | GCR_WARM_RST;
-	timeout = 100;     /* wait for the codec-ready bit to be set */
-	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
-		mdelay(1);
 }
 #endif
 
 #ifdef CONFIG_PXA3xx
 static inline void pxa_ac97_warm_pxa3xx(void)
 {
-	int timeout = 100;
-
 	gsr_bits = 0;
 
 	/* Can't use interrupts */
 	GCR |= GCR_WARM_RST;
-	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
-		mdelay(1);
 }
 
 static inline void pxa_ac97_cold_pxa3xx(void)
 {
-	int timeout = 1000;
-
 	/* Hold CLKBPB for 100us */
 	GCR = 0;
 	GCR = GCR_CLKBPB;
@@ -199,14 +185,13 @@ static inline void pxa_ac97_cold_pxa3xx(void)
 	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
 
 	GCR = GCR_WARM_RST | GCR_COLD_RST;
-	while (!(GSR & (GSR_PCR | GSR_SCR)) && timeout--)
-		mdelay(10);
 }
 #endif
 
 bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
 {
 	unsigned long gsr;
+	unsigned int timeout = 100;
 
 #ifdef CONFIG_PXA25x
 	if (cpu_is_pxa25x())
@@ -224,6 +209,10 @@ bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
 	else
 #endif
 		BUG();
+
+	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
+		mdelay(1);
+
 	gsr = GSR | gsr_bits;
 	if (!(gsr & (GSR_PCR | GSR_SCR))) {
 		printk(KERN_INFO "%s: warm reset timeout (GSR=%#lx)\n",
@@ -239,6 +228,7 @@ EXPORT_SYMBOL_GPL(pxa2xx_ac97_try_warm_reset);
 bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 {
 	unsigned long gsr;
+	unsigned int timeout = 1000;
 
 #ifdef CONFIG_PXA25x
 	if (cpu_is_pxa25x())
@@ -257,6 +247,9 @@ bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 #endif
 		BUG();
 
+	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
+		mdelay(1);
+
 	gsr = GSR | gsr_bits;
 	if (!(gsr & (GSR_PCR | GSR_SCR))) {
 		printk(KERN_INFO "%s: cold reset timeout (GSR=%#lx)\n",
-- 
1.8.4.rc3
