From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 26 Apr 2017 17:26:09 +0800
Subject: [PATCH v2 25/30] arm: dts: mt7623: rename mt7623-evb.dts to
 arch/arm/boot/dts/mt7623n-rfb.dtsi
In-Reply-To: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493198774-4478-26-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

There are 2 versions of the SoC. MT7623N is almost identical to MT7623A
but has some additional multimedia features. The reference boards are
available as NAND or MMC and might have a different ethernet setup. In
order to reduce the duplication of devicetree code we add an intermediate
dtsi file for these reference boards. Additionally Mediatek pointed out,
that the EVB is yet another board and the board in question is infact the
RFB. Take this into account while renaming the files.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>

---
 Documentation/devicetree/bindings/arm/mediatek.txt |  6 ++--
 arch/arm/boot/dts/Makefile                         |  2 +-
 arch/arm/boot/dts/mt7623-evb.dts                   | 33 ----------------------
 arch/arm/boot/dts/mt7623n-rfb-nand.dts             | 21 ++++++++++++++
 arch/arm/boot/dts/mt7623n-rfb.dtsi                 | 29 +++++++++++++++++++
 arch/arm/mach-mediatek/mediatek.c                  |  4 +--
 arch/arm/mach-mediatek/platsmp.c                   |  2 +-
 7 files changed, 57 insertions(+), 40 deletions(-)
 delete mode 100644 arch/arm/boot/dts/mt7623-evb.dts
 create mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
 create mode 100644 arch/arm/boot/dts/mt7623n-rfb.dtsi

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index c860b24..7f7c804 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -12,7 +12,7 @@ compatible: Must contain one of
    "mediatek,mt6592"
    "mediatek,mt6755"
    "mediatek,mt6795"
-   "mediatek,mt7623"
+   "mediatek,mt7623n"
    "mediatek,mt8127"
    "mediatek,mt8135"
    "mediatek,mt8173"
@@ -38,9 +38,9 @@ Supported boards:
 - Evaluation board for MT6795(Helio X10):
     Required root node properties:
       - compatible = "mediatek,mt6795-evb", "mediatek,mt6795";
-- Evaluation board for MT7623:
+- Reference  board for MT7623N with NAND:
     Required root node properties:
-      - compatible = "mediatek,mt7623-evb", "mediatek,mt7623";
+      - compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623n";
 - MTK mt8127 tablet moose EVB:
     Required root node properties:
       - compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0118084..5249d24 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1003,7 +1003,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
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
index a769149..0000000
--- a/arch/arm/boot/dts/mt7623-evb.dts
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * Copyright (c) 2016 MediaTek Inc.
- * Author: John Crispin <john@phrozen.org>
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
index 0000000..07b3953
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
+	compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623n";
+};
diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
new file mode 100644
index 0000000..c526116
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
+	memory at 80000000 {
+		reg = <0 0x80000000 0 0x40000000>;
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index a6e3c98..602211d 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -29,7 +29,7 @@ static void __init mediatek_timer_init(void)
 	void __iomem *gpt_base;
 
 	if (of_machine_is_compatible("mediatek,mt6589") ||
-	    of_machine_is_compatible("mediatek,mt7623") ||
+	    of_machine_is_compatible("mediatek,mt7623n") ||
 	    of_machine_is_compatible("mediatek,mt8135") ||
 	    of_machine_is_compatible("mediatek,mt8127")) {
 		/* turn on GPT6 which ungates arch timer clocks */
@@ -48,7 +48,7 @@ static void __init mediatek_timer_init(void)
 	"mediatek,mt2701",
 	"mediatek,mt6589",
 	"mediatek,mt6592",
-	"mediatek,mt7623",
+	"mediatek,mt7623n",
 	"mediatek,mt8127",
 	"mediatek,mt8135",
 	NULL,
diff --git a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
index 726eb69..2dfa1cd 100644
--- a/arch/arm/mach-mediatek/platsmp.c
+++ b/arch/arm/mach-mediatek/platsmp.c
@@ -58,7 +58,7 @@ struct mtk_smp_boot_info {
 
 static const struct of_device_id mtk_smp_boot_infos[] __initconst = {
 	{ .compatible   = "mediatek,mt6589", .data = &mtk_mt6589_boot },
-	{ .compatible   = "mediatek,mt7623", .data = &mtk_mt7623_boot },
+	{ .compatible   = "mediatek,mt7623n", .data = &mtk_mt7623_boot },
 };
 
 static void __iomem *mtk_smp_base;
-- 
1.9.1
