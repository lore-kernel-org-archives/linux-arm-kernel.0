From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 25 Jan 2016 12:19:26 +0100
Subject: [PATCH] ARM: dts: rockchip: Assign RK3288 EDP_24M input centrally
Message-ID: <1453720766-13086-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EDP 24M clock can be fed either by an SoC internal fixed clock or
from an external IC. Change the default parent to the internal clock in
the main rk3288 dtsi, to ensure (by default) it gets setup with a
non-orphaned clock (hardware defaults to the externa clock).

This prevents potential issues when the clock framework get support for
deferring on orphaned clocks, while specific boards can always change
the parent clock if an external input is preferred.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 arch/arm/boot/dts/rk3288-veyron.dtsi | 5 -----
 arch/arm/boot/dts/rk3288.dtsi        | 3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 9fce91f..5e61f07 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -340,11 +340,6 @@
 	i2c-scl-rising-time-ns = <1000>;
 };
 
-&power {
-	assigned-clocks = <&cru SCLK_EDP_24M>;
-	assigned-clock-parents = <&xin24m>;
-};
-
 &pwm1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 8ac49f3..03bb747 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -630,6 +630,9 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			assigned-clocks = <&cru SCLK_EDP_24M>;
+			assigned-clock-parents = <&xin24m>;
+
 			/*
 			 * Note: Although SCLK_* are the working clocks
 			 * of device without including on the NOC, needed for
-- 
2.7.0
