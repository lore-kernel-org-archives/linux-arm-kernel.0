From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 20 Jul 2016 20:16:28 +0200
Subject: [PATCH 2/3] mmc: sunxi: Set the 'New Timing' register for 8 bits DDR
 transfers
In-Reply-To: <cover.1469082481.git.moinejf@free.fr>
References: <cover.1469082481.git.moinejf@free.fr>
Message-ID: <bc7b767cad6db159a44c4b98d5b1f3eb53c26bd3.1469082481.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'new timing mode' with 8 bits DDR works correctly when the NewTiming
register is set.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
Note about the 'new timing mode'.

This patch assumes that, when the new mode is used, the clock driver
sets the mode select in the MMC clock and multiplies the clock rate
by 2:
- MMC side:
  - with a timing 8 bits DDR at 50MHz, the MMC driver calls
    clk_set_rate() with a rate 50*2 = 100MHz,
- clock side:
  - the clock driver sets the hardware MMC clock to 100*2 = 200MHz,
  - setting the 'mode select' of the hardware MMC clock divides the
    rate by 2,
- MMC side:
  - setting the MMC clock divider register to 1 divides the rate by 2.
So, the final rate is 50MHz.

For this to work, the clock driver must know when the 'mode select'
is used.
Instead of using a new special clock function, in my driver, the
'mode select' capable clocks are declared as such with an associated
rate (actually, mmc2 in A83T, and mmc{1,2} in H3).
When this rate is asked for (100MHz), the mode select is set.
This works without change in the MMC driver. If a 100MHz rate would be
used without 'mode select' for such clocks, an other mechanism should
be found (information in the low bits of the rate?).
---
 drivers/mmc/host/sunxi-mmc.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index ba647b7..7f9c31a 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -64,6 +64,7 @@
 #define SDXC_REG_CBCR	(0x48) /* SMC CIU Byte Count Register */
 #define SDXC_REG_BBCR	(0x4C) /* SMC BIU Byte Count Register */
 #define SDXC_REG_DBGC	(0x50) /* SMC Debug Enable Register */
+#define SDXC_REG_NTSR	(0x5c) /* SMC NewTiming Set Register */
 #define SDXC_REG_HWRST	(0x78) /* SMC Card Hardware Reset for Register */
 #define SDXC_REG_DMAC	(0x80) /* SMC IDMAC Control Register */
 #define SDXC_REG_DLBA	(0x84) /* SMC IDMAC Descriptor List Base Addre */
@@ -171,6 +172,9 @@
 #define SDXC_SEND_AUTO_STOPCCSD		BIT(9)
 #define SDXC_CEATA_DEV_IRQ_ENABLE	BIT(10)
 
+/* NewTiming Set Register */
+#define SDXC_NEWMODE_ENABLE		BIT(31)
+
 /* IDMA controller bus mod bit field */
 #define SDXC_IDMAC_SOFT_RESET		BIT(0)
 #define SDXC_IDMAC_FIX_BURST		BIT(1)
@@ -661,10 +665,20 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	u32 clock = ios->clock;
 	int ret;
 
-	/* 8 bit DDR requires a higher module clock */
-	if (ios->timing == MMC_TIMING_MMC_DDR52 &&
-	    ios->bus_width == MMC_BUS_WIDTH_8)
-		clock <<= 1;
+	/*
+	 * 8 bit DDR requires a higher module clock
+	 * and the 'new mode'
+	 */
+	if (ios->bus_width == MMC_BUS_WIDTH_8) {	/* eMMC */
+		rval = mmc_readl(host, REG_NTSR);
+		if (ios->timing == MMC_TIMING_MMC_DDR52) {
+			clock <<= 1;
+			rval |= SDXC_NEWMODE_ENABLE;
+		} else {
+			rval &= ~SDXC_NEWMODE_ENABLE;
+		}
+		mmc_writel(host, REG_NTSR, rval);
+	}
 
 	rate = clk_round_rate(host->clk_mmc, clock);
 	if (rate < 0) {
-- 
2.9.2
