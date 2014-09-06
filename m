From: cyndis@kapsi.fi (Mikko Perttunen)
Date: Sat,  6 Sep 2014 11:54:44 +0300
Subject: [PATCH v3 4/5] ARM: tegra: Add PMC thermtrip programming to Jetson
 TK1 device tree
In-Reply-To: <1409993685-21911-1-git-send-email-cyndis@kapsi.fi>
References: <1409993685-21911-1-git-send-email-cyndis@kapsi.fi>
Message-ID: <1409993685-21911-5-git-send-email-cyndis@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikko Perttunen <mperttunen@nvidia.com>

This adds the required information to reset the board during an overheating
situation to the Jetson TK1 device tree. The thermal reset is handled by the
PMC by sending an I2C message to the PMIC. The entries specify the I2C
message to be sent.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Wei Ni <wni@nvidia.com>
Tested-by: Wei Ni <wni@nvidia.com>
---
v3
- updated to new binding

 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index d4ddabd..d8894e2 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1422,7 +1422,7 @@
 	};
 
 	/* Expansion PWR_I2C_*, on-board components */
-	i2c at 0,7000d000 {
+	pmic_bus: i2c at 0,7000d000 {
 		status = "okay";
 		clock-frequency = <400000>;
 
@@ -1637,6 +1637,13 @@
 		nvidia,core-pwr-off-time = <61036>;
 		nvidia,core-power-req-active-high;
 		nvidia,sys-clock-req-active-high;
+
+		i2c-thermtrip {
+			nvidia,i2c-bus = <&pmic_bus>;
+			nvidia,bus-addr = <0x40>;
+			nvidia,reg-addr = <0x36>;
+			nvidia,reg-data = <0x2>;
+		};
 	};
 
 	padctl at 0,7009f000 {
-- 
2.1.0
