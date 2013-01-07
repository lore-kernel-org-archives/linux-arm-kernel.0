From: mikedunn@newsguy.com (Mike Dunn)
Date: Mon,  7 Jan 2013 13:55:12 -0800
Subject: [PATCH 1/3] ALSA: pxa27x: fix ac97 cold reset
In-Reply-To: <1357595714-13698-1-git-send-email-mikedunn@newsguy.com>
References: <1357595714-13698-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <1357595714-13698-2-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cold reset on the pxa27x currently fails and

     pxa2xx_ac97_try_cold_reset: cold reset timeout (GSR=0x44)

appears in the kernel log.  Through trial-and-error (the pxa270 developer's
manual is mostly incoherent on the topic of ac97 reset), I got cold reset to
complete by setting the WARM_RST bit in the GCR register (and later noticed that
pxa3xx does this for cold reset as well).  Also, a timeout loop is needed to
wait for the reset to complete.

Tested on a palm treo 680 machine.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 sound/arm/pxa2xx-ac97-lib.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 6fc0ae9..1ecd0a66 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -148,6 +148,8 @@ static inline void pxa_ac97_warm_pxa27x(void)
 
 static inline void pxa_ac97_cold_pxa27x(void)
 {
+	unsigned int timeout;
+
 	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
 	GCR &= ~GCR_COLD_RST;  /* then assert nCRST */
 
@@ -157,8 +159,10 @@ static inline void pxa_ac97_cold_pxa27x(void)
 	clk_enable(ac97conf_clk);
 	udelay(5);
 	clk_disable(ac97conf_clk);
-	GCR = GCR_COLD_RST;
-	udelay(50);
+	GCR = GCR_COLD_RST | GCR_WARM_RST;
+	timeout = 100;     /* wait for the codec-ready bit to be set */
+	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
+		mdelay(1);
 }
 #endif
 
-- 
1.7.8.6
