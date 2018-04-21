From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 16:03:42 +0200
Subject: [PATCH] arm64: dts: marvell: armada-37xx: reserve memory for ATF
Message-ID: <20180421140342.25082-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Gu <xigu@marvell.com>

The PSCI area should be reserved in Linux for PSCI operations such as
suspend/resume.

Reserve 2MiB of memory which matches the area used by ATF (BL1, BL2,
BL3x, see [1] in ATF source code). This covers all PSCI code and data
area and is 2MiB aligned, which is required by Linux for huge pages
handling.

[1] plat/marvell/a3700/common/include/platform_def.h

Signed-off-by: Victor Gu <xigu@marvell.com>
[miquel.raynal at bootlin.com: reword of commit message]
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 97207a61bc79..429ce91bfc39 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -22,6 +22,17 @@
 		serial1 = &uart1;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
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
