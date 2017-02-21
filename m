From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 21 Feb 2017 15:30:03 +0530
Subject: [PATCH] ARM: dts: am57xx-idk: Add DCAN support
Message-ID: <8981d49e7011a7246ff7dc6a9a9da0a56dfe5621.1487670384.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Schuyler Patton <spatton@ti.com>

AM571x IDK and the AM572x IDK use CAN1 interface.
This patch enables it for both boards.

Tested on AM572x IDK using cansequence.

Signed-off-by: Schuyler Patton <spatton@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
[nsekhar at ti.com: move to use DRA7XX_CORE_IOPAD())
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 814a720d5c3d..abdee2e7a18e 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -97,6 +97,22 @@
 	};
 };
 
+&dra7_pmx_core {
+	dcan1_pins_default: dcan1_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x37d0, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* dcan1_tx */
+			DRA7XX_CORE_IOPAD(0x37d4, PIN_INPUT_PULLUP | MUX_MODE0)		/* dcan1_rx */
+		>;
+	};
+
+	dcan1_pins_sleep: dcan1_pins_sleep {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x37d0, MUX_MODE15 | PULL_UP)	/* dcan1_tx.off */
+			DRA7XX_CORE_IOPAD(0x37d4, MUX_MODE15 | PULL_UP)	/* dcan1_rx.off */
+		>;
+	};
+};
+
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
@@ -387,6 +403,14 @@
 	max-frequency = <96000000>;
 };
 
+&dcan1 {
+	status = "okay";
+	pinctrl-names = "default", "sleep", "active";
+	pinctrl-0 = <&dcan1_pins_sleep>;
+	pinctrl-1 = <&dcan1_pins_sleep>;
+	pinctrl-2 = <&dcan1_pins_default>;
+};
+
 &qspi {
 	status = "okay";
 
-- 
2.9.0
