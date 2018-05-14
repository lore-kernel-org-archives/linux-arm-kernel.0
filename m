From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Mon, 14 May 2018 23:16:10 +0200
Subject: [RFC PATCH 10/10] arm64: dts: rockchip: Enable dmc and dfi nodes on
 gru.
In-Reply-To: <20180514211610.26618-1-enric.balletbo@collabora.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
Message-ID: <20180514211610.26618-11-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lin Huang <hl@rock-chips.com>

Enable the DMC (Dynamic Memory Controller) and the DFI (DDR PHY Interface)
nodes on gru/kevin boards so we can support DDR DVFS.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 21 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi     |  2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 18f546f2dfd1..ba2cfdd082b8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -525,6 +525,12 @@
 	extcon = <&usbc_extcon0>, <&usbc_extcon1>;
 };
 
+&dmc_opp_table {
+	opp04 {
+		opp-suspend;
+	};
+};
+
 /*
  * Set some suspend operating points to avoid OVP in suspend
  *
@@ -600,6 +606,10 @@
 		<400000000>;
 };
 
+&display_subsystem {
+	devfreq = <&dmc>;
+};
+
 &emmc_phy {
 	status = "okay";
 };
@@ -766,6 +776,17 @@ ap_i2c_audio: &i2c8 {
 	status = "okay";
 };
 
+&dfi {
+	status = "okay";
+};
+
+&dmc {
+	status = "okay";
+	center-supply = <&ppvar_centerlogic>;
+	upthreshold = <25>;
+	downdifferential = <15>;
+};
+
 &sdhci {
 	/*
 	 * Signal integrity isn't great at 200 MHz and 150 MHz (DDR) gives the
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e012cc8ae3d4..518c742293fc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -160,7 +160,7 @@
 		};
 	};
 
-	display-subsystem {
+	display_subsystem: display-subsystem {
 		compatible = "rockchip,display-subsystem";
 		ports = <&vopl_out>, <&vopb_out>;
 	};
-- 
2.17.0
