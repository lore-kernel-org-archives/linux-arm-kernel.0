From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Mar 2018 14:53:02 +0100
Subject: [PATCH 05/10] ARM: dts: Add Versatile IB2 device tree
In-Reply-To: <20180311135307.6271-1-linus.walleij@linaro.org>
References: <20180311135307.6271-1-linus.walleij@linaro.org>
Message-ID: <20180311135307.6271-6-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile board can be equipped with a interface board
just named "IB2". This was created in the early 2000s for
prototyping GSM candybar phone form factor products.

The IB2 board contains:
- Cascaded interrupt controller
- Enfora Enabler GSM0308 quad-band module with antenna and
  separate audio jack
- Keypad with joystick
- Sanyo 2.5" color display
- A 28-pin connector for mounting a camera

This adds a DTS file for the combination of the Versatile AB
with an IB2 daughterboard mounted, making the LED blink and
making the system controller available for drivers, such as
the panel driver.

The device tree bindings already exist in
Documentation/devicetree/bindings/arm/arm-boards.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Mali DP Maintainers <malidp@foss.arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/versatile-ab-ib2.dts | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/arm/boot/dts/versatile-ab-ib2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38543dc..850f36902b81 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1047,6 +1047,7 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
 	uniphier-sld8-ref.dtb
 dtb-$(CONFIG_ARCH_VERSATILE) += \
 	versatile-ab.dtb \
+	versatile-ab-ib2.dtb \
 	versatile-pb.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += \
 	vexpress-v2p-ca5s.dtb \
diff --git a/arch/arm/boot/dts/versatile-ab-ib2.dts b/arch/arm/boot/dts/versatile-ab-ib2.dts
new file mode 100644
index 000000000000..5890cb974f78
--- /dev/null
+++ b/arch/arm/boot/dts/versatile-ab-ib2.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The Versatile AB with the IB2 expansion board mounted.
+ * This works as a superset of the Versatile AB.
+ */
+
+#include "versatile-ab.dts"
+
+/ {
+	model = "ARM Versatile AB + IB2 board";
+
+	/* Special IB2 control register */
+	ib2_syscon at 27000000 {
+		compatible = "arm,versatile-ib2-syscon", "syscon", "simple-mfd";
+		reg = <0x27000000 0x4>;
+
+		led at 00.4 {
+			compatible = "register-bit-led";
+			offset = <0x00>;
+			mask = <0x10>;
+			label = "versatile-ib2:0";
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+		};
+	};
+};
-- 
2.14.3
