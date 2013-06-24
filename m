From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 24 Jun 2013 23:14:47 +0200 (CEST)
Subject: [PATCH v3 3/4] ARM: shmobile: ape6evm: add CPUFreq support
Message-ID: <Pine.LNX.4.64.1306242311120.26438@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds OPPs to the CA15 DT node and a max8973 DT node to support
clock and voltage scaling, using the cpufreq-cpu0 CPUFreq driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v3: fix a typo s/maxium/maxim/

 arch/arm/boot/dts/r8a73a4-ape6evm.dts |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 4fb0102..27c5e06 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -52,3 +52,25 @@
 		};
 	};
 };
+
+&i2c5 {
+	vdd_dvfs: max8973 at 1b {
+		compatible = "maxim,max8973";
+		reg = <0x1b>;
+
+		regulator-min-microvolt = <935000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&cpu0 {
+	cpu0-supply = <&vdd_dvfs>;
+	operating-points = <
+		/* kHz  uV */
+		1950000 1115000
+		1462500  995000
+	>;
+	voltage-tolerance = <1>; /* 1% */
+};
-- 
1.7.2.5
