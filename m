From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 Jul 2013 16:36:14 +0900
Subject: [PATCH 02/11] ARM: shmobile: ape6evm: add CPUFreq support
In-Reply-To: <cover.1374478037.git.horms+renesas@verge.net.au>
References: <cover.1374478037.git.horms+renesas@verge.net.au>
Message-ID: <463a2432a435ea3eda4714626f231b7b22f0ac3d.1374478037.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This patch adds OPPs to the CA15 DT node and a max8973 DT node to support
clock and voltage scaling, using the cpufreq-cpu0 CPUFreq driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index f603c69..e657a9d 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -50,3 +50,25 @@
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
1.8.2.1
