From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 5 Feb 2016 17:37:24 +0800
Subject: [PATCH v6 1/7] clk: mediatek: Refine the makefile to support multiple
 clock drivers
In-Reply-To: <1454665050-37776-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1454665050-37776-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1454665050-37776-2-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Kconfig to define clock configuration for each SoC, and
modify the Makefile to build drivers that only selected in config.

Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Tested-by: John Crispin <blogic@openwrt.org>
---
 drivers/clk/Kconfig           |  1 +
 drivers/clk/mediatek/Kconfig  | 23 +++++++++++++++++++++++
 drivers/clk/mediatek/Makefile |  6 +++---
 3 files changed, 27 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/mediatek/Kconfig

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index de707b2..d333863 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -202,6 +202,7 @@ config COMMON_CLK_CDCE706
 
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
+source "drivers/clk/mediatek/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/samsung/Kconfig"
diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
new file mode 100644
index 0000000..dc224e6
--- /dev/null
+++ b/drivers/clk/mediatek/Kconfig
@@ -0,0 +1,23 @@
+#
+# MediaTek SoC drivers
+#
+config COMMON_CLK_MEDIATEK
+	bool
+	---help---
+	  Mediatek SoCs' clock support.
+
+config COMMON_CLK_MT8135
+	bool "Clock driver for Mediatek MT8135"
+	depends on COMMON_CLK
+	select COMMON_CLK_MEDIATEK
+	default ARCH_MEDIATEK
+	---help---
+	  This driver supports Mediatek MT8135 clocks.
+
+config COMMON_CLK_MT8173
+	bool "Clock driver for Mediatek MT8173"
+	depends on COMMON_CLK
+	select COMMON_CLK_MEDIATEK
+	default ARCH_MEDIATEK
+	---help---
+	  This driver supports Mediatek MT8173 clocks.
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 95fdfac..32e7222 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,4 +1,4 @@
-obj-y += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o
+obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o
 obj-$(CONFIG_RESET_CONTROLLER) += reset.o
-obj-y += clk-mt8135.o
-obj-y += clk-mt8173.o
+obj-$(CONFIG_COMMON_CLK_MT8135) += clk-mt8135.o
+obj-$(CONFIG_COMMON_CLK_MT8173) += clk-mt8173.o
-- 
1.9.1
