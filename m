From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sat, 17 Nov 2018 10:11:31 -0800
Subject: [PATCH 1/1] reset: imx7: Add support for i.MX8MQ
In-Reply-To: <20181117181131.9330-1-andrew.smirnov@gmail.com>
References: <20181117181131.9330-1-andrew.smirnov@gmail.com>
Message-ID: <20181117181131.9330-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SRC IP block used in i.MX8MQ is a superset of what is found in i.MX7D,
so add all of the definitions necessary to support both.

Cc: p.zabel at pengutronix.de
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy at gmail.com
Cc: l.stach at pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx at nxp.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/reset/Kconfig                   |  2 +-
 drivers/reset/reset-imx7.c              | 66 ++++++++++++++++++++++++-
 include/dt-bindings/reset/imx7-reset.h  | 15 +++++-
 include/dt-bindings/reset/imx8m-reset.h | 47 ++++++++++++++++++
 4 files changed, 127 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8m-reset.h

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index c21da9fe51ec..4909aab7401b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -50,7 +50,7 @@ config RESET_HSDK
 config RESET_IMX7
 	bool "i.MX7 Reset Driver" if COMPILE_TEST
 	depends on HAS_IOMEM
-	default SOC_IMX7D
+	default SOC_IMX7D || SOC_IMX8MQ
 	select MFD_SYSCON
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 77911fa8f31d..dffad618f805 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -21,14 +21,16 @@
 #include <linux/reset-controller.h>
 #include <linux/regmap.h>
 #include <dt-bindings/reset/imx7-reset.h>
+#include <dt-bindings/reset/imx8m-reset.h>
 
 struct imx7_src {
 	struct reset_controller_dev rcdev;
 	struct regmap *regmap;
 };
 
-enum imx7_src_registers {
+enum imx_src_registers {
 	SRC_A7RCR0		= 0x0004,
+	SRC_A53RCR0		= 0x0004,
 	SRC_M4RCR		= 0x000c,
 	SRC_ERCR		= 0x0014,
 	SRC_HSICPHY_RCR		= 0x001c,
@@ -36,7 +38,9 @@ enum imx7_src_registers {
 	SRC_USBOPHY2_RCR	= 0x0024,
 	SRC_MIPIPHY_RCR		= 0x0028,
 	SRC_PCIEPHY_RCR		= 0x002c,
+	SRC_PCIE2PHY_RCR	= 0x0048,
 	SRC_DDRC_RCR		= 0x1000,
+
 };
 
 struct imx7_src_signal {
@@ -67,11 +71,67 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_PCIEPHY]		= { SRC_PCIEPHY_RCR, BIT(2) | BIT(1) },
 	[IMX7_RESET_PCIEPHY_PERST]	= { SRC_PCIEPHY_RCR, BIT(3) },
 	[IMX7_RESET_PCIE_CTRL_APPS_EN]	= { SRC_PCIEPHY_RCR, BIT(6) },
+	[IMX7_RESET_PCIE_CTRL_APPS_CLK_REQ] = { SRC_PCIEPHY_RCR, BIT(4) },
 	[IMX7_RESET_PCIE_CTRL_APPS_TURNOFF] = { SRC_PCIEPHY_RCR, BIT(11) },
 	[IMX7_RESET_DDRC_PRST]		= { SRC_DDRC_RCR, BIT(0) },
 	[IMX7_RESET_DDRC_CORE_RST]	= { SRC_DDRC_RCR, BIT(1) },
+
+	[IMX8M_RESET_A53_CORE_POR_RESET2] = { SRC_A53RCR0, BIT(2) },
+	[IMX8M_RESET_A53_CORE_POR_RESET3] = { SRC_A53RCR0, BIT(3) },
+	[IMX8M_RESET_A53_CORE_RESET2]     = { SRC_A53RCR0, BIT(6) },
+	[IMX8M_RESET_A53_CORE_RESET3]     = { SRC_A53RCR0, BIT(7) },
+	[IMX8M_RESET_A53_ETM_RESET2]      = { SRC_A53RCR0, BIT(14) },
+	[IMX8M_RESET_A53_ETM_RESET3]      = { SRC_A53RCR0, BIT(15) },
+	[IMX8M_RESET_PCIE2PHY]		= { SRC_PCIEPHY_RCR, BIT(2) | BIT(1) },
+	[IMX8M_RESET_PCIE2PHY_PERST]      = { SRC_PCIE2PHY_RCR, BIT(3) },
+	[IMX8M_RESET_PCIE2_CTRL_APPS_EN]  = { SRC_PCIE2PHY_RCR, BIT(6) },
+	[IMX8M_RESET_PCIE2_CTRL_APPS_CLK_REQ] = { SRC_PCIE2PHY_RCR, BIT(4) },
+	[IMX8M_RESET_PCIE2_CTRL_APPS_TURNOFF] = { SRC_PCIE2PHY_RCR, BIT(11) },
 };
 
+static inline void imx7_src_check_definitions(void)
+{
+	BUILD_BUG_ON(IMX8M_RESET_A53_CORE_POR_RESET0 !=
+		     IMX7_RESET_A7_CORE_POR_RESET0);
+	BUILD_BUG_ON(IMX8M_RESET_A53_CORE_POR_RESET1 !=
+		     IMX7_RESET_A7_CORE_POR_RESET1);
+	BUILD_BUG_ON(IMX8M_RESET_A53_CORE_RESET0 !=
+		     IMX7_RESET_A7_CORE_RESET0);
+	BUILD_BUG_ON(IMX8M_RESET_A53_CORE_RESET1 !=
+		     IMX7_RESET_A7_CORE_RESET1);
+	BUILD_BUG_ON(IMX8M_RESET_A53_DBG_RESET0 !=
+		     IMX7_RESET_A7_DBG_RESET0);
+	BUILD_BUG_ON(IMX8M_RESET_A53_DBG_RESET1 !=
+		     IMX7_RESET_A7_DBG_RESET1);
+	BUILD_BUG_ON(IMX8M_RESET_A53_ETM_RESET0 !=
+		     IMX7_RESET_A7_ETM_RESET0);
+	BUILD_BUG_ON(IMX8M_RESET_A53_ETM_RESET1 !=
+		     IMX7_RESET_A7_ETM_RESET1);
+	BUILD_BUG_ON(IMX8M_RESET_A53_SOC_DBG_RESET !=
+		     IMX7_RESET_A7_SOC_DBG_RESET);
+	BUILD_BUG_ON(IMX8M_RESET_A53_L2RESET != IMX7_RESET_A7_L2RESET);
+	BUILD_BUG_ON(IMX8M_RESET_SW_M4C_RST != IMX7_RESET_SW_M4C_RST);
+	BUILD_BUG_ON(IMX8M_RESET_SW_M4P_RST != IMX7_RESET_SW_M4P_RST);
+	BUILD_BUG_ON(IMX8M_RESET_EIM_RST != IMX7_RESET_EIM_RST);
+	BUILD_BUG_ON(IMX8M_RESET_HSICPHY_PORT_RST !=
+		     IMX7_RESET_HSICPHY_PORT_RST);
+	BUILD_BUG_ON(IMX8M_RESET_USBPHY1_POR != IMX7_RESET_USBPHY1_POR);
+	BUILD_BUG_ON(IMX8M_RESET_USBPHY1_PORT_RST !=
+		     IMX7_RESET_USBPHY1_PORT_RST);
+	BUILD_BUG_ON(IMX8M_RESET_USBPHY2_POR != IMX7_RESET_USBPHY2_POR);
+	BUILD_BUG_ON(IMX8M_RESET_USBPHY2_PORT_RST !=
+		     IMX7_RESET_USBPHY2_PORT_RST);
+	BUILD_BUG_ON(IMX8M_RESET_MIPI_PHY_MRST != IMX7_RESET_MIPI_PHY_MRST);
+	BUILD_BUG_ON(IMX8M_RESET_MIPI_PHY_SRST != IMX7_RESET_MIPI_PHY_SRST);
+	BUILD_BUG_ON(IMX8M_RESET_PCIEPHY != IMX7_RESET_PCIEPHY);
+	BUILD_BUG_ON(IMX8M_RESET_PCIE_CTRL_APPS_EN !=
+		     IMX7_RESET_PCIE_CTRL_APPS_EN);
+	BUILD_BUG_ON(IMX8M_RESET_PCIE_CTRL_APPS_TURNOFF !=
+		     IMX7_RESET_PCIE_CTRL_APPS_TURNOFF);
+	BUILD_BUG_ON(IMX8M_RESET_DDRC_PRST != IMX7_RESET_DDRC_PRST);
+	BUILD_BUG_ON(IMX8M_RESET_DDRC_CORE_RST != IMX7_RESET_DDRC_CORE_RST);
+}
+
 static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
 {
 	return container_of(rcdev, struct imx7_src, rcdev);
@@ -85,6 +145,7 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
 	unsigned int value = assert ? signal->bit : 0;
 
 	switch (id) {
+	case IMX8M_RESET_PCIE2PHY: /* FALLTHROUGH */
 	case IMX7_RESET_PCIEPHY:
 		/*
 		 * wait for more than 10us to release phy g_rst and
@@ -94,6 +155,7 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
 			udelay(10);
 		break;
 
+	case IMX8M_RESET_PCIE2_CTRL_APPS_EN: /* FALLTHROUGH */
 	case IMX7_RESET_PCIE_CTRL_APPS_EN:
 		value = (assert) ? 0 : signal->bit;
 		break;
@@ -126,6 +188,8 @@ static int imx7_reset_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct regmap_config config = { .name = "src" };
 
+	imx7_src_check_definitions();
+
 	imx7src = devm_kzalloc(dev, sizeof(*imx7src), GFP_KERNEL);
 	if (!imx7src)
 		return -ENOMEM;
diff --git a/include/dt-bindings/reset/imx7-reset.h b/include/dt-bindings/reset/imx7-reset.h
index 31b3f87dde9a..8fefd694d481 100644
--- a/include/dt-bindings/reset/imx7-reset.h
+++ b/include/dt-bindings/reset/imx7-reset.h
@@ -57,8 +57,21 @@
 #define IMX7_RESET_DDRC_CORE_RST	24
 
 #define IMX7_RESET_PCIE_CTRL_APPS_TURNOFF 25
+#define IMX7_RESET_PCIE_CTRL_APPS_CLK_REQ 26
 
-#define IMX7_RESET_NUM			26
+#define	IMX8M_RESET_A53_CORE_POR_RESET2	27
+#define IMX8M_RESET_A53_CORE_POR_RESET3	28
+#define IMX8M_RESET_A53_CORE_RESET2	29
+#define	IMX8M_RESET_A53_CORE_RESET3	30
+#define IMX8M_RESET_A53_ETM_RESET2	31
+#define IMX8M_RESET_A53_ETM_RESET3	32
+#define IMX8M_RESET_PCIE2PHY		33
+#define IMX8M_RESET_PCIE2PHY_PERST	34
+#define IMX8M_RESET_PCIE2_CTRL_APPS_EN	35
+#define IMX8M_RESET_PCIE2_CTRL_APPS_CLK_REQ 36
+#define IMX8M_RESET_PCIE2_CTRL_APPS_TURNOFF 37
+
+#define IMX7_RESET_NUM			38
 
 #endif
 
diff --git a/include/dt-bindings/reset/imx8m-reset.h b/include/dt-bindings/reset/imx8m-reset.h
new file mode 100644
index 000000000000..8fa840354723
--- /dev/null
+++ b/include/dt-bindings/reset/imx8m-reset.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Zodiac Inflight Innovations
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ */
+
+#ifndef DT_BINDING_RESET_IMX8M_H
+#define DT_BINDING_RESET_IMX8M_H
+
+#include "imx7-reset.h"
+
+#define IMX8M_RESET_A53_CORE_POR_RESET0 IMX7_RESET_A7_CORE_POR_RESET0
+#define IMX8M_RESET_A53_CORE_POR_RESET1 IMX7_RESET_A7_CORE_POR_RESET1
+
+#define IMX8M_RESET_A53_CORE_RESET0     IMX7_RESET_A7_CORE_RESET0
+#define IMX8M_RESET_A53_CORE_RESET1     IMX7_RESET_A7_CORE_RESET1
+
+#define IMX8M_RESET_A53_DBG_RESET0	IMX7_RESET_A7_DBG_RESET0
+#define IMX8M_RESET_A53_DBG_RESET1	IMX7_RESET_A7_DBG_RESET1
+
+#define IMX8M_RESET_A53_ETM_RESET0	IMX7_RESET_A7_ETM_RESET0
+#define IMX8M_RESET_A53_ETM_RESET1	IMX7_RESET_A7_ETM_RESET1
+
+#define IMX8M_RESET_A53_SOC_DBG_RESET   IMX7_RESET_A7_SOC_DBG_RESET
+#define IMX8M_RESET_A53_L2RESET         IMX7_RESET_A7_L2RESET
+#define IMX8M_RESET_SW_M4C_RST          IMX7_RESET_SW_M4C_RST
+#define IMX8M_RESET_SW_M4P_RST          IMX7_RESET_SW_M4P_RST
+#define IMX8M_RESET_EIM_RST             IMX7_RESET_EIM_RST
+#define IMX8M_RESET_HSICPHY_PORT_RST    IMX7_RESET_HSICPHY_PORT_RST
+#define IMX8M_RESET_USBPHY1_POR         IMX7_RESET_USBPHY1_POR
+#define IMX8M_RESET_USBPHY1_PORT_RST    IMX7_RESET_USBPHY1_PORT_RST
+#define IMX8M_RESET_USBPHY2_POR         IMX7_RESET_USBPHY2_POR
+#define IMX8M_RESET_USBPHY2_PORT_RST    IMX7_RESET_USBPHY2_PORT_RST
+#define IMX8M_RESET_MIPI_PHY_MRST       IMX7_RESET_MIPI_PHY_MRST
+#define IMX8M_RESET_MIPI_PHY_SRST       IMX7_RESET_MIPI_PHY_SRST
+
+#define IMX8M_RESET_PCIEPHY             IMX7_RESET_PCIEPHY
+#define IMX8M_RESET_PCIEPHY_PERST	IMX7_RESET_PCIEPHY_PERST
+#define IMX8M_RESET_PCIE_CTRL_APPS_EN   IMX7_RESET_PCIE_CTRL_APPS_EN
+#define IMX8M_RESET_DDRC_PRST           IMX7_RESET_DDRC_PRST
+#define IMX8M_RESET_DDRC_CORE_RST       IMX7_RESET_DDRC_CORE_RST
+
+#define IMX8M_RESET_PCIE_CTRL_APPS_TURNOFF IMX7_RESET_PCIE_CTRL_APPS_TURNOFF
+#define IMX8M_RESET_PCIE_CTRL_APPS_CLK_REQ IMX7_RESET_PCIE_CTRL_APPS_CLK_REQ
+
+#endif
-- 
2.19.1
