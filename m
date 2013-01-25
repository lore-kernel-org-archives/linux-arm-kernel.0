From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 12:55:32 +0900
Subject: [PATCH 14/15] ARM: mach-shmobile: sh73a0: Initialise MMCIF using DT
In-Reply-To: <1359086133-23357-1-git-send-email-horms+renesas@verge.net.au>
References: <1359086133-23357-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359086133-23357-15-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This device also requires a voltage regulator which
should be defined in a board-specific maner. An example
dts snipped follows.

/ {
	fixedregulator1v8: fixedregulator at 0 {
		compatible = "regulator-fixed";
		regulator-name = "fixed-1.8V";
		regulator-min-microvolt = <1800000>;
		regulator-max-microvolt = <1800000>;
	};
};

&mmcif {
	vmmc-supply = <&fixedregulator1v8>;
	vqmmc-supply = <&fixedregulator1v8>;
};

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-reference.dtsi |   24 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh73a0.c   |    1 +
 2 files changed, 25 insertions(+)
 create mode 100644 arch/arm/boot/dts/sh73a0-reference.dtsi

diff --git a/arch/arm/boot/dts/sh73a0-reference.dtsi b/arch/arm/boot/dts/sh73a0-reference.dtsi
new file mode 100644
index 0000000..d4bb012
--- /dev/null
+++ b/arch/arm/boot/dts/sh73a0-reference.dtsi
@@ -0,0 +1,24 @@
+/*
+ * Device Tree Source for the SH73A0 SoC
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "sh73a0.dtsi"
+
+/ {
+	compatible = "renesas,sh73a0";
+
+	mmcif: mmcif at 0x10010000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0xe6bd0000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 140 0x4
+			      0 141 0x4>;
+		reg-io-width = <4>;
+	};
+};
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index eab2667..afa5423 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -583,6 +583,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMCIF0 */
+	CLKDEV_DEV_ID("e6bd0000.mmcif", &mstp_clks[MSTP312]), /* MMCIF0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP311]), /* SDHI2 */
 	CLKDEV_DEV_ID("leds-renesas-tpu.12", &mstp_clks[MSTP303]), /* TPU1 */
 	CLKDEV_DEV_ID("leds-renesas-tpu.21", &mstp_clks[MSTP302]), /* TPU2 */
-- 
1.7.10.4
