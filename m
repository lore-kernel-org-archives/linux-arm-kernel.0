From: dianders@chromium.org (Doug Anderson)
Date: Wed,  6 Aug 2014 10:09:42 -0700
Subject: [PATCH v3 2/4] ARM: dts: Enable emmc and sdmmc on the rk3288-evb
 boards
In-Reply-To: <1407344984-14176-1-git-send-email-dianders@chromium.org>
References: <1407344984-14176-1-git-send-email-dianders@chromium.org>
Message-ID: <1407344984-14176-3-git-send-email-dianders@chromium.org>
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
* Though MMC DDR50 mode is partially supported in the dw_mmc
  rk3288-specific code in Addy's patch, Addy's patch doesn't add
  tuning support.  That means DDR50 mode is not reliable.  From the
  3288 TRM: "Tuning is required for other speed modes-such as
  DDR50-even though the output delay from the card is less than one
  cycle."  Thus, we don't enable MMC DDR50 mode in this patch.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes in v3:
- Removed DDR50 mode since it needs tuning, which isn't there yet.

Changes in v2:
- Squashed in the DDR50 mode since Addy spun his patch.
- New patchwork link for Addy's patch

 arch/arm/boot/dts/rk3288-evb.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 4f57209..c2cf72f 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -49,6 +49,38 @@
 	};
 };
 
+&emmc {
+	broken-cd;
+	bus-width = <8>;
+	cap-mmc-highspeed;
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
