From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  2 Jan 2013 22:55:19 -0700
Subject: [PATCH 4/6] ARM: bcm2835: add SDHCI node to DT
In-Reply-To: <1357192521-13025-1-git-send-email-swarren@wwwdotorg.org>
References: <1357192521-13025-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1357192521-13025-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SDHCI device node to the SoC DT file. Add a dummy fixed-clock
to satisfy the SDHCI driver's clock lookup; eventually this should be
replaced by a real clock implementation. Add board specific properties
to the Raspberry Pi board file.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/boot/dts/bcm2835-rpi-b.dts |    5 +++++
 arch/arm/boot/dts/bcm2835.dtsi      |   14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 6ff26f9..0544ef8 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -24,3 +24,8 @@
 		brcm,function = <7>; /* alt3 */
 	};
 };
+
+&sdhci {
+	status = "okay";
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 8917550..1d7e4f5 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -63,5 +63,19 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		sdhci: sdhci {
+			compatible = "brcm,bcm2835-sdhci";
+			reg = <0x7e300000 0x100>;
+			interrupts = <2 30>;
+			clocks = <&clk_mmc>;
+			status = "disabled";
+		};
+	};
+
+	clk_mmc: clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
 	};
 };
-- 
1.7.10.4
