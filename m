From: blogic@openwrt.org (John Crispin)
Date: Tue,  8 Mar 2016 11:29:56 +0100
Subject: [PATCH V5 3/4] net-next: mediatek: add Kconfig and Makefile
In-Reply-To: <1457432997-25526-1-git-send-email-blogic@openwrt.org>
References: <1457432997-25526-1-git-send-email-blogic@openwrt.org>
Message-ID: <1457432997-25526-4-git-send-email-blogic@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Makefile and Kconfig required to make the driver build.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/net/ethernet/Kconfig           |    1 +
 drivers/net/ethernet/Makefile          |    1 +
 drivers/net/ethernet/mediatek/Kconfig  |   17 +++++++++++++++++
 drivers/net/ethernet/mediatek/Makefile |    5 +++++
 4 files changed, 24 insertions(+)
 create mode 100644 drivers/net/ethernet/mediatek/Kconfig
 create mode 100644 drivers/net/ethernet/mediatek/Makefile

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 0b13af8..be67a19 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -106,6 +106,7 @@ config LANTIQ_ETOP
 	  Support for the MII0 inside the Lantiq SoC
 
 source "drivers/net/ethernet/marvell/Kconfig"
+source "drivers/net/ethernet/mediatek/Kconfig"
 source "drivers/net/ethernet/mellanox/Kconfig"
 source "drivers/net/ethernet/micrel/Kconfig"
 source "drivers/net/ethernet/microchip/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 38dc1a7..6ffcc80 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_JME) += jme.o
 obj-$(CONFIG_KORINA) += korina.o
 obj-$(CONFIG_LANTIQ_ETOP) += lantiq_etop.o
 obj-$(CONFIG_NET_VENDOR_MARVELL) += marvell/
+obj-$(CONFIG_NET_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_NET_VENDOR_MELLANOX) += mellanox/
 obj-$(CONFIG_NET_VENDOR_MICREL) += micrel/
 obj-$(CONFIG_NET_VENDOR_MICROCHIP) += microchip/
diff --git a/drivers/net/ethernet/mediatek/Kconfig b/drivers/net/ethernet/mediatek/Kconfig
new file mode 100644
index 0000000..b0229f4
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/Kconfig
@@ -0,0 +1,17 @@
+config NET_VENDOR_MEDIATEK
+	bool "MediaTek ethernet driver"
+	depends on ARCH_MEDIATEK
+	---help---
+	  If you have a Mediatek SoC with ethernet, say Y.
+
+if NET_VENDOR_MEDIATEK
+
+config NET_MEDIATEK_SOC
+	tristate "MediaTek MT7623 Gigabit ethernet support"
+	depends on NET_VENDOR_MEDIATEK && (MACH_MT7623 || MACH_MT2701)
+	select PHYLIB
+	---help---
+	  This driver supports the gigabit ethernet MACs in the
+	  MediaTek MT2701/MT7623 chipset family.
+
+endif #NET_VENDOR_MEDIATEK
diff --git a/drivers/net/ethernet/mediatek/Makefile b/drivers/net/ethernet/mediatek/Makefile
new file mode 100644
index 0000000..aa3f1c8
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the Mediatek SoCs built-in ethernet macs
+#
+
+obj-$(CONFIG_NET_MEDIATEK_SOC)			+= mtk_eth_soc.o
-- 
1.7.10.4
