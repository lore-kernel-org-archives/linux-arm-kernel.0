From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 15 Jan 2016 21:49:54 +0800
Subject: [PATCH v3 7/9] ARM: dts: rockchip: add the sdmmc for kylin board
In-Reply-To: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1452865796-23527-8-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although We can add the sdmmc node, shouldn't enable it.
Since the sdmmc is reusing the same pin with uart2.
Unfortunately, the uart2 is used by the debug port, so that will cause
the debug information can't display on console if enabling the sdmmc.

As we have supported the sdmmc (sd card) on hardware for kylin board.
So, maybe we can have the sdmmc node in kylin dts, not to enable it.

Anyway, you only need add the okay status if someone want to enable the
sdmmc.

e.g.
if you use the adb to debug with android os.
You can add the
status = "okay" to enable the sdmmc for sd card working.
The defauly status is disabling it.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v3:
- fix the commit content in sdmmc patch.

 arch/arm/boot/dts/rk3036-kylin.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index d30a6dd..8bdbb95 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -335,6 +335,17 @@
 	pinctrl-0 = <&sdio_clk &sdio_cmd &sdio_bus4>;
 };
 
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	card-detect-delay = <200>;
+	disable-wp;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_cd>, <&sdmmc_bus4>;
+};
+
 &uart2 {
 	status = "okay";
 };
@@ -372,6 +383,12 @@
 		};
 	};
 
+	sdmmc {
+		sdmmc_pwr: sdmmc-pwr {
+			rockchip,pins = <2 28 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sleep {
 		global_pwroff: global-pwroff {
 			rockchip,pins = <2 7 RK_FUNC_1 &pcfg_pull_none>;
-- 
1.9.1
