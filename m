From: zyw@rock-chips.com (Chris Zhong)
Date: Tue, 25 Nov 2014 15:32:22 +0800
Subject: [PATCH v9 3/4] ARM: dts: add RK3288 suspend support
In-Reply-To: <1416900743-29204-1-git-send-email-zyw@rock-chips.com>
References: <1416900743-29204-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1416900743-29204-4-git-send-email-zyw@rock-chips.com>
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

Changes in v9: None
Changes in v8: None
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
index d83ca93..c11b44c 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -481,6 +481,11 @@
 		};
 	};
 
+	sram at ff720000 {
+		compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
+		reg = <0xff720000 0x1000>;
+	};
+
 	pmu: power-management at ff730000 {
 		compatible = "rockchip,rk3288-pmu", "syscon";
 		reg = <0xff730000 0x100>;
@@ -704,6 +709,12 @@
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
