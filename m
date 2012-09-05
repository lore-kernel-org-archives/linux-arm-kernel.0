From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  5 Sep 2012 12:28:54 -0700
Subject: [PATCH 4/9] ARM: msm: Move 8660 to DT timer
In-Reply-To: <1346873339-10927-1-git-send-email-sboyd@codeaurora.org>
References: <1346873339-10927-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1346873339-10927-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the timer entry and point the machine descriptor to the
device tree based msm timer.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/msm8660-surf.dts | 17 +++++++++++++++++
 arch/arm/mach-msm/board-msm8x60.c  |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/msm8660-surf.dts b/arch/arm/boot/dts/msm8660-surf.dts
index 45bc4bb..93a15ab 100644
--- a/arch/arm/boot/dts/msm8660-surf.dts
+++ b/arch/arm/boot/dts/msm8660-surf.dts
@@ -15,6 +15,23 @@
 		      < 0x02081000 0x1000 >;
 	};
 
+	timer at 02000004 {
+		compatible = "qcom,msm-gpt", "qcom,msm-timer";
+		interrupts = <1 1 0x301>;
+		reg = <0x02000004 0x10>;
+		clock-frequency = <32768>;
+		cpu-offset = <0x40000>;
+	};
+
+	timer at 02000024 {
+		compatible = "qcom,msm-dgt", "qcom,msm-timer";
+		interrupts = <1 0 0x301>;
+		reg = <0x02000024 0x10>,
+		      <0x02000034 0x4>;
+		clock-frequency = <6750000>;
+		cpu-offset = <0x40000>;
+	};
+
 	serial at 19c400000 {
 		compatible = "qcom,msm-hsuart", "qcom,msm-uart";
 		reg = <0x19c40000 0x1000>,
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index 97db3cd..64c981d 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -154,7 +154,7 @@ DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
 	.handle_irq = gic_handle_irq,
 	.init_machine = msm8x60_dt_init,
 	.init_late = msm8x60_init_late,
-	.timer = &msm8x60_timer,
+	.timer = &msm_dt_timer,
 	.dt_compat = msm8x60_fluid_match,
 MACHINE_END
 #endif /* CONFIG_OF */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
