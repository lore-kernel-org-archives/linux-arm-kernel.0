From: zyw@rock-chips.com (Chris Zhong)
Date: Fri,  7 Nov 2014 21:49:36 +0800
Subject: [PATCH v7 4/5] ARM: dts: add RK3288 suspend support
In-Reply-To: <1415368177-6637-1-git-send-email-zyw@rock-chips.com>
References: <1415368177-6637-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1415368177-6637-5-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add pmu sram node for suspend, add global_pwroff pinctrl.
The pmu sram is used to store the resume code.
global_pwroff is held low level at work, it would be pull to high
when entering suspend. reference this in the board DTS file since
some boards need it.

Signed-off-by: Tony Xie <xxx@rock-chips.com>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>

---

Changes in v7: None
Changes in v6:
- change pmu_intmem at ff720000 to sram at ff720000

Changes in v5:
- change size to 4k

Changes in v4: None
Changes in v3: None
Changes in v2:
- put "rockchip,rk3288-pmu-sram" to first

 arch/arm/boot/dts/rk3288.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index cfc4378..0747c30 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -462,6 +462,11 @@
 		status = "disabled";
 	};
 
+	sram at ff720000 {
+		compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
+		reg = <0xff720000 0x1000>;
+	};
+
 	pmu: power-management at ff730000 {
 		compatible = "rockchip,rk3288-pmu", "syscon";
 		reg = <0xff730000 0x100>;
@@ -667,6 +672,12 @@
 			bias-disable;
 		};
 
+		sleep {
+			global_pwroff: global-pwroff {
+				rockchip,pins = <0 0 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins = <0 15 RK_FUNC_1 &pcfg_pull_none>,
-- 
1.9.1
