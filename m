From: martin.persson@stericsson.com (Martin Persson)
Date: Wed, 8 Dec 2010 15:13:28 +0100
Subject: [PATCH 1/2] arm: ux500: Add prcmu support for operating points
Message-ID: <1291817608-29071-1-git-send-email-martin.persson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support in PRCMU driver to handle CPU and APE operating points.

Signed-off-by: Martin Persson <martin.persson@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/include/mach/prcmu-defs.h |   30 +++++
 arch/arm/mach-ux500/include/mach/prcmu-regs.h |   15 ++-
 arch/arm/mach-ux500/include/mach/prcmu.h      |   14 ++-
 arch/arm/mach-ux500/prcmu.c                   |  151 ++++++++++++++++++++++++-
 4 files changed, 202 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-ux500/include/mach/prcmu-defs.h

diff --git a/arch/arm/mach-ux500/include/mach/prcmu-defs.h b/arch/arm/mach-ux500/include/mach/prcmu-defs.h
new file mode 100644
index 0000000..848ba64
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/prcmu-defs.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com>
+ * Author: Martin Persson <martin.persson@stericsson.com>
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * PRCM Unit definitions
+ */
+
+#ifndef __MACH_PRCMU_DEFS_H
+#define __MACH_PRCMU_DEFS_H
+
+enum prcmu_cpu_opp {
+	CPU_OPP_INIT	  = 0x00,
+	CPU_OPP_NO_CHANGE = 0x01,
+	CPU_OPP_100	  = 0x02,
+	CPU_OPP_50	  = 0x03,
+	CPU_OPP_MAX	  = 0x04,
+	CPU_OPP_EXT_CLK	  = 0x07
+};
+enum prcmu_ape_opp {
+	APE_OPP_NO_CHANGE = 0x00,
+	APE_OPP_100	  = 0x02,
+	APE_OPP_50	  = 0x03,
+};
+
+#endif /* __MACH_PRCMU_DEFS_H */
diff --git a/arch/arm/mach-ux500/include/mach/prcmu-regs.h b/arch/arm/mach-ux500/include/mach/prcmu-regs.h
index 8885f39..455467e 100644
--- a/arch/arm/mach-ux500/include/mach/prcmu-regs.h
+++ b/arch/arm/mach-ux500/include/mach/prcmu-regs.h
@@ -1,10 +1,15 @@
 /*
- * Copyright (c) 2009 ST-Ericsson SA
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
+ * Author: Kumar Sanghvi <kumar.sanghvi@stericsson.com>
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com>
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * PRCM Unit registers
  */
+
 #ifndef __MACH_PRCMU_REGS_H
 #define __MACH_PRCMU_REGS_H
 
@@ -88,4 +93,4 @@
 /* Miscellaneous unit registers */
 #define PRCM_DSI_SW_RESET          (_PRCMU_BASE + 0x324)
 
-#endif /* __MACH_PRCMU__REGS_H */
+#endif /* __MACH_PRCMU_REGS_H */
diff --git a/arch/arm/mach-ux500/include/mach/prcmu.h b/arch/arm/mach-ux500/include/mach/prcmu.h
index daa9d3a..c49e456 100644
--- a/arch/arm/mach-ux500/include/mach/prcmu.h
+++ b/arch/arm/mach-ux500/include/mach/prcmu.h
@@ -2,15 +2,27 @@
  * Copyright (C) STMicroelectronics 2009
  * Copyright (C) ST-Ericsson SA 2010
  *
+ * Author: Kumar Sanghvi <kumar.sanghvi@stericsson.com>
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com>
+ * Author: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
+ *
  * License Terms: GNU General Public License v2
  *
- * PRCMU f/w APIs
+ * PRCM Unit f/w API
  */
 #ifndef __MACH_PRCMU_H
 #define __MACH_PRCMU_H
+#include <mach/prcmu-defs.h>
 
 void __init prcmu_early_init(void);
 int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size);
 int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size);
+int prcmu_set_ape_opp(enum prcmu_ape_opp opp);
+int prcmu_set_cpu_opp(enum prcmu_cpu_opp opp);
+int prcmu_set_ape_cpu_opps(enum prcmu_ape_opp ape_opp,
+			   enum prcmu_cpu_opp cpu_opp);
+int prcmu_get_ape_opp(void);
+int prcmu_get_cpu_opp(void);
+bool prcmu_has_arm_maxopp(void);
 
 #endif /* __MACH_PRCMU_H */
diff --git a/arch/arm/mach-ux500/prcmu.c b/arch/arm/mach-ux500/prcmu.c
index 3ba3e32..87d7487 100644
--- a/arch/arm/mach-ux500/prcmu.c
+++ b/arch/arm/mach-ux500/prcmu.c
@@ -1,10 +1,14 @@
 /*
- * Copyright (C) ST Ericsson SA 2010
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010
  *
  * License Terms: GNU General Public License v2
+ * Author: Kumar Sanghvi <kumar.sanghvi@stericsson.com>
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com>
  * Author: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
  *
- * U8500 PRCMU driver.
+ * U8500 PRCM Unit interface driver
+ *
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -19,13 +23,27 @@
 
 #include <mach/hardware.h>
 #include <mach/prcmu-regs.h>
+#include <mach/prcmu-defs.h>
 
 /* Global var to runtime determine TCDM base for v2 or v1 */
 static __iomem void *tcdm_base;
 
+#define _MBOX_HEADER		(tcdm_base + 0xFE8)
+#define MBOX_HEADER_REQ_MB0	(_MBOX_HEADER + 0x0)
+
+#define REQ_MB1 (tcdm_base + 0xFD0)
 #define REQ_MB5 (tcdm_base + 0xE44)
+
+#define REQ_MB1_ARMOPP		(REQ_MB1 + 0x0)
+#define REQ_MB1_APEOPP		(REQ_MB1 + 0x1)
+#define REQ_MB1_BOOSTOPP	(REQ_MB1 + 0x2)
+
+#define ACK_MB1 (tcdm_base + 0xE04)
 #define ACK_MB5 (tcdm_base + 0xDF4)
 
+#define ACK_MB1_CURR_ARMOPP		(ACK_MB1 + 0x0)
+#define ACK_MB1_CURR_APEOPP		(ACK_MB1 + 0x1)
+
 #define REQ_MB5_I2C_SLAVE_OP (REQ_MB5)
 #define REQ_MB5_I2C_HW_BITS (REQ_MB5 + 1)
 #define REQ_MB5_I2C_REG (REQ_MB5 + 2)
@@ -34,12 +52,33 @@ static __iomem void *tcdm_base;
 #define ACK_MB5_I2C_STATUS (ACK_MB5 + 1)
 #define ACK_MB5_I2C_VAL (ACK_MB5 + 3)
 
+#define PRCM_AVS_VARM_MAX_OPP		(tcdm_base + 0x2E4)
+#define PRCM_AVS_ISMODEENABLE		7
+#define PRCM_AVS_ISMODEENABLE_MASK	(1 << PRCM_AVS_ISMODEENABLE)
+
 #define I2C_WRITE(slave) \
 	(((slave) << 1) | (cpu_is_u8500v2() ? BIT(6) : 0))
 #define I2C_READ(slave) \
 	(((slave) << 1) | (cpu_is_u8500v2() ? BIT(6) : 0) | BIT(0))
 #define I2C_STOP_EN BIT(3)
 
+enum mb1_h {
+	MB1H_ARM_OPP = 1,
+	MB1H_APE_OPP,
+	MB1H_ARM_APE_OPP,
+};
+
+static struct {
+	struct mutex lock;
+	struct completion work;
+	struct {
+		u8 arm_opp;
+		u8 ape_opp;
+		u8 arm_status;
+		u8 ape_status;
+	} ack;
+} mb1_transfer;
+
 enum ack_mb5_status {
 	I2C_WR_OK = 0x01,
 	I2C_RD_OK = 0x02,
@@ -148,6 +187,104 @@ unlock_and_return:
 }
 EXPORT_SYMBOL(prcmu_abb_write);
 
+static int set_ape_cpu_opps(u8 header, enum prcmu_ape_opp ape_opp,
+			    enum prcmu_cpu_opp cpu_opp)
+{
+	bool do_ape;
+	bool do_arm;
+	int err = 0;
+
+	do_ape = ((header == MB1H_APE_OPP) || (header == MB1H_ARM_APE_OPP));
+	do_arm = ((header == MB1H_ARM_OPP) || (header == MB1H_ARM_APE_OPP));
+
+	mutex_lock(&mb1_transfer.lock);
+
+	while (readl(PRCM_MBOX_CPU_VAL) & MBOX_BIT(1))
+		cpu_relax();
+
+	writeb(0, MBOX_HEADER_REQ_MB0);
+	writeb(cpu_opp, REQ_MB1_ARMOPP);
+	writeb(ape_opp, REQ_MB1_APEOPP);
+	writeb(0, REQ_MB1_BOOSTOPP);
+	writel(MBOX_BIT(1), PRCM_MBOX_CPU_SET);
+	wait_for_completion(&mb1_transfer.work);
+	if ((do_ape) && (mb1_transfer.ack.ape_status != 0))
+		err = -EIO;
+	if ((do_arm) && (mb1_transfer.ack.arm_status != 0))
+		err = -EIO;
+
+	mutex_unlock(&mb1_transfer.lock);
+
+	return err;
+}
+
+/**
+ * prcmu_set_ape_opp() - Set the OPP of the APE.
+ * @opp:	The OPP to set.
+ *
+ * This function sets the OPP of the APE.
+ */
+int prcmu_set_ape_opp(enum prcmu_ape_opp opp)
+{
+	return set_ape_cpu_opps(MB1H_APE_OPP, opp, APE_OPP_NO_CHANGE);
+}
+EXPORT_SYMBOL(prcmu_set_ape_opp);
+
+/**
+ * prcmu_set_cpu_opp() - Set the OPP of the CPU.
+ * @opp:	The OPP to set.
+ *
+ * This function sets the OPP of the CPU.
+ */
+int prcmu_set_cpu_opp(enum prcmu_cpu_opp opp)
+{
+	return set_ape_cpu_opps(MB1H_ARM_OPP, CPU_OPP_NO_CHANGE, opp);
+}
+EXPORT_SYMBOL(prcmu_set_cpu_opp);
+
+/**
+ * prcmu_set_ape_cpu_opps() - Set the OPPs of the APE and the CPU.
+ * @ape_opp:	The APE OPP to set.
+ * @cpu_opp:	The CPU OPP to set.
+ *
+ * This function sets the OPPs of the APE and the CPU.
+ */
+int prcmu_set_ape_cpu_opps(enum prcmu_ape_opp ape_opp,
+			   enum prcmu_cpu_opp cpu_opp)
+{
+	return set_ape_cpu_opps(MB1H_ARM_APE_OPP, ape_opp, cpu_opp);
+}
+EXPORT_SYMBOL(prcmu_set_ape_cpu_opps);
+
+/**
+ * prcmu_get_ape_opp() - Get the OPP of the APE.
+ *
+ * This function gets the OPP of the APE.
+ */
+enum prcmu_ape_opp prcmu_get_ape_opp(void)
+{
+	return readb(ACK_MB1_CURR_APEOPP);
+}
+EXPORT_SYMBOL(prcmu_get_ape_opp);
+
+/**
+ * prcmu_get_cpu_opp() - Get the OPP of the CPU.
+ *
+ * This function gets the OPP of the CPU. The OPP is specified in %%.
+ * PRCMU_OPP_EXT is a special OPP value, not specified in %%.
+ */
+int prcmu_get_cpu_opp(void)
+{
+	return readb(ACK_MB1_CURR_ARMOPP);
+}
+EXPORT_SYMBOL(prcmu_get_cpu_opp);
+
+bool prcmu_has_arm_maxopp(void)
+{
+	return (readb(PRCM_AVS_VARM_MAX_OPP) & PRCM_AVS_ISMODEENABLE_MASK)
+		== PRCM_AVS_ISMODEENABLE_MASK;
+}
+
 static void read_mailbox_0(void)
 {
 	writel(MBOX_BIT(0), PRCM_ARM_IT1_CLEAR);
@@ -155,6 +292,9 @@ static void read_mailbox_0(void)
 
 static void read_mailbox_1(void)
 {
+	mb1_transfer.ack.arm_opp = readb(ACK_MB1_CURR_ARMOPP);
+	mb1_transfer.ack.ape_opp = readb(ACK_MB1_CURR_APEOPP);
+	complete(&mb1_transfer.work);
 	writel(MBOX_BIT(1), PRCM_ARM_IT1_CLEAR);
 }
 
@@ -234,6 +374,13 @@ void __init prcmu_early_init(void)
 
 static int __init prcmu_init(void)
 {
+	if (cpu_is_u8500ed()) {
+		pr_err("prcmu: Unsupported chip version\n");
+		return 0;
+	}
+
+	mutex_init(&mb1_transfer.lock);
+	init_completion(&mb1_transfer.work);
 	mutex_init(&mb5_transfer.lock);
 	init_completion(&mb5_transfer.work);
 
-- 
1.7.2.2
