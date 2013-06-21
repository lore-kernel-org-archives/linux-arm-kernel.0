From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 21 Jun 2013 09:10:37 +0200
Subject: [PATCH 3/4] ARM: shmobile: ape6evm: add CPUFreq support
In-Reply-To: <1371798638-10530-1-git-send-email-g.liakhovetski@gmx.de>
References: <1371798638-10530-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1371798638-10530-4-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds OPPs to the CA15 DT node and a max8973 DT node to support
clock and voltage scaling, using the cpufreq-cpu0 CPUFreq driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 4fb0102..af6bd40 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -52,3 +52,29 @@
 		};
 	};
 };
+
+&i2c5 {
+	max8973 at 1b {
+		compatible = "maxium,max8973";
+		reg = <0x1b>;
+
+		regulators {
+			vdd_dvfs: dcdc {
+				regulator-min-microvolt = <935000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
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
