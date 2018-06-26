From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 26 Jun 2018 10:17:01 +0200
Subject: [PATCH v2] arm64: dts: marvell: armada-37xx: reserve memory for ATF
Message-ID: <20180626081701.27176-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Gu <xigu@marvell.com>

The PSCI area should be reserved in Linux for PSCI operations such as
suspend/resume.

Reserve 2MiB of memory which matches the area used by ATF (BL1, BL2,
BL3x, see [1] in ATF source code). This covers all PSCI code and data
area and is 2MiB aligned, which is required by Linux for huge pages
handling.

Please note that this is a default setup allowing to perform PSCI
operations with legacy bootloaders. Recent bootloaders should update the
region size/position accordingly.

[1] plat/marvell/a3700/common/include/platform_def.h

Signed-off-by: Victor Gu <xigu@marvell.com>
[miquel.raynal at bootlin.com: reword of commit message, comment in the DTSI]
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes since v1:
=================
* Updated commit log to explain that this memory region should be
  updated by recent bootloaders.
* Added a comment to tell the same thing above the psci-area subnode.

 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 3353252d78a0..d18a4a098d79 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -22,6 +22,21 @@
 		serial1 = &uart1;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * The PSCI firmware region depicted below is the default one
+		 * and should be updated by the bootloader.
+		 */
+		psci-area at 4000000 {
+			reg = <0 0x4000000 0 0x200000>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.14.1
