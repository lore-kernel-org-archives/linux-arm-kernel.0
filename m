From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 27 Oct 2012 18:22:45 +0200
Subject: [PATCH] arm: mvebu: support for the Globalscale Mirabox MBX0001 board
Message-ID: <1351354965-23875-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform, available from Globalscale has an Armada 370. For now,
only the serial port is supported. Support for network, USB and other
peripherals will be added as drivers for them become available for
Armada 370 in mainline.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/Makefile          |    3 ++-
 arch/arm/boot/dts/mbx001.dts        |   37 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/armada-370-xp.c |    1 +
 3 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/mbx001.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f37cf9f..ee09963 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -44,7 +44,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
 dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
 	msm8960-cdp.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
-	armada-xp-db.dtb
+	armada-xp-db.dtb \
+	mbx0001.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
 	imx53-ard.dtb \
 	imx53-evk.dtb \
diff --git a/arch/arm/boot/dts/mbx001.dts b/arch/arm/boot/dts/mbx001.dts
new file mode 100644
index 0000000..88a5a11
--- /dev/null
+++ b/arch/arm/boot/dts/mbx001.dts
@@ -0,0 +1,37 @@
+/*
+ * Device Tree file for Globalscale Mirabox MBX0001
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "armada-370.dtsi"
+
+/ {
+	model = "Mirabox MBX0001";
+	compatible = "globalscale,mbx0001", "marvell,armada370", "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	soc {
+		serial at d0012000 {
+			clock-frequency = <200000000>;
+			status = "okay";
+		};
+		timer at d0020300 {
+			clock-frequency = <600000000>;
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 49d7915..e5269b4 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -49,6 +49,7 @@ static void __init armada_370_xp_dt_init(void)
 static const char * const armada_370_xp_dt_board_dt_compat[] = {
 	"marvell,a370-db",
 	"marvell,axp-db",
+	"globalscale,mbx0001",
 	NULL,
 };
 
-- 
1.7.9.5
