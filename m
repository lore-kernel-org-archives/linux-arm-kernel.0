From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 22 Feb 2013 18:17:54 +0100
Subject: [PATCH 4/4] ARM: shmobile: kzm9g-reference: add CPUFreq support
In-Reply-To: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
References: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1361553474-27022-5-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the use of the generic cpufreq-cpu0 driver on kzm9g.
Providing a regulator and a list of OPPs in DT, combined with a clock,
attached to the cpu0 device is everything, the cpufreq-cpu0 driver needs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   19 ++++++++++++++++---
 arch/arm/mach-shmobile/Kconfig               |    2 ++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index d9f6c18..ebe3f49 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -18,6 +18,19 @@
 	model = "KZM-A9-GT";
 	compatible = "renesas,kzm9g-reference", "renesas,sh73a0";
 
+	cpus {
+		cpu at 0 {
+			cpu0-supply = <&vdd_dvfs>;
+			operating-points = <
+				/* kHz  uV */
+				1196000 1315000
+				 806000 1175000
+				 403000 1065000
+			>;
+			voltage-tolerance = <1>; /* 1% */
+		};
+	};
+
 	chosen {
 		bootargs = "console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel earlyprintk=sh-sci.4,115200";
 	};
@@ -118,10 +131,10 @@
 		reg = <0x40>;
 
 		regulators {
-			sd1 {
+			vdd_dvfs: sd1 {
 				regulator-name = "1.315V CPU";
-				regulator-min-microvolt = <1315000>;
-				regulator-max-microvolt = <1335000>;
+				regulator-min-microvolt = <1050000>;
+				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 927eecc..6f621ac 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -141,6 +141,8 @@ config MACH_KZM9G
 config MACH_KZM9G_REFERENCE
 	bool "KZM-A9-GT board - Reference Device Tree Implementation"
 	depends on ARCH_SH73A0
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
-- 
1.7.2.5
