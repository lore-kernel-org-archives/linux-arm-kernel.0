From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 12:29:32 +0100
Subject: [PATCH 13/16] arm: dts: rename mt7623-evb.dts to
 arch/arm/boot/dts/mt7623n-rfb.dtsi
In-Reply-To: <1485170975-51813-1-git-send-email-john@phrozen.org>
References: <1485170975-51813-1-git-send-email-john@phrozen.org>
Message-ID: <1485170975-51813-14-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 2 versions of the SoC. MT7623N is almost identical to MT7623A
but has some additional multimedia features. The reference boards are
available as NAND or MMC and might have a different ethernet setup. In
order to reduce the duplication of devicetree code we add an intermediate
dtsi file for these reference boards. Additionally MTK/WCN pointed out,
that the EVB is yet another board and the board in question is infact the
RFB. Take this into account while renaming the files.

 Signed-off-by: John Crispin <john@phrozen.org>
---
 Documentation/devicetree/bindings/arm/mediatek.txt |    4 +--
 arch/arm/boot/dts/Makefile                         |    2 +-
 arch/arm/boot/dts/mt7623-evb.dts                   |   33 --------------------
 arch/arm/boot/dts/mt7623n-rfb-nand.dts             |   21 +++++++++++++
 arch/arm/boot/dts/mt7623n-rfb.dtsi                 |   29 +++++++++++++++++
 5 files changed, 53 insertions(+), 36 deletions(-)
 delete mode 100644 arch/arm/boot/dts/mt7623-evb.dts
 create mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
 create mode 100644 arch/arm/boot/dts/mt7623n-rfb.dtsi

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index c860b24..71149cb 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -38,9 +38,9 @@ Supported boards:
 - Evaluation board for MT6795(Helio X10):
     Required root node properties:
       - compatible = "mediatek,mt6795-evb", "mediatek,mt6795";
-- Evaluation board for MT7623:
+- Reference  board for MT7623N with NAND:
     Required root node properties:
-      - compatible = "mediatek,mt7623-evb", "mediatek,mt7623";
+      - compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
 - MTK mt8127 tablet moose EVB:
     Required root node properties:
       - compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cccdbcb..9735c2c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -976,7 +976,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6580-evbp1.dtb \
 	mt6589-aquaris5.dtb \
 	mt6592-evb.dtb \
-	mt7623-evb.dtb \
+	mt7623n-rfb-nand.dtb \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
diff --git a/arch/arm/boot/dts/mt7623-evb.dts b/arch/arm/boot/dts/mt7623-evb.dts
deleted file mode 100644
index 58ed038..0000000
--- a/arch/arm/boot/dts/mt7623-evb.dts
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * Copyright (c) 2016 MediaTek Inc.
- * Author: John Crispin <blogic@openwrt.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-/dts-v1/;
-#include "mt7623-mt6323.dtsi"
-
-/ {
-	model = "MediaTek MT7623 evaluation board";
-	compatible = "mediatek,mt7623-evb", "mediatek,mt7623";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	memory {
-		reg = <0 0x80000000 0 0x40000000>;
-	};
-};
-
-&uart2 {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/mt7623n-rfb-nand.dts b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
new file mode 100644
index 0000000..436d51c
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: John Crispin <blogic@openwrt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+#include "mt7623n-rfb.dtsi"
+
+/ {
+	model = "MediaTek MT7623N NAND reference board";
+	compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
+};
diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
new file mode 100644
index 0000000..d46390e
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: John Crispin <blogic@openwrt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "mt7623-mt6323.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	memory {
+		reg = <0 0x80000000 0 0x40000000>;
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
-- 
1.7.10.4
