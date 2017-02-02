From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 19:51:52 +0100
Subject: [PATCH 02/23] PMC backup
In-Reply-To: <20170202185213.21698-1-alexandre.belloni@free-electrons.com>
References: <20170202185213.21698-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170202185213.21698-2-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clk/at91/clk-main.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index c813c27f2e58..63be69cd1437 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/syscore_ops.h>
 
 #include "pmc.h"
 
@@ -584,6 +585,73 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
 	return hw;
 }
 
+struct regmap *pmcreg;
+
+static struct
+{
+	u32 scsr;
+	u32 pcsr0;
+	u32 uckr;
+	u32 mor;
+	u32 mcfr;
+	u32 pllar;
+	u32 mckr;
+	u32 usb;
+	u32 imr;
+	u32 pcsr1;
+	u32 pcr[64];
+} pmc_cache;
+
+
+static int pmc_suspend(void)
+{
+	int i;
+
+	regmap_read(pmcreg, AT91_PMC_IMR, &pmc_cache.scsr);
+	regmap_read(pmcreg, AT91_PMC_PCSR, &pmc_cache.pcsr0);
+	regmap_read(pmcreg, AT91_CKGR_UCKR, &pmc_cache.uckr);
+	regmap_read(pmcreg, AT91_CKGR_MOR, &pmc_cache.mor);
+	regmap_read(pmcreg, AT91_CKGR_MCFR, &pmc_cache.mcfr);
+	regmap_read(pmcreg, AT91_CKGR_PLLAR, &pmc_cache.pllar);
+	regmap_read(pmcreg, AT91_PMC_MCKR, &pmc_cache.mckr);
+	regmap_read(pmcreg, AT91_PMC_USB, &pmc_cache.usb);
+	regmap_read(pmcreg, AT91_PMC_IMR, &pmc_cache.imr);
+	regmap_read(pmcreg, AT91_PMC_PCSR1, &pmc_cache.pcsr1);
+
+	for (i = 2; i < 64; i++) {
+		regmap_write(pmcreg, AT91_PMC_PCR, (i & AT91_PMC_PCR_PID_MASK));
+		regmap_read(pmcreg, AT91_PMC_PCR, &pmc_cache.pcr[i]);
+	}
+
+	return 0;
+}
+
+static void pmc_resume(void)
+{
+	int i;
+
+	regmap_write(pmcreg, AT91_PMC_IMR, pmc_cache.scsr);
+	regmap_write(pmcreg, AT91_PMC_PCER, pmc_cache.pcsr0);
+	regmap_write(pmcreg, AT91_CKGR_UCKR, pmc_cache.uckr);
+	regmap_write(pmcreg, AT91_CKGR_MOR, pmc_cache.mor);
+	regmap_write(pmcreg, AT91_CKGR_MCFR, pmc_cache.mcfr);
+	regmap_write(pmcreg, AT91_CKGR_PLLAR, pmc_cache.pllar);
+	regmap_write(pmcreg, AT91_PMC_MCKR, pmc_cache.mckr);
+	regmap_write(pmcreg, AT91_PMC_USB, pmc_cache.usb);
+	regmap_write(pmcreg, AT91_PMC_IMR, pmc_cache.imr);
+	regmap_write(pmcreg, AT91_PMC_PCER1, pmc_cache.pcsr1);
+
+	for (i = 2; i < 64; i++) {
+		regmap_write(pmcreg, AT91_PMC_PCR, (i & AT91_PMC_PCR_PID_MASK));
+		regmap_write(pmcreg, AT91_PMC_PCR, pmc_cache.pcr[i]);
+	}
+}
+
+static struct syscore_ops pmc_syscore_ops = {
+	.suspend = pmc_suspend,
+	.resume = pmc_resume,
+};
+
 static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
 {
 	struct clk_hw *hw;
@@ -601,6 +669,7 @@ static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
+	pmcreg = regmap;
 	of_property_read_string(np, "clock-output-names", &name);
 
 	hw = at91_clk_register_sam9x5_main(regmap, name, parent_names,
@@ -608,6 +677,8 @@ static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		return;
 
+	register_syscore_ops(&pmc_syscore_ops);
+
 	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(at91sam9x5_clk_main, "atmel,at91sam9x5-clk-main",
-- 
2.11.0
