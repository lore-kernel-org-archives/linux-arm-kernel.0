From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  3 Dec 2015 14:16:53 +0900
Subject: [PATCH] clk: uniphier: add clock drivers for UniPhier SoCs
Message-ID: <1449119813-7308-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the initial commit for the UniPhier clock drivers, including
support for PH1-sLD3, PH1-LD4, PH1-Pro4, PH1-sLD8, PH1-Pro5, and
ProXstream2/PH1-LD6b.

To improve the code maintainability, the driver consists of common
functions (clk-uniphier-core.c) and clock data arrays needed to
support each SoC.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 MAINTAINERS                              |   1 +
 drivers/clk/Kconfig                      |   1 +
 drivers/clk/Makefile                     |   1 +
 drivers/clk/uniphier/Kconfig             |  35 ++++++
 drivers/clk/uniphier/Makefile            |  10 ++
 drivers/clk/uniphier/clk-ph1-ld4.c       | 117 ++++++++++++++++++
 drivers/clk/uniphier/clk-ph1-pro4.c      | 117 ++++++++++++++++++
 drivers/clk/uniphier/clk-ph1-pro5.c      | 107 ++++++++++++++++
 drivers/clk/uniphier/clk-ph1-sld3.c      | 117 ++++++++++++++++++
 drivers/clk/uniphier/clk-ph1-sld8.c      | 107 ++++++++++++++++
 drivers/clk/uniphier/clk-proxstream2.c   |  88 +++++++++++++
 drivers/clk/uniphier/clk-uniphier-core.c | 150 ++++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier-mio.c  | 206 +++++++++++++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier-peri.c | 175 ++++++++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier.h      |  68 ++++++++++
 15 files changed, 1300 insertions(+)
 create mode 100644 drivers/clk/uniphier/Kconfig
 create mode 100644 drivers/clk/uniphier/Makefile
 create mode 100644 drivers/clk/uniphier/clk-ph1-ld4.c
 create mode 100644 drivers/clk/uniphier/clk-ph1-pro4.c
 create mode 100644 drivers/clk/uniphier/clk-ph1-pro5.c
 create mode 100644 drivers/clk/uniphier/clk-ph1-sld3.c
 create mode 100644 drivers/clk/uniphier/clk-ph1-sld8.c
 create mode 100644 drivers/clk/uniphier/clk-proxstream2.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-core.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-mio.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-peri.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cba790b..1c6edc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1642,6 +1642,7 @@ F:	arch/arm/boot/dts/uniphier*
 F:	arch/arm/include/asm/hardware/cache-uniphier.h
 F:	arch/arm/mach-uniphier/
 F:	arch/arm/mm/cache-uniphier.c
+F:	drivers/clk/uniphier/
 F:	drivers/i2c/busses/i2c-uniphier*
 F:	drivers/pinctrl/uniphier/
 F:	drivers/tty/serial/8250/8250_uniphier.c
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c3e3a02..7580323 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -191,6 +191,7 @@ config COMMON_CLK_CDCE706
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/qcom/Kconfig"
+source "drivers/clk/uniphier/Kconfig"
 
 endmenu
 
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 820714c..ab9d1bd 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_ARCH_STI)			+= st/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 obj-$(CONFIG_ARCH_OMAP2PLUS)		+= ti/
+obj-$(CONFIG_CLK_UNIPHIER)		+= uniphier/
 obj-$(CONFIG_ARCH_U8500)		+= ux500/
 obj-$(CONFIG_COMMON_CLK_VERSATILE)	+= versatile/
 obj-$(CONFIG_X86)			+= x86/
diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
new file mode 100644
index 0000000..7606f27
--- /dev/null
+++ b/drivers/clk/uniphier/Kconfig
@@ -0,0 +1,35 @@
+menuconfig CLK_UNIPHIER
+	bool "Clock drivers for UniPhier SoCs"
+	depends on ARCH_UNIPHIER
+	depends on OF
+	default y
+	help
+	  Supports clock drivers for UniPhier SoCs.
+
+if CLK_UNIPHIER
+
+config CLK_UNIPHIER_PH1_SLD3
+	bool "Clock driver for UniPhier PH1-sLD3 SoC"
+	default y
+
+config CLK_UNIPHIER_PH1_LD4
+	bool "Clock driver for UniPhier PH1-LD4 SoC"
+	default y
+
+config CLK_UNIPHIER_PH1_PRO4
+	bool "Clock driver for UniPhier PH1-Pro4 SoC"
+	default y
+
+config CLK_UNIPHIER_PH1_SLD8
+	bool "Clock driver for UniPhier PH1-sLD8 SoC"
+	default y
+
+config CLK_UNIPHIER_PH1_PRO5
+	bool "Clock driver for UniPhier PH1-Pro5 SoC"
+	default y
+
+config CLK_UNIPHIER_PROXSTREAM2
+	bool "Clock driver for UniPhier ProXstream2/PH1-LD6b SoC"
+	default y
+
+endif
diff --git a/drivers/clk/uniphier/Makefile b/drivers/clk/uniphier/Makefile
new file mode 100644
index 0000000..3be1a17
--- /dev/null
+++ b/drivers/clk/uniphier/Makefile
@@ -0,0 +1,10 @@
+obj-y += clk-uniphier-core.o
+obj-y += clk-uniphier-peri.o
+obj-y += clk-uniphier-mio.o
+
+obj-$(CONFIG_CLK_UNIPHIER_PH1_SLD3)	+= clk-ph1-sld3.o
+obj-$(CONFIG_CLK_UNIPHIER_PH1_LD4)	+= clk-ph1-ld4.o
+obj-$(CONFIG_CLK_UNIPHIER_PH1_PRO4)	+= clk-ph1-pro4.o
+obj-$(CONFIG_CLK_UNIPHIER_PH1_SLD8)	+= clk-ph1-sld8.o
+obj-$(CONFIG_CLK_UNIPHIER_PH1_PRO5)	+= clk-ph1-pro5.o
+obj-$(CONFIG_CLK_UNIPHIER_PROXSTREAM2)	+= clk-proxstream2.o
diff --git a/drivers/clk/uniphier/clk-ph1-ld4.c b/drivers/clk/uniphier/clk-ph1-ld4.c
new file mode 100644
index 0000000..48d342f
--- /dev/null
+++ b/drivers/clk/uniphier/clk-ph1-ld4.c
@@ -0,0 +1,117 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+
+#include "clk-uniphier.h"
+
+static struct uniphier_clk_init_data ph1_ld4_clk_idata[] __initdata = {
+	{
+		.name = "spll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.mult = 65,
+			.div = 1,
+		},
+	},
+	{
+		.name = "upll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.mult = 288000,
+			.div = 24576,
+		},
+	},
+	{
+		.name = "a2pll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.mult = 24,
+			.div = 1,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 3,
+		.data.factor = {
+			.parent_name = "a2pll",
+			.mult = 1,
+			.div = 16,
+		},
+	},
+	{
+		.name = "i2c",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 4,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 16,
+		},
+	},
+	{
+		.name = "arm-scu",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 7,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 32,
+		},
+	},
+	{
+		.name = "stdmac-clken",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = -1,
+		.data.gate = {
+			.parent_name = NULL,
+			.reg = 0x2104,
+			.bit_idx = 10,
+		},
+	},
+	{
+		.name = "stdmac",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = 10,
+		.data.gate = {
+			.parent_name = "stdmac-clken",
+			.reg = 0x2000,
+			.bit_idx = 10,
+		},
+	},
+	{
+		.name = "ehci",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 18,
+		.data.factor = {
+			.parent_name = "upll",
+			.mult = 1,
+			.div = 12,
+		},
+	},
+	{ /* sentinel */ }
+};
+
+static void __init ph1_ld4_clk_init(struct device_node *np)
+{
+	uniphier_clk_init(np, ph1_ld4_clk_idata);
+}
+CLK_OF_DECLARE(ph1_ld4_clk, "socionext,ph1-ld4-sysctrl", ph1_ld4_clk_init);
diff --git a/drivers/clk/uniphier/clk-ph1-pro4.c b/drivers/clk/uniphier/clk-ph1-pro4.c
new file mode 100644
index 0000000..052813a
--- /dev/null
+++ b/drivers/clk/uniphier/clk-ph1-pro4.c
@@ -0,0 +1,117 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+
+#include "clk-uniphier.h"
+
+static struct uniphier_clk_init_data ph1_pro4_clk_idata[] __initdata = {
+	{
+		.name = "spll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.mult = 64,
+			.div = 1,
+		},
+	},
+	{
+		.name = "upll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.mult = 288,
+			.div = 25,
+		},
+	},
+	{
+		.name = "a2pll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "upll",
+			.mult = 256,
+			.div = 125,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 3,
+		.data.factor = {
+			.parent_name = "a2pll",
+			.mult = 1,
+			.div = 8,
+		},
+	},
+	{
+		.name = "fi2c",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 4,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 32,
+		},
+	},
+	{
+		.name = "arm-scu",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 7,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 32,
+		},
+	},
+	{
+		.name = "stdmac-clken",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = -1,
+		.data.gate = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.reg = 0x2104,
+			.bit_idx = 10,
+		},
+	},
+	{
+		.name = "stdmac",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = 10,
+		.data.gate = {
+			.parent_name = "stdmac-clken",
+			.reg = 0x2000,
+			.bit_idx = 10,
+		},
+	},
+	{
+		.name = "ehci",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 18,
+		.data.factor = {
+			.parent_name = "upll",
+			.mult = 1,
+			.div = 12,
+		},
+	},
+	{ /* sentinel */ }
+};
+
+static void __init ph1_pro4_clk_init(struct device_node *np)
+{
+	uniphier_clk_init(np, ph1_pro4_clk_idata);
+}
+CLK_OF_DECLARE(ph1_pro4_clk, "socionext,ph1-pro4-sysctrl", ph1_pro4_clk_init);
diff --git a/drivers/clk/uniphier/clk-ph1-pro5.c b/drivers/clk/uniphier/clk-ph1-pro5.c
new file mode 100644
index 0000000..9f782d9
--- /dev/null
+++ b/drivers/clk/uniphier/clk-ph1-pro5.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+
+#include "clk-uniphier.h"
+
+static struct uniphier_clk_init_data ph1_pro5_clk_idata[] __initdata = {
+	{
+		.name = "spll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.mult = 120,
+			.div = 1,
+		},
+	},
+	{
+		.name = "dapll1",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.mult = 128,
+			.div = 125,
+		},
+	},
+	{
+		.name = "dapll2",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "upll",
+			.mult = 144,
+			.div = 5,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 3,
+		.data.factor = {
+			.parent_name = "dapll2",
+			.mult = 1,
+			.div = 8,
+		},
+	},
+	{
+		.name = "fi2c",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 4,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 48,
+		},
+	},
+	{
+		.name = "arm-scu",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 7,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 48,
+		},
+	},
+	{
+		.name = "stdmac-clken",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = -1,
+		.data.gate = {
+			.parent_name = NULL,
+			.reg = 0x2104,
+			.bit_idx = 10,
+		},
+	},
+	{
+		.name = "stdmac",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = 10,
+		.data.gate = {
+			.parent_name = "stdmac-clken",
+			.reg = 0x2000,
+			.bit_idx = 10,
+		},
+	},
+	{ /* sentinel */ }
+};
+
+static void __init ph1_pro5_clk_init(struct device_node *np)
+{
+	uniphier_clk_init(np, ph1_pro5_clk_idata);
+}
+CLK_OF_DECLARE(ph1_pro5_clk, "socionext,ph1-pro5-sysctrl", ph1_pro5_clk_init);
diff --git a/drivers/clk/uniphier/clk-ph1-sld3.c b/drivers/clk/uniphier/clk-ph1-sld3.c
new file mode 100644
index 0000000..7249a81
--- /dev/null
+++ b/drivers/clk/uniphier/clk-ph1-sld3.c
@@ -0,0 +1,117 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+
+#include "clk-uniphier.h"
+
+static struct uniphier_clk_init_data ph1_sld3_clk_idata[] __initdata = {
+	{
+		.name = "spll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.mult = 65,
+			.div = 1,
+		},
+	},
+	{
+		.name = "upll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.mult = 288000,
+			.div = 24576,
+		},
+	},
+	{
+		.name = "a2pll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.mult = 24,
+			.div = 1,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 3,
+		.data.factor = {
+			.parent_name = "a2pll",
+			.mult = 1,
+			.div = 16,
+		},
+	},
+	{
+		.name = "i2c",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 4,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 16,
+		},
+	},
+	{
+		.name = "arm-scu",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 7,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 32,
+		},
+	},
+	{
+		.name = "stdmac-clken",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = -1,
+		.data.gate = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.reg = 0x2104,
+			.bit_idx = 10,
+		},
+	},
+	{
+		.name = "stdmac",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = 10,
+		.data.gate = {
+			.parent_name = "stdmac-clken",
+			.reg = 0x2000,
+			.bit_idx = 10,
+		},
+	},
+	{
+		.name = "ehci",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 18,
+		.data.factor = {
+			.parent_name = "upll",
+			.mult = 1,
+			.div = 12,
+		},
+	},
+	{ /* sentinel */ }
+};
+
+static void __init ph1_sld3_clk_init(struct device_node *np)
+{
+	uniphier_clk_init(np, ph1_sld3_clk_idata);
+}
+CLK_OF_DECLARE(ph1_sld3_clk, "socionext,ph1-sld3-sysctrl", ph1_sld3_clk_init);
diff --git a/drivers/clk/uniphier/clk-ph1-sld8.c b/drivers/clk/uniphier/clk-ph1-sld8.c
new file mode 100644
index 0000000..bfebd38
--- /dev/null
+++ b/drivers/clk/uniphier/clk-ph1-sld8.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+
+#include "clk-uniphier.h"
+
+static struct uniphier_clk_init_data ph1_sld8_clk_idata[] __initdata = {
+	{
+		.name = "spll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.mult = 64,
+			.div = 1,
+		},
+	},
+	{
+		.name = "upll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.mult = 288,
+			.div = 25,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 3,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 20,
+		},
+	},
+	{
+		.name = "i2c",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 4,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 16,
+		},
+	},
+	{
+		.name = "arm-scu",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 7,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 32,
+		},
+	},
+	{
+		.name = "stdmac-clken",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = -1,
+		.data.gate = {
+			.parent_name = NULL,
+			.reg = 0x2104,
+			.bit_idx = 10,
+		},
+	},
+	{
+		.name = "stdmac",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = 10,
+		.data.gate = {
+			.parent_name = "stdmac-clken",
+			.reg = 0x2000,
+			.bit_idx = 10,
+		},
+	},
+	{
+		.name = "ehci",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 18,
+		.data.factor = {
+			.parent_name = "upll",
+			.mult = 1,
+			.div = 12,
+		},
+	},
+	{ /* sentinel */ }
+};
+
+static void __init ph1_sld8_clk_init(struct device_node *np)
+{
+	uniphier_clk_init(np, ph1_sld8_clk_idata);
+}
+CLK_OF_DECLARE(ph1_sld8_clk, "socionext,ph1-sld8-sysctrl", ph1_sld8_clk_init);
diff --git a/drivers/clk/uniphier/clk-proxstream2.c b/drivers/clk/uniphier/clk-proxstream2.c
new file mode 100644
index 0000000..b3ffedc
--- /dev/null
+++ b/drivers/clk/uniphier/clk-proxstream2.c
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+
+#include "clk-uniphier.h"
+
+static struct uniphier_clk_init_data proxstream2_clk_idata[] __initdata = {
+	{
+		.name = "spll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = UNIPHIER_CLK_EXT "ref",
+			.mult = 96,
+			.div = 1,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 3,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 27,
+		},
+	},
+	{
+		.name = "fi2c",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 4,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 48,
+		},
+	},
+	{
+		.name = "arm-scu",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 7,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 48,
+		},
+	},
+	{
+		.name = "stdmac-clken",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = -1,
+		.data.gate = {
+			.parent_name = NULL,
+			.reg = 0x2104,
+			.bit_idx = 10,
+		},
+	},
+	{
+		.name = "stdmac",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = 10,
+		.data.gate = {
+			.parent_name = "stdmac-clken",
+			.reg = 0x2000,
+			.bit_idx = 10,
+		},
+	},
+	{ /* sentinel */ }
+};
+
+static void __init proxstream2_clk_init(struct device_node *np)
+{
+	uniphier_clk_init(np, proxstream2_clk_idata);
+}
+CLK_OF_DECLARE(proxstream2_clk, "socionext,proxstream2-sysctrl",
+	       proxstream2_clk_init);
diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
new file mode 100644
index 0000000..d718dac
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -0,0 +1,150 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt)		"uniphier-clk: " fmt
+
+#include <linux/clk-provider.h>
+#include <linux/log2.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include "clk-uniphier.h"
+
+static void __init uniphier_clk_update_parent_name(struct device_node *np,
+						   const char **parent_name)
+{
+	const char *new_name;
+	int index;
+
+	if (!parent_name || !*parent_name)
+		return;
+
+	if (strncmp(*parent_name, UNIPHIER_CLK_EXT, strlen(UNIPHIER_CLK_EXT)))
+		return;
+
+	index = of_property_match_string(np, "clock-names",
+				*parent_name + strlen(UNIPHIER_CLK_EXT));
+	new_name = of_clk_get_parent_name(np, index);
+	if (new_name)
+		*parent_name = new_name;
+}
+
+static struct clk * __init uniphier_clk_register(struct device_node *np,
+						 void __iomem *regbase,
+					  struct uniphier_clk_init_data *idata)
+{
+	int i;
+
+	switch (idata->type) {
+	case UNIPHIER_CLK_TYPE_FIXED_FACTOR:
+		uniphier_clk_update_parent_name(np,
+					&idata->data.factor.parent_name);
+		return clk_register_fixed_factor(NULL, idata->name,
+						 idata->data.factor.parent_name,
+						 0,
+						 idata->data.factor.mult,
+						 idata->data.factor.div);
+	case UNIPHIER_CLK_TYPE_FIXED_RATE:
+		return clk_register_fixed_rate(NULL, idata->name, NULL,
+					       CLK_IS_ROOT,
+					       idata->data.rate.fixed_rate);
+	case UNIPHIER_CLK_TYPE_GATE:
+		uniphier_clk_update_parent_name(np,
+						&idata->data.gate.parent_name);
+		return clk_register_gate(NULL, idata->name,
+					 idata->data.gate.parent_name,
+					 idata->data.gate.parent_name ?
+					 0 : CLK_IS_ROOT,
+					 regbase + idata->data.gate.reg,
+					 idata->data.gate.bit_idx, 0, NULL);
+	case UNIPHIER_CLK_TYPE_MUX:
+		for (i = 0; i < idata->data.mux.num_parents; i++)
+			uniphier_clk_update_parent_name(np,
+					&idata->data.mux.parent_names[i]);
+		return clk_register_mux(NULL, idata->name,
+					idata->data.mux.parent_names,
+					idata->data.mux.num_parents, 0,
+					regbase + idata->data.mux.reg,
+					idata->data.mux.shift,
+					ilog2(idata->data.mux.num_parents),
+					0, NULL);
+	default:
+		WARN(1, "unsupported clock type\n");
+		return ERR_PTR(-EINVAL);
+	}
+}
+
+int __init uniphier_clk_init(struct device_node *np,
+			     struct uniphier_clk_init_data *idata)
+{
+	struct clk_onecell_data *clk_data;
+	struct uniphier_clk_init_data *p;
+	void __iomem *regbase;
+	int max_index = 0;
+	int ret;
+
+	regbase = of_iomap(np, 0);
+	if (!regbase)
+		return -ENOMEM;
+
+	for (p = idata; p->name; p++)
+		max_index = max(max_index, p->output_index);
+
+	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->clk_num = max_index + 1;
+	clk_data->clks = kcalloc(clk_data->clk_num, sizeof(struct clk *),
+				 GFP_KERNEL);
+	if (!clk_data->clks) {
+		ret = -ENOMEM;
+		goto free_clk_data;
+	}
+
+	for (p = idata; p->name; p++) {
+		pr_debug("register %s (%s[%d])\n", p->name, np->name,
+			 p->output_index);
+		p->clk = uniphier_clk_register(np, regbase, p);
+		if (IS_ERR(p->clk)) {
+			pr_err("failed to register %s\n", p->name);
+			ret = PTR_ERR(p->clk);
+			goto unregister;
+		}
+
+		if (p->output_index >= 0)
+			clk_data->clks[p->output_index] = p->clk;
+	}
+
+	ret = of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
+	if (ret)
+		goto unregister;
+
+	return ret;
+unregister:
+	for (p--; p >= idata; p--) {
+		pr_debug("unregister %s (%s[%d])\n", p->name, np->name,
+			 p->output_index);
+		clk_unregister(p->clk);
+		p->clk = NULL;
+	}
+	kfree(clk_data->clks);
+free_clk_data:
+	kfree(clk_data);
+
+	pr_err("%s: init failed with error %d\n", np->full_name, ret);
+
+	return ret;
+}
diff --git a/drivers/clk/uniphier/clk-uniphier-mio.c b/drivers/clk/uniphier/clk-uniphier-mio.c
new file mode 100644
index 0000000..26b63ab
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-mio.c
@@ -0,0 +1,206 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+
+#include "clk-uniphier.h"
+
+#define UNIPHIER_MIO_CLK_SD(ch, index)					\
+	{								\
+		.name = "sd" #ch "-clken",				\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = -1,					\
+		.data.gate = {						\
+			.parent_name = NULL,				\
+			.reg = 0x20 + 0x200 * ch,			\
+			.bit_idx = 8,					\
+		},							\
+	},								\
+	{								\
+		.name = "sd" #ch "-bridge-reset",			\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = -1,					\
+		.data.gate = {						\
+			.parent_name = "sd" #ch "-clken",		\
+			.reg = 0x110 + 0x200 * ch,			\
+			.bit_idx = 26,					\
+		},							\
+	},								\
+	{								\
+		.name = "sd" #ch "-reset",				\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = -1,					\
+		.data.gate = {						\
+			.parent_name = "sd" #ch "-bridge-reset",	\
+			.reg = 0x110 + 0x200 * ch,			\
+			.bit_idx = 0,					\
+		},							\
+	},								\
+	{								\
+		.name = "sd" #ch "-hw-reset",				\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = -1,					\
+		.data.gate = {						\
+			.parent_name = "sd" #ch "-reset",		\
+			.reg = 0x80 + 0x200 * ch,			\
+			.bit_idx = 0,					\
+		},							\
+	},								\
+	{								\
+		.name = "sd" #ch,					\
+		.type = UNIPHIER_CLK_TYPE_MUX,				\
+		.output_index = (index),				\
+		.data.mux = {						\
+			.parent_names = {				\
+				"sd" #ch "-reset",			\
+				"sd" #ch "-hw-reset",			\
+			},						\
+			.num_parents = 2,				\
+			.reg = 0x30 + 0x200 * ch,			\
+			.shift = 27,					\
+		},							\
+	}
+
+#define UNIPHIER_MIO_CLK_EHCI(ch, index)				\
+	{								\
+		.name = "ehci" #ch "-phy-clken",			\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = -1,					\
+		.data.gate = {						\
+			.parent_name = UNIPHIER_CLK_EXT "ehci",		\
+			.reg = 0x20 + 0x200 * ch,			\
+			.bit_idx = 29,					\
+		},							\
+	},								\
+	{								\
+		.name = "ehci" #ch "-link-clken",			\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = -1,					\
+		.data.gate = {						\
+			.parent_name = "ehci" #ch "-phy-clken",		\
+			.reg = 0x20 + 0x200 * ch,			\
+			.bit_idx = 28,					\
+		},							\
+	},								\
+	{								\
+		.name = "ehci" #ch "-bridge-reset",			\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = -1,					\
+		.data.gate = {						\
+			.parent_name = "ehci" #ch "-link-clken",	\
+			.reg = 0x110 + 0x200 * ch,			\
+			.bit_idx = 24,					\
+		},							\
+	},								\
+	{								\
+		.name = "ehci" #ch,					\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = (index),				\
+		.data.gate = {						\
+			.parent_name = "ehci" #ch "-bridge-reset",	\
+			.reg = 0x114 + 0x200 * ch,			\
+			.bit_idx = 0,					\
+		},							\
+	}
+
+#define UNIPHIER_MIO_CLK_DMAC(index)					\
+	{								\
+		.name = "miodmac-clken",				\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = -1,					\
+		.data.gate = {						\
+			.parent_name = UNIPHIER_CLK_EXT "stdmac",	\
+			.reg = 0x20,					\
+			.bit_idx = 25,					\
+		},							\
+	},								\
+	{								\
+		.name = "miodmac",					\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = (index),				\
+		.data.gate = {						\
+			.parent_name = "miodmac-clken",			\
+			.reg = 0x110,					\
+			.bit_idx = 17,					\
+		},							\
+	}
+
+static struct uniphier_clk_init_data ph1_sld3_mio_clk_idata[] __initdata = {
+	UNIPHIER_MIO_CLK_SD(0, 0),
+	UNIPHIER_MIO_CLK_SD(1, 1),
+	UNIPHIER_MIO_CLK_EHCI(0, 3),
+	UNIPHIER_MIO_CLK_EHCI(1, 4),
+	UNIPHIER_MIO_CLK_EHCI(2, 5),
+	UNIPHIER_MIO_CLK_EHCI(3, 6),
+	UNIPHIER_MIO_CLK_DMAC(7),
+	{ /* sentinel */ }
+};
+
+static struct uniphier_clk_init_data ph1_ld4_mio_clk_idata[] __initdata = {
+	UNIPHIER_MIO_CLK_SD(0, 0),
+	UNIPHIER_MIO_CLK_SD(1, 1),
+	UNIPHIER_MIO_CLK_EHCI(0, 3),
+	UNIPHIER_MIO_CLK_EHCI(1, 4),
+	UNIPHIER_MIO_CLK_EHCI(2, 5),
+	UNIPHIER_MIO_CLK_DMAC(7),
+	{ /* sentinel */ }
+};
+
+static struct uniphier_clk_init_data ph1_pro4_mio_clk_idata[] __initdata = {
+	UNIPHIER_MIO_CLK_SD(0, 0),
+	UNIPHIER_MIO_CLK_SD(1, 1),
+	UNIPHIER_MIO_CLK_SD(2, 2),
+	UNIPHIER_MIO_CLK_EHCI(0, 3),
+	UNIPHIER_MIO_CLK_EHCI(1, 4),
+	UNIPHIER_MIO_CLK_DMAC(7),
+	{ /* sentinel */ }
+};
+
+static struct uniphier_clk_init_data ph1_pro5_mio_clk_idata[] __initdata = {
+	UNIPHIER_MIO_CLK_SD(0, 0),
+	UNIPHIER_MIO_CLK_SD(1, 1),
+	{ /* sentinel */ }
+};
+
+static void __init ph1_sld3_mio_clk_init(struct device_node *np)
+{
+	uniphier_clk_init(np, ph1_sld3_mio_clk_idata);
+}
+CLK_OF_DECLARE(ph1_sld3_mio_clk, "socionext,ph1-sld3-mioctrl",
+	       ph1_sld3_mio_clk_init);
+
+static void __init ph1_ld4_mio_clk_init(struct device_node *np)
+{
+	uniphier_clk_init(np, ph1_ld4_mio_clk_idata);
+}
+CLK_OF_DECLARE(ph1_ld4_mio_clk, "socionext,ph1-ld4-mioctrl",
+	       ph1_ld4_mio_clk_init);
+CLK_OF_DECLARE(ph1_sld8_mio_clk, "socionext,ph1-sld8-mioctrl",
+	       ph1_ld4_mio_clk_init);
+
+static void __init ph1_pro4_mio_clk_init(struct device_node *np)
+{
+	uniphier_clk_init(np, ph1_pro4_mio_clk_idata);
+}
+CLK_OF_DECLARE(ph1_pro4_mio_clk, "socionext,ph1-pro4-mioctrl",
+	       ph1_pro4_mio_clk_init);
+
+static void __init ph1_pro5_mio_clk_init(struct device_node *np)
+{
+	uniphier_clk_init(np, ph1_pro5_mio_clk_idata);
+}
+CLK_OF_DECLARE(ph1_pro5_mio_clk, "socionext,ph1-pro5-mioctrl",
+	       ph1_pro5_mio_clk_init);
+CLK_OF_DECLARE(proxstream2_mio_clk, "socionext,proxstream2-mioctrl",
+	       ph1_pro5_mio_clk_init);
diff --git a/drivers/clk/uniphier/clk-uniphier-peri.c b/drivers/clk/uniphier/clk-uniphier-peri.c
new file mode 100644
index 0000000..adaae8e
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-peri.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+
+#include "clk-uniphier.h"
+
+#define UNIPHIER_PERI_CLK_UART(ch, index)			\
+	{							\
+		.name = "uart" #ch "-clken",			\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = -1,				\
+		.data.gate = {					\
+			.parent_name = UNIPHIER_CLK_EXT "uart",	\
+			.reg = 0x24,				\
+			.bit_idx = 19 + ch,			\
+		},						\
+	},							\
+	{							\
+		.name = "uart" #ch,				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = (index),			\
+		.data.gate = {					\
+			.parent_name = "uart" #ch "-clken",	\
+			.reg = 0x114,				\
+			.bit_idx = 19 + ch,			\
+		},						\
+	}
+
+#define UNIPHIER_PERI_CLK_I2C_COMMON				\
+	{							\
+		.name = "i2c-clken",				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = -1,				\
+		.data.gate = {					\
+			.parent_name = UNIPHIER_CLK_EXT "i2c",	\
+			.reg = 0x20,				\
+			.bit_idx = 1,				\
+		},						\
+	},							\
+	{							\
+		.name = "i2c-reset",				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = -1,				\
+		.data.gate = {					\
+			.parent_name = "i2c-clken",		\
+			.reg = 0x110,				\
+			.bit_idx = 1,				\
+		},						\
+	}
+
+
+#define UNIPHIER_PERI_CLK_I2C(ch, index)			\
+	{							\
+		.name = "i2c" #ch "-clken",			\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = -1,				\
+		.data.gate = {					\
+			.parent_name = "i2c-reset",		\
+			.reg = 0x24,				\
+			.bit_idx = 5 + ch,			\
+		},						\
+	},							\
+	{							\
+		.name = "i2c" #ch,				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = (index),			\
+		.data.gate = {					\
+			.parent_name = "i2c" #ch "-clken",	\
+			.reg = 0x114,				\
+			.bit_idx = 5 + ch,			\
+		},						\
+	}
+
+#define UNIPHIER_PERI_CLK_FI2C(ch, index)			\
+	{							\
+		.name = "fi2c" #ch "-clken",			\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = -1,				\
+		.data.gate = {					\
+			.parent_name = UNIPHIER_CLK_EXT "fi2c",	\
+			.reg = 0x24,				\
+			.bit_idx = 24 + ch,			\
+		},						\
+	},							\
+	{							\
+		.name = "fi2c" #ch,				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = index,				\
+		.data.gate = {					\
+			.parent_name = "fi2c" #ch "-clken",	\
+			.reg = 0x114,				\
+			.bit_idx = 24 + ch,			\
+		},						\
+	}
+
+static struct uniphier_clk_init_data ph1_ld4_peri_clk_idata[] __initdata = {
+	UNIPHIER_PERI_CLK_UART(0, 0),
+	UNIPHIER_PERI_CLK_UART(1, 1),
+	UNIPHIER_PERI_CLK_UART(2, 2),
+	UNIPHIER_PERI_CLK_UART(3, 3),
+	UNIPHIER_PERI_CLK_I2C_COMMON,
+	UNIPHIER_PERI_CLK_I2C(0, 4),
+	UNIPHIER_PERI_CLK_I2C(1, 5),
+	UNIPHIER_PERI_CLK_I2C(2, 6),
+	UNIPHIER_PERI_CLK_I2C(3, 7),
+	UNIPHIER_PERI_CLK_I2C(4, 8),
+	{ /* sentinel */ }
+};
+
+static struct uniphier_clk_init_data ph1_pro4_peri_clk_idata[] __initdata = {
+	UNIPHIER_PERI_CLK_UART(0, 0),
+	UNIPHIER_PERI_CLK_UART(1, 1),
+	UNIPHIER_PERI_CLK_UART(2, 2),
+	UNIPHIER_PERI_CLK_UART(3, 3),
+	UNIPHIER_PERI_CLK_FI2C(0, 4),
+	UNIPHIER_PERI_CLK_FI2C(1, 5),
+	UNIPHIER_PERI_CLK_FI2C(2, 6),
+	UNIPHIER_PERI_CLK_FI2C(3, 7),
+	/* no I2C ch4 */
+	UNIPHIER_PERI_CLK_FI2C(5, 9),
+	UNIPHIER_PERI_CLK_FI2C(6, 10),
+	{ /* sentinel */ }
+};
+
+static struct uniphier_clk_init_data ph1_pro5_peri_clk_idata[] __initdata = {
+	UNIPHIER_PERI_CLK_UART(0, 0),
+	UNIPHIER_PERI_CLK_UART(1, 1),
+	UNIPHIER_PERI_CLK_UART(2, 2),
+	UNIPHIER_PERI_CLK_UART(3, 3),
+	UNIPHIER_PERI_CLK_FI2C(0, 4),
+	UNIPHIER_PERI_CLK_FI2C(1, 5),
+	UNIPHIER_PERI_CLK_FI2C(2, 6),
+	UNIPHIER_PERI_CLK_FI2C(3, 7),
+	UNIPHIER_PERI_CLK_FI2C(4, 8),
+	UNIPHIER_PERI_CLK_FI2C(5, 9),
+	UNIPHIER_PERI_CLK_FI2C(6, 10),
+	{ /* sentinel */ }
+};
+
+static void __init ph1_ld4_peri_clk_init(struct device_node *np)
+{
+	uniphier_clk_init(np, ph1_ld4_peri_clk_idata);
+}
+CLK_OF_DECLARE(ph1_ld4_peri_clk, "socionext,ph1-ld4-perictrl",
+	       ph1_ld4_peri_clk_init);
+CLK_OF_DECLARE(ph1_sld8_peri_clk, "socionext,ph1-sld8-perictrl",
+	       ph1_ld4_peri_clk_init);
+
+static void __init ph1_pro4_peri_clk_init(struct device_node *np)
+{
+	uniphier_clk_init(np, ph1_pro4_peri_clk_idata);
+}
+CLK_OF_DECLARE(ph1_pro4_peri_clk, "socionext,ph1-pro4-perictrl",
+	       ph1_pro4_peri_clk_init);
+
+static void __init ph1_pro5_peri_clk_init(struct device_node *np)
+{
+	uniphier_clk_init(np, ph1_pro5_peri_clk_idata);
+}
+CLK_OF_DECLARE(ph1_pro5_peri_clk, "socionext,ph1-pro5-perictrl",
+	       ph1_pro5_peri_clk_init);
+CLK_OF_DECLARE(proxstream2_peri_clk, "socionext,proxstream2-perictrl",
+	       ph1_pro5_peri_clk_init);
diff --git a/drivers/clk/uniphier/clk-uniphier.h b/drivers/clk/uniphier/clk-uniphier.h
new file mode 100644
index 0000000..05277b6
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __CLK_UNIPHIER_H__
+#define __CLK_UNIPHIER_H__
+
+#include <linux/kernel.h>
+
+#define UNIPHIER_CLK_EXT	"[EXT]"
+
+enum uniphier_clk_type {
+	UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+	UNIPHIER_CLK_TYPE_FIXED_RATE,
+	UNIPHIER_CLK_TYPE_GATE,
+	UNIPHIER_CLK_TYPE_MUX,
+};
+
+struct uniphier_clk_fixed_factor_data {
+	const char *parent_name;
+	unsigned int mult;
+	unsigned int div;
+};
+
+struct uniphier_clk_fixed_rate_data {
+	unsigned long fixed_rate;
+};
+
+struct uniphier_clk_gate_data {
+	const char *parent_name;
+	unsigned int reg;
+	u8 bit_idx;
+};
+
+struct uniphier_clk_mux_data {
+	const char *parent_names[4];
+	u8 num_parents;
+	unsigned int reg;
+	u8 shift;
+};
+
+struct uniphier_clk_init_data {
+	const char *name;
+	enum uniphier_clk_type type;
+	int output_index;
+	union {
+		struct uniphier_clk_fixed_factor_data factor;
+		struct uniphier_clk_fixed_rate_data rate;
+		struct uniphier_clk_gate_data gate;
+		struct uniphier_clk_mux_data mux;
+	} data;
+	struct clk *clk;
+};
+
+int uniphier_clk_init(struct device_node *np,
+		      struct uniphier_clk_init_data *idata);
+
+#endif /* __CLK_UNIPHIER_H__ */
-- 
1.9.1
