From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 18 Sep 2013 11:48:38 -0700
Subject: [PATCH v2 4/4] arm: zynq: Enable arm_global_timer
In-Reply-To: <1379530118-22813-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1379530118-22813-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1379530118-22813-5-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zynq is based on an ARM Cortex-A9 MPCore, which features the
arm_global_timer in its SCU. Therefore enable the timer for Zynq.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
v2:
 - rename DT node: global_timer at ... => timer at ...
 - add Daniel's ACK
---
 arch/arm/boot/dts/zynq-7000.dtsi | 8 ++++++++
 arch/arm/mach-zynq/Kconfig       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index e32b92b..e7f73b2 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -92,6 +92,14 @@
 			};
 		};
 
+		global_timer: timer at f8f00200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0xf8f00200 0x20>;
+			interrupts = <1 11 0x301>;
+			interrupt-parent = <&intc>;
+			clocks = <&clkc 4>;
+		};
+
 		ttc0: ttc0 at f8001000 {
 			interrupt-parent = <&intc>;
 			interrupts = < 0 10 4 0 11 4 0 12 4 >;
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 04f8a4a..6b04260 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -13,5 +13,6 @@ config ARCH_ZYNQ
 	select HAVE_SMP
 	select SPARSE_IRQ
 	select CADENCE_TTC_TIMER
+	select ARM_GLOBAL_TIMER
 	help
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
-- 
1.8.4
