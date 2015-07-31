From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 31 Jul 2015 16:44:45 -0700
Subject: [PATCH 3/3] ARM64: dts: vexpress: Use assigned-clock-parents for sp810
In-Reply-To: <1438386285-5070-1-git-send-email-sboyd@codeaurora.org>
References: <55BBB2FC.9030102@codeaurora.org>
 <1438386285-5070-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1438386285-5070-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sp810 clk driver is calling the clk consumer APIs from
clk_prepare ops to change the parent to a 1 MHz fixed rate clock
for each of the clocks that the driver provides. Use
assigned-clock-parents for this instead of doing it in the driver
to avoid using the consumer API in provider code. This also
allows us to remove the usage of clk provider APIs that take a
struct clk as an argument from the sp810 driver.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi    | 2 ++
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
index 021e0f40f419..637e046f0e36 100644
--- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
@@ -136,6 +136,8 @@
 					clock-names = "refclk", "timclk", "apb_pclk";
 					#clock-cells = <1>;
 					clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
+					assigned-clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&v2m_sysctl 3>, <&v2m_sysctl 3>;
+					assigned-clock-parents = <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>;
 				};
 
 				apbregs at 010000 {
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
index c46cbb29f3c6..88a7583ed7a7 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
@@ -74,6 +74,8 @@
 				clock-names = "refclk", "timclk", "apb_pclk";
 				#clock-cells = <1>;
 				clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
+				assigned-clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&v2m_sysctl 3>, <&v2m_sysctl 3>;
+				assigned-clock-parents = <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>;
 			};
 
 			aaci at 040000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
