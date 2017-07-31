From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:18 +0200
Subject: [PATCH 26/31] arm64: dts: renesas: Add Renesas Draak board support
In-Reply-To: <cover.1501509525.git.horms+renesas@verge.net.au>
References: <cover.1501509525.git.horms+renesas@verge.net.au>
Message-ID: <c550443f08752b74aacc459fea85c12104a74077.1501509526.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Basic support for the Renesas Draak board based on R-Car D3:
  - Memory,
  - Main crystal,
  - Serial console,
  - Watchdog.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/Makefile           |  1 +
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 46 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77995-draak.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index acc4bb30d485..381928bc1358 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -2,6 +2,7 @@ dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es1-salvator-x.dtb r8a7795-es1-h3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
+dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
 
 always		:= $(dtb-y)
 clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
new file mode 100644
index 000000000000..d144370051d5
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -0,0 +1,46 @@
+/*
+ * Device Tree Source for the Draak board
+ *
+ * Copyright (C) 2016 Renesas Electronics Corp.
+ * Copyright (C) 2017 Glider bvba
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a77995.dtsi"
+
+/ {
+	model = "Renesas Draak board based on r8a77995";
+	compatible = "renesas,draak", "renesas,r8a77995";
+
+	aliases {
+		serial0 = &scif2;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x18000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <48000000>;
+};
+
+&scif2 {
+	status = "okay";
+};
+
+&rwdt {
+	timeout-sec = <60>;
+	status = "okay";
+};
-- 
2.1.4
