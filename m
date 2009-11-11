From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Wed, 11 Nov 2009 11:00:03 -0800
Subject: [PATCH] omap: Fix omapfb/lcdc on OMAP1510 broken when PM set
Message-ID: <mailman.15.1257966407.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_PM=y, the omapfb/lcdc device on Amstrad Delta, after initially
starting correctly, breaks with the following error messages:

omapfb omapfb: resetting (status 0xffffff96,reset count 1)
...
omapfb omapfb: resetting (status 0xffffff96,reset count 100)
omapfb omapfb: too many reset attempts, giving up.

Looking closer at this I have found that it had been broken almost 2 years ago
with commit 2418996e3b100114edb2ae110d5d4acb928909d2, PM fixes for OMAP1.

The definite reason for broken omapfb/lcdc behavoiur in PM mode
appeared to be ARM_IDLECT1:IDLIF_ARM (bit 6) put into idle regardless of LCD
DMA possibly running. The bit were set based on return value of the
omap_dma_running() function that did not check for dedicated LCD DMA
channel status. The patch below fixes this.

Note that the hardcoded register value will be fixed during the next merge
cycle to use OMAP_LCDC_ defines. Currently the OMAP_LCDC_ defines are local
to drivers/video/omap/lcdc.c, so let's not start moving those right now.

Created against linux-2.6.32-rc6

Tested on Amstrad Delta

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 02ed945..68eaae3 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1114,6 +1114,14 @@ int omap_dma_running(void)
 {
 	int lch;
 
+	/*
+	 * On OMAP1510, internal LCD controller will start the transfer
+	 * when it gets enabled, so assume DMA running if LCD enabled.
+	 */
+	if (cpu_is_omap1510())
+		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
+			return 1;
+
 	/* Check if LCD DMA is running */
 	if (cpu_is_omap16xx())
 		if (omap_readw(OMAP1610_DMA_LCD_CCR) & OMAP_DMA_CCR_EN)
