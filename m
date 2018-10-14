From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 14 Oct 2018 08:07:45 +0000
Subject: [PATCH V4 02/11] clk: imx: scu: add scu clock common part
In-Reply-To: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1539504194-28289-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add scu clock common part which will be used by client clock drivers.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v3->v4:
 * scu headfile path change
v2->v3:
 * no changes
v1->v2:
 * update function call name
---
 drivers/clk/imx/Kconfig       |  2 ++
 drivers/clk/imx/Makefile      |  2 ++
 drivers/clk/imx/scu/Kconfig   |  5 +++++
 drivers/clk/imx/scu/Makefile  |  4 ++++
 drivers/clk/imx/scu/clk-scu.c | 17 +++++++++++++++++
 drivers/clk/imx/scu/clk-scu.h | 18 ++++++++++++++++++
 6 files changed, 48 insertions(+)
 create mode 100644 drivers/clk/imx/scu/Kconfig
 create mode 100644 drivers/clk/imx/scu/Makefile
 create mode 100644 drivers/clk/imx/scu/clk-scu.c
 create mode 100644 drivers/clk/imx/scu/clk-scu.h

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 43a3ecc..b1599bf 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -3,3 +3,5 @@
 config MXC_CLK
 	bool
 	depends on ARCH_MXC
+
+source drivers/clk/imx/scu/Kconfig
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index d447f8c..79b641a 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -13,6 +13,8 @@ obj-$(CONFIG_MXC_CLK) += \
 	clk-pllv3.o \
 	clk-pfd.o
 
+obj-y += scu/
+
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
 obj-$(CONFIG_SOC_IMX25)  += clk-imx25.o
diff --git a/drivers/clk/imx/scu/Kconfig b/drivers/clk/imx/scu/Kconfig
new file mode 100644
index 0000000..4d018fd
--- /dev/null
+++ b/drivers/clk/imx/scu/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+# SCU based common clock support for NXP i.MX SoC family.
+config MXC_CLK_SCU
+	bool
+	depends on ARCH_MXC && ARM64
diff --git a/drivers/clk/imx/scu/Makefile b/drivers/clk/imx/scu/Makefile
new file mode 100644
index 0000000..7dead13
--- /dev/null
+++ b/drivers/clk/imx/scu/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_MXC_CLK_SCU) += \
+	clk-scu.o
diff --git a/drivers/clk/imx/scu/clk-scu.c b/drivers/clk/imx/scu/clk-scu.c
new file mode 100644
index 0000000..826049f
--- /dev/null
+++ b/drivers/clk/imx/scu/clk-scu.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <linux/errno.h>
+#include "clk-scu.h"
+
+DEFINE_SPINLOCK(imx_ccm_lock);
+struct imx_sc_ipc *ccm_ipc_handle;
+
+int imx_clk_scu_init(void)
+{
+	return imx_scu_get_handle(&ccm_ipc_handle);
+}
diff --git a/drivers/clk/imx/scu/clk-scu.h b/drivers/clk/imx/scu/clk-scu.h
new file mode 100644
index 0000000..b964f35
--- /dev/null
+++ b/drivers/clk/imx/scu/clk-scu.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ */
+
+#ifndef __IMX_CLK_SCU_H
+#define __IMX_CLK_SCU_H
+
+#include <linux/firmware/imx/sci.h>
+#include <linux/spinlock.h>
+
+extern spinlock_t imx_ccm_lock;
+extern struct imx_sc_ipc *ccm_ipc_handle;
+
+int imx_clk_scu_init(void);
+
+#endif
-- 
2.7.4
