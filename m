From: heiko.stuebner@collabora.com (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 01 Dec 2015 18:13:20 +0100
Subject: [PATCH 1/3] ARM: dts: rockchip: make sure edp_24m is associated to
 xin24m on veyron
Message-ID: <2211452.2WPFOUcQC0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The edp-24m clock has two possible sources: the 24MHz oscillator as well
as an external 27MHz input. The power-on-default is the 27MHz clock which
is not supplied on all Rockchip boards. While on all current boards and
also all Veyron Chromebooks the bootloader seems to adapt the muxing to
the internal source, this doesn't seem to be the case on headless veyron
devices like brain and mickey making the edp-24m clock an orphan.
On the hardware side the 27m input also is not connected at all.

With the upcoming deferral of orphan-clocks this results in the power-
domain code deferring, as it cannot request the needed clock and if the
synchronous reset is sucessfullat all in this case is also unknown.

So fix that by making sure, the edp-24m clock is muxed to the internal
24MHz oscillator at all times.

Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
---
 arch/arm/boot/dts/rk3288-veyron.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-
veyron.dtsi
index 5e61f07..9fce91f 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -340,6 +340,11 @@
 	i2c-scl-rising-time-ns = <1000>;
 };
 
+&power {
+	assigned-clocks = <&cru SCLK_EDP_24M>;
+	assigned-clock-parents = <&xin24m>;
+};
+
 &pwm1 {
 	status = "okay";
 };
-- 
2.6.1
