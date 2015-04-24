From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 24 Apr 2015 12:05:54 +0200
Subject: [PATCH] ARM: tegra: Add missing HDMI +5V regulator
Message-ID: <1429869954-5909-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Commit fb50a116bbbc ("drm/tegra: hdmi - Add connector supply support")
introduced a new supply for HDMI connectors that is used to control the
voltage on the +5V pin. Not all boards have had the corresponding supply
added to their device tree files, causing the following warning message
during boot:

	[    0.859698] 54280000.hdmi supply hdmi not found, using dummy regulator

Add such a regulator to the Seaboard DTS to enable the driver to control
this voltage and get rid of the warning.

Reported-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Hi Stephen,

This is completely untested because I don't have a Seaboard. But this is
based on the schematics and I think it should work, so it'd be great if
you could test it.

Thanks,
Thierry

 arch/arm/boot/dts/tegra20-seaboard.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index e2fed2712249..aea8994b35f2 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -31,6 +31,7 @@
 
 			vdd-supply = <&hdmi_vdd_reg>;
 			pll-supply = <&hdmi_pll_reg>;
+			hdmi-supply = <&vdd_hdmi>;
 
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
 			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
@@ -893,6 +894,17 @@
 			gpio = <&gpio TEGRA_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
+
+		vdd_hdmi: regulator at 6 {
+			compatible = "regulator-fixed";
+			reg = <6>;
+			regulator-name = "VDDIO_HDMI";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio TEGRA_GPIO(V, 5) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			vin-supply = <&vdd_5v0_reg>;
+		};
 	};
 
 	sound {
-- 
2.3.5
