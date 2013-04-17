From: cedric@precidata.com (Cedric Berger)
Date: Wed, 17 Apr 2013 22:42:51 +0200 (CEST)
Subject: [PATCH 3/10] LPC32XX: 003-mmc.1: Don't access private fields in MMC
 controller
Message-ID: <mailman.12.1366231384.1198.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gabriele Mondada <gabriele@precidata.com>
---
The mmci_set_clkreg() function violates its general contract by accessing
directly private host->mmc fields. This prevents us from implementing a MUX
on top of this driver. Fix that by changing slightly the function prototype.

Index: drivers/mmc/host/mmci.c
===================================================================
--- drivers/mmc/host/mmci.c	(revision 1726)
+++ drivers/mmc/host/mmci.c	(revision 1727)
@@ -207,10 +207,11 @@
 /*
  * This must be called with host->lock held
  */
-static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
+static void mmci_set_clkreg(struct mmci_host *host, struct mmc_ios *ios)
 {
 	struct variant_data *variant = host->variant;
 	u32 clk = variant->clkreg;
+	unsigned int desired = ios->clock;
 
 	if (desired) {
 		if (desired >= host->mclk) {
@@ -246,12 +247,12 @@
 		/* clk |= MCI_CLK_PWRSAVE; */
 	}
 
-	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4)
+	if (ios->bus_width == MMC_BUS_WIDTH_4)
 		clk |= MCI_4BIT_BUS;
-	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8)
+	if (ios->bus_width == MMC_BUS_WIDTH_8)
 		clk |= MCI_ST_8BIT_BUS;
 
-	if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
+	if (ios->timing == MMC_TIMING_UHS_DDR50)
 		clk |= MCI_ST_UX500_NEG_EDGE;
 
 	mmci_write_clkreg(host, clk);
@@ -1319,7 +1320,7 @@
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	mmci_set_clkreg(host, ios->clock);
+	mmci_set_clkreg(host, ios);
 	mmci_write_pwrreg(host, pwr);
 
 	spin_unlock_irqrestore(&host->lock, flags);
