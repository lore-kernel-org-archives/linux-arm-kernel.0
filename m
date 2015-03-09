From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  9 Mar 2015 21:06:55 +0100
Subject: [PATCH 2/4] ARM: shmobile: koelsch: Add da9063 PMIC device node for
 system restart
In-Reply-To: <1425931617-5479-1-git-send-email-geert+renesas@glider.be>
References: <1425931617-5479-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1425931617-5479-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the da9063 PMIC, with subnodes for rtc and wdt.
Regulator support is not yet included.

This allows the system to be restarted when the watchdog timer times
out, or when a system restart is requested.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
An earlier version of this patch has been posted as "[PATCH 3/4] ARM:
shmobile: koelsch: Add DA9063 PMIC device node for system restart".

Changes:
  - Add missing interrupt-controller property,
  - Add rtc and wdt subnodes.
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 25ce4c71939febd0..74c3212f1f11e47e 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -584,6 +584,22 @@
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
1.9.1
