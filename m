From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 26 Jul 2017 16:28:29 +0800
Subject: [PATCH v2 6/9] ARM: sun8i: a83t: cubietruck-plus: Enable PMIC part of
 AXP818 PMIC
In-Reply-To: <20170726082832.16789-1-wens@csie.org>
References: <20170726082832.16789-1-wens@csie.org>
Message-ID: <20170726082832.16789-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP813/AXP818 PMICs used with the A83T/H8 SoCs are actually 2 dies
in one package sharing the serial bus (I2C/RSB) pins. One die is the
actual PMIC. The other is an AC100 codec / RTC combo chip.

This patch enables the RSB controller and adds a device node for the
PMIC die to the Cubietruck Plus device tree. Since the AXP813 and
AXP818 are virtually identical, this patch uses the compatible string
for the former as a fallback.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index 163ddf8868b5..d88a22ac6222 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -129,6 +129,17 @@
 	status = "okay";
 };
 
+&r_rsb {
+	status = "okay";
+
+	axp81x: pmic at 3a3 {
+		compatible = "x-powers,axp818", "x-powers,axp813";
+		reg = <0x3a3>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &spdif {
 	status = "okay";
 };
-- 
2.13.3
