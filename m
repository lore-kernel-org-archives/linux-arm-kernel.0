From: romain.izard.pro@gmail.com (Romain Izard)
Date: Thu, 19 Oct 2017 18:42:06 +0200
Subject: [PATCH v5 2/3] clk: at91: pmc: Save SCSR during suspend
In-Reply-To: <20171019164207.32717-1-romain.izard.pro@gmail.com>
References: <20171019164207.32717-1-romain.izard.pro@gmail.com>
Message-ID: <20171019164207.32717-3-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The contents of the System Clock Status Register (SCSR) needs to be
restored into the System Clock Enable Register (SCER).

As the bootloader will restore some clocks by itself, the issue can be
missed as only the USB controller, the LCD controller, the Image Sensor
controller and the programmable clocks will be impacted.

Fix the obvious typo in the suspend/resume code, as the IMR register
does not need to be saved twice.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/clk/at91/pmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 5c2b26de303e..07dc2861ad3f 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -86,7 +86,7 @@ static int pmc_suspend(void)
 {
 	int i;
 
-	regmap_read(pmcreg, AT91_PMC_IMR, &pmc_cache.scsr);
+	regmap_read(pmcreg, AT91_PMC_SCSR, &pmc_cache.scsr);
 	regmap_read(pmcreg, AT91_PMC_PCSR, &pmc_cache.pcsr0);
 	regmap_read(pmcreg, AT91_CKGR_UCKR, &pmc_cache.uckr);
 	regmap_read(pmcreg, AT91_CKGR_MOR, &pmc_cache.mor);
@@ -129,7 +129,7 @@ static void pmc_resume(void)
 	if (pmc_cache.pllar != tmp)
 		pr_warn("PLLAR was not configured properly by the firmware\n");
 
-	regmap_write(pmcreg, AT91_PMC_IMR, pmc_cache.scsr);
+	regmap_write(pmcreg, AT91_PMC_SCER, pmc_cache.scsr);
 	regmap_write(pmcreg, AT91_PMC_PCER, pmc_cache.pcsr0);
 	regmap_write(pmcreg, AT91_CKGR_UCKR, pmc_cache.uckr);
 	regmap_write(pmcreg, AT91_CKGR_MOR, pmc_cache.mor);
-- 
2.11.0
