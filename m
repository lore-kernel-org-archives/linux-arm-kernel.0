From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon,  3 Feb 2014 14:34:37 -0800
Subject: [PATCH v3 7/7] arm: zynq: Add support for cpufreq
In-Reply-To: <1391466877-28908-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1391466877-28908-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1391466877-28908-8-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic cpufreq-cpu0 driver can scale the CPU frequency on Zynq
SOCs. Add the required platform device to the BSP and appropriate
OPPs to the dts.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: devicetree at vger.kernel.org
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v3:
 - change lowest frequency to 222223 (F_max / 3)
---
 arch/arm/boot/dts/zynq-7000.dtsi | 6 ++++++
 arch/arm/mach-zynq/Kconfig       | 2 ++
 arch/arm/mach-zynq/common.c      | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 8b67b19392ec..789d0bacc110 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -24,6 +24,12 @@
 			device_type = "cpu";
 			reg = <0>;
 			clocks = <&clkc 3>;
+			operating-points = <
+				/* kHz    uV */
+				666667  1000000
+				333334  1000000
+				222223  1000000
+			>;
 		};
 
 		cpu at 1 {
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index f84fab14f0b7..f03e75bd0b2b 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -2,6 +2,8 @@ config ARCH_ZYNQ
 	bool "Xilinx Zynq ARM Cortex A9 Platform" if ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
 	select COMMON_CLK
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 1db2a5ca9ab8..644468151c04 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -51,6 +51,8 @@ static struct platform_device zynq_cpuidle_device = {
  */
 static void __init zynq_init_machine(void)
 {
+	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+
 	/*
 	 * 64KB way size, 8-way associativity, parity disabled
 	 */
@@ -59,6 +61,7 @@ static void __init zynq_init_machine(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	platform_device_register(&zynq_cpuidle_device);
+	platform_device_register_full(&devinfo);
 }
 
 static void __init zynq_timer_init(void)
-- 
1.8.5.3
