From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed,  7 Apr 2010 18:05:22 +0300
Subject: [PATCH 1/2] [ARM] pxa: add minimal ULPI functionality for USB host
	port 2 on PXA310.
In-Reply-To: <cover.1270651775.git.grinberg@compulab.co.il>
References: <cover.1270651775.git.grinberg@compulab.co.il>
Message-ID: <fa93111b71cf1e43eef23869466072be4db67bcd.1270651775.git.grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/Makefile      |    1 +
 arch/arm/mach-pxa/pxa310-ulpi.c |  240 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/pxa310-ulpi.h |   85 ++++++++++++++
 3 files changed, 326 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-pxa/pxa310-ulpi.c
 create mode 100644 arch/arm/mach-pxa/pxa310-ulpi.h

diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 86bc87b..76d52f4 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o pxa2xx.o pxa25x.o
 obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o pxa2xx.o pxa27x.o
 obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o pxa3xx.o smemc.o
 obj-$(CONFIG_CPU_PXA300)	+= pxa300.o
+obj-$(CONFIG_CPU_PXA310)	+= pxa310-ulpi.o
 obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
 obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
 
diff --git a/arch/arm/mach-pxa/pxa310-ulpi.c b/arch/arm/mach-pxa/pxa310-ulpi.c
new file mode 100644
index 0000000..ab82db8
--- /dev/null
+++ b/arch/arm/mach-pxa/pxa310-ulpi.c
@@ -0,0 +1,240 @@
+/*
+ * linux/arch/arm/mach-pxa/pxa310-ulpi.c
+ *
+ * PXA310 ULPI USB host implementation.
+ *
+ * Copyright (C) 2010 CompuLab Ltd.
+ *
+ * Igor Grinberg <grinberg@compulab.co.il>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+
+#include <mach/regs-u2d.h>
+
+#include "pxa310-ulpi.h"
+
+static void __iomem *u2d_mmio_base;
+
+static inline unsigned int u2d_readl(unsigned int off)
+{
+	return __raw_readl(u2d_mmio_base + off);
+}
+
+static inline void u2d_writel(unsigned int off, unsigned int val)
+{
+	__raw_writel(val, u2d_mmio_base + off);
+}
+
+static inline enum u2d_phy_mode ulpi_get_phymode(void)
+{
+	return (u2d_readl(U2DOTGUSR) & 0xF0000000) >> 28;
+}
+
+static bool ulpi_is_in_sync_mode(void)
+{
+	enum u2d_phy_mode state = ulpi_get_phymode();
+
+	return (state == SYNCH) || (state == PRE_SYNCH);
+}
+
+static int ulpi_poll(void)
+{
+	int timeout = 50000;
+
+	while (timeout--) {
+		if (!(u2d_readl(U2DOTGUCR) & U2DOTGUCR_RUN))
+			return 0;
+
+		cpu_relax();
+	}
+
+	pr_warning("%s: ULPI access timed out!\n", __func__);
+
+	return -ETIMEDOUT;
+}
+
+static int ulpi_reg_read(u8 reg, u8 *value)
+{
+	int err = 0;
+
+	if (!ulpi_is_in_sync_mode()) {
+		pr_warning("%s: PHY is not in SYNCH mode!\n", __func__);
+		return -EBUSY;
+	}
+
+	u2d_writel(U2DOTGUCR,
+		   U2DOTGUCR_RUN | U2DOTGUCR_RNW | (reg << U2DOTGUCR_ADDR_S));
+	msleep(5);
+
+	err = ulpi_poll();
+	if (err)
+		return err;
+
+	*value = (u8)(u2d_readl(U2DOTGUCR) & U2DOTGUCR_RDATA);
+
+	return 0;
+}
+
+static int ulpi_reg_write(u8 reg, u8 value)
+{
+	int err;
+
+	if (!ulpi_is_in_sync_mode()) {
+		pr_warning("%s: PHY is not in SYNCH mode!\n", __func__);
+		return -EBUSY;
+	}
+
+	u2d_writel(U2DOTGUCR, U2DOTGUCR_RUN | (reg << U2DOTGUCR_ADDR_S)
+					    | (value << U2DOTGUCR_WDATA_S));
+	msleep(5);
+
+	err = ulpi_poll();
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int u2d_clk_enable(void)
+{
+	int err;
+	struct clk *u2d_clk;
+
+	u2d_clk = clk_get(NULL, "U2DCLK");
+	if (IS_ERR(u2d_clk)) {
+		err = PTR_ERR(u2d_clk);
+		pr_err("%s: failed to get U2DCLK: %d\n", __func__, err);
+		return err;
+	}
+	clk_enable(u2d_clk);
+
+	return 0;
+}
+
+static void u2d_otg_host_init(void)
+{
+	u32 u2dotgcr;
+
+	/* setup OTG controller registers */
+	u2dotgcr = u2d_readl(U2DOTGCR);
+	u2dotgcr |= U2DOTGCR_ULAF | U2DOTGCR_UTMID;
+	u2dotgcr &= ~(U2DOTGCR_SMAF | U2DOTGCR_CKAF);
+	u2d_writel(U2DOTGCR, u2dotgcr);
+	msleep(5);
+	u2d_writel(U2DOTGCR, u2dotgcr | U2DOTGCR_ULE);
+	msleep(5);
+
+	/* no OTG interrupts in host mode */
+	u2d_writel(U2DOTGICR, u2d_readl(U2DOTGICR) & ~U2DOTGICR_MASK);
+}
+
+static void u2d_ulpi_rtsm(void)
+{
+	u32 u2dotgcr;
+
+	/* put PHY to sync mode */
+	u2d_writel(U2DOTGCR, u2d_readl(U2DOTGCR) | U2DOTGCR_RTSM);
+	msleep(10);
+
+	/* setup OTG sync mode */
+	u2dotgcr = u2d_readl(U2DOTGCR) | U2DOTGCR_ULAF;
+	u2dotgcr &= ~(U2DOTGCR_SMAF | U2DOTGCR_CKAF);
+	u2d_writel(U2DOTGCR, u2dotgcr);
+}
+
+static void u2d_disable_otg_device(void)
+{
+	/* disable USB2 Device controller */
+	u2d_writel(U2DCR, u2d_readl(U2DCR) & ~U2DCR_UDE);
+	u2d_writel(U2DOTGCR, u2d_readl(U2DOTGCR) | U2DOTGCR_UTMID);
+
+	/* disable the otg interrupts */
+	u2d_writel(U2DOTGICR, u2d_readl(U2DOTGICR) & ~U2DOTGICR_MASK);
+}
+
+static int u2d_set_ulpi_serial(enum u2d_phy_mode mode)
+{
+	int err = 0;
+	u32 u2dotgcr;
+
+	/* enable the 15K Ohm pull-down resistor on D+ */
+	err = ulpi_reg_write(ULPI_OTG_CONTROL_SET, ULPI_OC_DPPULLDOWN);
+	if (err)
+		return err;
+
+	/* enable the 15K Ohm pull-down resistor on D- */
+	err = ulpi_reg_write(ULPI_OTG_CONTROL_SET, ULPI_OC_DMPULLDOWN);
+	if (err)
+		return err;
+
+	/* drive 5V on VBUS */
+	err = ulpi_reg_write(ULPI_OTG_CONTROL_SET, ULPI_OC_DRVVBUS);
+	if (err)
+		return err;
+
+	/* configure UHC for 6/3-pin serial mode */
+	if (mode == SER_6PIN)
+		u2d_writel(U2DP3CR, u2d_readl(U2DP3CR) & ~U2DP3CR_P2SS);
+	else if (mode == SER_3PIN)
+		u2d_writel(U2DP3CR, u2d_readl(U2DP3CR) | U2DP3CR_P2SS);
+
+	/* put PHY into host mode */
+	err = ulpi_reg_write(ULPI_FUNCTION_CONTROL_SET, 0x45);
+	if (err)
+		return err;
+
+	/* set PHY to serial 6/3 pin mode */
+	if (mode == SER_6PIN)
+		err = ulpi_reg_write(ULPI_INTERFACE_CONTROL, ULPI_IC_6PIN);
+	else if (mode == SER_3PIN)
+		err = ulpi_reg_write(ULPI_INTERFACE_CONTROL, ULPI_IC_3PIN);
+	if (err)
+		return err;
+
+	/* enable the serial mode */
+	u2dotgcr = u2d_readl(U2DOTGCR) | U2DOTGCR_SMAF;
+	u2d_writel(U2DOTGCR, u2dotgcr & ~(U2DOTGCR_ULAF | U2DOTGCR_CKAF));
+
+	return 0;
+}
+
+int pxa310_ulpi_init(enum u2d_phy_mode mode)
+{
+	int err;
+
+	err = u2d_clk_enable();
+	if (err)
+		goto err_out;
+
+	u2d_mmio_base = ioremap(U2D_PHYS_BASE, 0x1300);
+	if (u2d_mmio_base == NULL) {
+		pr_err("%s: failed to remap U2D registers address space\n",
+			__func__);
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	u2d_otg_host_init();
+	u2d_ulpi_rtsm();
+	u2d_disable_otg_device();
+
+	err = u2d_set_ulpi_serial(mode);
+	if (err)
+		goto err_out;
+
+	return 0;
+
+err_out:
+	pr_err("%s: ULPI init failed: %d\n", __func__, err);
+	return err;
+}
diff --git a/arch/arm/mach-pxa/pxa310-ulpi.h b/arch/arm/mach-pxa/pxa310-ulpi.h
new file mode 100644
index 0000000..87558f0
--- /dev/null
+++ b/arch/arm/mach-pxa/pxa310-ulpi.h
@@ -0,0 +1,85 @@
+/*
+ * linux/arch/arm/mach-pxa/pxa310-ulpi.h
+ *
+ * PXA310 ULPI USB host header file.
+ *
+ * Copyright (C) 2010 CompuLab Ltd.
+ *
+ * Igor Grinberg <grinberg@compulab.co.il>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __PXA310_ULPI__
+#define __PXA310_ULPI__
+
+/* OTG Interrupts */
+#define U2DOTGICR_MASK		0x37F7F
+
+/* PXA310 USB OTG Controller */
+#define ULPI_VENDOR_LOW		0x0
+#define ULPI_VENDOR_HIGH		0x1
+#define ULPI_PRODUCT_LOW		0x2
+#define ULPI_PRODUCT_HIGH		0x3
+#define ULPI_FUNCTION_CONTROL		0x4
+#define ULPI_FUNCTION_CONTROL_SET	0x5
+#define ULPI_FUNCTION_CONTROL_CLEAR	0x6
+#define ULPI_INTERFACE_CONTROL		0x7
+#define ULPI_INTERFACE_CONTROL_SET	0x8
+#define ULPI_INTERFACE_CONTROL_CLEAR	0x9
+#define ULPI_OTG_CONTROL		0xA
+#define ULPI_OTG_CONTROL_SET		0xB
+#define ULPI_OTG_CONTROL_CLEAR		0xC
+#define ULPI_INT_RISE			0xD
+#define ULPI_INT_RISE_SET		0xE
+#define ULPI_INT_RISE_CLEAR		0xF
+#define ULPI_INT_FALL			0x10
+#define ULPI_INT_FALL_SET		0x11
+#define ULPI_INT_FALL_CLEAR		0x12
+#define ULPI_INT_STATUS		0x13
+#define ULPI_INT_LATCH			0x14
+#define ULPI_DEBUG			0x15
+#define ULPI_SCRATCH			0x16
+#define ULPI_SCRATCH_SET		0x17
+#define ULPI_SCRATCH_CLEAR		0x18
+
+#define ULPI_FC_RESET		(1 << 5)	/* XCVR Reset */
+#define ULPI_FC_SUSPENDM	(1 << 6)	/* XCVR SuspendM, Low Power Mode */
+
+#define ULPI_IC_6PIN		(1 << 0)	/* XCVR 6 pin mode */
+#define ULPI_IC_3PIN		(1 << 1)	/* XCVR 3 pin mode */
+#define ULPI_IC_CARKIT		(1 << 2)	/* Carkit mode */
+#define ULPI_IC_CLKSUSPENDM	(1 << 3)	/* Active low clock suspend */
+
+#define ULPI_OC_IDPULLUP	(1 << 0)	/* ID Pull Up, enable sampling of ID line */
+#define ULPI_OC_DPPULLDOWN	(1 << 1)	/* Enable the 15K Ohm pull down resistor on D+ */
+#define ULPI_OC_DMPULLDOWN	(1 << 2)	/* Enable the 15K Ohm pull down resistor on D- */
+#define ULPI_OC_DISCHRGVBUS	(1 << 3)	/* Discharge Vbus */
+#define ULPI_OC_CHRGVBUS	(1 << 4)	/* Charge Vbus, for Vbus pulsing SRP */
+#define ULPI_OC_DRVVBUS	(1 << 5)	/* Drive 5V on Vbus */
+#define ULPI_OC_DRVVBUSEXT	(1 << 6)	/* Drive Vbus using external supply */
+
+#define ULPI_INT_HOSTDISCON	(1 << 0)	/* Host Disconnect */
+#define ULPI_INT_VBUSVALID	(1 << 1)	/* Vbus Valid */
+#define ULPI_INT_SESSIONVALID	(1 << 2)	/* Session Valid */
+#define ULPI_INT_SESSIONEND	(1 << 3)	/* Session End */
+#define ULPI_INT_IDGND		(1 << 4)	/* current status of IDGND */
+
+#define U2DOTGUCR_ADDR_S	(16)
+#define U2DOTGUCR_WDATA_S	(8)
+
+#define U2D_PHYS_BASE   0x54100000
+
+enum u2d_phy_mode {
+	SYNCH		= 0,
+	CARKIT		= (1 << 0),
+	SER_3PIN	= (1 << 1),
+	SER_6PIN	= (1 << 2),
+	LOWPOWER	= (1 << 3),
+	PRE_SYNCH	= (1 << 4),
+};
+
+int pxa310_ulpi_init(enum u2d_phy_mode);
+
+#endif /* __PXA310_ULPI__ */
-- 
1.6.4.4
