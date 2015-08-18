From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Tue, 18 Aug 2015 15:21:28 -0700
Subject: [PATCH] ARM: qcom: Disable i2c device on gsbi4 for ipq806x
Message-ID: <1439936488-14870-1-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the i2c device on gsbi4 and mark gsbi4_h and gsbi4_qup clks as
unused. If they are enabled, clock framework will turn them off at end
of probe. On ipq806x by design gsbi4_qup, gsbi4_h clks and i2c on gsbi4
are meant for RPM usage. So turning them off in kernel is incorrect.

Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts | 9 ---------
 drivers/clk/qcom/gcc-ipq806x.c           | 6 +++---
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
index b08907a..36e2b04 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
@@ -46,15 +46,6 @@
 			serial at 16340000 {
 				status = "ok";
 			};
-
-			i2c4: i2c at 16380000 {
-				status = "ok";
-
-				clock-frequency = <200000>;
-
-				pinctrl-0 = <&i2c4_pins>;
-				pinctrl-names = "default";
-			};
 		};
 
 		gsbi5: gsbi at 1a200000 {
diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 5639699..eb4065e 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -809,7 +809,7 @@ static struct clk_rcg gsbi6_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
+			.flags = CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -874,7 +874,7 @@ static struct clk_branch gsbi7_qup_clk = {
 			.parent_names = (const char *[]){ "gsbi7_qup_src" },
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -922,7 +922,7 @@ static struct clk_branch gsbi4_h_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_h_clk",
 			.ops = &clk_branch_ops,
-			.flags = CLK_IS_ROOT,
+			.flags = CLK_IS_ROOT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
-- 
2.1.4
