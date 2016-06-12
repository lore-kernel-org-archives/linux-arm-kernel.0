From: christopher.spinrath@rwth-aachen.de (christopher.spinrath at rwth-aachen.de)
Date: Sun, 12 Jun 2016 17:19:21 +0200
Subject: [PATCH v2 1/2] ARM: dts: imx6q-cm-fx6: fix the operation points
Message-ID: <cd3010c3a4144ec38f2cfd1bfbd1b2ad@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Valentin Raevsky <valentin@compulab.co.il>

The current ldo settings of the cm-fx6 do not allow 1.2GHz cpu
frequency. At this frequency the module behaves unstable.

But the imx6q fuse indicates that 1.2GHz operation is possible.
Hence, remove the 1.2GHz operation point in the device tree.

Signed-off-by: Valentin Raevsky <valentin@compulab.co.il>
[christopher.spinrath at rwth-aachen.de: enhanced commit message and adjust
 remaining operation points to match the ones in imx6q.dtsi]
Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
---

Notes:
    Changes since v1:
     - Enhance commit message to explain that we cannot rely on the imx6q
       fuse to restrict the frequency
     - put the same information into a comment in the device tree
     - fix the remaining operation points to match the ones given in
       imx6q.dtsi

 arch/arm/boot/dts/imx6q-cm-fx6.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index 6d8d5e9..0038f0e 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -91,6 +91,27 @@
 	};
 };
 
+&cpu0 {
+	/* Although the imx6q fuse indicates that 1.2GHz operation is possible,
+	 * the module behaves unstable at this frequency. Hence, remove the
+	 * 1.2GHz operation point here.
+	 */
+	operating-points = <
+		/* kHz	uV */
+		996000	1250000
+		852000	1250000
+		792000	1175000
+		396000	975000
+	>;
+	fsl,soc-operating-points = <
+		/* ARM kHz	SOC-PU uV */
+		996000		1250000
+		852000		1250000
+		792000		1175000
+		396000		1175000
+	>;
+};
+
 &ecspi1 {
 	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>, <&gpio3 19 GPIO_ACTIVE_HIGH>;
-- 
2.8.3
