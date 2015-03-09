From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  9 Mar 2015 21:06:57 +0100
Subject: [PATCH 4/4] ARM: shmobile: lager: Add da9063 PMIC device node for
 system restart
In-Reply-To: <1425931617-5479-1-git-send-email-geert+renesas@glider.be>
References: <1425931617-5479-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1425931617-5479-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the da9063 PMIC, with subnodes for rtc and wdt.
Regulator support is not yet included.

This allows the system to be restarted when the watchdog timer times
out, or when a system restart is requested.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 6fa8681a431fceb8..aaa4f258e279ccfa 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -582,6 +582,22 @@
 	pinctrl-0 = <&iic3_pins>;
 	status = "okay";
 
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
1.9.1
