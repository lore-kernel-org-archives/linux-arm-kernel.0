From: zoss@devai.org (Zoltan Devai)
Date: Sun,  9 Oct 2011 18:36:08 +0200
Subject: [PATCH 5/9] ARM: SPMP8000: Add pinmux driver
In-Reply-To: <1318178172-7965-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
Message-ID: <1318178172-7965-6-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/mach-spmp8000/pinmux.c |  131 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 131 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spmp8000/pinmux.c

diff --git a/arch/arm/mach-spmp8000/pinmux.c b/arch/arm/mach-spmp8000/pinmux.c
new file mode 100644
index 0000000..61174d5
--- /dev/null
+++ b/arch/arm/mach-spmp8000/pinmux.c
@@ -0,0 +1,131 @@
+/*
+ * SPMP8000 machines pinmux functions
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+
+#include <mach/scu.h>
+
+static int pgc_to_regs(int pc, void __iomem **reg, int *off, int *mask_bits)
+{
+	if (pc > 52) {
+		pr_err("Invalid pad group control number\n");
+		return -EINVAL;
+	}
+
+	*mask_bits = 1;
+
+	/* The pin controls are nicely scattered around */
+	if (pc < 10) {
+		*reg = REG_SCU_B(SCU_B_PGC0);
+		*off = pc * 3;
+		*mask_bits = 3;
+	} else if (pc == 10) {
+		*reg = REG_SCU_B(SCU_B_PGC1);
+		*off = 0;
+	} else if (pc < 42) {
+		*reg = REG_SCU_B(SCU_B_PGC2);
+		*off = pc - 10;
+	} else {
+		*reg = REG_SCU_B(SCU_B_PGC3);
+		*off = pc - 42;
+	}
+
+	return 0;
+}
+
+/**
+ * Set the control function (usually pull-up/down) of a pin group
+ * @pc Pin control group number
+ * @conf Control function state
+ */
+void spmp8000_pinmux_pgc_set(int pc, unsigned int conf)
+{
+	void __iomem *pgc_reg;
+	int ret, pgc_off, mask_bits;
+	u32 reg;
+
+	ret = pgc_to_regs(pc, &pgc_reg, &pgc_off, &mask_bits);
+	if (ret)
+		return;
+
+	pr_debug("pgc_set: %d, reg: %p, off: %d, mask: %d\n", pc, pgc_reg,
+		pgc_off, mask_bits);
+
+	reg = readl(pgc_reg);
+	reg &= ~(((1 <<  mask_bits) - 1) << pgc_off);
+	reg |= (conf << pgc_off);
+	writel(reg, pgc_reg);
+}
+
+/**
+ * Get the control function (usually pull-up/down) of a pin group
+ * @pc Pin control group number
+ * @returns Current function control state
+ */
+unsigned int spmp8000_pinmux_pgc_get(int pc)
+{
+	void __iomem *pgc_reg;
+	int ret, pgc_off, mask_bits;
+	u32 reg;
+
+	ret = pgc_to_regs(pc, &pgc_reg, &pgc_off, &mask_bits);
+	if (ret)
+		return ret;
+
+	reg = readl(pgc_reg);
+	reg >>= pgc_off;
+	reg &= (1 <<  mask_bits) - 1;
+	return reg;
+}
+
+static inline int pgs_to_reg(unsigned int pg)
+{
+	return (pg / 16) * 4;
+}
+
+static inline int pgs_to_off(unsigned int pg)
+{
+	return (pg % 16) * 2;
+}
+
+/**
+ * Set the function of a pin group
+ * @pg Pin group
+ * @func Function
+ */
+void spmp8000_pinmux_pgs_set(unsigned int pg, unsigned int func)
+{
+	u32 reg;
+
+	if ((pg > 63) || (func > 3)) {
+		pr_err("Invalid pad group function select\n");
+		return;
+	}
+
+	reg = readl(REG_SCU_B(SCU_B_PGS0 + pgs_to_reg(pg)));
+	reg &= ~(3 << pgs_to_off(pg));
+	reg |= (func << pgs_to_off(pg));
+	writel(reg, REG_SCU_B(SCU_B_PGS0 + pgs_to_reg(pg)));
+}
+/**
+ * Get the current function associated to the pin group
+ * @pg Pin group
+ * @returns The current function of the pin group
+ */
+int spmp8000_pinmux_pgs_get(int pg)
+{
+	u32 reg;
+
+	reg = readl(REG_SCU_B(SCU_B_PGS0 + pgs_to_reg(pg)));
+	reg = (reg >> pgs_to_off(pg)) & 3;
+	return reg;
+}
-- 
1.7.4.1
