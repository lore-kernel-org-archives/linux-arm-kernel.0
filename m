From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Feb 2015 17:33:40 +0000
Subject: [PATCH v3 2/4] ARM: sti: stih407-family: Add platform interconnects
 to always-on clk domain
In-Reply-To: <1424799222-9301-1-git-send-email-lee.jones@linaro.org>
References: <1424799222-9301-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1424799222-9301-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certain clocks should not be turned of by clk_disable_unused.  Until
now we have been using the kernel command-line of the same name to
prevent common clk from turning off all clocks without a reference,
as this would ensure hardware lockup.  This patch lists each
platform interconnect which needs to stay on to prevent the
aforementioned issue from arising.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index c06a546..35c74c6 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -34,6 +34,21 @@
 		reg = <0x08761000 0x1000>, <0x08760100 0x100>;
 	};
 
+	/*
+	 * ICNs are not visible/controllable in Linux, but references to their
+	 * clocks must be obtained and retained or the platform will become
+	 * irrecoverably unresponsive.
+	 */
+	icn {
+		compatible = "clk-always-on";
+		clocks = <&clk_s_c0_flexgen CLK_ICN_SBC>,
+			 <&clk_s_c0_flexgen CLK_ICN_CPU>,
+			 <&clk_s_c0_flexgen CLK_ICN_LMI>,
+			 <&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
+			 <&clk_s_a0_flexgen CLK_IC_LMI0>,
+			 <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+	};
+
 	scu at 08760000 {
 		compatible = "arm,cortex-a9-scu";
 		reg = <0x08760000 0x1000>;
-- 
1.9.1
