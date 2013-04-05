From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri,  5 Apr 2013 12:00:37 +0200
Subject: [PATCH v5 2/3] ARM: shmobile: kzm9g-reference: add AS3711 and CPUFreq
 DT bindings
In-Reply-To: <1365156038-12467-1-git-send-email-g.liakhovetski@gmx.de>
References: <1365156038-12467-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1365156038-12467-3-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds DT bindings for an AS3711 PMIC, used for supplying power to the
CPU, some peripherals and the backlight, as well as extends the cpu0 DT
node with OPPs and a reference to the PMIC to support the CPUFreq and
CPU DVFS functions.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v5: make the sd1 regulator immediately suitable for CPUFreq instead of
postponing it to an incremental patch.

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   86 ++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 5972abb..b6f759e 100644
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
+				 598000 1175000
+				 398667 1065000
+			>;
+			voltage-tolerance = <1>; /* 1% */
+		};
+	};
+
 	chosen {
 		bootargs = "console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel earlyprintk=sh-sci.4,115200";
 	};
@@ -59,6 +72,79 @@
 	};
 };
 
+&i2c0 {
+	as3711 at 40 {
+		compatible = "ams,as3711";
+		reg = <0x40>;
+
+		regulators {
+			vdd_dvfs: sd1 {
+				regulator-name = "1.315V CPU";
+				regulator-min-microvolt = <1050000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			sd2 {
+				regulator-name = "1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			sd4 {
+				regulator-name = "1.215V";
+				regulator-min-microvolt = <1215000>;
+				regulator-max-microvolt = <1235000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			ldo2 {
+				regulator-name = "2.8V CPU";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			ldo3 {
+				regulator-name = "3.0V CPU";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			ldo4 {
+				regulator-name = "2.8V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			ldo5 {
+				regulator-name = "2.8V #2";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			ldo7 {
+				regulator-name = "1.15V CPU";
+				regulator-min-microvolt = <1150000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			ldo8 {
+				regulator-name = "1.15V CPU #2";
+				regulator-min-microvolt = <1150000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
 &mmcif {
 	bus-width = <8>;
 	vmmc-supply = <&reg_1p8v>;
-- 
1.7.2.5
