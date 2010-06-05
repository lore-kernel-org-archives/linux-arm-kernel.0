From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat,  5 Jun 2010 02:46:48 +0200
Subject: [PATCH] pxa2xx/cpufreq: Fix DRI computation
Message-ID: <1275698808-31166-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRI field was incorrectly computed, causing various hangs and weird
behaviour on PXA2xx machines. This patch introduces the DRI computation
according to the PXA255 (January 2004) and PXA270 (MV-S301039-00 Rev. A)
datasheets.

NOTE: The CPU type is checked only once, so the code is a little bit faster now.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/cpufreq-pxa2xx.c |   33 +++++++++++++++++++++++++++++----
 1 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
index 9e4d981..5373db0 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
@@ -251,17 +251,42 @@ static void init_sdram_rows(void)
 	if (mdcnfg & (MDCNFG_DE0 | MDCNFG_DE1))
 		drac0 = MDCNFG_DRAC0(mdcnfg);
 
-	sdram_rows = 1 << (11 + max(drac0, drac2));
+	sdram_rows = 11 + max(drac0, drac2);
 }
 
 static u32 mdrefr_dri(unsigned int freq)
 {
 	u32 dri = 0;
 
-	if (cpu_is_pxa25x())
-		dri = ((freq * SDRAM_TREF) / (sdram_rows * 32));
+	/* 
+	 * PXA255 (6.5.3):
+	 * 	DRI = (Refresh time / rows * memory clock frequency) / 32
+	 * PXA270 (Table 91):
+	 * 	DRI = (Refresh time / rows * memory clock frequency - 31) / 32
+	 * 
+	 * Memory clock frequency is in MHz here! (Refresh time is in ms).
+	 */
+
+	/*
+	 * SDRAM_TREF	Refresh time
+	 * freq		Memory clock frequency (in kHz)
+	 * sdram_rows	Rows
+	 *
+	 * Here we do the common part for both CPUs:
+	 * 	(Refresh time / rows * memory clock frequency)
+	 *
+	 * NOTE: We must convert freq from kHz to MHz, but we do the
+	 * multiplication prior to division to retain percision.
+	 */
+	dri = (SDRAM_TREF * freq) / (sdram_rows * 1000);
+
+	/* On PXA27x, substitute 31 from the value first (Table 91). */
 	if (cpu_is_pxa27x())
-		dri = ((freq * SDRAM_TREF) / (sdram_rows - 31)) / 32;
+		dri -= 31;
+
+	/* Finaly, divide the result by 32. */
+	dri /= 32;
+
 	return dri;
 }
 
-- 
1.7.1
