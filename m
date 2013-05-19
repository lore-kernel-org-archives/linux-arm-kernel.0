From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 19 May 2013 23:39:38 +0200
Subject: [RFC PATCH 5/5] ARM: mv78x00: Add Device Tree support for the
 RD-78X00-mASA board
In-Reply-To: <1368999578-19938-1-git-send-email-gregory.clement@free-electrons.com>
References: <1368999578-19938-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1368999578-19938-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the device tree support for the RD-78X00-mASA board.
It mainly converts the platform resource from the former board file
to the dts. It also add this device tree to the list of the dtbs
make rule.

Currently support includes:
- UARTs
- USBs
- I2Cs
- RTC
- SATAs

The mains lacks are PCI and Ethernet which will be added when
converted to device tree.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/mv78x00-masa-db.dts | 61 +++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 arch/arm/boot/dts/mv78x00-masa-db.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b9f7121..f152b89 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -91,6 +91,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
 dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
 	msm8960-cdp.dtb
+dtb-$(CONFIG_ARCH_MV78X00) += mv78x00-masa-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-370-mirabox.dtb \
 	armada-370-rd.dtb \
diff --git a/arch/arm/boot/dts/mv78x00-masa-db.dts b/arch/arm/boot/dts/mv78x00-masa-db.dts
new file mode 100644
index 0000000..f87f84d
--- /dev/null
+++ b/arch/arm/boot/dts/mv78x00-masa-db.dts
@@ -0,0 +1,61 @@
+/*
+ * Copyright (C) 2013  Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "mv78x00.dtsi"
+
+/ {
+	model = "Marvell RD-78x00-MASA Development Board";
+	compatible = "marvell,rd-78x00-masa", "marvell,mv78x00";
+
+	memory {
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+
+		serial at 12000 {
+			clock-frequency = <200000000>;
+			status = "okay";
+		};
+
+		serial at 12200 {
+			clock-frequency = <200000000>;
+			status = "okay";
+		};
+
+		sata at a0000 {
+			nr-ports = <2>;
+			status = "okay";
+		};
+
+		i2c0: i2c at 10000 {
+			status = "okay";
+			rtc: rtc at 68 {
+				compatible = "dallas,ds1338";
+				reg = <0x68>;
+			};
+		};
+
+		ehci at 50000 {
+			status = "okay";
+		};
+
+		ehci at 51000 {
+			status = "okay";
+		};
+
+		ehci at 52000 {
+			status = "okay";
+		};
+	};
+};
-- 
1.8.1.2
