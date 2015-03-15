From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 16 Mar 2015 08:03:07 +0900
Subject: [PATCH 3/5] ARM: shmobile: koelsch: Add da9063 PMIC device node for
 system restart
In-Reply-To: <cover.1426456462.git.horms+renesas@verge.net.au>
References: <cover.1426456462.git.horms+renesas@verge.net.au>
Message-ID: <a6b422664597d7b9ca6cf441bc48cfe1a707cd3a.1426456462.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the da9063 PMIC, with subnodes for rtc and wdt.
Regulator support is not yet included.

This allows the system to be restarted when the watchdog timer times
out, or when a system restart is requested.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 213a643..b2dcf64 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -517,6 +517,22 @@
 	status = "okay";
 	clock-frequency = <100000>;
 
+	pmic at 58 {
+		compatible = "dlg,da9063";
+		reg = <0x58>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		rtc {
+			compatible = "dlg,da9063-rtc";
+		};
+
+		wdt {
+			compatible = "dlg,da9063-watchdog";
+		};
+	};
+
 	vdd_dvfs: regulator at 68 {
 		compatible = "dlg,da9210";
 		reg = <0x68>;
-- 
2.1.4
