From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  1 May 2015 09:35:56 +0100
Subject: [PATCH v2] ARM64: juno: add sp810 support and fix sp804 clock
 frequency
Message-ID: <1430469356-12057-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock generator in IOFPGA generates the two source clocks: 32kHz and
1MHz for the SP810 System Controller.

The SP810 System Controller selects 32kHz or 1MHz as the sources for
TIM_CLK[3:0], the SP804 timer clocks. The powerup default is 32kHz but
the maximum of "refclk" and "timclk" is chosen by the SP810 driver.

This patch adds support for SP810 system controller and  also fixes the
SP804 timer clock frequency.

However the SP804 driver needs to be enabled on ARM64 to test this,
which requires SP804 driver to be moved out of arch/arm.

Fixes: 71f867ec130e ("arm64: Add Juno board device tree.")
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 31 +++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

v1->v2: Added Liviu's Ack and a note in the commit log as per his
	suggestion

diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
index c138b95a8356..351c95bda89e 100644
--- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
@@ -21,6 +21,20 @@
 			clock-output-names = "juno_mb:clk25mhz";
 		};

+		v2m_refclk1mhz: refclk1mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <1000000>;
+			clock-output-names = "juno_mb:refclk1mhz";
+		};
+
+		v2m_refclk32khz: refclk32khz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+			clock-output-names = "juno_mb:refclk32khz";
+		};
+
 		motherboard {
 			compatible = "arm,vexpress,v2p-p1", "simple-bus";
 			#address-cells = <2>;  /* SMB chipselect number and offset */
@@ -66,6 +80,15 @@
 				#size-cells = <1>;
 				ranges = <0 3 0 0x200000>;

+				v2m_sysctl: sysctl at 020000 {
+					compatible = "arm,sp810", "arm,primecell";
+					reg = <0x020000 0x1000>;
+					clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&mb_clk24mhz>;
+					clock-names = "refclk", "timclk", "apb_pclk";
+					#clock-cells = <1>;
+					clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
+				};
+
 				mmci at 050000 {
 					compatible = "arm,pl180", "arm,primecell";
 					reg = <0x050000 0x1000>;
@@ -106,16 +129,16 @@
 					compatible = "arm,sp804", "arm,primecell";
 					reg = <0x110000 0x10000>;
 					interrupts = <9>;
-					clocks = <&mb_clk24mhz>, <&soc_smc50mhz>;
-					clock-names = "timclken1", "apb_pclk";
+					clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&mb_clk24mhz>;
+					clock-names = "timclken1", "timclken2", "apb_pclk";
 				};

 				v2m_timer23: timer at 120000 {
 					compatible = "arm,sp804", "arm,primecell";
 					reg = <0x120000 0x10000>;
 					interrupts = <9>;
-					clocks = <&mb_clk24mhz>, <&soc_smc50mhz>;
-					clock-names = "timclken1", "apb_pclk";
+					clocks = <&v2m_sysctl 2>, <&v2m_sysctl 3>, <&mb_clk24mhz>;
+					clock-names = "timclken1", "timclken2", "apb_pclk";
 				};

 				rtc at 170000 {
--
1.9.1
