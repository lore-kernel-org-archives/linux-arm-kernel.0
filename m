From: peng.fan@nxp.com (Peng Fan)
Date: Thu, 28 Dec 2017 17:35:50 +0800
Subject: [PATCH] ARM: imx: introduce imx_l2c310_write_sec
Message-ID: <1514453750-15479-1-git-send-email-peng.fan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some PL310 registers could only be wrote in secure world, so
introduce imx_l2c310_write_sec to support Linux running in
non-secure world.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm/mach-imx/system.c    | 21 +++++++++++++++++++--
 include/soc/imx/imx_sip_smc.h | 23 +++++++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)
 create mode 100644 include/soc/imx/imx_sip_smc.h

diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index c06af650e6b1..86ce9f590777 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -23,11 +23,13 @@
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <soc/imx/imx_sip_smc.h>
 
 #include <asm/system_misc.h>
 #include <asm/proc-fns.h>
 #include <asm/mach-types.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/outercache.h>
 
 #include "common.h"
 #include "hardware.h"
@@ -35,6 +37,9 @@
 static void __iomem *wdog_base;
 static struct clk *wdog_clk;
 static int wcr_enable = (1 << 2);
+#ifdef CONFIG_CACHE_L2X0
+static void __iomem *l2x0_base;
+#endif
 
 /*
  * Reset the system. It is called by machine_restart().
@@ -92,9 +97,15 @@ void __init imx1_reset_init(void __iomem *base)
 #endif
 
 #ifdef CONFIG_CACHE_L2X0
+void imx_l2c310_write_sec(unsigned long val, unsigned int reg)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(IMX_SIP_SMC_L2C310, val, reg, 0, 0, 0, 0, 0, &res);
+}
+
 void __init imx_init_l2cache(void)
 {
-	void __iomem *l2x0_base;
 	struct device_node *np;
 	unsigned int val;
 
@@ -102,6 +113,9 @@ void __init imx_init_l2cache(void)
 	if (!np)
 		return;
 
+	if (of_find_compatible_node(NULL, NULL, "linaro,optee-tz"))
+		outer_cache.write_sec = imx_l2c310_write_sec;
+
 	l2x0_base = of_iomap(np, 0);
 	if (!l2x0_base)
 		goto put_node;
@@ -117,7 +131,10 @@ void __init imx_init_l2cache(void)
 		val &= ~L310_PREFETCH_CTRL_OFFSET_MASK;
 		val |= 15;
 
-		writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
+		if (outer_cache.write_sec)
+			outer_cache.write_sec(val, L310_PREFETCH_CTRL);
+		else
+			writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
 	}
 
 	iounmap(l2x0_base);
diff --git a/include/soc/imx/imx_sip_smc.h b/include/soc/imx/imx_sip_smc.h
new file mode 100644
index 000000000000..61a493278169
--- /dev/null
+++ b/include/soc/imx/imx_sip_smc.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright 2017 NXP
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __IMX_SIP_SMC_H_
+#define __IMX_SIP_SMC_H_
+
+#include <linux/arm-smccc.h>
+
+#define IMX_SIP_SMC_VAL(func) ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
+						 ARM_SMCCC_SMC_32, \
+						 ARM_SMCCC_OWNER_SIP, \
+						 (func))
+
+#define IMX_L2C310		0x1
+
+#define IMX_SIP_SMC_L2C310	IMX_SIP_SMC_VAL(IMX_L2C310)
+
+#endif
-- 
2.14.1
