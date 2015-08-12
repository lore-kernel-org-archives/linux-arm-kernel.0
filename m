From: dongsheng.wang@freescale.com (Dongsheng Wang)
Date: Wed, 12 Aug 2015 13:53:26 +0800
Subject: [PATCH v2 1/2] soc/fsl: add freescale dir for SOC specific drivers
Message-ID: <1439358807-9024-1-git-send-email-dongsheng.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Some Freescale device drivers need to move to soc/, because these
drivers are specific drivers. Before the soc/ to be created, the
drivers had been there arch/ or drivers/misc/, but now soc/ dir
is a better choice.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
*V2*
Rebase for last kernel. Resend this patch, this patch is one year ago.
Sorry I haven't had the time to push this patch before.

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 96ddecb..b5c5179 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -5,5 +5,6 @@ source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
 source "drivers/soc/ti/Kconfig"
 source "drivers/soc/versatile/Kconfig"
+source "drivers/soc/fsl/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 7dc7c0d..1caf1d6 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_SOC_TI)		+= ti/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
+obj-$(CONFIG_FSL_SOC_DRIVERS)	+= fsl/
diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
new file mode 100644
index 0000000..863d1ef
--- /dev/null
+++ b/drivers/soc/fsl/Kconfig
@@ -0,0 +1,18 @@
+#
+# Freescale SOC drivers
+#
+menuconfig FSL_SOC_DRIVERS
+	bool "Freescale Soc Drivers"
+	default n
+	help
+	  Say y here to enable Freescale Soc Device Drivers support.
+	  The Soc Drivers provides the device driver that is a specific
+	  block or feature on Freescale platform.
+
+if FSL_SOC_DRIVERS
+
+if ARM
+source "drivers/soc/fsl/Kconfig.arm"
+endif
+
+endif
diff --git a/drivers/soc/fsl/Kconfig.arm b/drivers/soc/fsl/Kconfig.arm
new file mode 100644
index 0000000..8c90b82
--- /dev/null
+++ b/drivers/soc/fsl/Kconfig.arm
@@ -0,0 +1,16 @@
+#
+# Freescale ARM SOC Drivers
+#
+
+config	LS1_SOC_DRIVERS
+	bool "LS1021A Soc Drivers"
+	depends on SOC_LS1021A
+	default n
+	help
+	Say y here to enable Freescale LS1021A Soc Device Drivers support.
+	The Soc Drivers provides the device driver that is a specific block
+	or feature on LS1021A platform.
+
+if LS1_SOC_DRIVERS
+	source "drivers/soc/fsl/ls1/Kconfig"
+endif
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
new file mode 100644
index 0000000..b4215dd
--- /dev/null
+++ b/drivers/soc/fsl/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for Freescale Soc specific device drivers.
+#
+
+obj-$(CONFIG_LS1_SOC_DRIVERS) += ls1/
+
diff --git a/drivers/soc/fsl/ls1/Kconfig b/drivers/soc/fsl/ls1/Kconfig
new file mode 100644
index 0000000..7556f44
--- /dev/null
+++ b/drivers/soc/fsl/ls1/Kconfig
@@ -0,0 +1,3 @@
+#
+# LS-1 Soc drivers
+#
-- 
2.1.0.27.g96db324
