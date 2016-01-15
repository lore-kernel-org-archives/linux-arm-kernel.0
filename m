From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 15 Jan 2016 21:49:53 +0800
Subject: [PATCH v3 6/9] ARM: dts: rockchip: add the sdio power sequence for
 kylin board
In-Reply-To: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1452865796-23527-7-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the sdio power sequence for kylin board.
The WLAN attached to a SDIO interface, wifi/bluetooth have
reset and power been needed to enable.

AFAIK, the simple power sequence provider sets a value for multiple GPIOs.
So the reset and power of WlAN chip can be handled in mmc power sequence.
On the module itself this is one of these, that should can be handled
by reset GPIOs in simple mmc power sequence.

The Bluetooth host wake is high active from bootup, this patch is also
set pinctrl bias as the default to enable the pull up in soc internal.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v3:
- As Javier/Heiko discuss on https://patchwork.kernel.org/patch/7974311/,
  try to change dts with reset-gpios handle.

 arch/arm/boot/dts/rk3036-kylin.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 4fbd0a3..d30a6dd 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -78,6 +78,23 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_wake_h>;
+
+		/*
+		 * On the module itself this is one of these (depending
+		 * on the actual card populated):
+		 * - SDIO_RESET_L_WL_REG_ON
+		 * - SDIO_RESET_L_WL_RST
+		 * - SDIO_RESET_L_BT_EN
+		 */
+		reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>, /* WL_REG_ON */
+			      <&gpio0 27 GPIO_ACTIVE_LOW>, /* WL_RST */
+			      <&gpio2 9  GPIO_ACTIVE_LOW>; /* BT_EN */
+	};
 };
 
 &acodec {
@@ -311,6 +328,7 @@
 	cap-sdio-irq;
 	default-sample-phase = <90>;
 	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
 	non-removable;
 	num-slots = <1>;
 	pinctrl-names = "default";
@@ -348,6 +366,12 @@
 		};
 	};
 
+	sdio {
+		bt_wake_h: bt-wake-h {
+			rockchip,pins = <2 8 RK_FUNC_GPIO &pcfg_pull_default>;
+		};
+	};
+
 	sleep {
 		global_pwroff: global-pwroff {
 			rockchip,pins = <2 7 RK_FUNC_1 &pcfg_pull_none>;
-- 
1.9.1
