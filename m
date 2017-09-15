From: romain.izard.pro@gmail.com (Romain Izard)
Date: Fri, 15 Sep 2017 16:04:05 +0200
Subject: [PATCH v2 3/9] clk: at91: pmc: Support backup for programmable clocks
In-Reply-To: <20170915140411.31716-1-romain.izard.pro@gmail.com>
References: <20170915140411.31716-1-romain.izard.pro@gmail.com>
Message-ID: <20170915140411.31716-4-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Romain Izard <romain.izard@mobile-devices.fr>

When an AT91 programmable clock is declared in the device tree, register
it into the Power Management Controller driver. On entering suspend mode,
the driver saves and restores the Programmable Clock registers to support
the backup mode for these clocks.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
Changes in v2:
* register PCKs on clock startup

 drivers/clk/at91/clk-programmable.c |  2 ++
 drivers/clk/at91/pmc.c              | 27 +++++++++++++++++++++++++++
 drivers/clk/at91/pmc.h              |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 85a449cf61e3..0e6aab1252fc 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -204,6 +204,8 @@ at91_clk_register_programmable(struct regmap *regmap,
 	if (ret) {
 		kfree(prog);
 		hw = ERR_PTR(ret);
+	} else {
+		pmc_register_pck(id);
 	}
 
 	return hw;
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 07dc2861ad3f..3910b7537152 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -22,6 +22,7 @@
 #include "pmc.h"
 
 #define PMC_MAX_IDS 128
+#define PMC_MAX_PCKS 8
 
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range)
@@ -50,6 +51,7 @@ EXPORT_SYMBOL_GPL(of_at91_get_clk_range);
 static struct regmap *pmcreg;
 
 static u8 registered_ids[PMC_MAX_IDS];
+static u8 registered_pcks[PMC_MAX_PCKS];
 
 static struct
 {
@@ -66,8 +68,10 @@ static struct
 	u32 pcr[PMC_MAX_IDS];
 	u32 audio_pll0;
 	u32 audio_pll1;
+	u32 pckr[PMC_MAX_PCKS];
 } pmc_cache;
 
+/* Clock ID 0 is invalid */
 void pmc_register_id(u8 id)
 {
 	int i;
@@ -82,6 +86,21 @@ void pmc_register_id(u8 id)
 	}
 }
 
+/* Programmable Clock 0 is valid */
+void pmc_register_pck(u8 pck)
+{
+	int i;
+
+	for (i = 0; i < PMC_MAX_PCKS; i++) {
+		if (registered_pcks[i] == 0) {
+			registered_pcks[i] = pck + 1;
+			break;
+		}
+		if (registered_pcks[i] == (pck + 1))
+			break;
+	}
+}
+
 static int pmc_suspend(void)
 {
 	int i;
@@ -103,6 +122,10 @@ static int pmc_suspend(void)
 		regmap_read(pmcreg, AT91_PMC_PCR,
 			    &pmc_cache.pcr[registered_ids[i]]);
 	}
+	for (i = 0; registered_pcks[i]; i++) {
+		u8 num = registered_pcks[i] - 1;
+		regmap_read(pmcreg, AT91_PMC_PCKR(num), &pmc_cache.pckr[num]);
+	}
 
 	return 0;
 }
@@ -143,6 +166,10 @@ static void pmc_resume(void)
 			     pmc_cache.pcr[registered_ids[i]] |
 			     AT91_PMC_PCR_CMD);
 	}
+	for (i = 0; registered_pcks[i]; i++) {
+		u8 num = registered_pcks[i] - 1;
+		regmap_write(pmcreg, AT91_PMC_PCKR(num), pmc_cache.pckr[num]);
+	}
 
 	if (pmc_cache.uckr & AT91_PMC_UPLLEN)
 		mask |= AT91_PMC_LOCKU;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 858e8ef7e8db..d22b1fa9ecdc 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -31,8 +31,10 @@ int of_at91_get_clk_range(struct device_node *np, const char *propname,
 
 #ifdef CONFIG_PM
 void pmc_register_id(u8 id);
+void pmc_register_pck(u8 pck);
 #else
 static inline void pmc_register_id(u8 id) {}
+static inline void pmc_register_pck(u8 pck) {}
 #endif
 
 #endif /* __PMC_H_ */
-- 
2.11.0
