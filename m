From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Mon, 24 Apr 2017 15:22:04 -0500
Subject: [PATCH v2 4/4] ARM: dts: keystone: Add minimum support for K2G ICE evm
In-Reply-To: <20170424202204.24170-1-fcooper@ti.com>
References: <20170424202204.24170-1-fcooper@ti.com>
Message-ID: <20170424202204.24170-5-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add barebones dts support for TI's K2G Industrial Communication Engine evm.
This dts allows the board to boot using a ram based filesystem.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/Makefile             |  3 ++-
 arch/arm/boot/dts/keystone-k2g-ice.dts | 35 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/keystone-k2g-ice.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0118084..01a98f1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -193,7 +193,8 @@ dtb-$(CONFIG_ARCH_KEYSTONE) += \
 	keystone-k2hk-evm.dtb \
 	keystone-k2l-evm.dtb \
 	keystone-k2e-evm.dtb \
-	keystone-k2g-evm.dtb
+	keystone-k2g-evm.dtb \
+	keystone-k2g-ice.dtb
 dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-b3.dtb \
 	kirkwood-blackarmor-nas220.dtb \
diff --git a/arch/arm/boot/dts/keystone-k2g-ice.dts b/arch/arm/boot/dts/keystone-k2g-ice.dts
new file mode 100644
index 0000000..d820d37
--- /dev/null
+++ b/arch/arm/boot/dts/keystone-k2g-ice.dts
@@ -0,0 +1,35 @@
+/*
+ * Device Tree Source for K2G Industrial Communication Engine EVM
+ *
+ * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+/dts-v1/;
+
+#include "keystone-k2g.dtsi"
+
+/ {
+	compatible = "ti,k2g-ice", "ti,k2g", "ti,keystone";
+	model = "Texas Instruments K2G Industrial Communication EVM";
+
+	memory at 800000000 {
+		device_type = "memory";
+		reg = <0x00000008 0x00000000 0x00000000 0x20000000>;
+	};
+};
+
+&k2g_pinctrl {
+	uart0_pins: pinmux_uart0_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x11cc) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			K2G_CORE_IOPAD(0x11d0) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+		>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
-- 
2.10.0
