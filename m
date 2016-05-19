From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 May 2016 12:50:44 +0900
Subject: [PATCH/RFC 2/3] arm64: dts: salvator-x: add Salvator-X board on
 R8A7796 SoC
In-Reply-To: <1463629845-7115-1-git-send-email-horms+renesas@verge.net.au>
References: <1463629845-7115-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1463629845-7115-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds initial board support for R8A7796 Salvator-X.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
--
v1 [Simon Horman]
* Drop use of pfc, that can be added once pfc support is present in mainline
* Set size of memory (bank 0) to 2GiB instead of 1GiB
* Omit scif0
* Add scif_clk, from patch by Hiromitsu Yamasaki

v0 [Takeshi Kihara]
---
 arch/arm64/boot/dts/renesas/Makefile               |  1 +
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 45 ++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 9ce1890a650e..17139f7003a6 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb
+dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb
 
 always		:= $(dtb-y)
 clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
new file mode 100644
index 000000000000..9c52613fb88c
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -0,0 +1,45 @@
+/*
+ * Device Tree Source for the Salvator-X board
+ *
+ * Copyright (C) 2016 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7796.dtsi"
+
+/ {
+	model = "Renesas Salvator-X board based on r8a7796";
+	compatible = "renesas,salvator-x", "renesas,r8a7796";
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
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <16666666>;
+};
+
+&scif2 {
+	status = "okay";
+};
+
+&scif_clk {
+	clock-frequency = <14745600>;
+	status = "okay";
+};
-- 
2.1.4
