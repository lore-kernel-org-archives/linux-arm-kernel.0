From: zyw@rock-chips.com (Chris Zhong)
Date: Sat, 15 Nov 2014 19:45:09 +0800
Subject: [PATCH v8 3/4] ARM: dts: add RK3288 suspend support
In-Reply-To: <1416051910-16730-1-git-send-email-zyw@rock-chips.com>
References: <1416051910-16730-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1416051910-16730-4-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add pmu sram node for suspend, add global_pwroff pinctrl.
The pmu sram is used to store the resume code.
global_pwroff is held low level at work, it would be pull to high
when entering suspend. reference this in the board DTS file since
some boards need it.
ddrio_pwroff is power switch of ddr_controller, if you want to cut off
power rail of ddr_controller during suspend, please reference it.
ddr0_retention/ddr1_retention are the retention mode switches, if you
want to use the retention mode during suspend, please reference them.

Signed-off-by: Tony Xie <xxx@rock-chips.com>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>

---

Changes in v8:
- add ddr pinctrl for suspend

Changes in v7: None
Changes in v6:
- change pmu_intmem at ff720000 to sram at ff720000

Changes in v5:
- change size to 4k

Changes in v4: None
Changes in v3: None
Changes in v2:
- put "rockchip,rk3288-pmu-sram" to first

 arch/arm/boot/dts/rk3288.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index df30437..60bccff 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -482,6 +482,11 @@
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
@@ -687,6 +692,24 @@
 			bias-disable;
 		};
 
+		sleep {
+			global_pwroff: global-pwroff {
+				rockchip,pins = <0 0 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			ddrio_pwroff: ddrio-pwroff {
+				rockchip,pins = <0 1 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			ddr0_retention: ddr0-retention {
+				rockchip,pins = <0 2 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			ddr1_retention: ddr1-retention {
+				rockchip,pins = <0 3 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins = <0 15 RK_FUNC_1 &pcfg_pull_none>,
-- 
1.9.1
