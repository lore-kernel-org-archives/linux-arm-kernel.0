From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 27 Sep 2010 11:26:34 +0200
Subject: [PATCH v3 3/3] [ARM] tegra: harmony: enable PCI Express
In-Reply-To: <cover.1285579189.git.mike@compulab.co.il>
References: <cover.1285579189.git.mike@compulab.co.il>
Message-ID: <37648cc049e5296526d58eb2224744374a474c61.1285579189.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
CC: Olof Johansson <olof@lixom.net>
CC: Colin Cross <ccross@google.com>
CC: Gary King <GKing@nvidia.com>
---
 arch/arm/mach-tegra/Makefile             |    1 +
 arch/arm/mach-tegra/board-harmony-pcie.c |   57 ++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-harmony-pcie.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 23c9600..60f73c7 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
 
 obj-${CONFIG_MACH_HARMONY}              += board-harmony.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony-pinmux.o
+obj-${CONFIG_MACH_HARMONY}              += board-harmony-pcie.o
diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
new file mode 100644
index 0000000..f7e7d45
--- /dev/null
+++ b/arch/arm/mach-tegra/board-harmony-pcie.c
@@ -0,0 +1,57 @@
+/*
+ * arch/arm/mach-tegra/board-harmony-pcie.c
+ *
+ * Copyright (C) 2010 CompuLab, Ltd.
+ * Mike Rapoport <mike@compulab.co.il>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/gpio.h>
+#include <linux/err.h>
+#include <linux/regulator/consumer.h>
+
+#include <asm/mach-types.h>
+
+#include <mach/pinmux.h>
+#include "board.h"
+
+#ifdef CONFIG_TEGRA_PCI
+
+static int __init harmony_pcie_init(void)
+{
+	int err;
+
+	if (!machine_is_harmony())
+		return 0;
+
+	tegra_pinmux_set_tristate(TEGRA_PINGROUP_GPV, TEGRA_TRI_NORMAL);
+	tegra_pinmux_set_tristate(TEGRA_PINGROUP_SLXA, TEGRA_TRI_NORMAL);
+	tegra_pinmux_set_tristate(TEGRA_PINGROUP_SLXK, TEGRA_TRI_NORMAL);
+
+	err = tegra_pcie_init(true, true);
+	if (err)
+		goto err_pcie;
+
+	return 0;
+
+err_pcie:
+	tegra_pinmux_set_tristate(TEGRA_PINGROUP_GPV, TEGRA_TRI_TRISTATE);
+	tegra_pinmux_set_tristate(TEGRA_PINGROUP_SLXA, TEGRA_TRI_TRISTATE);
+	tegra_pinmux_set_tristate(TEGRA_PINGROUP_SLXK, TEGRA_TRI_TRISTATE);
+
+	return err;
+}
+
+subsys_initcall(harmony_pcie_init);
+
+#endif
-- 
1.6.6.2
