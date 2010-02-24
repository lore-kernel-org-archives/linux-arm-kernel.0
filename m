From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 24 Feb 2010 22:49:49 +0100
Subject: [PATCH] ARM: MMCI: support 8bit mode on the ST Micro version
Message-ID: <1267048189-16386-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for an 8bit wide bus to the card (data lines
MCIDAT0 through 7 exist) on the ST Micro version and alters the
U300 platform to support this.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
----
This thing comes in on top of the DMA and all, no hurries to get
this in really so it's pending conclusion of the DMA debate
and will be rewritten if need be.
---
 arch/arm/mach-u300/mmc.c |    2 +-
 drivers/mmc/host/mmci.c  |   10 +++++++++-
 drivers/mmc/host/mmci.h  |    4 +++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
index 8f6d8af..e40bfec 100644
--- a/arch/arm/mach-u300/mmc.c
+++ b/arch/arm/mach-u300/mmc.c
@@ -109,7 +109,7 @@ int __devinit mmc_init(struct amba_device *adev)
 	mmci_card->mmc0_plat_data.gpio_wp = -1;
 	mmci_card->mmc0_plat_data.gpio_cd = -1;
 	mmci_card->mmc0_plat_data.capabilities = MMC_CAP_MMC_HIGHSPEED |
-		MMC_CAP_SD_HIGHSPEED | MMC_CAP_4_BIT_DATA;
+		MMC_CAP_SD_HIGHSPEED | MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
 #ifdef CONFIG_DMA_ENGINE
 	mmci_card->mmc0_plat_data.dma_filter = coh901318_filter_id;
 	mmci_card->mmc0_plat_data.dma_rx_param =
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index a95c72a..3804151 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -65,7 +65,15 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	}
 
 	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4)
-		clk |= MCI_WIDE_BUS;
+		clk |= MCI_4BIT_BUS;
+
+	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
+		if (host->hw_designer == AMBA_VENDOR_ST)
+			clk |= MCI_8BIT_BUS;
+		else
+			dev_err(mmc_dev(host->mmc),
+				"8bit bus mode requested but not available\n");
+	}
 
 	writel(clk, host->base + MMCICLOCK);
 }
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 13557e9..9b09d15 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -25,7 +25,9 @@
 #define MCI_CLK_ENABLE		(1 << 8)
 #define MCI_CLK_PWRSAVE		(1 << 9)
 #define MCI_CLK_BYPASS		(1 << 10)
-#define MCI_WIDE_BUS		(1 << 11)
+#define MCI_4BIT_BUS		(1 << 11)
+/* The ST Micro version has an 8bit mode as well */
+#define MCI_8BIT_BUS		(1 << 12)
 /* HW flow control on the ST Micro version */
 #define MCI_FCEN		(1 << 13)
 
-- 
1.6.3.3
