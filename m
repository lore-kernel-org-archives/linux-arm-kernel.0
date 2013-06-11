From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 11 Jun 2013 16:48:57 +0200
Subject: [PATCH 2/3] ARM: dts: Add omap3-overo NAND flash memory binding
In-Reply-To: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch>
References: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1370962138-9631-3-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device-tree node for the on-board NAND memory.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo.dtsi |   50 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3.dtsi       |    2 +
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index e112a42..811b74c 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -33,6 +33,56 @@
 	};
 };
 
+&gpmc {
+	ranges = <0 0 0x30000000 0x00000004>;       /* CS0: NAND */
+
+	nand at 0,0 {
+		reg = <0 0 0>; /* CS0, offset 0 */
+		nand-bus-width = <16>;
+
+		ti,nand-ecc-opt = "sw";
+
+		gpmc,device-nand;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <36>;
+		gpmc,cs-wr-off-ns = <36>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <24>;
+		gpmc,adv-wr-off-ns = <36>;
+		gpmc,we-off-ns = <30>;
+		gpmc,oe-off-ns = <48>;
+		gpmc,access-ns = <54>;
+		gpmc,rd-cycle-ns = <72>;
+		gpmc,wr-cycle-ns = <72>;
+		gpmc,wr-access-ns = <30>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		xloader at 0 {
+			reg = <(0 * SZ_128K) (4 * SZ_128K)>;
+		};
+
+		uboot at 80000 {
+			reg = <(4 * SZ_128K) (14 * SZ_128K)>;
+		};
+
+		ubootenv at 240000 {
+			reg = <(18 * SZ_128K) (2 * SZ_128K)>;
+		};
+
+		linux at 280000 {
+			reg = <(20 * SZ_128K) (32 * SZ_128K)>;
+		};
+
+		rootfs at 680000 {
+			reg = <(52 * SZ_128K) MTDPART_SIZ_FULL>;
+		};
+	};
+};
+
 &i2c1 {
 	clock-frequency = <2600000>;
 
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 6d05ee0..65a9390 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -9,7 +9,9 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mtd/partitions.h>
 #include <dt-bindings/pinctrl/omap.h>
+#include <dt-bindings/sizes.h>
 
 #include "skeleton.dtsi"
 
-- 
1.7.5.4
