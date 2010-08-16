From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Mon, 16 Aug 2010 16:59:25 +0200
Subject: [PATCH] ARM: U8500 PRCMU driver
Message-ID: <1281970765-6576-1-git-send-email-mattias.wallin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mattias Nilsson <mattias.i.nilsson@stericsson.com>

Add an initial driver for communicating with the Power, Reset and
Clock Management Unit (PRCMU) firmware in U8500.
This initial version supports AB8500 communication only.

Signed-off-by: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/Makefile                  |    2 +-
 arch/arm/mach-ux500/include/mach/irqs.h       |    1 +
 arch/arm/mach-ux500/include/mach/prcmu-regs.h |   91 ++++++++++
 arch/arm/mach-ux500/include/mach/prcmu.h      |   15 ++
 arch/arm/mach-ux500/prcmu.c                   |  231 +++++++++++++++++++++++++
 5 files changed, 339 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ux500/include/mach/prcmu-regs.h
 create mode 100644 arch/arm/mach-ux500/include/mach/prcmu.h
 create mode 100644 arch/arm/mach-ux500/prcmu.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 002ebdc..ed180b8 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -4,7 +4,7 @@
 
 obj-y				:= clock.o cpu.o devices.o
 obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o devices-db5500.o
-obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
+obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o board-mop500-sdi.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index 10385bd..0e7a2ce 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -41,6 +41,7 @@
 #define IRQ_HSIR_CH2_OVRRUN	(IRQ_SHPI_START + 34)
 #define IRQ_HSIR_CH3_OVRRUN	(IRQ_SHPI_START + 35)
 #define IRQ_AB4500		(IRQ_SHPI_START + 40)
+#define IRQ_PRCMU               (IRQ_SHPI_START + 47)
 #define IRQ_DISP		(IRQ_SHPI_START + 48)
 #define IRQ_SiPI3		(IRQ_SHPI_START + 49)
 #define IRQ_I2C4		(IRQ_SHPI_START + 51)
diff --git a/arch/arm/mach-ux500/include/mach/prcmu-regs.h b/arch/arm/mach-ux500/include/mach/prcmu-regs.h
new file mode 100644
index 0000000..8885f39
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/prcmu-regs.h
@@ -0,0 +1,91 @@
+/*
+ * Copyright (c) 2009 ST-Ericsson SA
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ */
+#ifndef __MACH_PRCMU_REGS_H
+#define __MACH_PRCMU_REGS_H
+
+#include <mach/hardware.h>
+
+#define _PRCMU_BASE		IO_ADDRESS(U8500_PRCMU_BASE)
+
+#define PRCM_ARM_PLLDIVPS	(_PRCMU_BASE + 0x118)
+#define PRCM_ARM_CHGCLKREQ	(_PRCMU_BASE + 0x114)
+#define PRCM_PLLARM_ENABLE	(_PRCMU_BASE + 0x98)
+#define PRCM_ARMCLKFIX_MGT	(_PRCMU_BASE + 0x0)
+#define PRCM_A9_RESETN_CLR	(_PRCMU_BASE + 0x1f4)
+#define PRCM_A9_RESETN_SET	(_PRCMU_BASE + 0x1f0)
+#define PRCM_ARM_LS_CLAMP	(_PRCMU_BASE + 0x30c)
+#define PRCM_SRAM_A9		(_PRCMU_BASE + 0x308)
+
+/* ARM WFI Standby signal register */
+#define PRCM_ARM_WFI_STANDBY    (_PRCMU_BASE + 0x130)
+#define PRCMU_IOCR              (_PRCMU_BASE + 0x310)
+
+/* CPU mailbox registers */
+#define PRCM_MBOX_CPU_VAL	(_PRCMU_BASE + 0x0fc)
+#define PRCM_MBOX_CPU_SET	(_PRCMU_BASE + 0x100)
+#define PRCM_MBOX_CPU_CLR	(_PRCMU_BASE + 0x104)
+
+/* Dual A9 core interrupt management unit registers */
+#define PRCM_A9_MASK_REQ	(_PRCMU_BASE + 0x328)
+#define PRCM_A9_MASK_ACK	(_PRCMU_BASE + 0x32c)
+#define PRCM_ARMITMSK31TO0	(_PRCMU_BASE + 0x11c)
+#define PRCM_ARMITMSK63TO32	(_PRCMU_BASE + 0x120)
+#define PRCM_ARMITMSK95TO64	(_PRCMU_BASE + 0x124)
+#define PRCM_ARMITMSK127TO96	(_PRCMU_BASE + 0x128)
+#define PRCM_POWER_STATE_VAL	(_PRCMU_BASE + 0x25C)
+#define PRCM_ARMITVAL31TO0	(_PRCMU_BASE + 0x260)
+#define PRCM_ARMITVAL63TO32	(_PRCMU_BASE + 0x264)
+#define PRCM_ARMITVAL95TO64	(_PRCMU_BASE + 0x268)
+#define PRCM_ARMITVAL127TO96	(_PRCMU_BASE + 0x26C)
+
+#define PRCM_HOSTACCESS_REQ	(_PRCMU_BASE + 0x334)
+#define ARM_WAKEUP_MODEM	0x1
+
+#define PRCM_ARM_IT1_CLEAR	(_PRCMU_BASE + 0x48C)
+#define PRCM_ARM_IT1_VAL	(_PRCMU_BASE + 0x494)
+#define PRCM_HOLD_EVT		(_PRCMU_BASE + 0x174)
+
+#define PRCM_ITSTATUS0		(_PRCMU_BASE + 0x148)
+#define PRCM_ITSTATUS1		(_PRCMU_BASE + 0x150)
+#define PRCM_ITSTATUS2		(_PRCMU_BASE + 0x158)
+#define PRCM_ITSTATUS3		(_PRCMU_BASE + 0x160)
+#define PRCM_ITSTATUS4		(_PRCMU_BASE + 0x168)
+#define PRCM_ITSTATUS5		(_PRCMU_BASE + 0x484)
+#define PRCM_ITCLEAR5		(_PRCMU_BASE + 0x488)
+#define PRCM_ARMIT_MASKXP70_IT	(_PRCMU_BASE + 0x1018)
+
+/* System reset register */
+#define PRCM_APE_SOFTRST	(_PRCMU_BASE + 0x228)
+
+/* Level shifter and clamp control registers */
+#define PRCM_MMIP_LS_CLAMP_SET     (_PRCMU_BASE + 0x420)
+#define PRCM_MMIP_LS_CLAMP_CLR     (_PRCMU_BASE + 0x424)
+
+/* PRCMU clock/PLL/reset registers */
+#define PRCM_PLLDSI_FREQ           (_PRCMU_BASE + 0x500)
+#define PRCM_PLLDSI_ENABLE         (_PRCMU_BASE + 0x504)
+#define PRCM_LCDCLK_MGT            (_PRCMU_BASE + 0x044)
+#define PRCM_MCDECLK_MGT           (_PRCMU_BASE + 0x064)
+#define PRCM_HDMICLK_MGT           (_PRCMU_BASE + 0x058)
+#define PRCM_TVCLK_MGT             (_PRCMU_BASE + 0x07c)
+#define PRCM_DSI_PLLOUT_SEL        (_PRCMU_BASE + 0x530)
+#define PRCM_DSITVCLK_DIV          (_PRCMU_BASE + 0x52C)
+#define PRCM_APE_RESETN_SET        (_PRCMU_BASE + 0x1E4)
+#define PRCM_APE_RESETN_CLR        (_PRCMU_BASE + 0x1E8)
+
+/* ePOD and memory power signal control registers */
+#define PRCM_EPOD_C_SET            (_PRCMU_BASE + 0x410)
+#define PRCM_SRAM_LS_SLEEP         (_PRCMU_BASE + 0x304)
+
+/* Debug power control unit registers */
+#define PRCM_POWER_STATE_SET       (_PRCMU_BASE + 0x254)
+
+/* Miscellaneous unit registers */
+#define PRCM_DSI_SW_RESET          (_PRCMU_BASE + 0x324)
+
+#endif /* __MACH_PRCMU__REGS_H */
diff --git a/arch/arm/mach-ux500/include/mach/prcmu.h b/arch/arm/mach-ux500/include/mach/prcmu.h
new file mode 100644
index 0000000..549843f
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/prcmu.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * PRCMU f/w APIs
+ */
+#ifndef __MACH_PRCMU_H
+#define __MACH_PRCMU_H
+
+int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size);
+int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size);
+
+#endif /* __MACH_PRCMU_H */
diff --git a/arch/arm/mach-ux500/prcmu.c b/arch/arm/mach-ux500/prcmu.c
new file mode 100644
index 0000000..293274d
--- /dev/null
+++ b/arch/arm/mach-ux500/prcmu.c
@@ -0,0 +1,231 @@
+/*
+ * Copyright (C) ST Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License v2
+ * Author: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
+ *
+ * U8500 PRCMU driver.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/completion.h>
+#include <linux/jiffies.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+
+#include <mach/hardware.h>
+#include <mach/prcmu-regs.h>
+
+#define PRCMU_TCDM_BASE __io_address(U8500_PRCMU_TCDM_BASE)
+
+#define REQ_MB5 (PRCMU_TCDM_BASE + 0xE44)
+#define ACK_MB5 (PRCMU_TCDM_BASE + 0xDF4)
+
+#define REQ_MB5_I2C_SLAVE_OP (REQ_MB5)
+#define REQ_MB5_I2C_HW_BITS (REQ_MB5 + 1)
+#define REQ_MB5_I2C_REG (REQ_MB5 + 2)
+#define REQ_MB5_I2C_VAL (REQ_MB5 + 3)
+
+#define ACK_MB5_I2C_STATUS (ACK_MB5 + 1)
+#define ACK_MB5_I2C_VAL (ACK_MB5 + 3)
+
+#define I2C_WRITE(slave) ((slave) << 1)
+#define I2C_READ(slave) (((slave) << 1) | BIT(0))
+#define I2C_STOP_EN BIT(3)
+
+enum ack_mb5_status {
+	I2C_WR_OK = 0x01,
+	I2C_RD_OK = 0x02,
+};
+
+#define MBOX_BIT BIT
+#define NUM_MBOX 8
+
+static struct {
+	struct mutex lock;
+	struct completion work;
+	bool failed;
+	struct {
+		u8 status;
+		u8 value;
+	} ack;
+} mb5_transfer;
+
+/**
+ * prcmu_abb_read() - Read register value(s) from the ABB.
+ * @slave:	The I2C slave address.
+ * @reg:	The (start) register address.
+ * @value:	The read out value(s).
+ * @size:	The number of registers to read.
+ *
+ * Reads register value(s) from the ABB.
+ * @size has to be 1 for the current firmware version.
+ */
+int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
+{
+	int r;
+
+	if (size != 1)
+		return -EINVAL;
+
+	r = mutex_lock_interruptible(&mb5_transfer.lock);
+	if (r)
+		return r;
+
+	while (readl(PRCM_MBOX_CPU_VAL) & MBOX_BIT(5))
+		cpu_relax();
+
+	writeb(I2C_READ(slave), REQ_MB5_I2C_SLAVE_OP);
+	writeb(I2C_STOP_EN, REQ_MB5_I2C_HW_BITS);
+	writeb(reg, REQ_MB5_I2C_REG);
+
+	writel(MBOX_BIT(5), PRCM_MBOX_CPU_SET);
+	if (!wait_for_completion_timeout(&mb5_transfer.work,
+			msecs_to_jiffies(500))) {
+		pr_err("prcmu: prcmu_abb_read timed out.\n");
+		r = -EIO;
+		goto unlock_and_return;
+	}
+	r = ((mb5_transfer.ack.status == I2C_RD_OK) ? 0 : -EIO);
+	if (!r)
+		*value = mb5_transfer.ack.value;
+
+unlock_and_return:
+	mutex_unlock(&mb5_transfer.lock);
+	return r;
+}
+EXPORT_SYMBOL(prcmu_abb_read);
+
+/**
+ * prcmu_abb_write() - Write register value(s) to the ABB.
+ * @slave:	The I2C slave address.
+ * @reg:	The (start) register address.
+ * @value:	The value(s) to write.
+ * @size:	The number of registers to write.
+ *
+ * Reads register value(s) from the ABB.
+ * @size has to be 1 for the current firmware version.
+ */
+int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size)
+{
+	int r;
+
+	if (size != 1)
+		return -EINVAL;
+
+	r = mutex_lock_interruptible(&mb5_transfer.lock);
+	if (r)
+		return r;
+
+
+	while (readl(PRCM_MBOX_CPU_VAL) & MBOX_BIT(5))
+		cpu_relax();
+
+	writeb(I2C_WRITE(slave), REQ_MB5_I2C_SLAVE_OP);
+	writeb(I2C_STOP_EN, REQ_MB5_I2C_HW_BITS);
+	writeb(reg, REQ_MB5_I2C_REG);
+	writeb(*value, REQ_MB5_I2C_VAL);
+
+	writel(MBOX_BIT(5), PRCM_MBOX_CPU_SET);
+	if (!wait_for_completion_timeout(&mb5_transfer.work,
+			msecs_to_jiffies(500))) {
+		pr_err("prcmu: prcmu_abb_write timed out.\n");
+		r = -EIO;
+		goto unlock_and_return;
+	}
+	r = ((mb5_transfer.ack.status == I2C_WR_OK) ? 0 : -EIO);
+
+unlock_and_return:
+	mutex_unlock(&mb5_transfer.lock);
+	return r;
+}
+EXPORT_SYMBOL(prcmu_abb_write);
+
+static void read_mailbox_0(void)
+{
+	writel(MBOX_BIT(0), PRCM_ARM_IT1_CLEAR);
+}
+
+static void read_mailbox_1(void)
+{
+	writel(MBOX_BIT(1), PRCM_ARM_IT1_CLEAR);
+}
+
+static void read_mailbox_2(void)
+{
+	writel(MBOX_BIT(2), PRCM_ARM_IT1_CLEAR);
+}
+
+static void read_mailbox_3(void)
+{
+	writel(MBOX_BIT(3), PRCM_ARM_IT1_CLEAR);
+}
+
+static void read_mailbox_4(void)
+{
+	writel(MBOX_BIT(4), PRCM_ARM_IT1_CLEAR);
+}
+
+static void read_mailbox_5(void)
+{
+	mb5_transfer.ack.status = readb(ACK_MB5_I2C_STATUS);
+	mb5_transfer.ack.value = readb(ACK_MB5_I2C_VAL);
+	complete(&mb5_transfer.work);
+	writel(MBOX_BIT(5), PRCM_ARM_IT1_CLEAR);
+}
+
+static void read_mailbox_6(void)
+{
+	writel(MBOX_BIT(6), PRCM_ARM_IT1_CLEAR);
+}
+
+static void read_mailbox_7(void)
+{
+	writel(MBOX_BIT(7), PRCM_ARM_IT1_CLEAR);
+}
+
+static void (* const read_mailbox[NUM_MBOX])(void) = {
+	read_mailbox_0,
+	read_mailbox_1,
+	read_mailbox_2,
+	read_mailbox_3,
+	read_mailbox_4,
+	read_mailbox_5,
+	read_mailbox_6,
+	read_mailbox_7
+};
+
+static irqreturn_t prcmu_irq_handler(int irq, void *data)
+{
+	u32 bits;
+	u8 n;
+
+	bits = (readl(PRCM_ARM_IT1_VAL) & (MBOX_BIT(NUM_MBOX) - 1));
+	if (unlikely(!bits))
+		return IRQ_NONE;
+
+	for (n = 0; bits; n++) {
+		if (bits & MBOX_BIT(n)) {
+			bits -= MBOX_BIT(n);
+			read_mailbox[n]();
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+static int __init prcmu_init(void)
+{
+	mutex_init(&mb5_transfer.lock);
+	init_completion(&mb5_transfer.work);
+
+	/* Clean up the mailbox interrupts after pre-kernel code. */
+	writel((MBOX_BIT(NUM_MBOX) - 1), PRCM_ARM_IT1_CLEAR);
+
+	return request_irq(IRQ_PRCMU, prcmu_irq_handler, 0, "prcmu", NULL);
+}
+
+arch_initcall(prcmu_init);
-- 
1.6.3.3
