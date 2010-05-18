From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Tue, 18 May 2010 14:06:25 +0530
Subject: [PATCH 2/3] ux500: Add basic PRCM TCDM support
In-Reply-To: <1274171786-22990-1-git-send-email-sundar.iyer@stericsson.com>
References: <1274171786-22990-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <1274171786-22990-3-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kumar Sanghvi <kumar.sanghvi@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Kumar A Sanghvi <kumar.sanghvi@stericsson.com>
Signed-off-by: Sundar R Iyer <sundar.iyer@stericsson.com>
---
 arch/arm/mach-ux500/Makefile                       |    2 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |    1 +
 arch/arm/mach-ux500/include/mach/hardware.h        |    1 +
 arch/arm/mach-ux500/include/mach/irqs.h            |    1 +
 arch/arm/mach-ux500/include/mach/u8500-prcm-api.h  |   21 +++
 arch/arm/mach-ux500/include/mach/u8500-prcm-regs.h |   28 ++++
 arch/arm/mach-ux500/include/mach/u8500-prcm.h      |   57 +++++++
 arch/arm/mach-ux500/u8500-prcm.c                   |  169 ++++++++++++++++++++
 8 files changed, 279 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ux500/include/mach/u8500-prcm-api.h
 create mode 100644 arch/arm/mach-ux500/include/mach/u8500-prcm-regs.h
 create mode 100644 arch/arm/mach-ux500/include/mach/u8500-prcm.h
 create mode 100644 arch/arm/mach-ux500/u8500-prcm.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 3c1ac87..d3613ca 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -4,7 +4,7 @@
 
 obj-y				:= clock.o cpu.o devices.o
 obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o devices-db5500.o
-obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
+obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o u8500-prcm.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o localtimer.o
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 2e28d6f..5e5e749 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -38,6 +38,7 @@ static struct platform_device *platform_devs[] __initdata = {
 /* minimum static i/o mapping required to boot U8500 platforms */
 static struct map_desc u8500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_PRCMU_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_PRCMU_TCDM_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO0_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO1_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO2_BASE, SZ_4K),
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index 8656379..f640415 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -60,6 +60,7 @@
 #define UX500_MTU0_BASE		UX500(MTU0)
 #define UX500_MTU1_BASE		UX500(MTU1)
 #define UX500_PRCMU_BASE	UX500(PRCMU)
+#define UX500_PRCMU_TCDM_BASE	UX500(PRCMU_TCDM)
 
 #define UX500_RNG_BASE		UX500(RNG)
 #define UX500_RTC_BASE		UX500(RTC)
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index 910149e..a0a49a5 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -41,6 +41,7 @@
 #define IRQ_HSIR_CH2_OVRRUN	(IRQ_SHPI_START + 34)
 #define IRQ_HSIR_CH3_OVRRUN	(IRQ_SHPI_START + 35)
 #define IRQ_AB4500		(IRQ_SHPI_START + 40)
+#define IRQ_PRCMU		(IRQ_SHPI_START + 47)
 #define IRQ_DISP		(IRQ_SHPI_START + 48)
 #define IRQ_SiPI3		(IRQ_SHPI_START + 49)
 #define IRQ_I2C4		(IRQ_SHPI_START + 51)
diff --git a/arch/arm/mach-ux500/include/mach/u8500-prcm-api.h b/arch/arm/mach-ux500/include/mach/u8500-prcm-api.h
new file mode 100644
index 0000000..5f113c1
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/u8500-prcm-api.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * Author: Kumar Sanghvi <kumar.sanghvi@stericsson.com>
+ *
+ * U8500 PRCMU APIs
+ */
+
+/* ux500 subsystem */
+enum ux500_subsys {
+	SUBSYS_ARM,
+	SUBSYS_APE,
+};
+
+int prcm_set_subsys_opp(unsigned int subsys_opp_idx,
+		unsigned int subsys);
+int prcm_get_subsys_opp(unsigned int subsys);
+
diff --git a/arch/arm/mach-ux500/include/mach/u8500-prcm-regs.h b/arch/arm/mach-ux500/include/mach/u8500-prcm-regs.h
new file mode 100644
index 0000000..fd16755
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/u8500-prcm-regs.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * Author: Kumar Sanghvi <kumar.sanghvi@stericsson.com>
+ *
+ * U8500 PRCM Memory Map
+ */
+
+#ifndef __U8500_PRCM_REGS_H
+#define __U8500_PRCM_REGS_H
+
+#include <mach/hardware.h>
+
+#define _PRCMU_BASE             IO_ADDRESS(U8500_PRCMU_BASE)
+
+/* CPU mailbox registers */
+#define PRCM_MBOX_CPU_VAL       (_PRCMU_BASE + 0x0fc)
+#define PRCM_MBOX_CPU_SET       (_PRCMU_BASE + 0x100)
+#define PRCM_MBOX_CPU_CLR       (_PRCMU_BASE + 0x104)
+
+/* register for Ack mailbox interrupts */
+#define PRCM_ARM_IT1_CLEAR      (_PRCMU_BASE + 0x48C)
+#define PRCM_ARM_IT1_VAL        (_PRCMU_BASE + 0x494)
+
+#endif /* __U8500_PRCMU_REGS_H */
diff --git a/arch/arm/mach-ux500/include/mach/u8500-prcm.h b/arch/arm/mach-ux500/include/mach/u8500-prcm.h
new file mode 100644
index 0000000..5131649
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/u8500-prcm.h
@@ -0,0 +1,57 @@
+/*
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * Author: Kumar Sanghvi <kumar.sanghvi@stericsson.com>
+ *
+ * PRCM Mailbox definitions
+ */
+#ifndef __U8500_PRCM_H
+#define __U8500_PRCM_H
+
+#include <mach/hardware.h>
+
+#define _PRCMU_TCDM_BASE		IO_ADDRESS(U8500_PRCMU_TCDM_BASE)
+
+#define PRCM_CUR_PWRSTATE		(_PRCMU_TCDM_BASE + 0xffc)
+
+/* PRCM Mbox header */
+#define _PRCM_MBOX_HEADER		(_PRCMU_TCDM_BASE + 0xfe8)
+#define PRCM_MBOX_HEADER_REQ		(_PRCM_MBOX_HEADER + 0x0)
+#define PRCM_MBOX_HEADER_ACK		(_PRCM_MBOX_HEADER + 0x8)
+
+/* PRCM MailBox 1
+ *
+ * requests for controlling :
+ * - ARM OPP
+ * - APE OPP
+ * - Boost mode OPP
+ *
+ * replies for querying :
+ * - ARM/APE/Boost mode OPP
+ * - current DVFS transitions
+ */
+/* maiboxes */
+#define PRCM_REQ_MBOX1			(_PRCMU_TCDM_BASE + 0xfd0)
+#define PRCM_ACK_MBOX1			(_PRCMU_TCDM_BASE + 0xe04)
+
+/* headers */
+#define PRCM_MBOX_HEADER_REQ_MBOX1	(PRCM_MBOX_HEADER_REQ + 0x1)
+#define PRCM_MBOX_HEADER_ACK_MBOX1	(PRCM_MBOX_HEADER_ACK + 0x1)
+
+/* Mailbox 1 Requests */
+#define PRCM_MBOX1_REQ_ARMOPP		(PRCM_REQ_MBOX1 + 0x0)
+#define PRCM_MBOX1_REQ_APEOPP		(PRCM_REQ_MBOX1 + 0x1)
+#define PRCM_MBOX1_REQ_BOOSTOPP		(PRCM_REQ_MBOX1 + 0x2)
+
+/* Mailbox 1 ACKs */
+#define PRCM_MBOX1_ACK_ARMOPP		(PRCM_ACK_MBOX1 + 0x0)
+#define PRCM_MBOX1_ACK_APEOPP		(PRCM_ACK_MBOX1 + 0x1)
+#define PRCM_MBOX1_ACK_BOOSTOPP		(PRCM_ACK_MBOX1 + 0x2)
+#define PRCM_MBOX1_ACK_DVFS_STATUS	(PRCM_ACK_MBOX1 + 0x3)
+
+/* Mailbox Interrupts */
+#define PRCM_IRQ_ACK_MBOX1		(1 << 0x1)
+#endif /* __U8500_PRCM_H */
diff --git a/arch/arm/mach-ux500/u8500-prcm.c b/arch/arm/mach-ux500/u8500-prcm.c
new file mode 100644
index 0000000..2703768
--- /dev/null
+++ b/arch/arm/mach-ux500/u8500-prcm.c
@@ -0,0 +1,169 @@
+/*
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * Author: Kumar Sanghvi <kumar.sanghvi@stericsson.com>
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com>
+ *
+ * U8500 PRCM Unit driver
+ */
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
+
+#include <mach/u8500-prcm.h>
+#include <mach/u8500-prcm-regs.h>
+#include <mach/u8500-prcm-api.h>
+
+/* PRCM enums, definitions */
+#define U8500_PRCM_PWRSTATE_EXECUTE	(0x2)
+#define U8500_PRCM_MBOX1_ERROR		(0xB)
+
+/* supported mailboxes */
+enum ux500_prcm_mbox {
+	MBOX0,
+	MBOX1,
+};
+
+/* sync-helpers for req mbox 1 */
+DECLARE_COMPLETION(prcm_rqmbox1_completion);
+DEFINE_MUTEX(prcm_rqmbox1_lock);
+
+/**
+ * prcm_get_pwr_state() - get the PRCM current power state
+ */
+static inline int prcm_get_pwr_state(void)
+{
+	return readb(PRCM_CUR_PWRSTATE);
+}
+
+/**
+ * prcm_set_subsys_opp() - set the subsyste,(ARM/APE) frequency
+ * @freq: new frequency to be set
+ * @core: target core as ARM/APE
+ *
+ * this function recieves the new OPP index as requested
+ * and requests the PRCM for the desired core
+ */
+int prcm_set_subsys_opp(unsigned int subsys_opp_idx,
+		unsigned int subsys)
+{
+	int ret = 0;
+	int updated_sys_opp, dvfs_status;
+
+	mutex_lock(&prcm_rqmbox1_lock);
+
+	/* request opp mgmt for mbox  */
+	writel(0x0, PRCM_MBOX_HEADER_REQ_MBOX1);
+
+	/* later on, we handle the APE sub sys */
+	if (subsys == SUBSYS_ARM) {
+		writel(subsys_opp_idx, PRCM_MBOX1_REQ_ARMOPP);
+		writel(0x0, PRCM_MBOX1_REQ_APEOPP);
+	} else {
+		ret = -EINVAL;
+		goto error_ret;
+	}
+
+	/* trigger the prcm */
+	writel((1 << MBOX1), PRCM_MBOX_CPU_SET);
+
+	/* request and wait for reply */
+	wait_for_completion(&prcm_rqmbox1_completion);
+
+	dvfs_status = readb(PRCM_MBOX1_ACK_DVFS_STATUS);
+	/* confirm if dvfs status is not an error */
+	if ((dvfs_status & 0x0f) ==
+			U8500_PRCM_MBOX1_ERROR) {
+		ret = -EINVAL;
+		goto error_ret;
+	}
+
+	updated_sys_opp = readb(PRCM_MBOX1_ACK_ARMOPP);
+
+	mutex_unlock(&prcm_rqmbox1_lock);
+
+	if (subsys_opp_idx != updated_sys_opp)
+		ret = -EINVAL;
+
+error_ret:
+	mutex_unlock(&prcm_rqmbox1_lock);
+	return ret;
+}
+
+/**
+ * prcm_get_subsys_opp() - get the subsys(ARM/APE) frequency
+ * @core: target core as ARM/APE
+ *
+ * this function gets the OPP for the desired core
+ */
+int prcm_get_subsys_opp(unsigned int subsys)
+{
+	if (subsys == SUBSYS_ARM)
+		return readb(PRCM_MBOX1_ACK_ARMOPP);
+	else if (subsys == SUBSYS_APE)
+		return readb(PRCM_MBOX1_ACK_APEOPP);
+	else
+		return -EINVAL;
+}
+
+/**
+ * prcm_irq_handler() - IRQ handler
+ * @irq:        the irq number
+ * @ctrlr:      control
+ */
+static irqreturn_t prcm_irq_handler (int irq, void *ctrlr)
+{
+	/* clear interrupts */
+	if (readl(PRCM_ARM_IT1_VAL) & PRCM_IRQ_ACK_MBOX1) {
+		complete(&prcm_rqmbox1_completion);
+		writeb(PRCM_IRQ_ACK_MBOX1, PRCM_ARM_IT1_CLEAR);
+	} else
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * u8500_prcm_init() - U8500 PRCM driver init
+ */
+static int u8500_prcm_init(void)
+{
+	int err;
+
+	if (cpu_is_u8500ed()) {
+		printk(KERN_INFO "ux500-prcm: Not supported on ED versions\n");
+		return 0;
+	}
+
+	/* check if the PRCM is active or not */
+	if (prcm_get_pwr_state() != U8500_PRCM_PWRSTATE_EXECUTE) {
+		printk(KERN_INFO "ux500-prcm: no prcm available\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * clear all prcm interrupts.
+	 * possibly some transaction can happen (from u-boot)
+	 * even before the driver starts
+	 */
+	writeb(0xFF, PRCM_ARM_IT1_CLEAR);
+
+	err = request_irq(IRQ_PRCMU, prcm_irq_handler, IRQF_TRIGGER_HIGH,
+			"prcm_irq", NULL);
+	if (err < 0) {
+		printk(KERN_ERR
+			"ux500-prcm: Failed to request irq\n");
+		return err;
+	}
+
+	printk(KERN_INFO "ux500-prcm: prcm init done\n");
+
+	return 0;
+}
+
+arch_initcall(u8500_prcm_init);
-- 
1.6.3.3
