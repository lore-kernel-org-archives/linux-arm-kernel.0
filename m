From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 31 Jul 2015 16:44:44 -0700
Subject: [PATCH 2/3] ARM: dts: vexpress: Use assigned-clock-parents for sp810
In-Reply-To: <1438386285-5070-1-git-send-email-sboyd@codeaurora.org>
References: <55BBB2FC.9030102@codeaurora.org>
 <1438386285-5070-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1438386285-5070-3-git-send-email-sboyd@codeaurora.org>
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
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi | 2 ++
 arch/arm/boot/dts/vexpress-v2m.dtsi     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index 2efb2058ba49..21b02874bea3 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -101,6 +101,8 @@
 				clock-names = "refclk", "timclk", "apb_pclk";
 				#clock-cells = <1>;
 				clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
+				assigned-clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&v2m_sysctl 3>, <&v2m_sysctl 3>;
+				assigned-clock-parents = <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>;
 			};
 
 			/* PCI-E I2C bus */
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index cb3090f919a7..e712c0af149b 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -100,6 +100,8 @@
 				clock-names = "refclk", "timclk", "apb_pclk";
 				#clock-cells = <1>;
 				clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
+				assigned-clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&v2m_sysctl 3>, <&v2m_sysctl 3>;
+				assigned-clock-parents = <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>;
 			};
 
 			/* PCI-E I2C bus */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
