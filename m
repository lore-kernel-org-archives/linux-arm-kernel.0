From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  8 Dec 2011 16:23:02 +0100
Subject: [PATCH 1/3] ARM: at91: add accessor to manage smc
In-Reply-To: <20111208150348.GD23884@game.jcrosoft.org>
References: <20111208150348.GD23884@game.jcrosoft.org>
Message-ID: <1323357784-17555-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this will allow to configure the smc independtly of the register configuration
as example on rm9200 different from sam9

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/at91sam9_smc.h |   29 ++++++++
 arch/arm/mach-at91/sam9_smc.c                  |   93 ++++++++++++++++++++++--
 arch/arm/mach-at91/sam9_smc.h                  |   23 ------
 3 files changed, 115 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91sam9_smc.h b/arch/arm/mach-at91/include/mach/at91sam9_smc.h
index eb18a70..b5eff0e 100644
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
+extern int sam9_smc_configure(int id, int cs, struct sam9_smc_config* config);
+extern int sam9_smc_read(int id, int cs, struct sam9_smc_config* config);
+extern int sam9_smc_read_mode(int id, int cs, struct sam9_smc_config* config);
+extern int sam9_smc_write_mode(int id, int cs, struct sam9_smc_config* config);
+#endif
+
 #define AT91_SMC_SETUP		0x00				/* Setup Register for CS n */
 #define		AT91_SMC_NWESETUP	(0x3f << 0)			/* NWE Setup Length */
 #define			AT91_SMC_NWESETUP_(x)	((x) << 0)
diff --git a/arch/arm/mach-at91/sam9_smc.c b/arch/arm/mach-at91/sam9_smc.c
index 8294783..e5936dc 100644
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
@@ -17,13 +18,58 @@
 
 #include "sam9_smc.h"
 
-
 #define AT91_SMC_CS(id, n)	(smc_base_addr[id] + ((n) * 0x10))
 
 static void __iomem *smc_base_addr[2];
 
-static void __init sam9_smc_cs_configure(void __iomem *base, struct sam9_smc_config* config)
+static void __init_refok sam9_smc_cs_write_mode(void __iomem *base,
+					struct sam9_smc_config* config)
+{
+	__raw_writel(config->mode
+		   | AT91_SMC_TDF_(config->tdf_cycles),
+		   base + AT91_SMC_MODE);
+}
+
+int __init_refok sam9_smc_write_mode(int id, int cs,
+					struct sam9_smc_config* config)
+{
+	if (!smc_base_addr[id])
+		return -EINVAL;
+
+	sam9_smc_cs_write_mode(AT91_SMC_CS(id, cs), config);
+
+	return 0;
+}
+
+int __init_refok sam9_smc_configure(int id, int cs,
+					struct sam9_smc_config* config)
+{
+	if (!smc_base_addr[id])
+		return -EINVAL;
+
+	sam9_smc_cs_configure(AT91_SMC_CS(id, cs), config);
+
+	return 0;
+}
+
+static void __init_refok sam9_smc_cs_read_mode(void __iomem *base,
+					struct sam9_smc_config* config)
+{
+	u32 val = __raw_readl(base + AT91_SMC_MODE);
+
+	config->mode = (val & ~AT91_SMC_NWECYCLE);
+	config->tdf_cycles = (val & AT91_SMC_NWECYCLE) >> 16 ;
+}
+
+int __init_refok sam9_smc_read_mode(int id, int cs,
+					struct sam9_smc_config* config)
 {
+	void __iomen *base;
+
+	if (!smc_base_addr[id])
+		return -EINVAL;
+
+	base = AT91_SMC_CS(id, cs);
 
 	/* Setup register */
 	__raw_writel(AT91_SMC_NWESETUP_(config->nwe_setup)
@@ -45,14 +91,47 @@ static void __init sam9_smc_cs_configure(void __iomem *base, struct sam9_smc_con
 		   base + AT91_SMC_CYCLE);
 
 	/* Mode register */
-	__raw_writel(config->mode
-		   | AT91_SMC_TDF_(config->tdf_cycles),
-		   base + AT91_SMC_MODE);
+	sam9_smc_cs_write_mode(base, config);
+
+	return 0;
 }
 
-void __init sam9_smc_configure(int id, int cs, struct sam9_smc_config* config)
+int __init_refok sam9_smc_read(int id, int cs, struct sam9_smc_config* config)
 {
-	sam9_smc_cs_configure(AT91_SMC_CS(id, cs), config);
+	void __iomen *base;
+	u32 val;
+
+	if (!smc_base_addr[id])
+		return -EINVAL;
+
+	base = AT91_SMC_CS(id, cs);
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
+
+	return 0;
 }
 
 void __init at91sam9_ioremap_smc(int id, u32 addr)
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
