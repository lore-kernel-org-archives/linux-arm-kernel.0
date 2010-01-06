From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:07 -0800
Subject: [PATCH 25/35] davinci: add support for CDCE949 clock synthesizer
In-Reply-To: <1262802737-6601-25-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-16-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-17-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-18-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-19-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-20-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-21-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-22-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-23-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-24-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-25-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-26-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nageswari Srinivasan <nageswari@ti.com>

This patch adds support for TI's CDCE949 - a clock
synthesizer with 4 PLLs and 9 outputs.

It is used on DM6467 EVM. On the EVM, it generates
clocks required for VPIF, TSIF and Audio modules.

This patch adds it as part of the DaVinci clock framework.

Testing:
The various frequency outputs on Y1 have been tested using
a out-of-tree VPIF video driver supporting HD video.
The register values for Y5 frequency outputs have been
derived from TSIF driver sources in MontaVista LSP kernel,
but actual output has not been tested for lack of TSIF
driver which actually works on the latest kernel.

Signed-off-by: Nageswari Srinivasan <nageswari@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/cdce949.c              |  289 ++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/cdce949.h |   19 ++
 2 files changed, 308 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-davinci/cdce949.c
 create mode 100644 arch/arm/mach-davinci/include/mach/cdce949.h

diff --git a/arch/arm/mach-davinci/cdce949.c b/arch/arm/mach-davinci/cdce949.c
new file mode 100644
index 0000000..5a08283
--- /dev/null
+++ b/arch/arm/mach-davinci/cdce949.c
@@ -0,0 +1,289 @@
+/*
+ * TI CDCE949 clock synthesizer driver
+ *
+ * Note: This implementation assumes an input of 27MHz to the CDCE.
+ * This is by no means constrained by CDCE hardware although the datasheet
+ * does use this as an example for all illustrations and more importantly:
+ * that is the crystal input on boards it is currently used on.
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated. http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+
+#include <mach/clock.h>
+
+#include "clock.h"
+
+static struct i2c_client *cdce_i2c_client;
+
+/* CDCE register descriptor */
+struct cdce_reg {
+	u8	addr;
+	u8	val;
+};
+
+/* Per-Output (Y1, Y2 etc.) frequency descriptor */
+struct cdce_freq {
+	/* Frequency in KHz */
+	unsigned long frequency;
+	/*
+	 * List of registers to program to obtain a particular frequency.
+	 * 0x0 in register address and value is the end of list marker.
+	 */
+	struct cdce_reg *reglist;
+};
+
+#define CDCE_FREQ_TABLE_ENTRY(line, out)		\
+{							\
+	.reglist	= cdce_y ##line## _ ##out,		\
+	.frequency	= out,				\
+}
+
+/* List of CDCE outputs  */
+struct cdce_output {
+	/* List of frequencies on this output */
+	struct cdce_freq *freq_table;
+	/* Number of possible frequencies */
+	int size;
+};
+
+/*
+ * Finding out the values to program into CDCE949 registers for a particular
+ * frequency output is not a simple calculation. Have a look at the datasheet
+ * for the details. There is desktop software available to help users with
+ * the calculations. Here, we just depend on the output of that software
+ * (or hand calculations) instead trying to runtime calculate the register
+ * values and inflicting misery on ourselves.
+ */
+static struct cdce_reg cdce_y1_148500[] = {
+	{ 0x13, 0x00 },
+	/* program PLL1_0 multiplier */
+	{ 0x18, 0xaf },
+	{ 0x19, 0x50 },
+	{ 0x1a, 0x02 },
+	{ 0x1b, 0xc9 },
+	/* program PLL1_11 multiplier */
+	{ 0x1c, 0x00 },
+	{ 0x1d, 0x40 },
+	{ 0x1e, 0x02 },
+	{ 0x1f, 0xc9 },
+	/* output state selection */
+	{ 0x15, 0x00 },
+	{ 0x14, 0xef },
+	/* switch MUX to PLL1 output */
+	{ 0x14, 0x6f },
+	{ 0x16, 0x06 },
+	/* set P2DIV divider, P3DIV and input crystal */
+	{ 0x17, 0x06 },
+	{ 0x01, 0x00 },
+	{ 0x05, 0x48 },
+	{ 0x02, 0x80 },
+	/* enable and disable PLL */
+	{ 0x02, 0xbc },
+	{ 0x03, 0x01 },
+	{ },
+};
+
+static struct cdce_reg cdce_y1_74250[] = {
+	{ 0x13, 0x00 },
+	{ 0x18, 0xaf },
+	{ 0x19, 0x50 },
+	{ 0x1a, 0x02 },
+	{ 0x1b, 0xc9 },
+	{ 0x1c, 0x00 },
+	{ 0x1d, 0x40 },
+	{ 0x1e, 0x02 },
+	{ 0x1f, 0xc9 },
+	/* output state selection */
+	{ 0x15, 0x00 },
+	{ 0x14, 0xef },
+	/* switch MUX to PLL1 output */
+	{ 0x14, 0x6f },
+	{ 0x16, 0x06 },
+	/* set P2DIV divider, P3DIV and input crystal */
+	{ 0x17, 0x06 },
+	{ 0x01, 0x00 },
+	{ 0x05, 0x48 },
+	{ 0x02, 0x80 },
+	/* enable and disable PLL */
+	{ 0x02, 0xbc },
+	{ 0x03, 0x02 },
+	{ },
+};
+
+static struct cdce_reg cdce_y1_27000[] = {
+	{ 0x13, 0x00 },
+	{ 0x18, 0x00 },
+	{ 0x19, 0x40 },
+	{ 0x1a, 0x02 },
+	{ 0x1b, 0x08 },
+	{ 0x1c, 0x00 },
+	{ 0x1d, 0x40 },
+	{ 0x1e, 0x02 },
+	{ 0x1f, 0x08 },
+	{ 0x15, 0x02 },
+	{ 0x14, 0xed },
+	{ 0x16, 0x01 },
+	{ 0x17, 0x01 },
+	{ 0x01, 0x00 },
+	{ 0x05, 0x50 },
+	{ 0x02, 0xb4 },
+	{ 0x03, 0x01 },
+	{ },
+};
+
+static struct cdce_freq cdce_y1_freqs[] = {
+	CDCE_FREQ_TABLE_ENTRY(1, 148500),
+	CDCE_FREQ_TABLE_ENTRY(1, 74250),
+	CDCE_FREQ_TABLE_ENTRY(1, 27000),
+};
+
+static struct cdce_reg cdce_y5_13500[] = {
+	{ 0x27, 0x08 },
+	{ 0x28, 0x00 },
+	{ 0x29, 0x40 },
+	{ 0x2a, 0x02 },
+	{ 0x2b, 0x08 },
+	{ 0x24, 0x6f },
+	{ },
+};
+
+static struct cdce_reg cdce_y5_16875[] = {
+	{ 0x27, 0x08 },
+	{ 0x28, 0x9f },
+	{ 0x29, 0xb0 },
+	{ 0x2a, 0x02 },
+	{ 0x2b, 0x89 },
+	{ 0x24, 0x6f },
+	{ },
+};
+
+static struct cdce_reg cdce_y5_27000[] = {
+	{ 0x27, 0x04 },
+	{ 0x28, 0x00 },
+	{ 0x29, 0x40 },
+	{ 0x2a, 0x02 },
+	{ 0x2b, 0x08 },
+	{ 0x24, 0x6f },
+	{ },
+};
+static struct cdce_reg cdce_y5_54000[] = {
+	{ 0x27, 0x04 },
+	{ 0x28, 0xff },
+	{ 0x29, 0x80 },
+	{ 0x2a, 0x02 },
+	{ 0x2b, 0x07 },
+	{ 0x24, 0x6f },
+	{ },
+};
+
+static struct cdce_reg cdce_y5_81000[] = {
+	{ 0x27, 0x02 },
+	{ 0x28, 0xbf },
+	{ 0x29, 0xa0 },
+	{ 0x2a, 0x03 },
+	{ 0x2b, 0x0a },
+	{ 0x24, 0x6f },
+	{ },
+};
+
+static struct cdce_freq cdce_y5_freqs[] = {
+	CDCE_FREQ_TABLE_ENTRY(5, 13500),
+	CDCE_FREQ_TABLE_ENTRY(5, 16875),
+	CDCE_FREQ_TABLE_ENTRY(5, 27000),
+	CDCE_FREQ_TABLE_ENTRY(5, 54000),
+	CDCE_FREQ_TABLE_ENTRY(5, 81000),
+};
+
+
+static struct cdce_output output_list[] = {
+	[1]	= { cdce_y1_freqs, ARRAY_SIZE(cdce_y1_freqs) },
+	[5]	= { cdce_y5_freqs, ARRAY_SIZE(cdce_y5_freqs) },
+};
+
+int cdce_set_rate(struct clk *clk, unsigned long rate)
+{
+	int i, ret = 0;
+	struct cdce_freq *freq_table = output_list[clk->lpsc].freq_table;
+	struct cdce_reg  *regs = NULL;
+
+	if (!cdce_i2c_client)
+		return -ENODEV;
+
+	if (!freq_table)
+		return -EINVAL;
+
+	for (i = 0; i < output_list[clk->lpsc].size; i++) {
+		if (freq_table[i].frequency == rate / 1000) {
+			regs = freq_table[i].reglist;
+			break;
+		}
+	}
+
+	if (!regs)
+		return -EINVAL;
+
+	for (i = 0; regs[i].addr; i++) {
+		ret = i2c_smbus_write_byte_data(cdce_i2c_client,
+					regs[i].addr | 0x80, regs[i].val);
+		if (ret)
+			return ret;
+	}
+
+	atomic_set(&clk->rate, rate);
+
+	return 0;
+}
+
+static int cdce_probe(struct i2c_client *client,
+					const struct i2c_device_id *id)
+{
+	cdce_i2c_client = client;
+	return 0;
+}
+
+static int __devexit cdce_remove(struct i2c_client *client)
+{
+	cdce_i2c_client = NULL;
+	return 0;
+}
+
+static const struct i2c_device_id cdce_id[] = {
+	{"cdce949", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, cdce_id);
+
+static struct i2c_driver cdce_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "cdce949",
+	},
+	.probe		= cdce_probe,
+	.remove		= __devexit_p(cdce_remove),
+	.id_table	= cdce_id,
+};
+
+static int __init cdce_init(void)
+{
+	return i2c_add_driver(&cdce_driver);
+}
+subsys_initcall(cdce_init);
+
+static void __exit cdce_exit(void)
+{
+	i2c_del_driver(&cdce_driver);
+}
+module_exit(cdce_exit);
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("CDCE949 clock synthesizer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/mach-davinci/include/mach/cdce949.h b/arch/arm/mach-davinci/include/mach/cdce949.h
new file mode 100644
index 0000000..c73331f
--- /dev/null
+++ b/arch/arm/mach-davinci/include/mach/cdce949.h
@@ -0,0 +1,19 @@
+/*
+ * TI CDCE949 off-chip clock synthesizer support
+ *
+ * 2009 (C) Texas Instruments, Inc. http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+#ifndef _MACH_DAVINCI_CDCE949_H
+#define _MACH_DAVINCI_CDCE949_H
+
+#include <linux/clk.h>
+
+#include <mach/clock.h>
+
+int cdce_set_rate(struct clk *clk, unsigned long rate);
+
+#endif
-- 
1.6.6.rc2.1.g42108
