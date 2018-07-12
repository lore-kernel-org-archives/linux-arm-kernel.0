From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 12 Jul 2018 11:04:17 +0800
Subject: [PATCH] ARM: dts: sunxi: libretech-all-h3-cc: Enable eMMC module
Message-ID: <20180712030417.15881-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Libretech ALL-H3-CC has a high density connector for attaching
an eMMC module. The module form factor and connection is specific
to Libretech, and has provisions for split vmmc/vqmmc (core and I/O)
voltage supplies, but this board does not wire the vqmmc side. The
H2+/H3/H5 SoCs do not support alternate I/O voltages for eMMC either.
Only 3.3V is supported. A specific module that ties vqmmc to vmmc,
with both at 3.3V, must be used.

Given that a) eMMC is not designed to be hotplugged, b) power is
always provided on the pins, and c) MMC controllers can deal with
missing cards, we can enable this by default. If a module is attached
it will be picked up by the system.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
index f7ffdd6658a2..1eadc132390c 100644
--- a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
+++ b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
@@ -178,6 +178,15 @@
 	status = "okay";
 };
 
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_vcc_io>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.18.0
