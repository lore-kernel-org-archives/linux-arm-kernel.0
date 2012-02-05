From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  5 Feb 2012 19:22:53 +0100
Subject: [FOR 3.3 PATCH 1/2] ARM: at91: add accessor to manage smc
Message-ID: <1328466174-27946-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/at91sam9_smc.h |   29 +++++++++
 arch/arm/mach-at91/sam9_smc.c                  |   76 ++++++++++++++++++++++--
 arch/arm/mach-at91/sam9_smc.h                  |   23 -------
 3 files changed, 100 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91sam9_smc.h b/arch/arm/mach-at91/include/mach/at91sam9_smc.h
index eb18a70..a768b21 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9_smc.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9_smc.h
@@ -18,6 +18,35 @@
 
 #include <mach/cpu.h>
 
+#ifndef __ASSEMBLY__
+struct sam9_smc_config {
+	/* Setup register */
+	u8 ncs_read_setup;
+	u8 nrd_setup;
+	u8 ncs_write_setup;
+	u8 nwe_setup;
+
+	/* Pulse register */
+	u8 ncs_read_pulse;
+	u8 nrd_pulse;
+	u8 ncs_write_pulse;
+	u8 nwe_pulse;
+
+	/* Cycle register */
+	u16 read_cycle;
+	u16 write_cycle;
+
+	/* Mode register */
+	u32 mode;
+	u8 tdf_cycles:4;
+};
+
+extern void sam9_smc_configure(int id, int cs, struct sam9_smc_config* config);
+extern void sam9_smc_read(int id, int cs, struct sam9_smc_config* config);
+extern void sam9_smc_read_mode(int id, int cs, struct sam9_smc_config* config);
+extern void sam9_smc_write_mode(int id, int cs, struct sam9_smc_config* config);
+#endif
+
 #define AT91_SMC_SETUP		0x00				/* Setup Register for CS n */
 #define		AT91_SMC_NWESETUP	(0x3f << 0)			/* NWE Setup Length */
 #define			AT91_SMC_NWESETUP_(x)	((x) << 0)
diff --git a/arch/arm/mach-at91/sam9_smc.c b/arch/arm/mach-at91/sam9_smc.c
index 8294783..bf0cfef 100644
--- a/arch/arm/mach-at91/sam9_smc.c
+++ b/arch/arm/mach-at91/sam9_smc.c
@@ -2,6 +2,7 @@
  * linux/arch/arm/mach-at91/sam9_smc.c
  *
  * Copyright (C) 2008 Andrew Victor
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -22,7 +23,22 @@
 
 static void __iomem *smc_base_addr[2];
 
-static void __init sam9_smc_cs_configure(void __iomem *base, struct sam9_smc_config* config)
+static void sam9_smc_cs_write_mode(void __iomem *base,
+					struct sam9_smc_config* config)
+{
+	__raw_writel(config->mode
+		   | AT91_SMC_TDF_(config->tdf_cycles),
+		   base + AT91_SMC_MODE);
+}
+
+void sam9_smc_write_mode(int id, int cs,
+					struct sam9_smc_config* config)
+{
+	sam9_smc_cs_write_mode(AT91_SMC_CS(id, cs), config);
+}
+
+static void sam9_smc_cs_configure(void __iomem *base,
+					struct sam9_smc_config* config)
 {
 
 	/* Setup register */
@@ -45,16 +61,66 @@ static void __init sam9_smc_cs_configure(void __iomem *base, struct sam9_smc_con
 		   base + AT91_SMC_CYCLE);
 
 	/* Mode register */
-	__raw_writel(config->mode
-		   | AT91_SMC_TDF_(config->tdf_cycles),
-		   base + AT91_SMC_MODE);
+	sam9_smc_cs_write_mode(base, config);
 }
 
-void __init sam9_smc_configure(int id, int cs, struct sam9_smc_config* config)
+void sam9_smc_configure(int id, int cs,
+					struct sam9_smc_config* config)
 {
 	sam9_smc_cs_configure(AT91_SMC_CS(id, cs), config);
 }
 
+static void sam9_smc_cs_read_mode(void __iomem *base,
+					struct sam9_smc_config* config)
+{
+	u32 val = __raw_readl(base + AT91_SMC_MODE);
+
+	config->mode = (val & ~AT91_SMC_NWECYCLE);
+	config->tdf_cycles = (val & AT91_SMC_NWECYCLE) >> 16 ;
+}
+
+void sam9_smc_read_mode(int id, int cs,
+					struct sam9_smc_config* config)
+{
+	sam9_smc_cs_read_mode(AT91_SMC_CS(id, cs), config);
+}
+
+static void sam9_smc_cs_read(void __iomem *base,
+					struct sam9_smc_config* config)
+{
+	u32 val;
+
+	/* Setup register */
+	val = __raw_readl(base + AT91_SMC_SETUP);
+
+	config->nwe_setup = val & AT91_SMC_NWESETUP;
+	config->ncs_write_setup = (val & AT91_SMC_NCS_WRSETUP) >> 8;
+	config->nrd_setup = (val & AT91_SMC_NRDSETUP) >> 16;
+	config->ncs_read_setup = (val & AT91_SMC_NCS_RDSETUP) >> 24;
+
+	/* Pulse register */
+	val = __raw_readl(base + AT91_SMC_PULSE);
+
+	config->nwe_setup = val & AT91_SMC_NWEPULSE;
+	config->ncs_write_pulse = (val & AT91_SMC_NCS_WRPULSE) >> 8;
+	config->nrd_pulse = (val & AT91_SMC_NRDPULSE) >> 16;
+	config->ncs_read_pulse = (val & AT91_SMC_NCS_RDPULSE) >> 24;
+
+	/* Cycle register */
+	val = __raw_readl(base + AT91_SMC_CYCLE);
+
+	config->write_cycle = val & AT91_SMC_NWECYCLE;
+	config->read_cycle = (val & AT91_SMC_NRDCYCLE) >> 16;
+
+	/* Mode register */
+	sam9_smc_cs_read_mode(base, config);
+}
+
+void sam9_smc_read(int id, int cs, struct sam9_smc_config* config)
+{
+	sam9_smc_cs_read(AT91_SMC_CS(id, cs), config);
+}
+
 void __init at91sam9_ioremap_smc(int id, u32 addr)
 {
 	if (id > 1) {
diff --git a/arch/arm/mach-at91/sam9_smc.h b/arch/arm/mach-at91/sam9_smc.h
index 039c5ce..3e52dcd4 100644
--- a/arch/arm/mach-at91/sam9_smc.h
+++ b/arch/arm/mach-at91/sam9_smc.h
@@ -8,27 +8,4 @@
  * published by the Free Software Foundation.
  */
 
-struct sam9_smc_config {
-	/* Setup register */
-	u8 ncs_read_setup;
-	u8 nrd_setup;
-	u8 ncs_write_setup;
-	u8 nwe_setup;
-
-	/* Pulse register */
-	u8 ncs_read_pulse;
-	u8 nrd_pulse;
-	u8 ncs_write_pulse;
-	u8 nwe_pulse;
-
-	/* Cycle register */
-	u16 read_cycle;
-	u16 write_cycle;
-
-	/* Mode register */
-	u32 mode;
-	u8 tdf_cycles:4;
-};
-
-extern void __init sam9_smc_configure(int id, int cs, struct sam9_smc_config* config);
 extern void __init at91sam9_ioremap_smc(int id, u32 addr);
-- 
1.7.7
