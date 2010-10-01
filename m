From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:44 -0700
Subject: [PATCH 20/47] davinci: add support for aemif timing configuration
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-21-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

This patch adds support to configure the AEMIF interface
with supplied timing values.

Since this capability is useful both from NOR and NAND
flashes, it is provided as a new interface and in a file
of its own.

AEMIF timing configuration is required in cases:

1) Where the AEMIF clock rate can change at runtime (a side
   affect of cpu frequency change).

2) Where U-Boot does not support NAND/NOR but supports other
   media like SPI Flash or MMC/SD and thus does not care about
   setting up the AEMIF timing for kernel to use.

3) Where U-Boot just hasn't configured the timing values and
   cannot be upgraded because the box is already in the field.

Since there is now a header file for AEMIF interface, the
common (non-NAND specific) defines for AEMIF registers have
been moved from nand.h into the newly created aemif.h

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/Makefile             |    2 +-
 arch/arm/mach-davinci/aemif.c              |  133 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/aemif.h |   36 ++++++++
 arch/arm/mach-davinci/include/mach/nand.h  |    3 -
 drivers/mtd/nand/davinci_nand.c            |    1 +
 5 files changed, 171 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-davinci/aemif.c
 create mode 100644 arch/arm/mach-davinci/include/mach/aemif.h

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index eab4c0f..77a0f71 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -5,7 +5,7 @@
 
 # Common objects
 obj-y 			:= time.o clock.o serial.o io.o psc.o \
-			   gpio.o dma.o usb.o common.o sram.o
+			   gpio.o dma.o usb.o common.o sram.o aemif.o
 
 obj-$(CONFIG_DAVINCI_MUX)		+= mux.o
 
diff --git a/arch/arm/mach-davinci/aemif.c b/arch/arm/mach-davinci/aemif.c
new file mode 100644
index 0000000..9c3f500
--- /dev/null
+++ b/arch/arm/mach-davinci/aemif.c
@@ -0,0 +1,133 @@
+/*
+ * AEMIF support for DaVinci SoCs
+ *
+ * Copyright (C) 2010 Texas Instruments Incorporated. http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/time.h>
+
+#include <mach/aemif.h>
+
+/* Timing value configuration */
+
+#define TA(x)		((x) << 2)
+#define RHOLD(x)	((x) << 4)
+#define RSTROBE(x)	((x) << 7)
+#define RSETUP(x)	((x) << 13)
+#define WHOLD(x)	((x) << 17)
+#define WSTROBE(x)	((x) << 20)
+#define WSETUP(x)	((x) << 26)
+
+#define TA_MAX		0x3
+#define RHOLD_MAX	0x7
+#define RSTROBE_MAX	0x3f
+#define RSETUP_MAX	0xf
+#define WHOLD_MAX	0x7
+#define WSTROBE_MAX	0x3f
+#define WSETUP_MAX	0xf
+
+#define TIMING_MASK	(TA(TA_MAX) | \
+				RHOLD(RHOLD_MAX) | \
+				RSTROBE(RSTROBE_MAX) |	\
+				RSETUP(RSETUP_MAX) | \
+				WHOLD(WHOLD_MAX) | \
+				WSTROBE(WSTROBE_MAX) | \
+				WSETUP(WSETUP_MAX))
+
+/*
+ * aemif_calc_rate - calculate timing data.
+ * @wanted: The cycle time needed in nanoseconds.
+ * @clk: The input clock rate in kHz.
+ * @max: The maximum divider value that can be programmed.
+ *
+ * On success, returns the calculated timing value minus 1 for easy
+ * programming into AEMIF timing registers, else negative errno.
+ */
+static int aemif_calc_rate(int wanted, unsigned long clk, int max)
+{
+	int result;
+
+	result = DIV_ROUND_UP((wanted * clk), NSEC_PER_MSEC) - 1;
+
+	pr_debug("%s: result %d from %ld, %d\n", __func__, result, clk, wanted);
+
+	/* It is generally OK to have a more relaxed timing than requested... */
+	if (result < 0)
+		result = 0;
+
+	/* ... But configuring tighter timings is not an option. */
+	else if (result > max)
+		result = -EINVAL;
+
+	return result;
+}
+
+/**
+ * davinci_aemif_setup_timing - setup timing values for a given AEMIF interface
+ * @t: timing values to be progammed
+ * @base: The virtual base address of the AEMIF interface
+ * @cs: chip-select to program the timing values for
+ *
+ * This function programs the given timing values (in real clock) into the
+ * AEMIF registers taking the AEMIF clock into account.
+ *
+ * This function does not use any locking while programming the AEMIF
+ * because it is expected that there is only one user of a given
+ * chip-select.
+ *
+ * Returns 0 on success, else negative errno.
+ */
+int davinci_aemif_setup_timing(struct davinci_aemif_timing *t,
+					void __iomem *base, unsigned cs)
+{
+	unsigned set, val;
+	unsigned ta, rhold, rstrobe, rsetup, whold, wstrobe, wsetup;
+	unsigned offset = A1CR_OFFSET + cs * 4;
+	struct clk *aemif_clk;
+	unsigned long clkrate;
+
+	if (!t)
+		return 0;	/* Nothing to do */
+
+	aemif_clk = clk_get(NULL, "aemif");
+	if (IS_ERR(aemif_clk))
+		return PTR_ERR(aemif_clk);
+
+	clkrate = clk_get_rate(aemif_clk);
+
+	clkrate /= 1000;	/* turn clock into kHz for ease of use */
+
+	ta	= aemif_calc_rate(t->ta, clkrate, TA_MAX);
+	rhold	= aemif_calc_rate(t->rhold, clkrate, RHOLD_MAX);
+	rstrobe	= aemif_calc_rate(t->rstrobe, clkrate, RSTROBE_MAX);
+	rsetup	= aemif_calc_rate(t->rsetup, clkrate, RSETUP_MAX);
+	whold	= aemif_calc_rate(t->whold, clkrate, WHOLD_MAX);
+	wstrobe	= aemif_calc_rate(t->wstrobe, clkrate, WSTROBE_MAX);
+	wsetup	= aemif_calc_rate(t->wsetup, clkrate, WSETUP_MAX);
+
+	if (ta < 0 || rhold < 0 || rstrobe < 0 || rsetup < 0 ||
+			whold < 0 || wstrobe < 0 || wsetup < 0) {
+		pr_err("%s: cannot get suitable timings\n", __func__);
+		return -EINVAL;
+	}
+
+	set = TA(ta) | RHOLD(rhold) | RSTROBE(rstrobe) | RSETUP(rsetup) |
+		WHOLD(whold) | WSTROBE(wstrobe) | WSETUP(wsetup);
+
+	val = __raw_readl(base + offset);
+	val &= ~TIMING_MASK;
+	val |= set;
+	__raw_writel(val, base + offset);
+
+	return 0;
+}
+EXPORT_SYMBOL(davinci_aemif_setup_timing);
diff --git a/arch/arm/mach-davinci/include/mach/aemif.h b/arch/arm/mach-davinci/include/mach/aemif.h
new file mode 100644
index 0000000..05b2934
--- /dev/null
+++ b/arch/arm/mach-davinci/include/mach/aemif.h
@@ -0,0 +1,36 @@
+/*
+ * TI DaVinci AEMIF support
+ *
+ * Copyright 2010 (C) Texas Instruments, Inc. http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+#ifndef _MACH_DAVINCI_AEMIF_H
+#define _MACH_DAVINCI_AEMIF_H
+
+#define NRCSR_OFFSET		0x00
+#define AWCCR_OFFSET		0x04
+#define A1CR_OFFSET		0x10
+
+#define ACR_ASIZE_MASK		0x3
+#define ACR_EW_MASK		BIT(30)
+#define ACR_SS_MASK		BIT(31)
+
+/* All timings in nanoseconds */
+struct davinci_aemif_timing {
+	u8	wsetup;
+	u8	wstrobe;
+	u8	whold;
+
+	u8	rsetup;
+	u8	rstrobe;
+	u8	rhold;
+
+	u8	ta;
+};
+
+int davinci_aemif_setup_timing(struct davinci_aemif_timing *t,
+					void __iomem *base, unsigned cs);
+#endif
diff --git a/arch/arm/mach-davinci/include/mach/nand.h b/arch/arm/mach-davinci/include/mach/nand.h
index b2ad809..b5893f0 100644
--- a/arch/arm/mach-davinci/include/mach/nand.h
+++ b/arch/arm/mach-davinci/include/mach/nand.h
@@ -30,9 +30,6 @@
 
 #include <linux/mtd/nand.h>
 
-#define NRCSR_OFFSET		0x00
-#define AWCCR_OFFSET		0x04
-#define A1CR_OFFSET		0x10
 #define NANDFCR_OFFSET		0x60
 #define NANDFSR_OFFSET		0x64
 #define NANDF1ECC_OFFSET	0x70
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 2ac7367..8e2d56c 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 
 #include <mach/nand.h>
+#include <mach/aemif.h>
 
 #include <asm/mach-types.h>
 
-- 
1.7.2.1
