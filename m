From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Apr 2014 17:40:30 -0700
Subject: [PATCH 4/4] ARM: dts: Enable twl4030 off-idle configuration for
 selected omaps
In-Reply-To: <1398300030-7386-1-git-send-email-tony@atomide.com>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
Message-ID: <1398300030-7386-5-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least N900 now seems to shut down the external oscillator
when hitting off-idle.

OMAP37XX EVM (TMDSEVM3730) does not seem to have twl4030 clken
pin connected, so there is no point trying to enable shutting
down of the oscillator on it for the extra latency it adds.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-evm-common.dtsi | 7 +++++++
 arch/arm/boot/dts/omap3-n900.dts        | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
index 3007e79..3d25340 100644
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -45,6 +45,13 @@
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
 
+&twl {
+	twl_power: power {
+		compatible = "ti,twl4030-power-idle";
+		ti,use_poweroff;
+	};
+};
+
 &i2c2 {
 	clock-frequency = <400000>;
 };
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index bae58c0..c9ed2d4 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -269,6 +269,11 @@
 		compatible = "ti,twl4030-audio";
 		ti,enable-vibra = <1>;
 	};
+
+	twl_power: power {
+		compatible = "ti,twl4030-power-idle-osc-off";
+		ti,use_poweroff;
+	};
 };
 
 &twl_gpio {
-- 
1.8.1.1
