From: dianders@chromium.org (Doug Anderson)
Date: Thu, 31 Jul 2014 09:13:18 -0700
Subject: [PATCH v2 2/4] ARM: dts: Enable emmc and sdmmc on the rk3288-evb
 boards
In-Reply-To: <1406823200-20911-1-git-send-email-dianders@chromium.org>
References: <1406823200-20911-1-git-send-email-dianders@chromium.org>
Message-ID: <1406823200-20911-3-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the sdmmc and emmc ports on the rk3288 using the
currently posted driver from Addy at:
  https://patchwork.kernel.org/patch/4653631/

This enables basic SD and eMMC support.  Things are not yet running at
the fastest speed and we don't have the regulators specified, but we
can at least use the eMMC and SD cards now.

A few notes:
* This is not baesd on Jaehoon's patch series removing the slot node,
  but it does use new syntax like putting the bus width at the top
  level and using the new cap-mmc-highspeed / cap-sd-highspeed.  A
  future patch will modify this one to remove the slot node.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes in v2:
- Squashed in the DDR50 mode since Addy spun his patch.
- New patchwork link for Addy's patch

 arch/arm/boot/dts/rk3288-evb.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 749e20d..ec580fa 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -37,6 +37,39 @@
 	};
 };
 
+&emmc {
+	broken-cd;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
+	status = "okay";
+
+	slot at 0 {
+		reg = <0>;
+		disable-wp;
+	};
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	card-detect-delay = <200>;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	status = "okay";
+
+	slot at 0 {
+		reg = <0>;
+		disable-wp;		/* wp not hooked up */
+	};
+};
+
 &i2c0 {
 	status = "okay";
 };
-- 
2.0.0.526.g5318336
